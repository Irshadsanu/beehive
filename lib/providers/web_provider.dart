import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:universal_html/html.dart' as web_file;
import 'package:screenshot/screenshot.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import '../Views/district_analatic_report.dart';
import '../Views/paymen_Entries_model.dart';
import '../Views/receipt_list_model.dart';
import '../Views/time_stamp_model.dart';
import '../Views/ward_model.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../service/time_service.dart';


class WebProvider extends ChangeNotifier{
  ScreenshotController screenshotController = ScreenshotController();
  firebase_storage.Reference ref = FirebaseStorage.instance.ref("iamges");
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;
  int i=0;
  List<PaymentDetails> paymentDetailsList = [];
  List<PaymentEntriesModel> paymentEntriesList = [];


  bool isDate = false;
  bool isDateChanged = false;
  TimeOfDay _time =  TimeOfDay.now();
  DateTime _date =  DateTime.now();
  DateTime scheduledTime=DateTime.now();
  String scheduledDayNode="";
  var outputFormat = DateFormat('yyyy/M/d hh:mm a');
  TextEditingController dateController = TextEditingController();


  ///webside make reciept
  TextEditingController webName = TextEditingController();
  TextEditingController webAmount = TextEditingController();
  TextEditingController webTransactionID = TextEditingController();
  TextEditingController webPhone = TextEditingController();
  TextEditingController webWard = TextEditingController();
  WardModel? wardModel;


  TextEditingController transactionId = TextEditingController();
  TextEditingController nameChangeCt = TextEditingController();


  String shiftDistrict="";
  String shiftAssembly="";
  String shiftPanchayathh="";
  TextEditingController shiftWardFrom = TextEditingController();


  TextEditingController transactionIdController = TextEditingController();
  TextEditingController utrController = TextEditingController();

  ///login
  String password='';

  final DateRangePickerController _dateRangePickerController = DateRangePickerController();


  ///Reports
  List<DistrictAnalyticsReport> distReportArray=[];
  List<DistrictAnalyticsReportOld> distReportLastArray=[];
  List<String> districts=['ALAPPUZHA','ERANAKULAM','IDUKKI','KANNUR','KASERGOD','KOLLAM','KOTTAYAM','KOZHIKODE','MALAPPURAM','PALAKKAD','PATHANAMTHITTA','THIRUVANANTHAPURAM','THRISSUR','WAYANAD'];

  int lastCountTotal=0;
  double lastAmountTotal=0;
  int lastProCountTotal=0;
  double lastProAmountTotal=0;

  int countTotal=0;
  double amountTotal=0;
  int proCountTotal=0;
  double proAmountTotal=0;

  ///issue clearance

  String issueName='';
  String issuePhoneNumber='';
  String issueDistrict='';
  String issueAssembly='';
  String issuePanchayath='';
  String issueWard='';
  String issueWardNumber='';
  String issueAmount='';
  String issueAppVersion='';
  String issueDeviceId='';
  String issueID='';
  String issuePrintStatus='';
  String issueRefNo='';
  String issueTime='';
  String issueUpiID='';
  String issuePayment='';
  bool isPayment=false;
  bool isAddToTotal=false;

  DateTime lastUpdated=DateTime.now();
  DateTime fetchedTime=DateTime.now();

  List<DistrictAnalyticsReport> mandalamWiseList=[];


  WebProvider(){
    checkPassword();
  }


  clearIssues(){
    issueName='';
     issuePhoneNumber='';
     issueDistrict='';
     issueAssembly='';
     issuePanchayath='';
     issueWard='';
     issueWardNumber='';
     issueAmount='';
     issueAppVersion='';
     issueDeviceId='';
     issueID='';
     issuePrintStatus='';
     issueRefNo='';
     issueTime='';
     issueUpiID='';
    issuePayment='';
    isPayment=false;
    isAddToTotal=false;
  }

  String entryExist='';
  String entryStatus='';
  void getUtrDetails(String utr,BuildContext context){

    print(utr.toString()+"dffw3www");
    String transactionId = '';
    db.collection('Entries').where('UTR',isEqualTo:utr).get().then((utrValue) {
      if(utrValue.docs.isNotEmpty){
        print("rwwewr");

        transactionId = utrValue.docs.first.get('TransactionID');
        getIdDetails(transactionId,context);
      }else{
        issueClearanceAlert(context,"No ID Found!!!",'There is No Data With this ID');
        notifyListeners();
      }
    });
  }

