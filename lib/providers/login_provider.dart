import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../QMCHAdminScreens/adminhome.dart';
import '../QmchScreens/login_screen.dart';
import '../QmchScreens/patient_sponsership_homescreen.dart';
import '../QmchScreens/userRegistrationScreen.dart';
import '../Screens/home_screen.dart';
import '../constants/my_functions.dart';
import '../service/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'donation_provider.dart';
import 'home_provider.dart';


class LoginProvider extends ChangeNotifier {
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isTrue = false;
  TextEditingController userRegNameCT = TextEditingController();
  TextEditingController userRegPhoneCT = TextEditingController();

  LoginProvider(){
    getPackageName();
  }

  Future<void> userAuthorized(String? phoneNumber, BuildContext context) async {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    db.collection("USERS").where("PHONE_NUMBER",isEqualTo:phoneNumber ).get().then((value) {
      if(value.docs.isNotEmpty){
        for(var element in value.docs){
          Map<dynamic,dynamic> map = element.data();
          if(map['fcmID']==null){
            FirebaseMessaging.instance.getToken().then((value) {
              db.collection('USERS').doc(element.id).update({'fcmID': value.toString()});
            });
          }
          String adminName=map['NAME'].toString();
          String id=element.id;
          String phone=map['PHONE_NUMBER'].toString();
          if(phone.length==13){
            phone=phone.substring(3,13);
          }
          HomeProvider homeProvider =
          Provider.of<HomeProvider>(context, listen: false);
          homeProvider.checkVoulenteerApproved(phone);

          print(packageName.toString()+' IEFIUEFF '+map['TYPE']);
          if(packageName.toString()=='com.spine.qmch'){
            donationProvider.getUserImg(id,map['TYPE'].toString());
            homeProvider.fetchHistoryWithMobileNo(phone);
            if(map['TYPE'].toString()=='SUBSCRIBER') {
              FocusScope.of(context).unfocus();
              callNextReplacement(HomeScreenNew(loginUserID: id,loginUsername: adminName,subScriberType: 'SUBSCRIBER',loginUserPhone:phone,equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
                  sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''),context);
            }else if(map['TYPE'].toString()=='GENERAL'){
              FocusScope.of(context).unfocus();
              callNextReplacement(HomeScreenNew(loginUserID: id,loginUsername: adminName,subScriberType: 'GENERAL',loginUserPhone: phone
                  ,equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
                  sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''),context);
            }else if(map['TYPE'].toString()=='VOLUNTEER'){
              FocusScope.of(context).unfocus();
              callNextReplacement(HomeScreenNew(loginUserID: id,loginUsername: adminName,subScriberType: 'VOLUNTEER',loginUserPhone: phone
                  ,equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
                  sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''),context);

            }else{
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(backgroundColor: Colors.red,
                content: Center(child: Text("No User Found in this number")),
                duration: Duration(milliseconds: 3000),
              ));
              finish(context);
            }
          }else if(packageName.toString()=='com.spine.behiveAdmin'){
            if(map['TYPE'].toString()=='ADMIN'){

              donationProvider.getAdminImg(id);
              callNextReplacement(AdminHome(adminName: adminName,adminID: id, adminPhone: phone,),context);
            }else{
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(backgroundColor: Colors.red,
                content: Center(child: Text("No admin Found in this number")),
                duration: Duration(milliseconds: 3000),
              ));
              callNextReplacement(LoginScreen(), context);
            }
          }

        }
      }
    });
  }


  void clearForm(){
    userRegNameCT.clear();
    userRegPhoneCT.clear();
    notifyListeners();
  }

  Future<void> registerUser(BuildContext context,String from) async {
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    String? strDeviceID= "";
    if(Platform.isAndroid){
      strDeviceID= await DeviceInfo().fun_initPlatformState();

    }else if(Platform.isIOS){
      try {
        strDeviceID = await UniqueIdentifier.serial;
      } on PlatformException {
        strDeviceID = 'Failed to get Unique Identifier';
      }

    }
    DateTime now=DateTime.now();
    String key=DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String,Object> map=HashMap();
    HashMap<String,Object> Usermap=HashMap();
    HashMap<String,Object> Voulmap=HashMap();

    if(from=='VOLUNTEER'){
      Voulmap["Name"] = userRegNameCT.text.toString();
      Voulmap["Phone"] = userRegPhoneCT.text.toString();
      Voulmap["DeviceId"] = strDeviceID!;

      Voulmap['ADDED_TIME']=now;
      Voulmap['ADDED_TIME_MILLIS']=key;
      Voulmap['ADDED_BY']='SELF';
      Voulmap['Status']='PENDING';
      Voulmap['ID']=key;

    }



    map['SPONSOR_NAME']=userRegNameCT.text;
    map['SPONSOR_PHONE']=userRegPhoneCT.text;

    Usermap['NAME']=userRegNameCT.text;
    Usermap['PHONE_NUMBER']='+91'+userRegPhoneCT.text;
    Usermap['ADDED_TIME']=now;
    Usermap['ADDED_BY']='SELF';
    Usermap['ADDED_ADMIN_ID']='';
    Usermap['TYPE']='GENERAL';
    Usermap['ID']=key;
    Usermap['REF']='VOLUNTEERS/'+key;


    map['ADDED_TIME']=now;
    map['ADDED_TIME_MILLIS']=key;
    map['ADDED_BY']='SELF';
    map['ADDED_ADMIN_ID']='';
    map['ID']=key;

    map['DEVICE_ID']=strDeviceID.toString();

    FirebaseMessaging.instance.getToken().then((value) {
      HashMap<String,Object> fcmMap=HashMap();
      fcmMap['fcmID']= value.toString();
      if(from=='SPONSOR'){
        db.collection('SPONSORS').doc(key).set(fcmMap,SetOptions(merge: true));
      }else{
        db.collection('USERS').doc(key).set(fcmMap,SetOptions(merge: true));
      }
    });

    if(from=='SPONSOR'){
      db.collection('SPONSORS').doc(key).set(map,SetOptions(merge: true));
      callNextReplacement(PatientSposershipHomeScreen(loginUsername: userRegNameCT.text,loginUserID: key,
          subScriberType: 'GENERAL',loginUserPhone: userRegPhoneCT.text
          ,equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
          sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''), context);
    }else if(from=='GENERAL'){
      db.collection('USERS').doc(key).set(Usermap,SetOptions(merge: true));
      callNextReplacement(HomeScreenNew(loginUsername: userRegNameCT.text,
          loginUserID: key, subScriberType: 'GENERAL', loginUserPhone: userRegPhoneCT.text
          ,equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
          sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''), context);
    }else if(from=='VOLUNTEER'){
      db.collection('USERS').doc(key).set(Usermap,SetOptions(merge: true));
      db.collection('VOLUNTEERS').doc(key).set(Voulmap,SetOptions(merge: true));
      callNextReplacement(HomeScreenNew(loginUsername: userRegNameCT.text,
          loginUserID: key, subScriberType: 'VOLUNTEER', loginUserPhone: userRegPhoneCT.text
          ,equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
          sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''), context);

      homeProvider.checkVoulenteerApproved(userRegPhoneCT.text);
    }else if(from=='SUBSCRIBER'){
      callNextReplacement(HomeScreenNew(loginUsername: userRegNameCT.text,
          loginUserID: key, subScriberType: 'SUBSCRIBER', loginUserPhone: userRegPhoneCT.text
          ,equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
          sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''), context);
    }


  }

  Future<void> checkSponserAlreadyExist(BuildContext context,String loginPhone,String name,String subType,String id) async {
    String? strDeviceID= "";
    if(Platform.isAndroid){
      strDeviceID= await DeviceInfo().fun_initPlatformState();

    }else if(Platform.isIOS){
      try {
        strDeviceID = await UniqueIdentifier.serial;
      } on PlatformException {
        strDeviceID = 'Failed to get Unique Identifier';
      }

    }

    if(loginPhone=='' || id==''){
      clearForm();
      print('New Sponsor');
      callNext(UserRegistrationScreen(from: 'SPONSOR'), context);
    }else{
      callNext(PatientSposershipHomeScreen(loginUsername: name,
          loginUserID: id,subScriberType: subType,loginUserPhone: loginPhone,equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
          sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''), context);
    }

  }


  Route _createRoute(Widget c) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => c,
      transitionDuration: const Duration(seconds: 2), // Adjust the duration as needed
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;

        var curve = Curves.easeInOutQuad; // Use a custom curve

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Interval(0.0, 1.0, curve: curve),
        );

        return AnimatedBuilder(
          animation: curvedAnimation,
          builder: (context, child) {
            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
          child: child,
        );
      },
    );
  }

  String? packageName;
  Future<void> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName;
    print("${packageName}packagenameee");
    notifyListeners();
  }

}