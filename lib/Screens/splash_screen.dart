import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../constants/my_functions.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import 'package:provider/provider.dart';
import '../Admin/admin_login_screen.dart';
import '../QmchScreens/login_screen.dart';
import '../constants/my_colors.dart';
import '../providers/login_provider.dart';
import '../providers/main_provider.dart';
import 'home.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  String paymentID;
  SplashScreen({Key? key,required this.paymentID}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DatabaseReference mRootReference =
  FirebaseDatabase.instance.reference();
  String? packageName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPackageName();
    print("splash referall1111111"+widget.paymentID.toString());
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);

    HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
    MainProvider mainProvier = Provider.of<MainProvider>(context, listen: false);
    // homeProvider.lockAppTv();
    print("AAAASSSS");

    LoginProvider loginProvider =
    Provider.of<LoginProvider>(context, listen: false);

    // if(!kIsWeb){
    // mRootReference.child("0").keepSynced(true);


    Future.delayed(const Duration(seconds:5), () async {
      print("widget.paymentID"+widget.paymentID);

      /// lock for Iuml hq
      if(packageName.toString()=='com.spine.qmch'){
        homeProvider.lockApp();
      }else if(packageName.toString()=='com.spine.qmchAdmin'){
        homeProvider.lockAdminApp();
      }
      // homeProvider.lockAppTv();
      ///lock only for monitor and admin appp
      // homeProvider.lockAppMonitor();
      homeProvider.fetchDetails();
      homeProvider.lockPinWardReceipt();
      homeProvider.lockPinWardHistory();
      homeProvider.changeReport();
      mainProvier.fetchImages();
      donationProvider.fetchPanjayath();
      donationProvider.getTodayTopper();
      // donationProvider.getHideWards();
      // donationProvider.fetchAssembly();
      // donationProvider.otherPaymentButton();
      print("asa SSSsas"+widget.paymentID);

      if(kIsWeb&&widget.paymentID!="General"){
        donationProvider.getDirectReceipt(widget.paymentID,context,'','','','','','','','','','','','','','',);///for issue clearence portaal

      }else{
        ////reshma
        FirebaseAuth auth = FirebaseAuth.instance;
        var user = auth.currentUser;
        print(' INCFVNRV');
        if(packageName=='com.spine.behiveAdmin'){
          if (user == null) {
            callNextReplacement(LoginScreen(), context);
          }else{
            loginProvider.userAuthorized(user.phoneNumber.toString(), context,);
          }
        }else if(packageName=='com.spine.behive'){
          callNextReplacement(HomeScreenNew(loginUserID: '',loginUsername: '',subScriberType: '',loginUserPhone: '',
              equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
              sponsorCategory: '',foodkitAmount: '',foodkitPrice: ''), context);
          // if (user == null) {
          //   homeProvider.fetchHistoryFromFireStore();
          //   callNextReplacement(HomeScreenNew(loginUserID: '',loginUsername: '',subScriberType: '',loginUserPhone: '',
          //       equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
          //       sponsorCategory: '',foodkitAmount: '',foodkitPrice: ''), context);
          // }else{
          //   loginProvider.userAuthorized(user.phoneNumber.toString(), context,);
          // }
        }


        // if(FirebaseAuth.instance.currentUser!=null){
        //
        //
        // }else{
        //   try {
        //
        //     final userCredential =
        //     FirebaseAuth.instance.signInAnonymously().then((value) {
        //       print("Signed in with temporary account.");
        //       print(value.user?.uid.toString());
        //
        //
        //     });
        //
        //   } on FirebaseAuthException catch (e) {
        //
        //
        //
        //     switch (e.code) {
        //       case "operation-not-allowed":
        //         print("Anonymous auth hasn't been enabled for this project.");
        //         break;
        //       default:
        //         print("Unknown error.");
        //     }
        //   } on Exception catch(e){
        //     print("SSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        //   }
        // }


      }
      ///new code b



      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
    // homeProvider.inagurationTrigger(context);
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget mobile(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;

    return Scaffold(
        body:
        MediaQuery.of(context).orientation==Orientation.landscape
            ?
        Row(
          children: [

            SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/tvsplash.png",
                          ),
                          fit:BoxFit.fill
                      )
                  ),
                ),
              ),
            ),

          ],
        )
            :
        Center(
          child: SizedBox(
            // width:width*.80,
            // height:190,
            child:   SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: width,
                      color: Colors.white,
                      child: Center(child: Image.asset("assets/behive/unnathi_splash.gif",scale: 4,fit: BoxFit.fill,))),
                  SizedBox(height: height*0.01,),

                ],
              ),
            ),
          ),
        ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child:Image.asset(
          "assets/logo.png",
          scale: 2.3,
        ),
      ),
    );
  }

  Widget web(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;

    return Container(
      height: height,
      width: width,

      child: Center(
        child: queryData.orientation == Orientation.portrait
            ? Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: width,
                child: Scaffold(
                    body:
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: height*0.35,),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     const SizedBox(
                          //       width: 75,
                          //     ),
                          //     Image.asset(
                          //       "assets/Quaid-e Millath.png",
                          //       scale: 3.3,
                          //     ),
                          //
                          //   ],
                          // ),


                          // const SizedBox(height: 40,),
                          // Container(
                          //   margin: EdgeInsets.symmetric(horizontal: 10),
                          //   height: height*0.2,
                          //   // height: 274,
                          //   width: width,
                          //   decoration: const BoxDecoration(
                          //     // color: Colors.yellow,
                          //     image: DecorationImage(image: AssetImage("assets/splash_text.png"),scale: 3,fit: BoxFit.fill),
                          //   ),
                          //
                          // ),
                          Center(
                            child: Image.asset(
                              "assets/splash_text.png",
                              scale: 2.3,
                            ),
                          ),
                          Center(
                            child: Image.asset(
                              "assets/SplashGif.gif",
                              scale: 7,
                            ),
                          ),
                          const SizedBox(height: 120,),
                          Image.asset(
                            "assets/logo.png",
                            scale: 2.3,
                          ),
                        ],
                      ),
                    ))
            ),
          ],
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: width,
                child: Scaffold(
                    body:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height*0.35,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     const SizedBox(
                        //       width: 75,
                        //     ),
                        //     Image.asset(
                        //       "assets/Quaid-e Millath.png",
                        //       scale: 3.3,
                        //     ),
                        //
                        //   ],
                        // ),


                        // const SizedBox(height: 40,),
                        // Container(
                        //   margin: EdgeInsets.symmetric(horizontal: 10),
                        //   height: height*0.2,
                        //   // height: 274,
                        //   width: width,
                        //   decoration: const BoxDecoration(
                        //     // color: Colors.yellow,
                        //     image: DecorationImage(image: AssetImage("assets/splash_text.png"),scale: 3,fit: BoxFit.fill),
                        //   ),
                        //
                        // ),
                        Center(
                          child: Image.asset(
                            "assets/splash_text.png",
                            scale: 2.3,
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            "assets/SplashGif.gif",
                            scale: 7,
                          ),
                        ),
                        const SizedBox(height: 120,),
                        Image.asset(
                          "assets/logo.png",
                          scale: 2.3,
                        ),
                      ],
                    ))
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName;
    print("${packageName}packagenameee");
    setState(() {

    });
  }
}