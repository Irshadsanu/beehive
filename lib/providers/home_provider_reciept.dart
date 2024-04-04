import 'dart:async';
import 'dart:collection';
// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Views/payment_details_old.dart';
import '../Views/payment_model.dart';
import '../Views/ward_total_model.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../service/device_info.dart';


class HomeProviderReceiptApp extends ChangeNotifier {
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;

  double totalCollection = 0;
  List<String> sliderList = [];
  List<PaymentModel> historyList = [];
  List<WardTotalModel> wardTotalList = [];
  List<PaymentDetailsOld> paymentDetailsList = [];
  List<PaymentDetailsOld> failureList = [];
  List<PaymentDetailsOld> filteredPaymentDetailsList = [];
  StreamSubscription? _streamSubscription;


  DateTime pickedDate=DateTime.now();
  String  selectedDate='';
  int listLength=0;

  Timer? _timer;

  bool isBuzzer=false;






  String termsAndCondition = '';
  String aboutUs = '';
  String contactNumber='';
  String contactTime='';
  String iosPaymentGateway='';

  HomeProviderReceiptApp() {
    // fetchHistory();
    fetchWard();
    // fetchSliderImage();
    // fetchTotal();
    // fetchDetails();
  }


  void radioButtonChanges(bool bool) {
    notifyListeners();
    isBuzzer = bool;
    notifyListeners();
  }


  fetchHistory() async {
    if(!kIsWeb){
      String strDeviceID= await DeviceInfo().fun_initPlatformState();
      mRoot.child("Payment").child(strDeviceID).keepSynced(true);

      mRoot.child('UserPayments').child(strDeviceID).onValue.listen((event) {
        historyList.clear();
        if(event.snapshot.exists){
          Map<dynamic, dynamic> map = event.snapshot.value as Map;
          map.forEach((key, value) {
            mRoot.child(value['OrderRef']).once().then((value) {
              if(value.snapshot.exists){
                Map<dynamic, dynamic> data = value.snapshot.value as Map;
                historyList.add(PaymentModel(
                    key,
                    data['Amount'],
                    data["Name"],
                    data["PhoneNumber"],
                    data["Response"] ?? "",
                    data["Status"],
                    data["Ward"],data["Time"]));

                historyList.sort((a, b) => int.parse(b.time).compareTo(int.parse(a.time)));

                notifyListeners();


              }
            });
            notifyListeners();

          });
          notifyListeners();

        }
        notifyListeners();

      });
    }

  }