  getIdDetails(String tId,BuildContext context){
    clearIssues();
    transactionIdController.text=tId;
    notifyListeners();
    db.collection('Attempts').where('ID',isEqualTo:tId ).get().then((value) {
      if(value.docs.isNotEmpty){
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();

          issueName=map['Name'].toString();
          issuePhoneNumber=map['PhoneNumber'].toString();
          issueDistrict=map['district'].toString();
          issueAssembly=map['assembly'].toString();
          issuePanchayath=map['panchayath'].toString();
          issueWard=map['wardName'].toString();
          issueWardNumber=map['wardNumber'].toString();
          issueAmount=map['Amount'].toString();
          issueAppVersion=map['AppVersion'].toString();
          issueDeviceId=map['DeviceId'].toString();
          issueID=map['ID'].toString();
          issuePrintStatus=map['PrintStatus'].toString();
          issueRefNo=map['RefNo'].toString();
          issueTime=map['Time'].toString();
          issueUpiID=map['UpiID'].toString();
        }
        notifyListeners();
        db.collection('Payments').where('ID',isEqualTo:tId ).get().then((paymentValue) {
          db.collection('Entries').where('TransactionID',isEqualTo:tId ).get().then((entryValue) {
            if(paymentValue.docs.isNotEmpty){
              isPayment=false;
              issuePayment='YES';
              notifyListeners();
            }else{
              isPayment=true;
              issuePayment='NO';
              notifyListeners();
            }
            if(entryValue.docs.isNotEmpty){
              entryExist='AVAILABLE';
              entryStatus=entryValue.docs.first.get('Status').toString();
              notifyListeners();
            }else{
              entryExist='NOT AVAILABLE';
              notifyListeners();
            }
          });
        });

        notifyListeners();
      }
      else{
        issueClearanceAlert(context,"No ID Found!!!",'There is Data With this ID');
        notifyListeners();
      }
    });
    notifyListeners();
  }

  issueClearanceAlert(BuildContext context,String heading,String content) {
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      backgroundColor: Colors.white,
      actions: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text(
                  heading,
                  style: black16,
                ),
                const SizedBox(height: 10,),
                 Align(
                  alignment: Alignment.center,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      content,
                      // style: black16,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      // flex: 1,
                        child: InkWell(
                          onTap: () {
                            finish(context);
                            clearIssues();
                            transactionIdController.clear();
                            notifyListeners();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 40,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Text(
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


  void radioButtonChanges(bool bool) {
    notifyListeners();
    isAddToTotal = bool;
    notifyListeners();
  }

  issueClearance(BuildContext context,String docId,String deviceId,String millis,
      String district,String assembly,String amount) async {

    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));
    var year = DateFormat('yyyy').format(dt);
    var month = DateFormat('M').format(dt);
    var day = DateFormat('d').format(dt);
    var hour = DateFormat('H').format(dt);
    String dayNode = 'Y$year/M$month/D$day/H$hour';

    db.collection("Attempts").doc(docId).get().then((DocumentSnapshot element)  {
      if (element.exists) {
        Map<dynamic, dynamic> map = element.data() as Map;
        map["Status"] = "Success";
        map["PaymentApp"] = "UPLOADED";
        map["Responds"] = "UPLOADED";
        map["Time"] = int.parse(millis);
        map["Receipt Status"]="Viewed";
        map["LastForDigits"]=docId.substring(docId.length-4,docId.length);
        db.collection('Payments').doc(docId).set(map.cast());
        db.collection('MonitorNode').doc(docId).set(map.cast());
        print(docId.toString()+"Aads222");


        db.collection('Attempts').doc(docId).set({"Status":"Success"},SetOptions(merge: true));
        // sendMessage();

        // db.collection('WardTotalAmount').doc('${district}_${assembly}_$booth').update(
        //     {"Amount": FieldValue.increment(double.parse(amount))});



        HashMap<String, Object> map3 = HashMap();
        map3["Amount"] = amount.toString();
        map3["Status"] = "Success";

      }
    });
    issueClearanceAlert(context,"Issue Cleared",'Issue Cleared Successfully');
  }

  // issueLoopClearance(){
  //   db.collection('Payments').where('Time',isGreaterThanOrEqualTo: 1666722600000).where('Time',isLessThanOrEqualTo: 1666726200000).get().then((value) {
  //     print("loop counts  :  "+value.docs.length.toString());
  //     print("loop counts  :  "+value.docs.first.id);
  //     HashMap<String, Object> map = HashMap();
  //
  //     int length = 0;
  //     for (var element in value.docs) {
  //       HashMap<String, Object> map2 = HashMap();
  //
  //       // String millis = element["Time"].toString();
  //       length++;
  //       var dt = DateTime.fromMillisecondsSinceEpoch(element["Time"]);
  //       var year = DateFormat('yyyy').format(dt);
  //       var month = DateFormat('M').format(dt);
  //       var day = DateFormat('d').format(dt);
  //       var hour = DateFormat('H').format(dt);
  //       String dayNode = 'Y$year/M$month/D$day/H0';
  //       String docId = element["ID"];
  //       String deviceId = element["DeviceId"];
  //
  //
  //       print("day nodeeeeee"+dayNode);
  //       print("length : "+length.toString());
  //       print("Time : "+element["Time"].toString());
  //
  //       // print(element["DeviceId"].toString()+"LLLLLLLLLLLLL");
  //
  //       // map[element["ID"]]=element["DeviceId"];
  //
  //       map2["Amount"]=element["Amount"].toString();
  //       map2["AppVersion"]=element["AppVersion"].toString();
  //       map2["DeviceId"]=element["DeviceId"].toString();
  //
  //       map2["ID"]=element["ID"].toString();
  //       map2["Name"]=element["Name"].toString();
  //
  //       map2["PaymentApp"]=element["PaymentApp"].toString();
  //
  //       map2["PaymentUpi"]=element["PaymentUpi"].toString();
  //
  //       map2["PhoneNumber"]=element["PhoneNumber"].toString();
  //
  //       map2["Print Status"] = 'Printed';
  //
  //       map2["PrintStatus"]=element["PrintStatus"].toString();
  //
  //       map2["Receipt Status"]=element["Receipt Status"].toString();
  //       map2["RefNo"]=element["RefNo"].toString();
  //       map2["Responds"]=element["Responds"].toString();
  //
  //       map2["Status"]=element["Status"].toString();
  //       map2["Time"]=element["Time"].toString();
  //       map2["UpiID"]=element["UpiID"].toString();
  //       map2["Ward"]=element["Ward"].toString();
  //       map2["district"]=element["district"].toString();
  //       map2["panchayath"]=element["panchayath"].toString();
  //       map2["wardname"]=element["wardname"].toString();
  //       map2["wardnumber"]=element["wardnumber"].toString();
  //
  //
  //       // map[element["ID"]]=map2;
  //
  //       print(map2.toString()+"FYHT");
  //
  //       mRoot.child("Payment").child(dayNode).child("HourEntry").child(docId).set(map2);
  //       String ref = 'Payment/$dayNode/HourEntry/$docId';
  //       mRoot.child("PaymentDetails").child(docId).child("OrderRef").set(ref);
  //       mRoot.child("UserPayments").child(deviceId).child(docId).child("OrderRef").set(ref);
  //
  //
  //     }
  //     // mRoot.child("TESTSPINE123").set(map);
  //     // print(map.toString()+"WEFRGYRt");
  //
  //   });
  // }

  // String getDateFormat(String millis) {
  //   var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));
  //   var year = DateFormat('yyyy').format(dt);
  //   var month = DateFormat('M').format(dt);
  //   var day = DateFormat('d').format(dt);
  //   var hour = DateFormat('H').format(dt);
  //   print("timerrrr"+hour.toString());
  //   var d12 = DateFormat('dd/MM/yyyy hh:mm a').format(dt);
  //   return d12.toString();
  //
  // }



  createImage(ScreenshotController screenshotController) async {
    await screenshotController
        .capture().then((Uint8List? image) async {
      if (image != null) {

        ByteData bytes=ByteData.view(image.buffer);

        var blob = web_file.Blob([bytes], 'image/png', 'native');
        String path=DateTime.now().millisecondsSinceEpoch.toString();
        var anchorElement = web_file.AnchorElement(href: web_file.Url.createObjectUrlFromBlob(blob).toString(),);
        anchorElement.download=path;
        anchorElement.click();
      }


      // Handle captured image
    });
  }



  fetchExcel(BuildContext context,DateTime now){

    String dayNode = 'Y${now.year}/M${now.month}/D${now.day}';
    uploadLoading(context, 100);
    mRoot.child('Payment').child(dayNode).once().then((event) {
      paymentDetailsList.clear();
      if(event.snapshot.exists){
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        map.forEach((hKey, hValue) {
          if(hValue['HourEntry']!=null){
            hValue['HourEntry'].forEach((key, value) {
              String receiptStatus="notViewed";
              if( value['Receipt Status']!=null){
                receiptStatus="Viewed";
              }
              double amount= 0;
              try{
                amount =double.parse(value['Amount'].toString().replaceAll(",", ''));

              }catch(e){
                print(key);
              }
                paymentDetailsList.add(
                    PaymentDetails(
                    key, value['Amount'].toString(), value['Name'].toString(), value['PaymentApp'].toString(),
                    value['PhoneNumber'].toString(), value['Status'].toString(), value['Time'].toString(), value['Ward'].toString(), value["district"].toString(),
                    value["panchayath"].toString(), value["wardName"].toString(), value["wardNumber"].toString(),value['UpiID']??'NIL',
                        value['RefNo']??'NIL',
                        receiptStatus,value["PaymentUpi"]??'NIL',
                        value["EnrollerName"]??"NILL",
                        value["NameShowStatus"]??"NIL",
                        value["Age"]??"NIL",
                        map["EnrollerId"]??"NILL",
                        map["Platform"]??"NILL",
                        map["DeviceId"]??"NILL",
                      map["Payment Category"]??"NILL",

                    )
                );
                print(paymentDetailsList.length);
            });
          }

        });
      }
      finish(context);
    });
  }
  fetchExcelFireStore(BuildContext context,int start,int end){

    uploadLoading(context, 100);
    db.collection('Payments').where("Time", isGreaterThanOrEqualTo:start ).where("Time", isLessThanOrEqualTo:end).get().then((event) {
      paymentDetailsList.clear();
      if(event.docs.isNotEmpty){
        for (var element in event.docs) {
          Map<dynamic, dynamic> map = element.data() as Map;

          String receiptStatus="notViewed";
          String paymentUpi="Nil";
          if( element.data().containsKey("Receipt Status")){
            receiptStatus="Viewed";
          }
          if( element.data().containsKey("PaymentUpi")){
            paymentUpi=element.get('PaymentUpi').toString();
          }
          paymentDetailsList.add(PaymentDetails(
              element.id,
              map['Amount'].toString(),
              map['Name'].toString(),
              map['PaymentApp'].toString(),
              map['PhoneNumber'].toString(),
              map['Status'].toString(),
              map['Time'].toString(),
              map['Ward'].toString(),
              map['district'].toString(),
              map['assembly'].toString(),
              map['panchayath'].toString(),
              map['wardName'].toString(),
              map['wardNumber'].toString(),
              map['UpiID'].toString(),
              map['RefNo'].toString(),
              receiptStatus,paymentUpi,
              map['EnrollerName']??"NILL",
              map['NameShowStatus'].toString(),
              map["EnrollerId"]??"NILL",
              map["Platform"]??"NILL",
            map["DeviceId"]??"NILL",
            map["Payment Category"]??"NILL",
          ));
          print(paymentDetailsList.length);

          notifyListeners();

          // if(element.id=='1667110042595'){
          //   print("testing issue id Amount "+element.data()['Amount'].toString());
          //   print("testing issue id Name "+element.data()['Name'].toString(),);
          //   print("testing issue id PaymentApp "+element.data()['PaymentApp'].toString(),);
          //   print("testing issue id PhoneNumber "+element.data()['PhoneNumber'].toString(),);
          //   print("testing issue id Status "+element.data()['Status'].toString(),);
          //   print("testing issue id Time "+element.data()['Time'].toString(),);
          //   print("testing issue id Ward "+element.data()['Ward'].toString(),);
          //   print("testing issue id district "+element.data()['district'].toString(),);
          //   print("testing issue id panchayath "+element.data()['panchayath'].toString(),);
          //   print("testing issue id wardname "+element.data()['wardname'].toString(),);
          //   print("testing issue id wardnumber "+element.data()['wardnumber'].toString(),);
          //   print("testing issue id UpiID "+element.data()['UpiID'].toString(),);
          //   print("testing issue id RefNo "+element.data()['RefNo'].toString(),);
          //   print("testing issue id receiptStatus "+receiptStatus);
          //   print("testing issue id paymentUpi "+paymentUpi);
          // }



        }
      }
      finish(context);

    });
  }
  void createExcel(List<PaymentDetails> historyList) async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];
    final List<Object> list = [
      'DATE',
      'HOUR',
      'TIME',
      'TIME IN MILLIS',
      'TRANSACTION ID',
      'AMOUNT',
      'NAME',
      'PAYMENT APP',
      'PHONE NUMBER',
      'STATUS',
      'WARD',
      'DISTRICT',
      'ASSEMBLY',
      'PANCHAYATH',
      'WARD NAME',
      'WARD NUMBER',
      'UPI ID',
      'REF NO',
      'PAYMENT UPI ID',
      'ENROLLER',
      'ENROLLER ID',
      'DEVICE ID',
    ];
    const int firstRow = 1;

    const int firstColumn = 1;

    const bool isVertical = false;

    sheet.importList(list, firstRow, firstColumn, isVertical);
    int i = 1;
    for (var element in historyList) {
      int time= 00000000000;
      try{
        time =int.parse(element.time);
      }catch(e){

      }
      double amount= 0;
      try{
        amount =double.parse(element.amount.replaceAll(",", ''));

      }catch(e){
        print(element.id);
      }

      i++;
      final List<Object> list = [
        getDate(time.toString()),
        getHour(time.toString()),
        getTime(time.toString()),
        element.time,
        element.id,
        amount,
        element.name,
        element.paymentApp,
        element.phoneNumber,
        element.status,
        element.ward,
        element.district,
        element.assembly,
        element.panchayath,
        element.wardName,
        element.wardNumber,
        element.upiId==''?'NIL':element.upiId,
        element.refNo==''?'NIL':element.refNo,
        element.paymentUpiId,
        element.enroller,
        element.enrollerId,
        element.deviceId,
      ];
      final int firstRow = i;

      const int firstColumn = 1;

      const bool isVertical = false;

      sheet.importList(list, firstRow, firstColumn, isVertical);
    }

    sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if(!kIsWeb){
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
    else{

      var blob = web_file.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'native');

      var anchorElement = web_file.AnchorElement(
        href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
      )..setAttribute("download", "data.xlsx")..click();
    }

  }

  Future<void> uploadToFirebase(List <dynamic> map,BuildContext context) async {
    i=0;
    double totalAmount=0.0;
    uploadLoading(context,map.length);
    for(var data in map){
      i++;
      notifyListeners();
      try{
        double amount=double.parse(data["Amount"].toString());

        String? key = data["Transaction ID"].toString();

        var dateTime = DateTime.tryParse(data["Txn Date"].toString());
        String year = "Y" + dateTime!.year.toString();
        String month = "M" + dateTime.month.toString();
        String day = "D" + dateTime.day.toString();
        String hour = "H" + dateTime.hour.toString();


        HashMap<String, Object> excelData = HashMap();
        excelData["Amount"] = data["Amount"].toString();
        excelData["ID"] = key;
        excelData["Name"] = "No Name";
        excelData["PaymentApp"] = "Bank";
        excelData["PhoneNumber"] = "No Phone Number";
        excelData["Status"] = "Success";
        excelData["Time"] = dateTime.millisecondsSinceEpoch.toString();
        excelData["Ward"] = "General";
        excelData["district"] = "General";
        excelData["panchayath"] = "General";
        excelData["wardname"] = "General";
        excelData["wardnumber"] = "General";
        excelData["UpiID"] = "";
        excelData["RefNo"] = "";
        excelData["Check"] = "true";
        String orderRef = "Payment/" + year + "/" + month + "/" + day + "/" +
            hour + "/HourEntry/" + key;
        await mRoot.child("PaymentDetails").child(key).child("OrderRef").set(
            orderRef);
        await mRoot.child("Payment").child(year).child(month).child(day).child(hour)
            .child("HourEntry").child(key)
            .update(excelData);
        HashMap<String, Object> excelDataStore = excelData;
        excelDataStore["Amount"] = double.parse(data["Amount"].toString());
        excelDataStore['Time']=dateTime.millisecondsSinceEpoch;
        excelDataStore['LastForDigits']=key.substring(key.length-4,key.length);



        db.collection('Payments').doc(key).set(excelData);
        totalAmount = totalAmount + double.tryParse(data["Amount"].toString())!;

      }catch(e){
        print(e);
        print('Error________________________________ on $i');

      }



    }
    if(i==map.length){
      finish(context);
      db.collection('Total').doc('Total').update({"Amount": FieldValue.increment(totalAmount)});
      uploadComplete(context, map.length.toString()+" transaction uploaded");
    }
  }
  Future<void> uploadNewToFirebase(List <dynamic> map,BuildContext context) async {
    double totalAmount=0.0;
    i=0;

    uploadLoading(context,map.length);
    for(var data in map){
      i++;
      notifyListeners();
      try{
       double amount=double.parse(data["Amount(Rs.)"].toString());

        String d=data["Transaction Date"]+" "+data["Transaction Time"]+" "+data["Corporate ID"].toString();
        var newDateTime =  DateFormat("dd-MMM-yy hh:mm:ss aa").parse(d);


        String? key =data['Mintoak Transaction ID'].toString();
        String year = "Y" + newDateTime.year.toString();
        String month = "M" + newDateTime.month.toString();
        String day = "D" + newDateTime.day.toString();
        String hour = "H" + newDateTime.hour.toString();

        HashMap<String, Object> excelData = HashMap();
        excelData["Amount"] = data["Amount(Rs.)"].toString();
        excelData["ID"] = key;
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
        excelData["UpiID"] = "";
        excelData["RefNo"] = "";

        await mRoot.child("Payment").child(year).child(month).child(day).child(hour)
            .child("HourEntry").child(key)
            .update(excelData);
        String orderRef="Payment/"+year+"/"+month+"/"+day+"/"+hour+"/HourEntry/"+key;
        await mRoot.child("PaymentDetails").child(key).child("OrderRef").set(orderRef);
        HashMap<String, Object> excelDataStore = excelData;
        excelDataStore["Amount"] = double.parse(data["Amount(Rs.)"].toString());
        excelDataStore['Time']=newDateTime.millisecondsSinceEpoch;
        excelDataStore['LastForDigits']=key.substring(key.length-4,key.length);

        db.collection('Payments').doc(key).set(excelData);
        totalAmount=totalAmount+double.tryParse(data["Amount(Rs.)"].toString())!;

      }catch(e){
        print(e);

        print('Error________________________________ on $i');

      }


    }
    if(i==map.length){
      finish(context);
      db.collection('Total').doc('Total').update({"Amount": FieldValue.increment(totalAmount)});
      uploadComplete(context, map.length.toString()+" transaction uploaded");
    }
  }
  Future<void> uploadToFirebaseExcelFormatted(List <dynamic> map,BuildContext context) async {
    i=0;
    double totalAmount=0.0;
    uploadLoading(context,map.length);
    for(var data in map){
      i++;
      notifyListeners();
      String key = DateTime.now().millisecondsSinceEpoch.toString();

      double amount=0;
      String name='No Name';
      String paymentApp='Bank';
      String phoneNumber='No Phone Number';
      String status='Success';
      int    time=DateTime.now().millisecondsSinceEpoch;
      String ward='General';
      String district='General';
      String panchayath='General';
      String wardname='General';
      String wardnumber='General';
      String upiId='NIL';
      String refNo='NIL';

      try{

        key = data["TRANSACTION ID"].toString();
        amount=double.parse(data["AMOUNT"].toString());
        name=data["NAME"].toString();
        paymentApp=data["PAYMENT APP"].toString();
        phoneNumber=data["PHONE NUMBER"].toString();
        status=data["STATUS"].toString();
        time=int.parse(data["TIME IN MILLIS"].toString());
        ward=data["WARD"].toString();
        district=data["DISTRICT"].toString();
        panchayath=data["PANCHAYATH"].toString();
        wardname=data["WARD NAME"].toString();
        wardnumber=data["WARD NUMBER"].toString();
        upiId=data["UPI ID"].toString();
        refNo=data["REF NO"].toString();

        var dateTime = DateTime.fromMillisecondsSinceEpoch(time);
        String year = "Y" + dateTime.year.toString();
        String month = "M" + dateTime.month.toString();
        String day = "D" + dateTime.day.toString();
        String hour = "H" + dateTime.hour.toString();


        HashMap<String, Object> excelData = HashMap();
        excelData["Amount"] =amount.toString();
        excelData["ID"] = key;
        excelData["Name"] = name;
        excelData["PaymentApp"] =  paymentApp;
        excelData["PhoneNumber"] = phoneNumber;
        excelData["Status"] = status;
        excelData["Time"] = dateTime.millisecondsSinceEpoch.toString();
        excelData["Ward"] = ward;
        excelData["district"] = district;
        excelData["panchayath"] = panchayath;
        excelData["wardname"] = wardname;
        excelData["wardnumber"] = wardnumber;
        excelData["UpiID"] = upiId;
        excelData["RefNo"] = refNo;
        excelData["Check"] = "true";
        String orderRef = "Payment/" + year + "/" + month + "/" + day + "/" +
            hour + "/HourEntry/" + key;
        await mRoot.child("PaymentDetails").child(key).child("OrderRef").set(orderRef);
        await mRoot.child("Payment").child(year).child(month).child(day).child(hour).child("HourEntry").child(key).update(excelData);
        HashMap<String, Object> excelDataStore = excelData;
        excelDataStore["Amount"] = amount;
        excelDataStore['Time']=dateTime.millisecondsSinceEpoch;
        excelDataStore['LastForDigits']=key.substring(key.length-4,key.length);



        db.collection('Payments').doc(key).set(excelData);
        // db.collection('WardTotalAmount').doc('${district}_${panchayath}_$wardname').update({"Amount": FieldValue.increment(int.parse(amountTC.text))});
        totalAmount = totalAmount + amount;

      }catch(e){
        print(e);

        print('Error________________________________ on $i');
      }




    }
    if(i==map.length){
      finish(context);
      uploadComplete(context, map.length.toString()+" transaction uploaded");
    }
  }
  Future<void> uploadToFirebaseExcelFormattedTotal(List <dynamic> map,BuildContext context) async {
    i=0;
    double totalAmount=0.0;
    uploadLoading(context,map.length);
    for(var data in map){
      i++;
      notifyListeners();
      String key = DateTime.now().millisecondsSinceEpoch.toString();

      double amount=0;
      String name='No Name';
      String paymentApp='Bank';
      String phoneNumber='No Phone Number';
      String status='Success';
      int    time=DateTime.now().millisecondsSinceEpoch;
      String ward='General';
      String district='General';
      String panchayath='General';
      String wardname='General';
      String wardnumber='General';
      String upiId='NIL';
      String refNo='NIL';

      try{
        key = data["TRANSACTION ID"].toString();
        amount=double.parse(data["AMOUNT"].toString());
        name=data["NAME"].toString();
        paymentApp=data["PAYMENT APP"].toString();
        phoneNumber=data["PHONE NUMBER"].toString();
        status=data["STATUS"].toString();
        time=int.parse(data["TIME IN MILLIS"].toString());
        ward=data["WARD"].toString();
        district=data["DISTRICT"].toString();
        panchayath=data["PANCHAYATH"].toString();
        wardname=data["WARD NAME"].toString();
        wardnumber=data["WARD NUMBER"].toString();
        upiId=data["UPI ID"].toString();
        refNo=data["REF NO"].toString();

        var dateTime = DateTime.fromMillisecondsSinceEpoch(time);
        String year = "Y" + dateTime.year.toString();
        String month = "M" + dateTime.month.toString();
        String day = "D" + dateTime.day.toString();
        String hour = "H" + dateTime.hour.toString();


        HashMap<String, Object> excelData = HashMap();
        excelData["Amount"] =amount.toString();
        excelData["ID"] = key;
        excelData["Name"] = name;
        excelData["PaymentApp"] =  paymentApp;
        excelData["PhoneNumber"] = phoneNumber;
        excelData["Status"] = status;
        excelData["Time"] = dateTime.millisecondsSinceEpoch.toString();
        excelData["Ward"] = ward;
        excelData["district"] = district;
        excelData["panchayath"] = panchayath;
        excelData["wardname"] = wardname;
        excelData["wardnumber"] = wardnumber;
        excelData["UpiID"] = upiId;
        excelData["RefNo"] = refNo;
        excelData["Check"] = "true";
        String orderRef = "Payment/" + year + "/" + month + "/" + day + "/" +
            hour + "/HourEntry/" + key;
        await mRoot.child("PaymentDetails").child(key).child("OrderRef").set(orderRef);
        await mRoot.child("Payment").child(year).child(month).child(day).child(hour).child("HourEntry").child(key).update(excelData);
        HashMap<String, Object> excelDataStore = excelData;
        excelDataStore["Amount"] = amount;
        excelDataStore['Time']=dateTime.millisecondsSinceEpoch;
        excelDataStore['LastForDigits']=key.substring(key.length-4,key.length);



        db.collection('Payments').doc(key).set(excelData);
        // db.collection('WardTotalAmount').doc('${district}_${panchayath}_$wardname').update({"Amount": FieldValue.increment(int.parse(amountTC.text))});
        totalAmount = totalAmount + amount;

      }catch(e){
        print(e);

        print('Error________________________________ on $i');
      }




    }
    if(i==map.length){
      finish(context);
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
  uploadLoading(BuildContext context,int total) {
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      shape: const RoundedRectangleBorder(

          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      backgroundColor: Colors.white,
      actions: [
        Row(
          children:  [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircularProgressIndicator(color: Colors.blue),
            ),
            const SizedBox(width: 10,),
            Consumer<WebProvider>(
                builder: (context,value,child) {
                  return Text(value.i.toString()+"/");
                }
            ),
            Text(total.toString()+" Uploading..."),
          ],
        )      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  getDate(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));

    var d12 = DateFormat('dd-MMM-yy').format(dt);
    return d12;
  }
  getTime(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));
    var d12 = DateFormat('hh:mm:ss a').format(dt);
    return d12;
  }
  getHour(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));
    var d12 = DateFormat('hh').format(dt);
    return d12;
  }
  Future<void> selectDate(BuildContext context,String from) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate:  DateTime(2100),
    );

    if (picked != null) {
      if(from=='firestore'){
      }else{
        fetchExcel(context, picked);

      }
    }
  }

  void uploadWard(List map, BuildContext context) async{

    for(var data in map){
      print("aaaaaaaaaa"+data['Value.wardname'].toString());
      HashMap<String, Object> excelData = HashMap();
      excelData['district']=data['Value.district'].toString();
      excelData['assembly']=data['Value.assembly'].toString();
      excelData['panchayath']=data['Value.panchayath'].toString();
      excelData['wardname']=data['Value.wardname'].toString();
      excelData['wardnumber']=data['Value.wardnumber'].toString();
      excelData['Target']=data['Value.target'].toString();

     await mRoot.child('NewWards').child(data['Value.wardnumber'].toString()).set(excelData);
      HashMap<String, Object> fireStore = HashMap();
      fireStore['district']=data['Value.district'].toString();
      fireStore['assembly']=data['Value.assembly'].toString();
      fireStore['panchayath']=data['Value.panchayath'].toString();
      fireStore['wardname']=data['Value.wardname'].toString();
      fireStore['Amount']=0;
      fireStore['TRANSACTION_COUNT']=0;
      fireStore['Target']=num.parse(data['Value.target'].toString());



      await db.collection('WardTotalAmount').doc('${data['Value.district'].toString()}'
         '_${data['Value.panchayath'].toString()}_${data['Value.wardname'].toString()}').set(fireStore);
     // await db.collection("PANCHAYATH_TOTAL").doc('${data['Value.district'].toString()}'
     //     '_${data['Value.assembly'].toString()}_${data['Value.panchayath'].toString()}').set(fireStore3);
     //  await db.collection("ASSEMBLY_TOTAL").doc('${data['Value.district'].toString()}'
     //      '_${data['Value.assembly'].toString()}').set(fireStore4);

    }
    /// for setting ward total 0
    // var jsonText = await rootBundle.loadString('assets/ward_database.json');
    // var jsonResponse = json.decode(jsonText.toString());
    //
    // Map <dynamic, dynamic> map = jsonResponse as Map;
    // map.forEach((key, value) async {
    //   print(key);
    //     HashMap<String, Object> excelData = HashMap();
    //
    //     excelData['Amount']=0;
    //     excelData['district']=value['district'].toString();
    //     excelData['panchayath']=value['panchayath'].toString();
    //     excelData['wardname']=value['wardname'].toString();
    //    await db.collection('WardTotalAmount').doc('${value['district'].toString()}_${value['panchayath'].toString()}_${value['wardname'].toString()}').set(excelData);
    //
    // });

  }
  void hideWard(List map, BuildContext context) async{

    for(var data in map) {
      print("aaaaaaaaaa" + data['Value.wardname'].toString());
      HashMap<String, Object> excelData = HashMap();
      excelData['district'] = data['Value.district'].toString();
      excelData['assembly'] = data['Value.assembly'].toString();
      excelData['panchayath'] = data['Value.panchayath'].toString();
      excelData['wardname'] = data['Value.wardname'].toString();
      excelData['wardnumber'] = data['Value.wardnumber'].toString();

      await mRoot.child('hidewards').child(data['Value.wardnumber'].toString()).set(excelData);
      await db.collection('WardTotalAmount').doc('${data['Value.district'].toString()}''_${data['Value.panchayath'].toString()}_${data['Value.wardname'].toString()}').delete();
    }
  }
  void uploadWardWithoutZero(List map, BuildContext context) async{

    for(var data in map){
      print("aaaaaaaaaa"+data['Value.wardname'].toString());
      HashMap<String, Object> excelData = HashMap();
      excelData['district']=data['Value.district'].toString();
      excelData['assembly']=data['Value.assembly'].toString();
      excelData['panchayath']=data['Value.panchayath'].toString();
      excelData['wardname']=data['Value.wardname'].toString();
      excelData['wardnumber']=data['Value.wardnumber'].toString();

     await mRoot.child('NewWards').child(data['Value.wardnumber'].toString()).set(excelData);
      HashMap<String, Object> fireStore = HashMap();
      fireStore['district']=data['Value.district'].toString();
      fireStore['assembly']=data['Value.assembly'].toString();
      fireStore['panchayath']=data['Value.panchayath'].toString();
      fireStore['wardname']=data['Value.wardname'].toString();
      // fireStore['Amount']=0;
      // fireStore['TRANSACTION_COUNT']=0;
      HashMap<String, Object> fireStore3 = HashMap();
      fireStore3['DISTRICT']=data['Value.district'].toString();
      fireStore3['ASSEMBLY']=data['Value.assembly'].toString();
      fireStore3['PANCHAYATH']=data['Value.panchayath'].toString();
      // fireStore3['AMOUNT']=0;
      // fireStore3['TRANSACTION_COUNT']=0;
      HashMap<String, Object> fireStore4 = HashMap();
      fireStore4['DISTRICT']=data['Value.district'].toString();
      fireStore4['ASSEMBLY']=data['Value.assembly'].toString();
      // fireStore4['AMOUNT']=0;
      // fireStore4['TRANSACTION_COUNT']=0;


      await db.collection('WardTotalAmount').doc('${data['Value.district'].toString()}''_${data['Value.panchayath'].toString()}_${data['Value.wardname'].toString()}').set(fireStore);
     await db.collection("PANCHAYATH_TOTAL").doc('${data['Value.district'].toString()}''_${data['Value.assembly'].toString()}_${data['Value.panchayath'].toString()}').set(fireStore3);
      await db.collection("ASSEMBLY_TOTAL").doc('${data['Value.district'].toString()}''_${data['Value.assembly'].toString()}').set(fireStore4);

    }
    /// for setting ward total 0
    // var jsonText = await rootBundle.loadString('assets/ward_database.json');
    // var jsonResponse = json.decode(jsonText.toString());
    //
    // Map <dynamic, dynamic> map = jsonResponse as Map;
    // map.forEach((key, value) async {
    //   print(key);
    //     HashMap<String, Object> excelData = HashMap();
    //
    //     excelData['Amount']=0;
    //     excelData['district']=value['district'].toString();
    //     excelData['panchayath']=value['panchayath'].toString();
    //     excelData['wardname']=value['wardname'].toString();
    //    await db.collection('WardTotalAmount').doc('${value['district'].toString()}_${value['panchayath'].toString()}_${value['wardname'].toString()}').set(excelData);
    //
    // });

  }
  void selectWebWard(WardModel item){
    webWard.text=item.wardName;
    wardModel =item;
    notifyListeners();
  }
  Future<void> selectDateAndTime(BuildContext context) async {

    await _selectDate(context);
    await _selectTime(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate:  DateTime(2100),
    );

    if (picked != null) {
      _date = picked;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (picked != null) {
      _time = picked;
      scheduledDayNode=_date.year.toString()+'/'+_date.month.toString()+'/'+_date.day.toString();
      scheduledTime =  DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);
      dateController.text=outputFormat.format(scheduledTime);
    }
  }
  var outputDayNode = DateFormat('d/MM/yyy');
  Future<void> makeReceipt() async {
    // String? key = DateTime.now().millisecondsSinceEpoch.toString();
    String timeString="";

    DateTime now =DateTime.now();

    String?  key = DateTime.now().microsecondsSinceEpoch.toString()+generateRandomString(2);


    if(webTransactionID.text.isNotEmpty){

      key = webTransactionID.text;

    }


    TimeStampModel? timeStampModel=await TimeService().getTime();

    if(timeStampModel!=null){
      now = timeStampModel.datetime.toLocal();
      timeString = outputDayNode.format(now).toString();
      print(now.toString()+"ttyyuu");
      print(timeString+"ttyyuu");
    }

    print(timeString+"yeyeyyyee");
    DateTime? dateTime=scheduledTime;

    HashMap<String, Object> recieptData = HashMap();
    recieptData["Amount"] = webAmount.text;

    recieptData["Name"] = webName.text != '' ? webName.text : 'No Name';
    recieptData["PhoneNumber"] = webPhone.text != '' ? webPhone.text : 'No Phone Number';
    recieptData["Ward"] = webWard.text != '' ? webWard.text : 'General';
    recieptData["ID"] = key;
    recieptData["PaymentApp"] = "Bank";
    recieptData["Status"] = "Success";
    recieptData["Time"] = dateTime.millisecondsSinceEpoch.toString();
    recieptData["Payment_Date"] = timeString;
    recieptData['NameShowStatus']='YES';
    String district = '';
    String assembly = '';
    String panchayath = '';
    String wardName = '';
    String wardNumber= '';
    if (wardModel != null) {
      district = wardModel!.district;
      assembly = wardModel!.assembly;
      panchayath = wardModel!.panchayath;
      wardName = wardModel!.wardName;
      wardNumber = wardModel!.wardNumber;
    } else {
      district = 'General';
      assembly = 'General';
      panchayath = 'General';
      wardName = 'General';
      wardNumber = 'General';
    }
    print( wardModel!.panchayath.toString()+"panchayath");
    print( wardModel!.wardName.toString()+"wardName");
    print( wardModel!.wardNumber.toString()+"wardNumber");
    print( wardModel!.assembly.toString()+"assembly");
    print( wardModel!.district.toString()+"district");

    recieptData["district"]=district;
    recieptData["assembly"]=assembly;
    recieptData["panchayath"]=panchayath;
    recieptData["wardName"]=wardName;
    recieptData["wardNumber"]=wardNumber;
    recieptData["UpiID"] = "";
    recieptData["RefNo"] = "";
    recieptData["From"] = "MakeReceipt";
    recieptData["Receipt Status"] = "notViewed";


    HashMap<String, Object> excelDataStore = HashMap();
    excelDataStore= recieptData;
    excelDataStore["Amount"] = int.parse(webAmount.text);
    excelDataStore['Time']=dateTime.millisecondsSinceEpoch;
    excelDataStore['LastForDigits']=key.substring(key.length-4,key.length);


    db.collection('Payments').doc(key).set(excelDataStore);
    db.collection('MonitorNode').doc(key).set(excelDataStore);
    String node='${district}_${panchayath}_$wardName';
    // await db.collection('WardTotalAmount').doc(node).set({"Amount": FieldValue.increment(double.parse(webAmount.text))},SetOptions(merge: true));

    notifyListeners();
  }
  String paymentCount="";
  String paymentCountPAnchayath="";
  Future<void> getPaymentCount(BuildContext context,String district,String assembly,String panchayath,String ward) async {
    print("eyywise"+district+"_"+assembly+"_"+ward);

    var payments = await db.collection("Payments").where("district",isEqualTo:district).where("assembly",isEqualTo:assembly).where("panchayath",isEqualTo: panchayath).where("wardName",isEqualTo:ward).get();

    if(payments.docs.isNotEmpty){

      paymentCount=payments.docs.length.toString();
      notifyListeners();
      // for(var element in payments.docs){
      //   i++;
      //
      //   print("payments : $i");
      // }

    }else{
      paymentCount="";
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text("DATA NOT FOUND"),
        duration: Duration(milliseconds: 3000),
      ));

    }

  }
  Future<void> getPaymentCountPanchayath(BuildContext context,String district,String assembly,String panchayath) async {
    print("eyywise"+district+"_"+assembly+"_"+panchayath);

    var payments = await db.collection("Payments").where("district",isEqualTo:district).where("assembly",isEqualTo:assembly).where("panchayath",isEqualTo:panchayath).get();

    if(payments.docs.isNotEmpty){

      paymentCountPAnchayath=payments.docs.length.toString();
      notifyListeners();
      // for(var element in payments.docs){
      //   i++;
      //
      //   print("payments : $i");
      // }

    }else{
      paymentCountPAnchayath="";
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text("DATA NOT FOUND"),
        duration: Duration(milliseconds: 3000),
      ));

    }

  }
  Future<void> shiftWard(BuildContext context,String district,String assembly,String panchayath,String fromWard) async {



    var payments = await db.collection("Payments").where("district",isEqualTo:district).where("assembly",isEqualTo:assembly).where("panchayath",isEqualTo: panchayath).where("wardName",isEqualTo:fromWard).get();
    String wardName = '';
    if (wardModel != null) {

      wardName = wardModel!.wardName;

    } else {

      wardName = 'General';

    }
    print(wardName+"sdsdswwe44");
    print("eyywise"+district+"_"+assembly+"_"+wardName);
    if(payments.docs.isNotEmpty){
      print(payments.docs.length.toString()+"totaalconutt");
      for(var element in payments.docs){
        i++;


        await db.collection("Payments").doc(element.id).set({"wardName":wardName},SetOptions(merge: true));
        await db.collection("MonitorNode").doc(element.id).set({"wardName":wardName},SetOptions(merge: true));

        print("payments : $i");
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        backgroundColor: Colors.blue,
        content: Text("CHANGE COMPLETED"),
        duration: Duration(milliseconds: 3000),
      ));
      finish(context);

    }else{
      print("not exist");
    }


    // db.collection(collectionPath)


  }
  void clearShiftwardData(){
    shiftDistrict="";
    shiftAssembly="";
    shiftPanchayathh="";
    shiftWardFrom.text="";
    notifyListeners();



  }
  Future<void> shiftPanchayath(String district,String assembly,String fromPanchayath) async {



    var payments = await db.collection("Payments").where("district",isEqualTo:district).where("assembly",isEqualTo:assembly).where("panchayath",isEqualTo:fromPanchayath).get();
    String wardName = '';
    if (wardModel != null) {

      wardName = wardModel!.panchayath;

    } else {

      wardName = 'General';

    }
    print(wardName+"sdsdswwe44");
    print("eyywise"+district+"_"+assembly+"_"+wardName);
    if(payments.docs.isNotEmpty){
      print(payments.docs.length.toString()+"totaalconutt");
      for(var element in payments.docs){
        i++;


        await db.collection("Payments").doc(element.id).set({"panchayath":wardName},SetOptions(merge: true));
        await db.collection("MonitorNode").doc(element.id).set({"panchayath":wardName},SetOptions(merge: true));

        print("payments : $i");
      }

    }else{
      print("not exist");
    }


    // db.collection(collectionPath)


  }
  Future<void> selectDateForDayTotal(BuildContext context,String from) async {
    DateTimeRangePicker(
        startText: "From",
        endText: "To",
        doneText: "Yes",
        cancelText: "Cancel",
        interval: 5,
        initialStartTime: DateTime.now(),
        initialEndTime: DateTime.now(),
        mode: DateTimeRangePickerMode.dateAndTime,
        minimumTime: DateTime(2000),
        maximumTime: DateTime(2200),
        use24hFormat: true,
        onConfirm: (start, end) {
          if(from=='FireStore'){

            fetchExcelFireStore(context,start.millisecondsSinceEpoch,end.millisecondsSinceEpoch);
          }else{

            getDayTotal(start.millisecondsSinceEpoch, end.millisecondsSinceEpoch);

          }
        }).showPicker(context);
  }

  void getDayTotal(int fromDate,int toDate) {
    double total=0;
    db.collection('Payments').where("Time", isGreaterThan:fromDate ).where("Time", isLessThan:toDate).get().then((value){
      total=0;

      if(value.docs.isNotEmpty){
        for (var element in value.docs) {
          total=total+double.parse(element.get('Amount').toString());
          print(total);
        }}
    });
  }
  // Future<void> uploadToFirebaseExcelFormatted(List <dynamic> map,BuildContext context,DateTime now) async {
  //   i=0;
  //   double totalAmount=0.0;
  //   uploadLoading(context,map.length);
  //
  //   String dayNode = 'Y${now.year}/M${now.month}/D${now.day}';
  //   uploadLoading(context, 100);
  //   mRoot.child('Payment').child(dayNode).onValue.listen((event) {
  //     paymentDetailsList.clear();
  //     if(event.snapshot.exists){
  //       Map<dynamic, dynamic> mapPayment = event.snapshot.value as Map;
  //       mapPayment.forEach((hKey, hValue) {
  //         if(hValue['HourEntry']!=null){
  //           hValue['HourEntry'].forEach((key, value) async {
  //             print('Staaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaart');
  //             for(var data in map){
  //
  //               if(data["TRANSACTION ID"].toString()==key){
  //                 print('Staaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaart2');
  //
  //                 mRoot.child('Payment').child(dayNode).child(hKey).child(data["TRANSACTION ID"].toString()).remove();
  //
  //                 i++;
  //                 notifyListeners();
  //                 String key = DateTime.now().millisecondsSinceEpoch.toString();
  //
  //                 double amount=0;
  //                 String name='No Name';
  //                 String paymentApp='Bank';
  //                 String phoneNumber='No Phone Number';
  //                 String status='Success';
  //                 int    time=DateTime.now().millisecondsSinceEpoch;
  //                 String ward='General';
  //                 String district='General';
  //                 String panchayath='General';
  //                 String wardname='General';
  //                 String wardnumber='General';
  //                 String upiId='NIL';
  //                 String refNo='NIL';
  //
  //                 try{
  //
  //                   key = data["TRANSACTION ID"].toString();
  //                   amount=double.parse(data["AMOUNT"].toString());
  //                   name=data["NAME"].toString();
  //                   paymentApp=data["PAYMENT APP"].toString();
  //                   phoneNumber=data["PHONE NUMBER"].toString();
  //                   status=data["STATUS"].toString();
  //                   time=int.parse(data["TIME IN MILLIS"].toString());
  //                   ward=data["WARD"].toString();
  //                   district=data["DISTRICT"].toString();
  //                   panchayath=data["PANCHAYATH"].toString();
  //                   wardname=data["WARD NAME"].toString();
  //                   wardnumber=data["WARD NUMBER"].toString();
  //                   upiId=data["UPI ID"].toString();
  //                   refNo=data["REF NO"].toString();
  //
  //                   var dateTime = DateTime.fromMillisecondsSinceEpoch(time);
  //                   String year = "Y" + dateTime.year.toString();
  //                   String month = "M" + dateTime.month.toString();
  //                   String day = "D" + dateTime.day.toString();
  //                   String hour = "H" + dateTime.hour.toString();
  //
  //
  //                   HashMap<String, Object> excelData = HashMap();
  //                   excelData["Amount"] =amount.toString();
  //                   excelData["ID"] = key;
  //                   excelData["Name"] = name;
  //                   excelData["PaymentApp"] =  paymentApp;
  //                   excelData["PhoneNumber"] = phoneNumber;
  //                   excelData["Status"] = status;
  //                   excelData["Time"] = dateTime.millisecondsSinceEpoch.toString();
  //                   excelData["Ward"] = ward;
  //                   excelData["district"] = district;
  //                   excelData["panchayath"] = panchayath;
  //                   excelData["wardname"] = wardname;
  //                   excelData["wardnumber"] = wardnumber;
  //                   excelData["UpiID"] = upiId;
  //                   excelData["RefNo"] = refNo;
  //                   excelData["Check"] = "true";
  //                   String orderRef = "Payment/" + year + "/" + month + "/" + day + "/" +
  //                       hour + "/HourEntry/" + key;
  //                   // await mRoot.child("PaymentDetails").child(key).child("OrderRef").set(orderRef);
  //                   await mRoot.child("Payment").child(year).child(month).child(day).child(hour).child("HourEntry").child(key).update(excelData);
  //                   // HashMap<String, Object> excelDataStore = excelData;
  //                   // excelDataStore["Amount"] = amount;
  //                   // excelDataStore['Time']=dateTime.millisecondsSinceEpoch;
  //                   // excelDataStore['LastForDigits']=key.substring(key.length-4,key.length);
  //
  //
  //
  //                   // db.collection('Payments').doc(key).set(excelData);
  //                   // db.collection('WardTotalAmount').doc('${district}_${panchayath}_$wardname').update({"Amount": FieldValue.increment(int.parse(amountTC.text))});
  //                   totalAmount = totalAmount + amount;
  //
  //                 }catch(e){
  //                   print(e);
  //
  //                   print('Error________________________________ on $i');
  //                 }
  //
  //               }
  //
  //
  //
  //
  //             }
  //           });
  //         }
  //
  //       });
  //     }
  //     finish(context);
  //   });
  //   // for(var data in map){
  //   //   i++;
  //   //   notifyListeners();
  //   //   String key = DateTime.now().millisecondsSinceEpoch.toString();
  //   //
  //   //   double amount=0;
  //   //   String name='No Name';
  //   //   String paymentApp='Bank';
  //   //   String phoneNumber='No Phone Number';
  //   //   String status='Success';
  //   //   int    time=DateTime.now().millisecondsSinceEpoch;
  //   //   String ward='General';
  //   //   String district='General';
  //   //   String panchayath='General';
  //   //   String wardname='General';
  //   //   String wardnumber='General';
  //   //   String upiId='NIL';
  //   //   String refNo='NIL';
  //   //
  //   //   try{
  //   //
  //   //     key = data["TRANSACTION ID"].toString();
  //   //     amount=double.parse(data["AMOUNT"].toString());
  //   //     name=data["NAME"].toString();
  //   //     paymentApp=data["PAYMENT APP"].toString();
  //   //     phoneNumber=data["PHONE NUMBER"].toString();
  //   //     status=data["STATUS"].toString();
  //   //     time=int.parse(data["TIME IN MILLIS"].toString());
  //   //     ward=data["WARD"].toString();
  //   //     district=data["DISTRICT"].toString();
  //   //     panchayath=data["PANCHAYATH"].toString();
  //   //     wardname=data["WARD NAME"].toString();
  //   //     wardnumber=data["WARD NUMBER"].toString();
  //   //     upiId=data["UPI ID"].toString();
  //   //     refNo=data["REF NO"].toString();
  //   //
  //   //     var dateTime = DateTime.fromMillisecondsSinceEpoch(time);
  //   //     String year = "Y" + dateTime.year.toString();
  //   //     String month = "M" + dateTime.month.toString();
  //   //     String day = "D" + dateTime.day.toString();
  //   //     String hour = "H" + dateTime.hour.toString();
  //   //
  //   //
  //   //     HashMap<String, Object> excelData = HashMap();
  //   //     excelData["Amount"] =amount.toString();
  //   //     excelData["ID"] = key;
  //   //     excelData["Name"] = name;
  //   //     excelData["PaymentApp"] =  paymentApp;
  //   //     excelData["PhoneNumber"] = phoneNumber;
  //   //     excelData["Status"] = status;
  //   //     excelData["Time"] = dateTime.millisecondsSinceEpoch.toString();
  //   //     excelData["Ward"] = ward;
  //   //     excelData["district"] = district;
  //   //     excelData["panchayath"] = panchayath;
  //   //     excelData["wardname"] = wardname;
  //   //     excelData["wardnumber"] = wardnumber;
  //   //     excelData["UpiID"] = upiId;
  //   //     excelData["RefNo"] = refNo;
  //   //     excelData["Check"] = "true";
  //   //     String orderRef = "Payment/" + year + "/" + month + "/" + day + "/" +
  //   //         hour + "/HourEntry/" + key;
  //   //     // await mRoot.child("PaymentDetails").child(key).child("OrderRef").set(orderRef);
  //   //     await mRoot.child("Payment").child(year).child(month).child(day).child(hour).child("HourEntry").child(key).update(excelData);
  //   //     // HashMap<String, Object> excelDataStore = excelData;
  //   //     // excelDataStore["Amount"] = amount;
  //   //     // excelDataStore['Time']=dateTime.millisecondsSinceEpoch;
  //   //     // excelDataStore['LastForDigits']=key.substring(key.length-4,key.length);
  //   //
  //   //
  //   //
  //   //     // db.collection('Payments').doc(key).set(excelData);
  //   //     // db.collection('WardTotalAmount').doc('${district}_${panchayath}_$wardname').update({"Amount": FieldValue.increment(int.parse(amountTC.text))});
  //   //     totalAmount = totalAmount + amount;
  //   //
  //   //   }catch(e){
  //   //     print(e);
  //   //
  //   //     print('Error________________________________ on $i');
  //   //   }
  //   //
  //   //
  //   //
  //   //
  //   // }
  //   if(i==map.length){
  //     // finish(context);
  //     uploadComplete(context, map.length.toString()+" transaction uploaded");
  //   }
  // }

 loopPayments(int start,int end){

    /// zero loop

   db.collection('Payments').where('Time',isGreaterThan: start).where('Time',isLessThan: end).get().then((snapshot) async {


     if(snapshot.docs.isNotEmpty){
       for (var element in snapshot.docs) {

         // if(element.data().containsKey('Time')){
         //
         // }

         String district=element.get('district');
         String panchayath=element.get('panchayath');
         String wardName=element.get('wardname');
         // print(element.id);
         // await mRoot.child('PaymentDetails').child(element.id).once().then((value) async {
         //    if(value.snapshot.exists){
         //      Map<dynamic,dynamic> map=value.snapshot.value as Map;
         //      await  mRoot.child(map['OrderRef'].toString()).once().then((value) async {
         //        Map<dynamic,dynamic> dataMap=value.snapshot.value as Map;
         //
         //        HashMap<String, Object> excelData = HashMap();
         //        excelData["Amount"] =double.parse(dataMap['Amount'].toString());
         //        excelData["ID"] = element.id.toString();
         //        excelData["Name"] = dataMap['Name'].toString();
         //        excelData["PaymentApp"] =  dataMap['PaymentApp'].toString();
         //        excelData["PhoneNumber"] = dataMap['PhoneNumber'].toString();
         //        excelData["Status"] = dataMap['Status'].toString();
         //        excelData["Time"] = int.parse(dataMap['Time'].toString());
         //        excelData["Ward"] = dataMap['Ward'].toString();
         //        excelData["district"] = dataMap['district'].toString();
         //        excelData["panchayath"] = dataMap['panchayath'].toString();
         //        excelData["wardname"] = dataMap['wardname'].toString();
         //        excelData["wardnumber"] = dataMap['wardnumber'].toString();
         //        excelData["UpiID"] = dataMap['UpiID'].toString();
         //        excelData["RefNo"] = '';
         //        excelData["Check"] = "trueNew";
         //        await db.collection('Payments').doc(element.id).set(excelData).then((value) => print(element.id));
         //
         //
         //      });
         //    }
         // });
         String node='${district}_${panchayath}_$wardName';
         try{
             await db.collection('WardTotalAmount').doc(node).update({"Amount": FieldValue.increment(double.parse(element.get('Amount').toString()))}).then((value) => print(element.id));
             // await db.collection('Payments').doc(element.id).update(excelData).then((value) => print(element.id));


         } catch(e){
           // HashMap<String, Object> fireStore = HashMap();
           // fireStore['district']=district;
           // fireStore['panchayath']=panchayath;
           // fireStore['wardname']=wardName;
           // fireStore['Amount']=0;
           // await db.collection('WardTotalAmount').doc(node).set(fireStore);
           //
           // print(node);
         }



       }}

   });
 }
  Future<void> selectDateForDayTotalForLoop(BuildContext context) async {
    DateTimeRangePicker(
        startText: "From",
        endText: "To",
        doneText: "Yes",
        cancelText: "Cancel",
        interval: 5,
        initialStartTime: DateTime.now(),
        initialEndTime: DateTime.now(),
        mode: DateTimeRangePickerMode.dateAndTime,
        minimumTime: DateTime(2000),
        maximumTime: DateTime(2200),
        use24hFormat: true,
        onConfirm: (start, end) {
          loopPayments(start.millisecondsSinceEpoch, end.millisecondsSinceEpoch);

        }).showPicker(context);
  }
  // zeroPayments(){
  //   WardsService().getUnitAll().then((value) async {
  //     HashMap<String, Object> fireStoreG = HashMap();
  //     fireStoreG['district']='General';
  //     fireStoreG['panchayath']='General';
  //     fireStoreG['wardname']='General';
  //     fireStoreG['Amount']=0;
  //     await db.collection('WardTotalAmount').doc('General_General_General').set(fireStoreG).then((value) => print('General'));
  //
  //     for (var element in value) {
  //       HashMap<String, Object> fireStore = HashMap();
  //       fireStore['district']=element.district.toString();
  //       fireStore['panchayath']=element.panchayath.toString();
  //       fireStore['wardname']=element.wardname.toString();
  //       fireStore['Amount']=0;
  //       String node='${element.district.toString()}_${element.panchayath.toString()}_${element.wardname.toString()}';
  //       await db.collection('WardTotalAmount').doc(node).set(fireStore).then((value) => print(node));
  //     }
  //
  //   });
  // }
  dateRangePickerFlutter(BuildContext context){
    Widget calendarWidget() {
      return SizedBox(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.range,
          controller: _dateRangePickerController,
          // initialSelectedRange: PickerDateRange(_startDate, _endDate),
          allowViewNavigation: true,
          headerHeight: 20.0,
          showTodayButton: true,
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
          ),
          initialSelectedDate: DateTime.now(),
          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,
          onSubmit: (Object? val) {
            _dateRangePickerController.selectedRange=val as PickerDateRange?;

            if(_dateRangePickerController.selectedRange!.endDate==null){
              DateTime endDate=_dateRangePickerController.selectedRange!.startDate!;
               endDate=DateTime(endDate.year,endDate.month,endDate.day,23,59,59,59,59);

              fetchExcelFireStore(context,_dateRangePickerController.selectedRange!.startDate!.millisecondsSinceEpoch,endDate.millisecondsSinceEpoch);


              notifyListeners();

            }else{
              fetchExcelFireStore(context,_dateRangePickerController.selectedRange!.startDate!.millisecondsSinceEpoch,_dateRangePickerController.selectedRange!.endDate!.millisecondsSinceEpoch);



              notifyListeners();

            }
            finish(context);
          },
          onCancel: () {
            _dateRangePickerController.selectedDate = null;
            finish(context);
          },
        ),
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),

            content: calendarWidget(),
          );
        });
    notifyListeners();
  }

  Future<void> loopWardKannur() async {
    var jsonText = await rootBundle.loadString('assets/KPCC_JSON.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    jsonMap.forEach((key, value) async {
      if(value['district']=='KANNUR'&&value['panchayath']=='Alakode'){
        HashMap<String, Object> fireStore = HashMap();
        fireStore['district']=value['district'].toString();
        fireStore['panchayath']=value['panchayath'].toString();
        fireStore['wardname']=value['wardname'].toString();
        fireStore['Amount']=0;
        await db.collection('WardTotalAmount').doc('${value['district'].toString()}_${value['panchayath'].toString()}_${value['wardname'].toString()}').set(fireStore).then((value) {
          print(1);
        });

      }
    });
  }


  Future<void> loopTotalWard() async {
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    int i=0;
    jsonMap.forEach((key, value) async {
        HashMap<String, Object> fireStore = HashMap();
        fireStore['district']=value['district'].toString();
        fireStore['assembly']=value['assembly'].toString();
        fireStore['panchayath']=value['panchayath'].toString();
        fireStore['wardname']=value['wardname'].toString();
        fireStore['Amount']=0;
        fireStore['TRANSACTION_COUNT']=0;
        await db.collection('WardTotalAmount').doc('${value['district'].toString()}_${value['panchayath'].toString()}_${value['wardname'].toString()}').set(fireStore).then((value) {
          i++;
          print(i.toString()+"  yyeyeeeyey");
        });


    });
  }

  Future<void> loopTotalWardAndUpdateTarget() async {
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    int i=0;
    jsonMap.forEach((key, value) async {
      HashMap<String, Object> fireStore = HashMap();

      if(value['target'].toString()==""||value['target'].toString()=="0"){

        print("iiiiiiiissssssssempttttty");
        fireStore['Target']=1111111;

      }else{
        fireStore['Target']=num.parse(value['target'].toString());

      }



      await db.collection('WardTotalAmount').doc('${value['district'].toString()}_${value['panchayath'].toString()}_${value['wardname'].toString()}').set(fireStore,SetOptions(merge: true)).then((value) {
        i++;
        print(i.toString()+"  yyeyeeeyey");
      });


    });
  }


  Future<void> loopTotalBoothOnlyNonExist() async {
    var jsonText = await rootBundle.loadString('assets/KPCC_JSON.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    int i=0;

    jsonMap.forEach((key, value) async {
      // print("AWWWWAQQ");
      HashMap<String, Object> fireStore = HashMap();
      fireStore['district']=value['District'].toString();
      fireStore['assembly']=value['Assembly'].toString();
      fireStore['booth']=value['Booth'].toString();
      fireStore['mandalam']=value['Mandalam'].toString();
      fireStore['block']=value['Block'].toString();
      fireStore['Amount']=0;
      fireStore['TransactionCount']=0;

      HashMap<String, Object> fireStoreupdate = HashMap();

      fireStoreupdate['mandalam']=value['Mandalam'].toString();
      fireStoreupdate['block']=value['Block'].toString();


  await db.collection('WardTotalAmount').doc('${value['District'].toString()}_${value['Assembly'].toString()}_${value['Booth'].toString()}').set(fireStoreupdate,SetOptions(merge: true))
      .then((value) {
    i++;
    print(i.toString());
  });



    });
  }
  Future<void> loopTotalAssembly() async {
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    int i=0;
    jsonMap.forEach((key, value) async {
      HashMap<String, Object> fireStore = HashMap();
      fireStore['DISTRICT']=value['district'].toString();
      fireStore['ASSEMBLY']=value['assembly'].toString();
      fireStore['AMOUNT']=0;
      fireStore['TRANSACTION_COUNT']=0;

      await db.collection('ASSEMBLY_TOTAL').doc('${value['district'].toString()}_${value['assembly'].toString()}').set(fireStore).then((value) {
        i++;
        print(i.toString()+"  yyeyeeeyey");
      });


    });
  }

  Future<void> loopTotalPanchyath() async {
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    int i=0;
    jsonMap.forEach((key, value) async {
      HashMap<String, Object> fireStore = HashMap();
      fireStore['DISTRICT']=value['district'].toString();
      fireStore['ASSEMBLY']=value['assembly'].toString();
      fireStore['PANCHAYATH']=value['panchayath'].toString();
      fireStore['AMOUNT']=0;
      fireStore['TRANSACTION_COUNT']=0;

      await db.collection('PANCHAYATH_TOTAL').doc('${value['district'].toString()}_${value['assembly'].toString()}_${value['panchayath'].toString()}').set(fireStore).then((value) {
        i++;
        print(i.toString()+"  yyeyeeeyey");
      });


    });
  }
  Future<void> loopWardNonExist() async {
    int i = 0;
    int j= 0;
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    jsonMap.forEach((key, jsonValue) async {
      var value6 = await db.collection('WardTotalAmount').doc('${jsonValue['district'].toString()}_${jsonValue['panchayath'].toString()}''_${jsonValue['wardname'].toString()}').get();
      if(value6.exists) {
        j++;
        print(j.toString()+"  yyeyeeeyey");
        print('print  : ${jsonValue['district'].toString()}_${jsonValue['panchayath'].toString()}''_${jsonValue['wardname'].toString()}');
      }
      else{
        print('print  : ${jsonValue['district'].toString()}_${jsonValue['panchayath'].toString()}''_${jsonValue['wardname'].toString()}');
        HashMap<String, Object> fireStore = HashMap();
        fireStore['district']=jsonValue['district'].toString();
        fireStore['assembly']=jsonValue['assembly'].toString();
        fireStore['panchayath']=jsonValue['panchayath'].toString();
        fireStore['wardname']=jsonValue['wardname'].toString();
        fireStore['Amount']=0;
        fireStore['TRANSACTION_COUNT']=0;
        await db.collection('WardTotalAmount').doc('${jsonValue['district'].toString()}_${jsonValue['panchayath'].toString()}''_${jsonValue['wardname'].toString()}').set(fireStore,SetOptions(merge: true)).then((value2) {
          i++;
          print(i.toString()+"eeeee");
        });
      }
    });
  }
  Future<void> loopPanchayathNonExist() async {
    int i = 0;
    int j= 0;
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    jsonMap.forEach((key, jsonValue) async {
      var value6 = await db.collection('PANCHAYATH_TOTAL').doc('${jsonValue['district'].toString()}_${jsonValue['assembly'].toString()}''_${jsonValue['panchayath'].toString()}').get();
      if(value6.exists) {
        j++;
        print(j.toString()+"  yyeyeeeyey");
        print('print  : ${jsonValue['district'].toString()}_${jsonValue['assembly'].toString()}''_${jsonValue['panchayath'].toString()}');
      }
      else{
        print('print  : ${jsonValue['district'].toString()}_${jsonValue['assembly'].toString()}''_${jsonValue['panchayath'].toString()}');
        HashMap<String, Object> fireStore = HashMap();
        fireStore['DISTRICT']=jsonValue['district'].toString();
        fireStore['ASSEMBLY']=jsonValue['assembly'].toString();
        fireStore['PANCHAYATH']=jsonValue['panchayath'].toString();
        fireStore['AMOUNT']=0;
        fireStore['TRANSACTION_COUNT']=0;
        await db.collection('PANCHAYATH_TOTAL').doc('${jsonValue['district'].toString()}_${jsonValue['assembly'].toString()}''_${jsonValue['panchayath'].toString()}').set(fireStore,SetOptions(merge: true)).then((value2) {
          i++;
          print(i.toString()+"eeeee");
        });
      }
    });
  }
  Future<void> loopChangeDistrictName() async {
    int i = 0;
    int j= 0;
    var payments = await db.collection("Attempts").where("district",isEqualTo:"KASERGOD").get();

    if(payments.docs.isNotEmpty){
      for(var data in payments.docs){
        i++;
        await db.collection("Attempts").doc(data.id).set({"district":"KASARGOD"},SetOptions(merge: true));
        print("payments : $i");
      }

    }

    

   
  }



  Future<void> loopWardKasargod() async {
    int j=0;
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    jsonMap.forEach((key, value) async {
      if(value['district']=='PALAKKAD'){
        j++;
        HashMap<String, Object> fireStore = HashMap();
        fireStore['district']=value['district'].toString();
        fireStore['assembly']=value['assembly'].toString();
        fireStore['panchayath']=value['panchayath'].toString();
        fireStore['wardname']=value['wardname'].toString();

        print(value['district'].toString()+"..........district");
        print(value['panchayath'].toString()+"..........panchayath");
        print(value['wardname'].toString()+"..........wardname");

        var payments = await db.collection("Payments").where("district",isEqualTo:value['district'].toString()).where("panchayath",isEqualTo:value['panchayath'].toString()).where("wardName",isEqualTo:value['wardname'].toString() ).get();


          double wardTotal=0;
          int i=0;
          if(payments.docs.isNotEmpty){
            print("aaaaaassssmmmmm");
            for (var element in payments.docs) {
              print("code iss here");
              i++;

              wardTotal=wardTotal+double.parse( element.get('Amount').toString().replaceAll(",", ""));
              print(wardTotal.toString()+"sfsjbhj");

              notifyListeners();
            }
          }else{
            wardTotal=0;
            i=0;


          }
        fireStore['district']=value['district'].toString();
        fireStore['assembly']=value['assembly'].toString();
        fireStore['panchayath']=value['panchayath'].toString();
        fireStore['wardname']=value['wardname'].toString();
        fireStore['Amount']=wardTotal;
        fireStore['TRANSACTION_COUNT']=i;
        await db.collection('WardTotalAmount').doc('${value['district'].toString()}_${value['panchayath'].toString()}_${value['wardname'].toString()}').set(fireStore,SetOptions(merge: true)).then((value) {
          print(j.toString());
        });

      }
    });
  }
  Future<void> loopPaymentsToWardtotal() async {
    int j=0;


    var pay =await db.collection('Payments').where('district',isEqualTo: "KANNUR").get();
    if(pay.docs.isNotEmpty){
      print(pay.docs.length.toString()+"ERHBFEHBHHBBHJUBH");
      for (var element1 in pay.docs) {
        j++;
        print(j.toString()+"SJFNW33333EDJM");

        Map<dynamic, dynamic> map = element1.data() as Map;

        HashMap<String, Object> fireStore = HashMap();
        // fireStore['district']=map['district'].toString();
        // fireStore['assembly']=map['assembly'].toString();
        // fireStore['panchayath']=map['panchayath'].toString();
        // fireStore['wardname']=map['wardName'].toString();

        var payments = await db.collection("Payments").where("district",isEqualTo:map['district'].toString()).where("panchayath",isEqualTo:map['panchayath'].toString()).where("wardName",isEqualTo:map['wardName'].toString() ).get();


        double wardTotal=0;
        int i=0;
        if(payments.docs.isNotEmpty){
          print("aaaaaassssmmmmm");
          for (var element in payments.docs) {
            print("code iss here");
            i++;

            wardTotal=wardTotal+double.parse( element.get('Amount').toString().replaceAll(",", ""));
            print(wardTotal.toString()+"sfsjbhj");

            notifyListeners();
          }
        }else{
          wardTotal=0;
          i=0;


        }
        fireStore['district']=map['district'].toString();
        fireStore['assembly']=map['assembly'].toString();
        fireStore['panchayath']=map['panchayath'].toString();
        fireStore['wardname']=map['wardName'].toString();
        fireStore['Amount']=wardTotal;
        fireStore['TRANSACTION_COUNT']=i;
        await db.collection('WardTotalAmount').doc('${map['district'].toString()}_${map['panchayath'].toString()}_${map['wardName'].toString()}').set(fireStore,SetOptions(merge: true)).then((value) {
          print(j.toString());
        });

      }
    }



  }
  double wardTotal=0;
  void districtTotal(){

    db.collection("WardTotalAmountt").get().then((value) {

      if(value.docs.isNotEmpty){

        for (var element in value.docs) {

          wardTotal=wardTotal+double.parse( element.get('Amount').toString().replaceAll(",", ""));

          print(wardTotal.toString()+"sdrinj12345");

        }


      }

    });

  }
  Future<void> loopWardTargetZero() async {
    int j=0;

    var wards = await db.collection("WardTotalAmount").get();



    if(wards.docs.isNotEmpty){
      print("aaaaaassssmmmmm");
      int i=0;
      for (var element in wards.docs) {


        i++;

        Map<dynamic, dynamic> map = element.data();

        if(map["Target"]==null){
          print("target awwwwwww"+element.id.toString());
          await db.collection("WardTotalAmount").doc(element.id).set({"Target":100100},SetOptions(merge: true));

        }else if(map["Target"]==1111111){
          print("target awww111111wwww"+element.id.toString());
          await db.collection("WardTotalAmount").doc(element.id).set({"Target":100100},SetOptions(merge: true));

        }else{
          print(i.toString()+" target amountcontain"+element.id.toString());



        }
        print(i.toString());

      }

      }




      notifyListeners();
    }



  deleteTransactions(List <dynamic> map) async {
    for (var element in map) {
      print(element['TnID']);
     await db.collection('Payments').doc(element['TnID']).delete();
      await mRoot.child('PaymentDetails').child(element['TnID']).once().then((dataSnapshot) async {

        if (dataSnapshot.snapshot.value != null) {
          Map<dynamic, dynamic> map = dataSnapshot.snapshot.value as Map;
          // mRoot.child(map['OrderRef']).once().then((value) =>print(value.snapshot.value));
          await  mRoot.child(map['OrderRef']).remove();
          await mRoot.child('PaymentDetails').child(element['TnID']).remove();
        }

      });
    }}

  void checkPassword() {
    mRoot.child('0').child('PS').onValue.listen((event) {
      if(event.snapshot.exists){
        String pass=event.snapshot.value.toString();
        DateTime now=DateTime.now();
        int passTime=DateTime(now.year,now.month,now.day,0,0,0,0,0).millisecondsSinceEpoch;
        double passDouble=(passTime/double.parse(pass));
        password =passDouble.truncate().toString();
      }
    });
  }


  fetchDistrictAnalyticsReport(BuildContext context){
    fetchedTime=DateTime.now();
    uploadLoading(context, 100);
    int start=DateTime.now().subtract(const Duration(days: 10)).millisecondsSinceEpoch;
    int end=DateTime.now().millisecondsSinceEpoch;
    List<DistrictAnalyticsReport> emptyCell=[];
    emptyCell.add(DistrictAnalyticsReport(0, 0.0, ''));

    db.collection('Payments').get().then((event) {
      finish(context);
      distReportArray.clear();
      List<DistrictAnalyticsReport> districtPayment=[];
      List<DistrictAnalyticsReport> kmccPayment=[];
      List<DistrictAnalyticsReport> otherPayment=[];
      countTotal=0;
      amountTotal=0;
      if(event.docs.isNotEmpty){
        for (var element in event.docs) {
          countTotal++;
          double amount=0;
          String dist='GENERAL';

          if(element.data()['district']!=null){
          dist=element.data()['district'].toString().toUpperCase();
          }
          try{
            amount=double.parse(element.data()['Amount'].toString().replaceAll(',', ''));
          }catch(e){
              print(e.toString()+" amount("+element.data()['Amount'].toString()+") id : "+element.id);
          }
          amountTotal=amountTotal+amount;
          proCountTotal=countTotal-lastCountTotal;
          proAmountTotal=amountTotal-lastAmountTotal;
          if(districts.contains(dist)){
            if(districtPayment.map((e) => e.name).contains(dist)){
              int index=districtPayment.indexWhere((element) =>  element.name.toUpperCase()==dist);
              DistrictAnalyticsReport districtAnalyticsReport=districtPayment[index];
              districtAnalyticsReport.count=districtAnalyticsReport.count+1;
              districtAnalyticsReport.amount=districtAnalyticsReport.amount+amount;
              districtPayment[index]=districtAnalyticsReport;
            }else{
              districtPayment.add(DistrictAnalyticsReport(1, amount, dist));
            }
            districtPayment.sort((a, b) => b.amount.compareTo(a.amount));
          }else if(dist.contains("KMCC")){
            if(kmccPayment.map((e) => e.name).contains(dist)){
              int index=kmccPayment.indexWhere((element) =>  element.name.toUpperCase()==dist);
              DistrictAnalyticsReport districtAnalyticsReport=kmccPayment[index];
              districtAnalyticsReport.count=districtAnalyticsReport.count+1;
              districtAnalyticsReport.amount=districtAnalyticsReport.amount+amount;
              kmccPayment[index]=districtAnalyticsReport;
            }else{
              kmccPayment.add(DistrictAnalyticsReport(1, amount, dist));
            }
            kmccPayment.sort((a, b) => b.amount.compareTo(a.amount));
          }else{
            if(otherPayment.map((e) => e.name).contains(dist)){
              int index=otherPayment.indexWhere((element) =>  element.name.toUpperCase()==dist);
              DistrictAnalyticsReport districtAnalyticsReport=otherPayment[index];
              districtAnalyticsReport.count=districtAnalyticsReport.count+1;
              districtAnalyticsReport.amount=districtAnalyticsReport.amount+amount;
              otherPayment[index]=districtAnalyticsReport;
            }else{
              otherPayment.add(DistrictAnalyticsReport(1, amount, dist));
            }
            otherPayment.sort((a, b) => b.amount.compareTo(a.amount));
          }

          distReportArray=districtPayment+emptyCell+kmccPayment+emptyCell+otherPayment;

          notifyListeners();





          notifyListeners();
        }
      }

    });
    
    db.collection('LastReport').get().then((value) {
      distReportLastArray.clear();
      List<DistrictAnalyticsReport> districtPayment=[];
      List<DistrictAnalyticsReport> kmccPayment=[];
      List<DistrictAnalyticsReport> otherPayment=[];
      lastCountTotal=0;
      lastAmountTotal=0;
        lastProCountTotal=0;
      lastProAmountTotal=0;
      if(value.docs.isNotEmpty){
        for (var element in value.docs) {
          lastCountTotal=lastCountTotal+int.parse(element.get('count').toString());
          lastAmountTotal=lastAmountTotal+element.get('amount');
          lastProCountTotal=lastProCountTotal+int.parse((element.data()['ProgressCount']??element.get('count')).toString());
          lastProAmountTotal=lastProAmountTotal+(element.data()['ProgressAmount']??element.get('amount'));
          distReportLastArray.add(DistrictAnalyticsReportOld(element.get('count'), element.get('amount'), element.id,element.data()['ProgressCount']??element.get('count'),element.data()['ProgressAmount']??element.get('amount'),));
          proCountTotal=countTotal-lastCountTotal;
          proAmountTotal=amountTotal-lastAmountTotal;
          notifyListeners();

        }

      }
    });
    db.collection('LastReportDate').doc('Date').get().then((value) {
      if(value.exists){
        lastUpdated=DateTime.fromMillisecondsSinceEpoch(value.get('Time'));
      }
    });
  }
  
  saveLastReport(BuildContext context){

    for (var element in distReportArray) {
      if(element.name!=''){
        HashMap<String, Object> data = HashMap();
        data['amount']=element.amount;
        data['count']=element.count;
        data['Name']=element.name;
        if(distReportLastArray.map((e) => e.name).contains(element.name)){
          int index=distReportLastArray.indexWhere((e) =>  e.name==element.name);
          DistrictAnalyticsReportOld districtAnalyticsReport=distReportLastArray[index];

          data['ProgressAmount']=element.amount-districtAnalyticsReport.amount;
          data['ProgressCount']=element.count-districtAnalyticsReport.count;
        }else{
          data['ProgressAmount']=element.amount;
          data['ProgressCount']=element.count;
        }
        db.collection('LastReport').doc(element.name).set(data);
        db.collection('Reports').doc(DateTime.now().millisecondsSinceEpoch.toString()).collection('District').doc(element.name).set(data);

      }

    }
    HashMap<String, Object> timeMap = HashMap();
    timeMap['Time']=fetchedTime.millisecondsSinceEpoch;
    db.collection('LastReportDate').doc('Date').set(timeMap);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(
      content: Text(
          "Success"),
    ));
    finish(context);

  }

  DistrictAnalyticsReportOld  getLastItem(String name) {
    DistrictAnalyticsReportOld districtAnalyticsReport=DistrictAnalyticsReportOld(0, 0,name,0,0);
    if(distReportLastArray.map((e) => e.name.toUpperCase()).contains(name.toUpperCase())){
      int index=distReportLastArray.indexWhere((element) =>  element.name.toUpperCase()==name.toUpperCase());
      districtAnalyticsReport=distReportLastArray[index];
    }
    return districtAnalyticsReport;
  }
  void createExcelDistrictReport(List<DistrictAnalyticsReport> listArray) async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];
    final List<Object> list = [];
    const int firstRow = 1;

    const int firstColumn = 1;

    const bool isVertical = false;

    sheet.importList(list, firstRow, firstColumn, isVertical);
    int i = 1;
    for (var element in listArray) {
      i++;

      final List<Object> list = [
        element.name,
        getLastItem(element.name).count,
        getLastItem(element.name).amount,
        getLastItem(element.name).progressCount,
        getLastItem(element.name).progressAmount,
        element.count,
        element.amount,
        element.count-getLastItem(element.name).count,
        element.amount-getLastItem(element.name).amount,
      ];
      final int firstRow = i;

      const int firstColumn = 1;

      const bool isVertical = false;

      sheet.importList(list, firstRow, firstColumn, isVertical);
    }

    sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if(!kIsWeb){
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
    else{

      var blob = web_file.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'native');

      var anchorElement = web_file.AnchorElement(
        href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
      )..setAttribute("download", "data.xlsx")..click();
    }

  }

  void onDistrictSelected(String selection,BuildContext context) {
    uploadLoading(context, 100);

    db.collection('Payments').where('district',isEqualTo: selection).get().then((event) {
      finish(context);
      mandalamWiseList.clear();


      if(event.docs.isNotEmpty){
        for (var element in event.docs) {
          double amount=0;
          String mandalam='GENERAL';

          if(element.data()['district']!=null){
            mandalam=element.data()['district'].toString().toUpperCase();
          }
          try{
            amount=double.parse(element.data()['Amount'].toString().replaceAll(',', ''));
          }catch(e){
            print(e.toString()+" amount("+element.data()['Amount'].toString()+") id : "+element.id);
          }

            if(mandalamWiseList.map((e) => e.name).contains(mandalam)){
              int index=mandalamWiseList.indexWhere((element) =>  element.name.toUpperCase()==mandalam);
              DistrictAnalyticsReport districtAnalyticsReport=mandalamWiseList[index];
              districtAnalyticsReport.count=districtAnalyticsReport.count+1;
              districtAnalyticsReport.amount=districtAnalyticsReport.amount+amount;
              mandalamWiseList[index]=districtAnalyticsReport;
            }else{
              mandalamWiseList.add(DistrictAnalyticsReport(1, amount, mandalam));
            }
          mandalamWiseList.sort((a, b) => b.amount.compareTo(a.amount));



          notifyListeners();





          notifyListeners();
        }
      }

    });
  }

  fetchEntriesExcelFireStore(BuildContext context){

    uploadLoading(context, 100);
    db.collection('Entries').get().then((event) {
      paymentEntriesList.clear();
      if(event.docs.isNotEmpty){
        for (var element in event.docs) {
          Map<dynamic, dynamic> map = element.data() as Map;

          paymentEntriesList.add(PaymentEntriesModel(
              map['Amount'].toString(),
              map['ID'].toString(),
              map['Status'].toString(),
              map['Time'].toString(),
              map['TransactionID'].toString(),
              map['UPI_ID'].toString(),
              map['UTR'].toString(),
              map['meRes'].toString(),
              map['pgMerchantId'].toString(),
              map['value_1'].toString(),
              map['value_11'].toString(),
              map['value_12'].toString(),
              map['value_2'].toString(),
          ));
          print(paymentEntriesList.length);

          notifyListeners();



        }
        createEntriesExcel(paymentEntriesList);
        notifyListeners();
      }
      finish(context);

    });


  }
  void createEntriesExcel(List<PaymentEntriesModel> historyList) async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];
    final List<Object> list = [

      'TIME',
      'ID',
      'TRANSACTION ID',
      'AMOUNT',
      'STATUS',
      'UPI ID',
      'UTR',
      'MERES',
      'PGMERCHANT ID',
      'VALUE_1',
      'VALUE_2',
      'VALUE_11',
      'VALUE_12',
    ];
    const int firstRow = 1;

    const int firstColumn = 1;

    const bool isVertical = false;

    sheet.importList(list, firstRow, firstColumn, isVertical);
    int i = 1;
    for (var element in historyList) {
      int time= 00000000000;
      try{
        time =int.parse(element.time);
      }catch(e){

      }
      double amount= 0;
      try{
        amount =double.parse(element.amount.replaceAll(",", ''));

      }catch(e){
        print(element.paymentId);
      }

      i++;
      final List<Object> list = [
        element.time,
        element.paymentId,
        element.transactionId,
        amount,
        element.status,
        element.upiId,
        element.utr,
        element.mRes,
        element.pgmerchantId,
        element.value1,
        element.value2,
        element.value11,
        element.value12,
      ];
      final int firstRow = i;

      const int firstColumn = 1;

      const bool isVertical = false;

      sheet.importList(list, firstRow, firstColumn, isVertical);
    }

    sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if(!kIsWeb){


      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);

    }
    else{

      var blob = web_file.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'native');

      var anchorElement = web_file.AnchorElement(
        href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
      )..setAttribute("download", "data.xlsx")..click();
    }

  }
  String nameStatus="";
  String nameChange="";
  void  getNameStatus(String id){

    db.collection("Payments").doc(id).get().then((value) {

      if(value.exists){
        nameStatus=value["NameShowStatus"].toString();
        notifyListeners();
      }
      print(nameStatus+"rurruh");
      notifyListeners();
    });
    notifyListeners();


  }
  void  getName(String id){

    db.collection("Payments").doc(id).get().then((value) {

      if(value.exists){
        nameChange=value["Name"].toString();
        notifyListeners();
      }
      print(nameChange+"rurruh");
      notifyListeners();
    });
    notifyListeners();


  }

  void changeNameStatus(String nameStatus,String id){
    HashMap<String, Object> map = HashMap();

    if(nameStatus=="NO") {
      map["NameShowStatus"] = "YES";
    }
    db.collection("Payments").doc(id).set(map, SetOptions(merge: true));
    db.collection("MonitorNode").doc(id).set(map, SetOptions(merge: true));
    notifyListeners();
  }
  void changeName(String nameChange,String id){
    HashMap<String, Object> map = HashMap();


      map["Name"] = nameChange;
      map["NameChanged"] = "YES";

    db.collection("Payments").doc(id).set(map, SetOptions(merge: true));
    db.collection("MonitorNode").doc(id).set(map, SetOptions(merge: true));
    notifyListeners();
  }





}
String generateRandomString(int length) {
  final random = Random();
  const availableChars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  final randomString = List.generate(length,
          (index) => availableChars[random.nextInt(availableChars.length)]).join();

  return randomString;
}