  double filterCollection = 0;
  void fetchWard() {
    db
        .collection('WardTotalAmount')
        .orderBy('Amount', descending: true)
        .limit(10)
        .snapshots()
        .listen((event) {
      wardTotalList.clear();
      filterCollection=0;
      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          filterCollection=filterCollection+double.parse(element.get('Amount').toString());
          wardTotalList.add(WardTotalModel(
            double.parse(element.get('Amount').toString()),
            element.get('district'),
            element.get('assembly'),
            element.get('panchayath'),
            element.get('wardname'),element.get("Target".toString())));
          notifyListeners();
        }
      }
      notifyListeners();

    });
  }

  fetchSliderImage() {
    mRoot.child('SliderImage').onValue.listen((databaseEvent) {
      sliderList.clear();
      if (databaseEvent.snapshot.value != null) {
        Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

        map.forEach((key, value) {
          sliderList.add(value.toString());
          notifyListeners();
        });
      }
    });
  }

  void fetchTotal() {
    db.collection('Total').doc('Total').snapshots().listen((event) {
      if (event.exists) {
        totalCollection = double.parse(event.get('Amount').toString());
        notifyListeners();
      }
    });
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate:  DateTime(2100),
    );

    if (picked != null) {
      pickedDate = picked;
      fetchReceiptList(pickedDate);
    }
  }

  fetchPaymentReceiptList(){
    mRoot.child('PaymentDetails').orderByKey().limitToLast(5).once().then((snapshot) {
      print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq   '+snapshot.snapshot.children.length.toString());
      print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr   '+snapshot.snapshot.value.toString());
    });
  }


  void fetchReceiptList(DateTime now) async{
    print('haiidddddddddddddddddddd');
      int hour =DateTime.now().hour;
      bool first=true;
    // _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      int newHour=DateTime.now().hour;
        if(hour!=newHour||first){
          first=false;
          hour =newHour;
          var outputDayNode = DateFormat('d MMM yyyy');
          selectedDate=outputDayNode.format(now);

          String dayNode = 'Y${now.year}/M${now.month}/D${now.day}/H$hour';
          mRoot.child("Payment").child(dayNode).keepSynced(true);

          print('abcddfffffffffff   ${dayNode}');

          if(_streamSubscription!=null){
            _streamSubscription!.cancel();
          }

          bool notFirst=false;
          paymentDetailsList.clear();
          filteredPaymentDetailsList.clear();
          _streamSubscription=mRoot.child("Payment").child(dayNode).child('HourEntry').limitToLast(listLength).onValue.listen((databaseEvent) {
            if(paymentDetailsList.isNotEmpty){
              notFirst=true;
            }
            if (databaseEvent.snapshot.value != null) {
              print('trfyrururrr');
              Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;
              map.forEach((key, value) {
                print('pooooooppp');
                  int time=0000000000;
                  try{
                    time=int.parse(value['Time'].toString());
                  }catch(e){

                  }
                  if(!paymentDetailsList.map((item) => item.id).contains(key)){
                    print('kkkkkfjfjjfkfkk');
                    if(isBuzzer){
                      if(notFirst){
                        if(value['Status']!='Success'){
                          // AssetsAudioPlayer.newPlayer().open(
                          //   Audio("assets/buzzer.mp3"),
                          //   showNotification: true,
                          // );
                        }
                      }
                    }

                    paymentDetailsList.add(PaymentDetailsOld(
                        key,
                        value['Amount'].toString(),
                        value['Name'].toString(),
                        value['PaymentApp'].toString(),
                        value['PhoneNumber'].toString(),
                        value['Status'].toString(),
                        time,
                        value['Ward'].toString(),
                        value["district"].toString(),
                        value["panchayath"].toString(),
                        value["wardname"].toString(),
                        value["wardnumber"].toString(),value['UpiID']??'',value['RefNo']??'',value["PaymentUpi"]??'Nil'));
                    filteredPaymentDetailsList=paymentDetailsList;
                    notifyListeners();
                    print("haiiiiiiii${paymentDetailsList.length}");
                  }
                  paymentDetailsList.sort((a, b) => b.time.compareTo(a.time));
                  filteredPaymentDetailsList.sort((a, b) => b.time.compareTo(a.time));
                  notifyListeners();
                  notifyListeners();
                });
            }}
          );
        }
    // });

  }

  void filterReceiptList(String item) {
    if(item!=''){
      filteredPaymentDetailsList = paymentDetailsList
          .where((element) => element.name.toLowerCase()
          .contains(item.toLowerCase())|| element.phoneNumber.contains(item))
          .toList();
      notifyListeners();
    }


  }

  void fetchDetails() {
    mRoot.child('0').onValue.listen((event) {
      if(event.snapshot.exists){
        Map<dynamic,dynamic> map = event.snapshot.value as Map;
        termsAndCondition=map['TermsAndCondition'];
        aboutUs=map['AboutUs'];
        contactNumber=map['PhoneNumber']??'';
        contactTime=map['AvailableTime']??'';
        iosPaymentGateway=map['IosPaymentGateway']??'';
        notifyListeners();
      }
    });
  }

  void uplaodToFirebase(List <dynamic> map,BuildContext context){
    int i=0;
    double totalAmount=0.0;

    for(var data in map){
      i++;

      // if(i<=2) {
      String? key = mRoot
          .push()
          .key;
      var datetme = DateTime.tryParse(data["Txn Date"]);
      String year = "Y" + datetme!.year.toString();
      String month = "M" + datetme.month.toString();
      String day = "D" + datetme.day.toString();
      String hour = "H" + datetme.hour.toString();

      totalAmount = totalAmount + double.tryParse(data["Amount"].toString())!;

      HashMap<String, Object> excelData = HashMap();
      excelData["Amount"] = data["Amount"];
      excelData["ID"] = key!;
      excelData["Name"] = "No Name";
      excelData["PaymentApp"] = "Bank";
      excelData["PhoneNumber"] = "No Phone Number";
      excelData["Status"] = "Success";
      excelData["Time"] = datetme.millisecondsSinceEpoch;
      excelData["Ward"] = "General";
      excelData["district"] = "General";
      excelData["panchayath"] = "General";
      excelData["wardname"] = "General";
      excelData["wardnumber"] = "General";
      String orderRef = "Payment/" + year + "/" + month + "/" + day + "/" +
          hour + "/HourEntry/" + key;
      mRoot.child("PaymentDetails").child(key).child("OrderRef").set(
          orderRef);
      mRoot.child("Payment").child(year).child(month).child(day).child(hour)
          .child("HourEntry").child(key)
          .update(excelData);
      // }
    }
    if(i==map.length){
      db.collection('Total').doc('Total').update(
          {"Amount": FieldValue.increment(totalAmount)});
      uploadComplete(context, map.length.toString()+" transaction uploaded");
    }
  }
  void uplaodNewToFirebase(List <dynamic> map,BuildContext context){
    int i=0;
    double totalAmount=0.0;
    for(var data in map){
      i++;
      // if(i<=2){
      String d=data["Transaction Date"]+" "+data["Transaction Time"]+" "+data["Corporate ID"].toString();
      var newDateTime =  DateFormat("dd-MMM-yy hh:mm:ss aa").parse(d);
      String? key = mRoot
          .push()
          .key;
      String year = "Y" + newDateTime.year.toString();
      String month = "M" + newDateTime.month.toString();
      String day = "D" + newDateTime.day.toString();
      String hour = "H" + newDateTime.hour.toString();
      totalAmount=totalAmount+double.tryParse(data["Amount(Rs.)"].toString())!;
      HashMap<String, Object> excelData = HashMap();
      excelData["Amount"] = data["Amount(Rs.)"].toString();
      excelData["ID"] = key!;
      excelData["Name"] = "No Name";
      excelData["PaymentApp"] = "Bank";
      if(data["User Mobile Number"] =="nil") {
        excelData["PhoneNumber"] = "No Phone Number";
      }else{
        excelData["PhoneNumber"] = data["User Mobile Number"].toString();
      }
      excelData["Status"] = "Success";
      excelData["Time"] = newDateTime.millisecondsSinceEpoch.toString();
      excelData["Ward"] = "General";
      excelData["district"] = "General";
      excelData["panchayath"] = "General";
      excelData["wardname"] = "General";
      excelData["wardnumber"] = "General";

      mRoot.child("Payment").child(year).child(month).child(day).child(hour)
          .child("HourEntry").child(key)
          .update(excelData);
      String orderRef="Payment/"+year+"/"+month+"/"+day+"/"+hour+"/HourEntry/"+key;
      mRoot.child("PaymentDetails").child(key).child("OrderRef").set(orderRef);

      // }
    }
    if(i==map.length){
      db.collection('Total').doc('Total').update({"Amount": FieldValue.increment(totalAmount)});
      uploadComplete(context, map.length.toString()+" transaction uploaded");
    }
  }
  uploadComplete(BuildContext context,String data) {
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      backgroundColor: Colors.white,
      actions: [
        SizedBox(
          width: 400,
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Upload Successful",
                style: black16,
              ),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      data,
                      style: black16,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          finish(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: 40,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: myGreen,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child:  Text(
                            "OK",
                            style: white16,
                          ),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void increaseLimit(int length) {
    listLength=length;
    notifyListeners();
  }

  void changeStatus(PaymentDetailsOld item) {}



}
