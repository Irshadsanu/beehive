import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cashfree_pg/cashfree_pg.dart';
// import 'package:crop_image/crop_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:universal_html/html.dart' as web_file;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Screens/crop_image_screen.dart';
import '../Screens/donation_success.dart';
import '../Screens/home_screen.dart';
import '../Screens/reciept_page.dart';
import '../Views/ageModel.dart';
import '../Views/bank_model.dart';
import '../Views/cash_free_model.dart';
import '../Views/panjayath_model.dart';
import '../Views/payment_option_model.dart';
import '../Views/receipt_list_model.dart';
import '../Views/time_stamp_model.dart';
import '../Views/upi_model.dart';
import '../Views/ward_model.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../qmchModels/subScriberModel.dart';
import '../qmchModels/equipmentModel.dart';
import '../qmchModels/foodkitModel.dart';
import '../service/device_info.dart';
import '../service/time_service.dart';
import '../service/wards_service.dart';
import 'home_provider.dart';

class DonationProvider extends ChangeNotifier {
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static const platformChanel = MethodChannel('payuGateway');

  /// for donation page
  TextEditingController amountTC = TextEditingController();

  TextEditingController dhotiCounterController = TextEditingController();

  ///for donate page KNM APP
  TextEditingController kpccAmountController = TextEditingController();
  TextEditingController nameTC = TextEditingController();
  TextEditingController phoneTC = TextEditingController();
  TextEditingController wardTC = TextEditingController();
  TextEditingController assemblyCt = TextEditingController();
  TextEditingController selectWardTC = TextEditingController();

  ///multiple payment controllers
  TextEditingController zakathAmountCT = TextEditingController();
  TextEditingController equipmentAmountCT = TextEditingController();
  TextEditingController patientAmountCT = TextEditingController();
  TextEditingController foodkitAmountCT = TextEditingController();
  TextEditingController membersPaymentAmountCT = TextEditingController();
  TextEditingController subscriptionAmountCT = TextEditingController();

  TextEditingController equipmentSelectedCT = TextEditingController();
  TextEditingController equipmentSelectedIDCT = TextEditingController();
  TextEditingController patientSelectedCT = TextEditingController();
  TextEditingController monthNameCT = TextEditingController();

  TextEditingController patientSelectedNameCT = TextEditingController();
  TextEditingController date1 = TextEditingController();
  TextEditingController date2 = TextEditingController();

  DateTime subscribeDate1 = DateTime.now();
  DateTime subscribeDate2 = DateTime.now();
  final DateRangePickerController _dateRangePickerController =
      DateRangePickerController();

  double zakathTotal = 0.0;
  double equipmntTotal = 0.0;
  double patientTotal = 0.0;
  double footkitTotal = 0.0;
  double subscriptionTotal = 0;
  double totalMonthDifference = 1 ;
  double allTotal = 0.0;

  List<AgeModel> ageSelectionList = [];
  List<AgeModel> genderList = [];

  WardModel? selectedWard;
  AssemblyModel? selectedAssembly;
  bool done = false;
  List<WardModel> wards = [];
  List<WardModel> newWards = [];
  List<WardModel> allWards = [];
  List<WardModel> hideWards = [];
  Map<dynamic, dynamic> newWardsMap = {};
  Map<dynamic, dynamic> hideWardsMap = {};
  List<PaymentOptModel> paymentOptions = [];
  String mid = "HewFhH22025932253187";
  String upiAddress = "9048004320@paytm";
  String strAmountButton = "";
  String displayAmount = "";
  List<PanjayathModel> panjayathList = [];
  List<AssemblyModel> assemblyList = [];
  List<AssemblyModel> booths = [];
  List<AssemblyModel> newBooths = [];
  List<AssemblyModel> allBooths = [];
  List<WardModel> chipsetWardList = [];
  List<WardModel> chipsetBoothList = [];
  PanjayathModel? selectedPanjayathChip;
  AssemblyModel? selectedAssemblyChip;
  List<String> paymentGateWays = [];
  String WImageByte = "ffff";
  int dhothiCounter = 0;
  int dhothiAmount = 0;
  bool shownameBool = false;
  String names = '';
  List<MonthBool> monthList=[];
  List<SubscriberPaymentModel> subscriberPaymentList=[];
  double monthlyPayAmount=0;

  int knmAmount = 0;

  ///for receipt page
  DateTime donationTime = DateTime.now();
  String donorName = '';
  String donorNumber = '';
  String donorPlace = '';
  String donorID = '';
  String donorStatus = '';
  String donorAmount = '';
  String donorApp = '';
  String? onOfButton = '';
  String donorReceiptPrinted = '';
  Uint8List? fileBytes;

  // var controller = CropController(
  //   aspectRatio: 1,
  //   defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  // );

  ///forWhatsapp status
  final ImagePicker picker = ImagePicker();
  File? statusImage;
  var whatsappStatus;
  String? gender;

  bool monthlyAmountAlert = false;

  ///payment gateway cashFree
  String stage = "TEST";
  String orderNote = "HADDIYA";
  String orderCurrency = "INR";
  String appId = "138690c1d12c4584a31312d667096831";
  String customerEmail = "sample@gmail.com";
  String notifyUrl = "https://spinecodes.in/";
  String paymentBankCode = "https://spinecodes.in/";
  String alertShowed = "";
  bool isAlertShowed = false;
  List<dynamic> upiApps = [];

  ///bank cashFree
  List<BankModel> banks = [];
  List<BankModel> filteredBanks = [];

  ///card cashFree
  String cardHolderName = "";
  String cardNumber = "";
  String cvvCode = "";
  String expiryDate = "";

  ///upi cashFree
  TextEditingController upiIdEt = TextEditingController();

  ///bank details
  String acNo = "";
  String ifsc = "";
  String acName = "";
  String acUpiId = "";
  int limit = 25;
  int equipmentCount = 0;

  ///for receiptList
  TextEditingController name = TextEditingController();
  TextEditingController transactionID = TextEditingController();
  TextEditingController pinWardTC = TextEditingController();

  String phonePinWard = 'OFF';
  String paymentButton = '';
  TextStyle styleOfAmountAlert = poppinsalertwhite; // White
  bool minimumbool = true;

  List<String> organisationList = [];
  TextEditingController organisationTC = TextEditingController();

  TextEditingController familyNameTC = TextEditingController();

  ///QMCH AMDIN
  TextEditingController equipmentNameCT = TextEditingController();
  TextEditingController equipmentPriceCT = TextEditingController();
  TextEditingController equipmentCountCT = TextEditingController();
  TextEditingController equipmentDiscriptionCT = TextEditingController();

  TextEditingController subscriberNameCT = TextEditingController();
  TextEditingController subscriberPhoneCT = TextEditingController();
  TextEditingController subscriberAddressCT = TextEditingController();

  TextEditingController sponserNameCT = TextEditingController();
  TextEditingController sponserphoneCT = TextEditingController();
  TextEditingController foodKitNameCT = TextEditingController();
  TextEditingController foodKitPriceCT = TextEditingController();
  TextEditingController foodKitDiscriptionCT = TextEditingController();

  TextEditingController newsTitleCT = TextEditingController();
  TextEditingController newsDiscriptionCT = TextEditingController();

  ///admin FoodKit
  List<File> carouselfileList = [];
  List<dynamic> carouselModelList = [];
  File? fileImage;
  File? fileImage2;
  List<FoodKitModel> fetchFoodKitList = [];
  List<NewsFeedModel> newsList = [];
  List<NewsFeedModel> filterNewsList = [];
  DateTime scheduledTimeFrom = DateTime.now();
  int limitHome = 25;
  int totalFoodListedCount = 0;
  String fetchimage = '';
  String sponserImage = '';
  String adminImageUrl = '';
  String userImgUrl = '';
  String newsImage = '';
  List<String> list = [];

  String equipmentPhotoUrl = '';

  DonationProvider() {
    addMonths();
    addSponserFoodkit();
    addSponsershipDisease();
    fetchDatabaseWard();
    fetchDatabaseHideWard();
    fetchWard();
    fetchAllWards();
    // paymentOptions.add(PaymentOptModel("1", "assets/paytm.png", "Paytm"));
    // paymentOptions.add(PaymentOptModel("2", "assets/upi_logo.png", "Upi"));
    getUPIApps();
    fetchPaymentGateways();
    getSharedPrefName();
    // fetchAccountDetails();
    fetchPinWard();
    lockIosGooglePayButton();
    lockIosPhonePayButton();
    // getOrganisation();
  }

  // void otherPaymentButton() {
  //   mRoot.child("OTHER PEYMENT BUTTON").onValue.listen((DatabaseEvent event) {
  //     Map<dynamic, dynamic> map = event.snapshot.value as Map;
  //     paymentButton = map['VALUE'].toString();
  //     notifyListeners();
  //   });
  // }

  void setTextColor(TextStyle textStyle) {
    styleOfAmountAlert = textStyle;
    notifyListeners();
  }

  void addAges() {
    ageSelectionList.add(AgeModel('Below 25', false));
    ageSelectionList.add(AgeModel('25-35', false));
    ageSelectionList.add(AgeModel('35-50', false));
    ageSelectionList.add(AgeModel('Above 50', false));

    genderList.add(AgeModel('Male', false));
    genderList.add(AgeModel('Female', false));
    genderList.add(AgeModel('Other', false));
    notifyListeners();
  }

  void onCountChange(String text) {
    notifyListeners();
  }

  void onComplete(double amt) {
    if (amt >= 138) {
    } else {}

    notifyListeners();
  }

  void funPaytm(
    BuildContext context,
    String paymentCategory,
    String equipmentCount,
    String equipmentID,
    String oneEquipmentPrice,
    String loginUsername,
    String loginUserID,
    String subScriberType,
    String loginUserPhone,
    String zakathAmount,
    String deseaseName,
    String sponsorCategory,
    String sponsorCount,
    String sponsorItemOnePrice,
    String foodkitPrice,
    String footkitCount,
    String equipmentAmount,
    String sponsorPatientAmonut,
    String foodkitAmount,
      List<MonthBool> monthList
  ) async {
    String orderID = mRoot.push().key.toString();

    String callBackUrl =
        "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=" +
            orderID;
    var url = 'https://us-central1-candidatec.cloudfunctions.net/widgets/users';

    var body = json.encode({
      "OrderID": orderID,
      "Value": amountTC.text.replaceAll(',', ''),
      "callbackUrl": callBackUrl,
      "User": "122",
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': "application/json"},
      );
      var responseData = json.decode(response.body);

      String txnToken = responseData['body']['txnToken'].toString();

      var paytmResponse = AllInOneSdk.startTransaction(
          mid, orderID, "1.00", txnToken, callBackUrl, true, true);
      paytmResponse.then((value) {
        ///success
        upDatePayment(
          "SUCCESS",
          value.toString(),
          context,
          orderID,
          'Paytm',
          '',
          "",
          paymentCategory,
          equipmentCount,
          equipmentID,
          oneEquipmentPrice,
          loginUsername,
          loginUserID,
          subScriberType,
          loginUserPhone,
          zakathAmount,
          deseaseName,
          sponsorCategory,
          sponsorCount,
          sponsorItemOnePrice,
          foodkitPrice,
          footkitCount,
          equipmentAmount,
          sponsorPatientAmonut,
          foodkitAmount,monthList
        );
      }).catchError((onError) {
        upDatePayment(
          "FAILED",
          onError.toString(),
          context,
          orderID,
          'Paytm',
          '',
          "",
          paymentCategory,
          equipmentCount,
          equipmentID,
          oneEquipmentPrice,
          loginUsername,
          loginUserID,
          subScriberType,
          loginUserPhone,
          zakathAmount,
          deseaseName,
          sponsorCategory,
          sponsorCount,
          sponsorItemOnePrice,
          foodkitPrice,
          footkitCount,
          equipmentAmount,
          sponsorPatientAmonut,
          foodkitAmount,monthList
        );

        ///failed
      });
    } catch (e) {}
  }

  // addNumber(){
  //   HashMap<String, Object> map = HashMap();
  //  map["PhoneNumber2"] = '+919744678000';
  //   mRoot.child("0").update(map);
  // }
  var outputDayNode = DateFormat('d/MM/yyy');

  upDatePayment(
      String status,
      String response,
      BuildContext context,
      String orderID,
      String app,
      String upiIdP,
      String appver,
      String paymentCategory,
      String equipmentCount,
      String equipmentID,
      String oneEquipmentPrice,
      String loginUsername,
      String loginUserID,
      String subScriberType,
      String loginUserPhone,
      String zakathAmount,
      String deseaseName,
      String sponsorCategory,
      String sponsorCount,
      String sponsorItemOnePrice,
      String foodkitPrice,
      String footkitCount,
      String equipmentAmount,
      String sponsorPatientAmonut,
      String foodkitAmount,List<MonthBool> monthList) async {
    callNextReplacement(
        DonationSuccess(
          paymentCategory: paymentCategory,
          equipmentCount: equipmentCount,
          equipmentID: equipmentID,
          oneEquipmentPrice: oneEquipmentPrice,
          loginUserID: loginUserID,
          loginUsername: loginUsername,
          subScriberType: subScriberType,
          loginUserPhone: loginUserPhone,
          zakathAmount: zakathAmount,
          sponsorPatientAmonut: sponsorPatientAmonut,
          sponsorItemOnePrice: sponsorItemOnePrice,
          sponsorCount: sponsorCount,
          sponsorCategory: sponsorCategory,
          footkitCount: footkitCount,
          deseaseName: deseaseName,
          foodkitPrice: foodkitPrice,
          equipmentAmount: equipmentAmount,
          foodkitAmount: foodkitAmount,monthList: monthList,
        ),
        context);
    // var outputDayNode = DateFormat('yyyy_M_d');
    String name = nameTC.text;
    DateTime now = DateTime.now();
    String timeString = "";
    TimeStampModel? timeStampModel = await TimeService().getTime();

    if (timeStampModel != null) {
      now = timeStampModel.datetime.toLocal();
      timeString = outputDayNode.format(now).toString();
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageVersion = packageInfo.version;

    String amount = kpccAmountController.text.toString().replaceAll(',', '');

    print(paymentCategory.toString()+' IJCFMIJVFIR');

    String district = '';
    String assembly = '';
    String panchayath = '';
    String wardName = '';
    String wardNumber = '';

    HashMap<String, Object> map = HashMap();
    HashMap<String, Object> SubscriptionMap = HashMap();
    map['Payment Category'] = paymentCategory;

    ///GENERAL/ZAKATH/EQUIPMENT
    if (paymentCategory == 'EQUIPMENT') {
      map['EquipmentID'] = equipmentID;
      map['EquipmentCount'] = equipmentCount;
      map['One_EquipmentAmount'] = oneEquipmentPrice;
    }

    ///in sponsor patient equipment id and equipment name paasses the data about sponsor type(homecare/dyalisys) and its count
    else if (paymentCategory == 'SPONSOR_PATIENT') {
      map['Sponsoring_Category'] = equipmentID;
      map['Sponsoring_Count'] = equipmentCount;
      map['Sponsoring_OneItemAmount'] = oneEquipmentPrice;
    } else if (paymentCategory == 'FOODKIT') {
      map['FoodKitPrice'] = oneEquipmentPrice;
      map['FoodKitCount'] = equipmentCount;
    } else if (paymentCategory == 'MULTIPLE_PAYMENT'){

      map['EquipmentID']=equipmentID;
      map['EquipmentCount']=equipmentCount;
      map['One_EquipmentAmount']=oneEquipmentPrice;

      map['Sponsoring_Category']=sponsorCategory;
      map['Sponsoring_OneItemAmount']=sponsorItemOnePrice;
      map['Sponsoring_Count']=sponsorCount;///not



      map['FoodKitPrice']=foodkitPrice;
      map['FoodKitCount']=footkitCount;

      map['FoodKitTotal']=foodkitAmount;
      map['Sponsoring_Total']=sponsorPatientAmonut;
      map['zakathAmount']=zakathAmount;
      map['EquipmentTotal']=equipmentAmount;
      map['MonthlyTotal']=deseaseName;


         print(
        '\n'+'equipmentCount  '+equipmentCount+'\n'+
        'equipmentID  '+equipmentID+'\n'+
        'oneEquipmentPrice  '+oneEquipmentPrice+'\n'+
            'equipmentAmount '+ equipmentAmount+'\n'+
            '\n'+'zakathAmount  '+zakathAmount+'\n'+
            '\n'+'\n'+'sponsorPatientAmonut  '+  sponsorPatientAmonut+'\n'+
            '\n'+'sponsorItemOnePrice  '+sponsorItemOnePrice+'\n'+
            '\n'+'sponsorCount  '+ sponsorCount+'\n'+
            '\n'+'sponsorCategory  '+  sponsorCategory+'\n'+
            '\n'+'\n'+'footkitCount  '+footkitCount+'\n'+
        'deseaseName '+deseaseName+'\n'+
      'foodkitPrice '+  foodkitPrice+'\n'+
      'foodkitAmount '+  foodkitAmount+'\n'+ 'Prineeeeeeee');

    }

    if (loginUserID != '' || loginUsername != '') {
      map['LoginUserName'] = loginUsername;
      map['LoginUserID'] = loginUserID;
    }
    if (subScriberType != '') {
      map['LoginUserType'] = subScriberType;
    }
    if (loginUserPhone != '') {
      map['LoginUserPhone'] = loginUserPhone;
    }

    map['AddedTime'] = DateTime.now();
    map['AddedTime_Millis'] = DateTime.now().millisecondsSinceEpoch.toString();
    map["Receipt Status"] = "Viewed";
    map["Amount"] = amount;
    map["Responds"] = response;
    map["Name"] = name;
    map["PhoneNumber"] = phoneTC.text;
    map["Time"] = now.millisecondsSinceEpoch.toString();
    map["Payment_Date"] = timeString;
    map["ID"] = orderID;
    if(paymentCategory=='MONTHLY_PAYMENT' || paymentCategory=='MULTIPLE_PAYMENT'){
      if(monthList.where((elements) => elements.payStatus == 'NOTPAID' && elements.selectionBool).map((e) => e.monthName).toSet().toList().length>0) {
        map['ONE_MONTH_AMOUNT'] =
            double.parse(kpccAmountController.text) / monthList
                .where((element) =>
            element.payStatus == 'NOTPAID' && element.selectionBool)
                .length;
        map['SELECTED_MONTHS'] =monthList.where((elements) => elements.payStatus == 'NOTPAID' && elements.selectionBool).map((e) => e.monthName).toSet().toList();
        map['YEAR'] = DateTime
            .now()
            .year;
        map['SUBSRIBER_REF']='SUBSCRIBERS/'+loginUserID;
      }
    }
    if (status == "SUCCESS") {
      if(paymentCategory == 'EQUIPMENT'){
        db.collection('EQUIPMENTS').doc(equipmentID).set({
          "EQUIPMENT_COLLECTED_COUNT":
          FieldValue.increment(double.parse(equipmentCount.toString())),
        }, SetOptions(merge: true));
      }

      map["Status"] = "Success";
      map["Receipt Status"] = "notViewed";
    } else {
      map["Status"] = "Failed";
    }

    if (selectedWard != null) {
      district = selectedWard!.district;
      assembly = selectedWard!.assembly;
      panchayath = selectedWard!.panchayath;
      wardName = selectedWard!.wardName;
      wardNumber = selectedWard!.wardNumber;
    } else {
      district = 'GENERAL';
      assembly = 'GENERAL';
      panchayath = 'GENERAL';
      wardName = 'GENERAL';
      wardNumber = 'GENERAL';
    }

    map["district"] = district;
    map["assembly"] = assembly;
    map["panchayath"] = panchayath;
    map["wardName"] = wardName;
    map["wardNumber"] = wardNumber;
    map["Ward"] = wardName;
    map["PaymentApp"] = app;

    if (Platform.isIOS) {
      map["Platform"] = "IOS";
    } else if (Platform.isAndroid) {
      map["Platform"] = "ANDROID";
    } else {
      map["Platform"] = "NIL";
    }

    map["UpiID"] = "";
    map["RefNo"] = "App";
    map["PaymentUpi"] = upiIdP;
    map["PrintStatus"] = 'Not Printed';
    map["AppVersion"] = appver;
    map['LastForDigits'] =
        orderID.substring(orderID.length - 4, orderID.length);
    String? strDeviceID = "";

    if (Platform.isAndroid) {
      strDeviceID = await DeviceInfo().fun_initPlatformState();
    } else if (Platform.isIOS) {
      try {
        strDeviceID = await UniqueIdentifier.serial;
      } on PlatformException {
        strDeviceID = 'Failed to get Unique Identifier';
      }
    } else {
      print("");
    }
    map["DeviceId"] = strDeviceID!;

    if (shownameBool) {
      map['NameShowStatus'] = 'NO';
    } else {
      map['NameShowStatus'] = 'YES';
    }
    String dayNode = 'Y${now.year}/M${now.month}/D${now.day}/H${now.hour}';

    mRoot
        .child("Payment")
        .child(dayNode)
        .child("HourEntry")
        .child(orderID)
        .set(map);

    db.collection("MonitorNode").doc(orderID).set(map);
    String ref = 'Payment/$dayNode/HourEntry/$orderID';
    mRoot.child("PaymentDetails").child(orderID).child("OrderRef").set(ref);
    if (!kIsWeb) {
      // mRoot.child("UserPayments").child(strDeviceID).child(orderID).child("OrderRef").set(ref);
    }

    if (status == "SUCCESS") {
      print("successsss1111");

      HashMap<String, Object> dataMap = map;

      dataMap["Amount"] = double.parse(amount);
      dataMap['Time'] = now.millisecondsSinceEpoch;
      dataMap['LastForDigits'] =
          orderID.substring(orderID.length - 4, orderID.length);
      dataMap['Receipt Status'] = "notViewed";
      db.collection('Payments').doc(orderID).set(dataMap);
      db.collection('Attempts').doc(orderID).update({"Status": "Success"});

      if(paymentCategory=='MONTHLY_PAYMENT' || paymentCategory=='MULTIPLE_PAYMENT'){
        if(monthList.length>0) {
          SubscriptionMap['REFERENCE'] = 'Payments/' + orderID;
          SubscriptionMap['ADDED_TIME'] = DateTime.now();
          SubscriptionMap['STATUS'] = status;
          // String currentMonthInWords = DateFormat('MMMM').format(DateTime.now());
          SubscriptionMap['ADDED_TIME_MILLIS'] = DateTime
              .now()
              .millisecondsSinceEpoch
              .toString();
          SubscriptionMap['AMOUNT'] =
              double.parse(kpccAmountController.text) / monthList
                  .where((element) =>
              element.payStatus == 'NOTPAID' && element.selectionBool)
                  .length;

          if(equipmentID!=''&&equipmentID!='null' && equipmentCount!='' && equipmentCount!='null'&& equipmentCount!='0'){
            db.collection('EQUIPMENTS').doc(equipmentID).set({
              "EQUIPMENT_COLLECTED_COUNT":
              FieldValue.increment(double.parse(equipmentCount.toString())),
            }, SetOptions(merge: true));
          }
          if(paymentCategory == 'EQUIPMENT'){
            db.collection('EQUIPMENTS').doc(equipmentID).set({
              "EQUIPMENT_COLLECTED_COUNT":
              FieldValue.increment(double.parse(equipmentCount.toString())),
            }, SetOptions(merge: true));
          }

          for (var elements in monthList) {
            if (elements.payStatus == 'NOTPAID' && elements.selectionBool) {
              SubscriptionMap['MONTH'] = elements.monthName.toUpperCase();
              SubscriptionMap['YEAR'] = DateTime
                  .now()
                  .year;
              await db.collection('SUBSCRIBERS').doc(loginUserID).collection(
                  'PAYMENTS').doc(DateTime
                  .now()
                  .year
                  .toString() + '_' + elements.monthName.toUpperCase()).set(
                  SubscriptionMap, SetOptions(merge: true));
            }
          }
        }
      }
    }

    getDonationDetailsForReceipt(orderID);

    // amountTC.clear();
    // nameTC.clear();
    // phoneTC.clear();
    // wardTC.clear();
    // selectedWard = null;
    notifyListeners();
  }

  // void delete(){
  //   mRoot.child('UserPayments').remove();
  // }

  // stopDhoti(){
  //   HashMap<String, Object> stopMap = HashMap();
  //   stopMap["AppVersion"]='';
  //   mRoot.child('0').update(stopMap);
  // }

  fetchWard() async {
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());

    Map<dynamic, dynamic> map = jsonResponse as Map;
    wards.clear();
    map.forEach((key, value) {
      wards.add(WardModel(
          value['district'].toString(),
          value['assembly'].toString(),
          value['panchayath'].toString(),
          value['wardname'].toString(),
          value['wardname'].toString()));
    });
  }

  Future<void> fetchAllWards() async {
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());

    mRoot.child('NewWards').onValue.listen((databaseEvent) {
      Map<dynamic, dynamic> map = jsonResponse as Map;
      wards.clear();
      map.forEach((key, value) {
        wards.add(WardModel(
            value['district'].toString(),
            value['assembly'].toString(),
            value['panchayath'].toString(),
            value['wardname'].toString(),
            value['wardname'].toString()));
      });

      newWards.clear();
      if (databaseEvent.snapshot.value != null) {
        newWardsMap = databaseEvent.snapshot.value as Map;
        Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

        map.forEach((key, value) {
          newWards.add(WardModel(
              value['district'].toString(),
              value['assembly'].toString(),
              value['panchayath'].toString(),
              value['wardname'].toString(),
              value['wardnumber'].toString()));
        });
        print(newWards.length.toString() + "qqwwdedj44");

        notifyListeners();
      }
      allWards = wards + newWards;
      notifyListeners();

      print("dfs2222");
      // mRoot.child('hidewards').onValue.listen((databaseEvent) {
      //   print("cfyfyg");
      //   hideWards.clear();
      //   if (databaseEvent.snapshot.value != null) {
      //     print("wiseeeeee");
      //     hideWardsMap= databaseEvent.snapshot.value as Map;
      //     Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;
      //     print("wiseeeeee");
      //     print(map.toString()+"sdfcsnh");
      //
      //     map.forEach((key, value) {
      //       print(key.toString()+"sdfdf222");
      //       hideWards.add(WardModel(
      //           value['district'].toString(), value['assembly'].toString(),value['panchayath'].toString(),
      //           value['wardname'].toString(), value['wardnumber'].toString()));
      //       notifyListeners();
      //
      //     });
      //     print(hideWards.length.toString()+"sdsdqwe");
      //
      //     allWards=wards+newWards;
      //
      //     print(hideWards.length.toString()+"sdsdqwewwwww666");
      //     print(wards.length.toString()+"sdsdqwewwwww111");
      //     print(newWards.length.toString()+"sdsdqwewwwww555");
      //     print(allWards.length.toString()+"sdsdqwewwwww55522");
      //
      //     allWards.removeWhere((item1) => hideWards.any((item2) => (item1.wardName == item2.wardName && item1.panchayath == item2.panchayath && item1.assembly == item2.assembly && item1.district == item2.district )));
      //
      //
      //     notifyListeners();
      //   }else{
      //     allWards=wards+newWards;
      //
      //   }
      //
      // });
    });
  }

  // fetchAllBooth() async {
  //   print("warddddloop22");
  //
  //   var jsonText = await rootBundle.loadString('assets/KPCC_JSON.json');
  //   var jsonResponse = json.decode(jsonText.toString());
  //
  //
  //   mRoot.child('NewWards').onValue.listen((databaseEvent) {
  //
  //     Map <dynamic, dynamic> map = jsonResponse as Map;
  //     booths.clear();
  //     map.forEach((key, value) {
  //       booths.add(AssemblyModel(value['District'].toString(), value['Assembly'].toString()));
  //
  //     });
  //
  //     newBooths.clear();
  //     if (databaseEvent.snapshot.value != null) {
  //       newWardsMap= databaseEvent.snapshot.value as Map;
  //       Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;
  //
  //       map.forEach((key, value) {
  //         newBooths.add(AssemblyModel(value['District'].toString(), value['Assembly'].toString(),));
  //       });
  //
  //       notifyListeners();
  //     }
  //
  //     allBooths=booths+newBooths;
  //
  //   });
  //
  //
  //
  // }

  void onSelectWard(WardModel? ward) {
    selectedWard = ward;

    if (ward != null) {
      wardTC.text = ward.wardName;
      notifyListeners();
    }
    notifyListeners();
  }

  void onSelectAssembly(AssemblyModel? assembly) {
    selectedAssembly = assembly;

    if (assembly != null) {
      assemblyCt.text = assembly.assembly;
      notifyListeners();
    }
    notifyListeners();
  }

  void fetchDatabaseWard() {
    mRoot.child('NewWards').onValue.listen((databaseEvent) {
      newWards.clear();
      if (databaseEvent.snapshot.value != null) {
        newWardsMap = databaseEvent.snapshot.value as Map;
        Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

        map.forEach((key, value) {
          newWards.add(WardModel(
              value['district'].toString(),
              value['panchayath'].toString(),
              value['assembly'].toString(),
              value['wardname'].toString(),
              value['wardnumber'].toString()));
        });

        notifyListeners();
      }
    });
  }

  void fetchDatabaseHideWard() {
    mRoot.child('hidewards').onValue.listen((databaseEvent) {
      newWards.clear();
      if (databaseEvent.snapshot.value != null) {
        hideWardsMap = databaseEvent.snapshot.value as Map;
        Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

        map.forEach((key, value) {
          hideWards.add(WardModel(
              value['district'].toString(),
              value['panchayath'].toString(),
              value['assembly'].toString(),
              value['wardname'].toString(),
              value['wardnumber'].toString()));
        });

        notifyListeners();
      }
    });
  }

  // void fetchDonationDetails(String orderID) {
  //   print("fetch worksssss");
  //   donationTime = DateTime.now();
  //   donorName = '';
  //   donorNumber = '';
  //   donorPlace = '';
  //   donorStatus = '';
  //   donorReceiptPrinted = 'notPrinted';
  //   donorID = orderID;
  //   mRoot.child('PaymentDetails').child(orderID).once().then((dataSnapshot) {
  //
  //     if (dataSnapshot.snapshot.value != null) {
  //       Map<dynamic, dynamic> map = dataSnapshot.snapshot.value as Map;
  //       mRoot.child(map['OrderRef']).onValue.listen((event) {
  //         if (event.snapshot.value != null) {
  //           Map<dynamic, dynamic> detailsMap = event.snapshot.value as Map;
  //           donationTime = DateTime.now();
  //           donorName = '';
  //           donorNumber = '';
  //           donorPlace = '';
  //           donorID = '';
  //           donorReceiptPrinted = 'notPrinted';
  //
  //           donationTime = DateTime.fromMillisecondsSinceEpoch(int.parse(detailsMap['Time'].toString()));
  //           donorName = detailsMap['Name'].toString();
  //           donorNumber = detailsMap['PhoneNumber'].toString();
  //           donorPlace = detailsMap['Ward'].toString();
  //           donorID = orderID;
  //           donorStatus = detailsMap['Status'].toString();
  //           donorAmount = detailsMap['Amount'].toString();
  //           donorApp = detailsMap['PaymentApp'].toString();
  //           if(detailsMap['Print Status']!=null){
  //             donorReceiptPrinted=detailsMap['Print Status'].toString();
  //           }
  //
  //           print("app name"+donorApp);
  //
  //           notifyListeners();
  //         }
  //       });
  //     }
  //   });
  // }

  getDonationDetailsForReceipt(String paymentID) {
    print("AAAAAAAAAAAAAAAAAAAAAAA11");
    donationTime = DateTime.now();
    donorName = '';
    donorNumber = '';
    donorPlace = '';
    donorStatus = '';
    donorReceiptPrinted = 'notPrinted';
    donorID = paymentID;
    db.collection("MonitorNode").doc(paymentID).get().then((value) {
      if (value.exists) {
        donationTime = DateTime.fromMillisecondsSinceEpoch(
            int.parse(value.get("Time").toString()));
        donorName = value.get("Name").toString();
        donorNumber = value.get("PhoneNumber").toString();
        donorPlace = value.get("Ward").toString();
        donorID = paymentID;
        donorStatus = value.get("Status").toString();
        // donorStatus = 'Success';
        ///ameen commented
        donorAmount =
            double.parse(value.get("Amount").toString()).toStringAsFixed(0);
        donorApp = value.get("PaymentApp").toString();

        notifyListeners();
      }
    });
  }

  createImage(String from, String donorName,
      ScreenshotController screenshotController) async {
    String imgName = DateTime.now().millisecondsSinceEpoch.toString();
    // ScreenshotController screenshotController = ScreenshotController();
    await screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        printStatus(donationTime.millisecondsSinceEpoch.toString(), donorID);
        if (!kIsWeb) {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath =
              await File('${directory.path}/$imgName.png').create();
          await imagePath.writeAsBytes(image);

          if (from == 'Print') {
            OpenFile.open(imagePath.path);
          } else {
            Share.shareFiles(
              [imagePath.path],
            );
          }
        } else {
          ByteData bytes = ByteData.view(image.buffer);

          var blob = web_file.Blob([bytes], 'image/png', 'native');

          var anchorElement = web_file.AnchorElement(
            href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
          )
            ..setAttribute("download", "data.png")
            ..click();
        }
      }

      // Handle captured image
    });
  }

  Future getImageFromCamera(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 15);
    if (pickedFile != null) {
      statusImage = File(pickedFile.path);
      fileBytes = await statusImage!.readAsBytes();

      // controller= controller = CropController(
      //   aspectRatio: 1,
      //   defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
      // );
      // callNext(const CropPage(title: "Crop Image"), context);
    } else {
      print('No image selected.');
    }
    if (pickedFile!.path.isEmpty) retrieveLostData();
    notifyListeners();
  }

  Future getImageFromGallery(BuildContext context) async {
    if (!kIsWeb) {
      print("Reached 01");
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);

      print("Reached 02");
      if (pickedFile != null) {
        statusImage = File(pickedFile.path);
        fileBytes = await statusImage!.readAsBytes();
        print("Reached 03");
        // controller = CropController(
        //   aspectRatio: 1,
        //   defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
        // );

        print("Reached 1");
        // callNext(const CropPage(title: "Crop Image"), context);
      } else {}
      if (pickedFile!.path.isEmpty) retrieveLostData();
    } else {
      getImageWeb(context);
    }
    notifyListeners();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      statusImage = File(response.file!.path);
      fileBytes = await statusImage!.readAsBytes();
      notifyListeners();
    }
  }

  Future<void> shareImageStatus(
      ScreenshotController screenshotControllerStatus) async {
    print("HHHHHHHHHHHHHH" + screenshotControllerStatus.toString());

    await screenshotControllerStatus.capture().then((Uint8List? image) async {
      print("HHHHHHHHHHHHHH555" + image.toString());

      if (image != null) {
        printStatus(donationTime.millisecondsSinceEpoch.toString(), donorID);
        if (!kIsWeb) {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/image.png').create();
          await imagePath.writeAsBytes(image);
          print("sfwsdfgfdsg" + imagePath.toString());

          /// Share Plugin
          await Share.shareFiles([imagePath.path]);
        } else {
          ByteData bytes = ByteData.view(image.buffer);

          var blob = web_file.Blob([bytes], 'image/png', 'native');

          var anchorElement = web_file.AnchorElement(
            href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
          )
            ..setAttribute("download", "data.png")
            ..click();
        }
      }

      // Handle captured image
    });
  }

  Future<void> shareImageForPoster(
      ScreenshotController screenshotControllerStatus) async {
    print("HHHHHHHHHHHHHH" + screenshotControllerStatus.toString());

    await screenshotControllerStatus.capture().then((Uint8List? image) async {
      print("HHHHHHHHHHHHHH555" + image.toString());

      if (image != null) {
        // printStatus(donationTime.millisecondsSinceEpoch.toString(),donorID);
        if (!kIsWeb) {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/image.png').create();
          await imagePath.writeAsBytes(image);
          print("sfwsdfgfdsg" + imagePath.toString());

          /// Share Plugin
          await Share.shareFiles([imagePath.path]);
        } else {
          ByteData bytes = ByteData.view(image.buffer);

          var blob = web_file.Blob([bytes], 'image/png', 'native');

          var anchorElement = web_file.AnchorElement(
            href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
          )
            ..setAttribute("download", "data.png")
            ..click();
        }
      }

      // Handle captured image
    });
  }

  // Future<void> onTap(ApplicationMeta app,BuildContext context) async {
  //   String orderID=mRoot.push().key.toString();
  //   String _url=getUpiURL(upiAddress, 'Ashhar', '5812',DateTime.now().millisecondsSinceEpoch.toString(), orderID, "Check", "1", "INR", "https://spinecodes.in/");
  //   var result = await launch(_url);
  //   debugPrint(result.toString());
  //   if (result ==true) {
  //     print("Done");
  //   } else if (result ==false){
  //     print("Fail");
  //   }
  //
  //   // String orderID=mRoot.push().key.toString();
  //   //
  //   //
  //   // final transactionRef = Random.secure().nextInt(1 << 32).toString();
  //   //
  //   // final a = await UpiPay.initiateTransaction(
  //   //   amount: amountTC.text.replaceAll(',', ''),
  //   //   app: app.upiApplication,
  //   //   receiverName: 'Ashhar',
  //   //   receiverUpiAddress: upiAddress,
  //   //   transactionRef: transactionRef,
  //   //   transactionNote: 'UPI Payment',
  //   //
  //   //   // merchantCode: '7372',
  //   // );
  //   // if(a.status.toString()=='UpiTransactionStatus.success'){
  //   //   upDatePayment('Success', "", context, orderID,'UPI');
  //   //
  //   // }else{
  //   //   upDatePayment('Failed', "", context, orderID,'UPI');
  //   //
  //   // }
  //
  //
  //
  //
  //
  //
  // }

  String getUpiURL(
      String payeeAddress,
      String payeeName,
      String payeeMCC,
      String trxnID,
      String trxnRefId,
      String trxnNote,
      String payeeAmount,
      String currencyCode,
      String refUrl) {
    String UPI = "upi://pay?pa=" +
        payeeAddress +
        "&pn=" +
        payeeName +
        "&mc=" +
        payeeMCC +
        "&tid=" +
        trxnID +
        "&tr=" +
        trxnRefId +
        "&tn=" +
        trxnNote +
        "&am=" +
        payeeAmount +
        "&cu=" +
        currencyCode +
        "&url=" +
        refUrl +
        '/' +
        trxnID;
    return UPI.replaceAll(" ", "+");
  }

  Future<String> cashFree(String orderId, String amount) async {
    // var client = http.Client();
    // var body = json.encode({
    //   'orderId': orderId,
    //   'orderAmount': amount,
    //   "orderCurrency": "INR"
    // });
    //
    // var response = await client.post(
    //     Uri.parse('https://test.cashfree.com/api/v2/cftoken/order'),
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'x-client-id': '138690c1d12c4584a31312d667096831',
    //       'x-client-secret': '5f9e892b82c15b6074622a948d172f467f565cbf'
    //     },
    //     body: body
    // );
    // var jsonMap = json.decode(response.body);
    //
    // var token = Cashfreemodel
    //     .fromJson(jsonMap)
    //     .cftoken;

    // return token;

    var client = http.Client();
    var url =
        'https://us-central1-haddiyya-1b794.cloudfunctions.net/widgets/users';
    var body = json.encode({
      "OrderID": orderId,
      "orderAmount": amount,
    });
    final response = await client.post(
      Uri.parse(url),
      body: body,
      headers: {'Content-type': "application/json"},
    );
    var responseData = json.decode(response.body);
    var token = Cashfreemodel.fromJson(responseData).cftoken;
    return token;
  }

  getUPIApps() {
    if (!kIsWeb) {
      CashfreePGSDK.getUPIApps().then((value) {
        if (value != null && value.isNotEmpty) {
          upiApps = value;
          notifyListeners();
        }
      });
    }
  }

  Future<void> seamlessUPIIntent(
    item,
    BuildContext context,
    String paymentCategory,
    String equipmentCount,
    String equipmentID,
    String oneEquipmentPrice,
    String loginUsername,
    String loginUserID,
    String subScriberType,
    String loginUserPhone,
    String zakathAmount,
    String deseaseName,
    String sponsorCategory,
    String sponsorCount,
    String sponsorItemOnePrice,
    String foodkitPrice,
    String footkitCount,
    String equipmentAmount,
    String sponsorPatientAmonut,
    String foodkitAmount,
  ) async {
    String orderId = transactionID.text;

    String tokenData =
        await cashFree(orderId, amountTC.text.replaceAll(',', ''));

    String name = nameTC.text != '' ? nameTC.text : 'No Name';
    String phone = phoneTC.text != '' ? phoneTC.text : '0000000000';

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": amountTC.text.replaceAll(',', ''),
      "customerName": name,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": phone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,
      // For seamless UPI Intent
      "appName": item['id']
    };

    CashfreePGSDK.doUPIPayment(inputParams).then((value) {
      print(value!['txStatus']);
      upDatePayment(
        value['txStatus'],
        value.toString(),
        context,
        orderId,
        item['displayName'].toString() + " CashFree",
        '',
        " ",
        paymentCategory,
        equipmentCount,
        equipmentID,
        oneEquipmentPrice,
        loginUsername,
        loginUserID,
        subScriberType,
        loginUserPhone,
        zakathAmount,
        deseaseName,
        sponsorCategory,
        sponsorCount,
        sponsorItemOnePrice,
        foodkitPrice,
        footkitCount,
        equipmentAmount,
        sponsorPatientAmonut,
        foodkitAmount,monthList
      );
    });
  }

  Future<void> seamlessNetbankingPayment(
    BuildContext context,
    String bankCode,
    String paymentCategory,
    String equipmentCount,
    String equipmentID,
    String oneEquipmentPrice,
    String loginUsername,
    String loginUserID,
    String subScriberType,
    String loginUserPhone,
    String zakathAmount,
    String deseaseName,
    String sponsorCategory,
    String sponsorCount,
    String sponsorItemOnePrice,
    String foodkitPrice,
    String footkitCount,
    String equipmentAmount,
    String sponsorPatientAmonut,
    String foodkitAmount,List<MonthBool> monthList
  ) async {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String tokenData =
        await cashFree(orderId, amountTC.text.replaceAll(',', ''));

    String name = nameTC.text != '' ? nameTC.text : 'No Name';
    String phone = phoneTC.text != '' ? phoneTC.text : '0000000000';

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": amountTC.text.replaceAll(',', ''),
      "customerName": name,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": phone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,

      // EXTRA THINGS THAT NEEDS TO BE ADDED
      "paymentOption": "nb",
      "paymentCode": bankCode,
      // Find Code here https://docs.cashfree.com/docs/net-banking
    };

    CashfreePGSDK.doPayment(inputParams).then((value) {
      Map<dynamic, dynamic> detailsMap = value as Map;
      if (detailsMap['txStatus'] != 'CANCELLED') {
        upDatePayment(
          value['txStatus'],
          value.toString(),
          context,
          orderId,
          "Net Banking CashFree",
          '',
          "",
          paymentCategory,
          equipmentCount,
          equipmentID,
          oneEquipmentPrice,
          loginUsername,
          loginUserID,
          subScriberType,
          loginUserPhone,
          zakathAmount,
          deseaseName,
          sponsorCategory,
          sponsorCount,
          sponsorItemOnePrice,
          foodkitPrice,
          footkitCount,
          equipmentAmount,
          sponsorPatientAmonut,
          foodkitAmount,monthList
        );
      }
    });
  }

  getBanks() async {
    var jsonText = await rootBundle.loadString('assets/bank_list.json');
    var jsonResponse = json.decode(jsonText.toString());
    List tmpWards = jsonResponse;
    banks.clear();
    for (var element in tmpWards) {
      banks.add(BankModel(element['Code'], element['Bank']));
      filteredBanks.add(BankModel(element['Code'], element['Bank']));
      notifyListeners();
    }
    notifyListeners();
  }

  void payAmountButton(String text) {
    strAmountButton = text;
    notifyListeners();
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // notifyListeners();
  }

  void onCardInputChange(CreditCardModel data) {
    cardHolderName = data.cardHolderName;
    expiryDate = data.expiryDate;
    cardNumber = data.cardNumber;
    cvvCode = data.cvvCode;
    notifyListeners();
  }

  Future<void> seamlessCardPayment(
    BuildContext context,
    String paymentCategory,
    String equipmentCount,
    String equipmentID,
    String oneEquipmentPrice,
    String loginUsername,
    String loginUserID,
    String subScriberType,
    String loginUserPhone,
    String zakathAmount,
    String deseaseName,
    String sponsorCategory,
    String sponsorCount,
    String sponsorItemOnePrice,
    String foodkitPrice,
    String footkitCount,
    String equipmentAmount,
    String sponsorPatientAmonut,
    String foodkitAmount,List<MonthBool> monthList
  ) async {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String tokenData =
        await cashFree(orderId, amountTC.text.replaceAll(',', ''));

    String name = nameTC.text != '' ? nameTC.text : 'No Name';
    String phone = phoneTC.text != '' ? phoneTC.text : '0000000000';
    String monthExp = expiryDate.substring(0, expiryDate.indexOf("/"));
    String yearExp = "20" +
        expiryDate.substring(expiryDate.indexOf("/") + 1, expiryDate.length);

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": amountTC.text.replaceAll(',', ''),
      "customerName": name,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": phone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,
      "paymentOption": "card",
      "card_number": cardNumber.replaceAll(' ', ''),
      "card_expiryMonth": monthExp,
      "card_expiryYear": yearExp,
      "card_holder": cardHolderName,
      "card_cvv": cvvCode
    };

    CashfreePGSDK.doPayment(inputParams).then((value) {
      Map<dynamic, dynamic> detailsMap = value as Map;
      if (detailsMap['txStatus'] != 'CANCELLED') {
        upDatePayment(
          value['txStatus'],
          value.toString(),
          context,
          orderId,
          "Card CashFree",
          '',
          "",
          paymentCategory,
          equipmentCount,
          equipmentID,
          oneEquipmentPrice,
          loginUsername,
          loginUserID,
          subScriberType,
          loginUserPhone,
          zakathAmount,
          deseaseName,
          sponsorCategory,
          sponsorCount,
          sponsorItemOnePrice,
          foodkitPrice,
          footkitCount,
          equipmentAmount,
          sponsorPatientAmonut,
          foodkitAmount,monthList
        );
      }
    });
  }

  Future<void> getSharedPref() async {
    SharedPreferences userPreference = await SharedPreferences.getInstance();
    if (userPreference.getString("AlertShowed") != null) {
      isAlertShowed = true;
    } else {
      isAlertShowed = false;
    }
  }

  void onFilterBank(String value) {
    filteredBanks = banks
        .where((element) =>
            element.bank.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> seamlessUPIPayment(
    BuildContext context,
    String upiID,
    String paymentCategory,
    String equipmentCount,
    String equipmentID,
    String oneEquipmentPrice,
    String loginUsername,
    String loginUserID,
    String subScriberType,
    String loginUserPhone,
    String zakathAmount,
    String deseaseName,
    String sponsorCategory,
    String sponsorCount,
    String sponsorItemOnePrice,
    String foodkitPrice,
    String footkitCount,
    String equipmentAmount,
    String sponsorPatientAmonut,
    String foodkitAmount,List<MonthBool> monthList
  ) async {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String tokenData =
        await cashFree(orderId, amountTC.text.replaceAll(',', ''));

    String name = nameTC.text != '' ? nameTC.text : 'No Name';
    String phone = phoneTC.text != '' ? phoneTC.text : '0000000000';

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": amountTC.text.replaceAll(',', ''),
      "customerName": name,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": phone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,

      // EXTRA THINGS THAT NEEDS TO BE ADDED
      "paymentOption": "upi",
      "upi_vpa": upiID
    };

    CashfreePGSDK.doPayment(inputParams).then((value) {
      Map<dynamic, dynamic> detailsMap = value as Map;
      if (detailsMap['txStatus'] != 'CANCELLED') {
        upDatePayment(
          value['txStatus'],
          value.toString(),
          context,
          orderId,
          "UpiLinking CashFree",
          '',
          "",
          paymentCategory,
          equipmentCount,
          equipmentID,
          oneEquipmentPrice,
          loginUsername,
          loginUserID,
          subScriberType,
          loginUserPhone,
          zakathAmount,
          deseaseName,
          sponsorCategory,
          sponsorCount,
          sponsorItemOnePrice,
          foodkitPrice,
          footkitCount,
          equipmentAmount,
          sponsorPatientAmonut,
          foodkitAmount,monthList
        );
      }
    });
  }

  void fetchPaymentGateways() {
    mRoot.child("PaymentGateways").onValue.listen((event) {
      paymentGateWays.clear();
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        map.forEach((key, value) {
          paymentGateWays.add(value.toString());
          notifyListeners();
        });
      }
      notifyListeners();
    });
  }

  // Future<void> payUPaymentGateWay(BuildContext context,String amount,String name,String phone) async {
  //   finish(context);
  //   String txnID=DateTime.now().millisecondsSinceEpoch.toString();
  //   var arguments={'amount':amount,'phone':phone,'name':name,'txnID':txnID};
  //
  //   if(Platform.isAndroid){
  //     String status=await platformChanel.invokeMethod('openPayu',arguments);
  //
  //
  //     if(status!=null){
  //       upDatePayment(status, "no response", context, txnID, "HDFC",'');
  //     }
  //   }
  //
  // }

  Future<void> upiIntent(
    BuildContext context,
    String amount,
    String name,
    String phone,
    String app,
    String appver,
    String paymentCategory,
    String equipmentCount,
    String equipmentID,
    String oneEquipmentPrice,
    String loginUsername,
    String loginUserID,
    String subScriberType,
    String loginUserPhone,
    String zakathAmount,
    String deseaseName,
    String sponsorCategory,
    String sponsorCount,
    String sponsorItemOnePrice,
    String foodkitPrice,
    String footkitCount,
    String equipmentAmount,
    String sponsorPatientAmonut,
    String foodkitAmount,List<MonthBool> monthList
  ) async {
    print('what is name   :  ' + nameTC.text + amount);

    String txnID = transactionID.text;
    UpiModel upiModel = await getUpiUri(app, amount.replaceAll(',', ''), txnID);
    var arguments = {
      'Uri': upiModel.uri,
    };
    print(upiModel.upiId + ' oivjwoejfewf');
    if (Platform.isAndroid) {
      String status = await platformChanel.invokeMethod(app, arguments);

      if (status != 'NoApp') {
        if (status != 'FAILED') {
          print("code isss here");
          upDatePayment(
            "SUCCESS",
            status,
            context,
            txnID,
            app,
            upiModel.upiId,
            appver,
            paymentCategory,
            equipmentCount,
            equipmentID,
            oneEquipmentPrice,
            loginUsername,
            loginUserID,
            subScriberType,
            loginUserPhone,
            zakathAmount,
            deseaseName,
            sponsorCategory,
            sponsorCount,
            sponsorItemOnePrice,
            foodkitPrice,
            footkitCount,
            equipmentAmount,
            sponsorPatientAmonut,
            foodkitAmount,monthList
          );
        } else {
          print("code isss here22222");
          upDatePayment(
              "FAILED",
              "no response",
              context,
              txnID,
              app,
              upiModel.upiId,
              appver,paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice,loginUsername,loginUserID,subScriberType,loginUserPhone, zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice, foodkitPrice, footkitCount,equipmentAmount,
                sponsorPatientAmonut, foodkitAmount,monthList);

          ///ameen commented
          // upDatePayment(
          //   "SUCCESS",
          //   status,
          //   context,
          //   txnID,
          //   app,
          //   upiModel.upiId,
          //   appver,
          //   paymentCategory,
          //   equipmentCount,
          //   equipmentID,
          //   oneEquipmentPrice,
          //   loginUsername,
          //   loginUserID,
          //   subScriberType,
          //   loginUserPhone,
          //   zakathAmount,
          //   deseaseName,
          //   sponsorCategory,
          //   sponsorCount,
          //   sponsorItemOnePrice,
          //   foodkitPrice,
          //   footkitCount,
          //   equipmentAmount,
          //   sponsorPatientAmonut,
          //   foodkitAmount,monthList
          // );
        }
      } else {
        String url = '';
        if (app == 'BHIM') {
          url =
              'https://play.google.com/store/apps/details?id=in.org.npci.upiapp&hl=en_IN&gl=US';
        } else if (app == 'GPay') {
          url =
              'https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user&hl=en_IN&gl=US';
        } else if (app == 'Paytm') {
          url =
              'https://play.google.com/store/apps/details?id=net.one97.paytm&hl=en_IN&gl=US';
        } else if (app == 'PhonePe') {
          url =
              'https://play.google.com/store/apps/details?id=com.phonepe.app&hl=en_IN&gl=US';
        }
        _launchURL(url);
      }
    }
  }

  shareQrToApp() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/upiqrcode.jpeg');
      final Uint8List list = bytes.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/upiqrcode.jpeg').create();
      file.writeAsBytesSync(list);
      var arguments = {
        'path': 'upiqrcode.jpeg',
        'app': 'com.google.android.apps.nbu.paisa.user'
      };

      await platformChanel.invokeMethod('ShareQr', arguments);
    } catch (e) {}
  }

  Future<void> sendMessage() async {
    String apiKey = "apikey=" "8YMRueR+cPI-m0xemFHppCTknkiCUGj80K4G1veO9N";
    String c;
    c = "Redeem Process is success...! , you have received "
        " Point as Cash , and you have "
        " Points remaining\n"
        "Thank you\n"
        "...HOTEL DELICIA...";
    String message = "&message=" + c;
    String sender = "&sender=" "DELCIA";
    String numbers = "&numbers=" "918086589166";
    String data = apiKey + numbers + message + sender;

    var postUri = Uri.parse("https://api.textlocal.in/send/?");
    var request = http.MultipartRequest("POST", postUri);
    List<int> bytes = utf8.encode(data);
    request.files.add(http.MultipartFile.fromBytes('file', bytes));
    Map<String, String> headers = {
      'Content-Length': utf8.encode(data).length.toString()
    };
    request.headers.addAll(headers);

    request.send().then((response) {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Uploaded!");
        }
      }
    });
  }

  void copyToClipBoard(BuildContext context, text) {
    Clipboard.setData(ClipboardData(text: text));
    final snackBar = SnackBar(
        backgroundColor: myBlack,
        duration: const Duration(milliseconds: 2000),
        content: Text(
          "Copied to clipboard",
          textAlign: TextAlign.center,
          softWrap: true,
          style: snackbarStyle,
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void changeWhatsappImage(var cropper) async {
    whatsappStatus = cropper;
    WImageByte = "true";

    notifyListeners();
  }

  Future<void> shareQr() async {
    final bytes = await rootBundle.load('assets/upiqrcode.jpeg');
    final list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/image.jpg').create();
    file.writeAsBytesSync(list);
    Share.shareFiles([(file.path)], text: '');
  }

  Future<void> getImageWeb(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      fileBytes = result.files.first.bytes;
      // callNext(const CropPage(title: "Crop Image"), context);

      notifyListeners();

      // Upload file
    }
  }

  Future<void> getSharedPrefName() async {
    SharedPreferences userPreference = await SharedPreferences.getInstance();
    if (userPreference.getString("ReceiptName") != null) {
      name.text = userPreference.getString("ReceiptName")!;
    }
  }

  void selectPinWard(WardModel wardName) {
    pinWardTC.text = wardName.wardName;
    selectedWard = wardName;
    notifyListeners();
  }

  void addPinWard(BuildContext context, String timeStamp, String transactionID,
      String amount, PaymentDetails item) {
    HashMap<String, Object> wardData = HashMap();
    wardData["Ward"] = pinWardTC.text;
    wardData["wardName"] = pinWardTC.text;
    wardData["district"] = selectedWard!.district;
    wardData["assembly"] = selectedWard!.assembly;
    wardData["panchayath"] = selectedWard!.panchayath;
    wardData["wardNumber"] = selectedWard!.wardNumber;
    db.collection("Payments").doc(transactionID).get().then((value) {
      if (value.exists) {
        db
            .collection('Payments')
            .doc(transactionID)
            .set(wardData, SetOptions(merge: true));
        db
            .collection("MonitorNode")
            .doc(transactionID)
            .set(wardData, SetOptions(merge: true));

        print(
            '${selectedWard!.district}_${selectedWard!.panchayath}_${selectedWard!.wardName}'
                    .toString() +
                "yggyusysyg");
        db
            .collection('WardTotalAmount')
            .doc(
                '${selectedWard!.district}_${selectedWard!.panchayath}_${selectedWard!.wardName}')
            .set({
          "Amount": FieldValue.increment(double.parse(amount)),
          "TRANSACTION_COUNT": FieldValue.increment(1)
        }, SetOptions(merge: true));
        notifyListeners();
        print(
            '${item.district}_${item.panchayath}_${item.wardName}'.toString() +
                "yttyfty");

        db
            .collection('WardTotalAmount')
            .doc('${item.district}_${item.panchayath}_${item.wardName}')
            .set({
          "Amount": FieldValue.increment(-double.parse(amount)),
          "TRANSACTION_COUNT": FieldValue.increment(-1)
        }, SetOptions(merge: true));
        notifyListeners();
      }
    });

    if (selectedWard!.panchayath != item.panchayath) {
      db
          .collection('PANCHAYATH_TOTAL')
          .doc(
              '${selectedWard!.district}_${selectedWard!.assembly}_${selectedWard!.panchayath}')
          .set({
        "AMOUNT": FieldValue.increment(double.parse(amount)),
        "TRANSACTION_COUNT": FieldValue.increment(1),
      }, SetOptions(merge: true));
      db
          .collection('PANCHAYATH_TOTAL')
          .doc('${item.district}_${item.assembly}_${item.panchayath}')
          .set({
        "AMOUNT": FieldValue.increment(-double.parse(amount)),
        "TRANSACTION_COUNT": FieldValue.increment(-1),
      }, SetOptions(merge: true));
      notifyListeners();

      if (selectedWard!.assembly != item.assembly) {
        db
            .collection('ASSEMBLY_TOTAL')
            .doc('${selectedWard!.district}_${selectedWard!.assembly}')
            .set({
          "AMOUNT": FieldValue.increment(double.parse(amount)),
          "TRANSACTION_COUNT": FieldValue.increment(1),
        }, SetOptions(merge: true));
        db
            .collection('ASSEMBLY_TOTAL')
            .doc('${item.district}_${item.assembly}')
            .set({
          "AMOUNT": FieldValue.increment(-double.parse(amount)),
          "TRANSACTION_COUNT": FieldValue.increment(-1),
        }, SetOptions(merge: true));
        notifyListeners();

        if (selectedWard!.district != item.district) {
          db.collection('DISTRICTS_TOTAL').doc(selectedWard!.district).set({
            "AMOUNT": FieldValue.increment(double.parse(amount)),
            "TRANSACTION_COUNT": FieldValue.increment(1),
          }, SetOptions(merge: true));
          db.collection('DISTRICTS_TOTAL').doc(item.district).set({
            "AMOUNT": FieldValue.increment(-double.parse(amount)),
            "TRANSACTION_COUNT": FieldValue.increment(-1),
          }, SetOptions(merge: true));
          notifyListeners();
        }
      }
    }

    notifyListeners();

    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    homeProvider.fetchHistoryFromFireStore();

//     homeProvider.searchPayments(
//         transactionID, context);
// finish(context);
//     notifyListeners();
  }

// void addPinBooth(BuildContext context,String timeStamp,String transactionID,String amount, PaymentDetails item){
//
//
//
//
//   HashMap<String, Object> wardData = HashMap();
//     wardData["district"]=selectedWard!.district;
//     wardData["assembly"]=selectedWard!.assembly;
//     wardData["block"]=selectedWard!.block;
//     wardData["mandalam"]=selectedWard!.mandalam;
//     // wardData["booth"]=pinWardTC.text;
//     wardData["booth"]=selectedWard!.booth;
//
//
//
//
//   db.collection("Payments").doc(transactionID).get().then((value){
//     if(value.exists){
//       db.collection('Payments').doc(transactionID).update(wardData);
//       db.collection("MonitorNode").doc(transactionID).update(wardData);
//
//       db.collection('WardTotalAmount').doc('${selectedWard!.district}_${selectedWard!.assembly}_${selectedWard!.booth}').update({"Amount": FieldValue.increment(double.parse(amount))});
//
//       db.collection('WardTotalAmount').doc('${item.district}_${item.assembly}_${item.booth}').update({"Amount": FieldValue.increment(-double.parse(amount))});
//       notifyListeners();
//
//     }
//
//   });
//
//     HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
//     homeProvider.fetchHistoryFromFireStore();
//
//
// }

  void receiptStatus(transactionID) {
    HashMap<String, Object> receiptData = HashMap();
    receiptData["Receipt Status"] = "Viewed";
    receiptData["Name"] = name.text;
    mRoot
        .child('PaymentDetails')
        .child(transactionID)
        .once()
        .then((dataSnapshot) {
      if (dataSnapshot.snapshot.value != null) {
        Map<dynamic, dynamic> map = dataSnapshot.snapshot.value as Map;
        mRoot.child(map['OrderRef']).update(receiptData);
      }
    });
    db.collection('Payments').doc(transactionID).update(receiptData);
    notifyListeners();
  }

  void receiptSuccessStatus(transactionID) {
    HashMap<String, Object> receiptData = HashMap();
    receiptData["Receipt Status"] = "Viewed";
    mRoot
        .child('PaymentDetails')
        .child(transactionID)
        .once()
        .then((dataSnapshot) {
      if (dataSnapshot.snapshot.value != null) {
        Map<dynamic, dynamic> map = dataSnapshot.snapshot.value as Map;
        mRoot.child(map['OrderRef']).update(receiptData);
      }
    });
    db.collection('Payments').doc(transactionID).update(receiptData);
    notifyListeners();
  }

  void printStatus(String timeStamp, transactionID) {
    HashMap<String, Object> receiptData = HashMap();
    receiptData["Print Status"] = "Printed";

    mRoot
        .child('PaymentDetails')
        .child(transactionID)
        .once()
        .then((dataSnapshot) {
      if (dataSnapshot.snapshot.value != null) {
        Map<dynamic, dynamic> map = dataSnapshot.snapshot.value as Map;

        mRoot.child(map['OrderRef']).update(receiptData);
      }
    });
    db.collection('Payments').doc(transactionID).update(receiptData);

    notifyListeners();
  }

  void printStatusforPoster(String timeStamp, transactionID) {
    HashMap<String, Object> receiptData = HashMap();
    receiptData["Print Status"] = "Printed";

    mRoot
        .child('PaymentDetails')
        .child(transactionID)
        .once()
        .then((dataSnapshot) {
      if (dataSnapshot.snapshot.value != null) {
        Map<dynamic, dynamic> map = dataSnapshot.snapshot.value as Map;

        mRoot.child(map['OrderRef']).update(receiptData);
      }
    });
    db.collection('Payments').doc(transactionID).update(receiptData);

    notifyListeners();
  }

  // void fetchAccountDetails(){
  //   mRoot.child("0").child("AccountDetials").onValue.listen((event) {
  //     if(event.snapshot.value!=null){
  //       Map<dynamic, dynamic> map = event.snapshot.value as Map;
  //       acNo=map["AccountNumber"];
  //       ifsc=map["ifsc"];
  //       acName=map["AccountName"];
  //       acUpiId=map["UpiId"];
  //       notifyListeners();
  //     }
  //     notifyListeners();
  //   });
  // }

  Future<UpiModel> getUpiUri(String app, String amount, String txnID) async {
    double amt = 0;

    try {
      amt = double.parse(amount);
    } catch (e) {}

    if (amt < 2000) {
      app = app + '2000';
    }

    var snapshot = await mRoot
        .child("0")
        .child("AccountDetials")
        .child('PaymentGateway')
        .child(app)
        .once();
    Map<dynamic, dynamic> map = snapshot.snapshot.value as Map;
    String upiId = map['UpiId'];
    String upiName = map['UpiName'];
    String upiAdd = map['UpiAdd'];
    // UpiModel upiModel=UpiModel(upiId, 'upi://pay?pa=$upiId&pn=$upiName&am=$amount&cu=INR&mc=8651&m&purpose=00&tn=kx ${txnID}$upiAdd');
    UpiModel upiModel = UpiModel(upiId,
        'upi://pay?pa=$upiId&pn=$upiName&am=$amount&cu=INR&mc=8651&tn=qm ${txnID}$upiAdd');
    return upiModel;
  }

  void onAmountChange(String text) {
    displayAmount = text;
    notifyListeners();
  }

  Future<void> fetchPanjayath() async {
    panjayathList =
        await WardsService(newWardsMap, hideWardsMap).getAllPanjayath();
  }

  // Future<void> fetchAssembly() async {
  //   assemblyList=await WardsService(newWardsMap).getAllAssembly();
  // }

  void fetchUnitChipset(PanjayathModel selection, BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    notifyListeners();

    selectedPanjayathChip = selection;
    chipsetWardList.clear();
    WardsService(newWardsMap, hideWardsMap)
        .getUnitChip(selection.district, selection.panjayath)
        .then((value) {
      chipsetWardList = value;
      notifyListeners();
    });
    notifyListeners();
  }

  // void fetchBoothChipset(AssemblyModel selection,BuildContext context) async {
  //
  //
  //   FocusScopeNode currentFocus = FocusScope.of(context);
  //   if (!currentFocus.hasPrimaryFocus) {
  //     currentFocus.unfocus();
  //   }
  //
  //   notifyListeners();
  //
  //   selectedAssemblyChip=selection;
  //   chipsetBoothList.clear();
  //   WardsService(newWardsMap).getBoothChip(selection.district, selection.assembly).then((value) {
  //     chipsetBoothList=value;
  //     notifyListeners();
  //
  //   });
  //   notifyListeners();
  // }

  void fetchPinWard() {
    mRoot.child('0').child('PinWardPH').onValue.listen((event) {
      if (event.snapshot.exists) {
        phonePinWard = event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }

  void attempt(
      String orderID,
      String appver,
      String paymentCategory,
      String equipmentCount,
      String equipmentID,
      String oneEquipmentPrice,
      String loginUsername,
      String loginUserID,
      String subScriberType,
      String loginUserPhone,  String zakathAmount,String deseaseName,String sponsorCategory,String sponsorCount,
  String sponsorItemOnePrice,String foodkitPrice,String footkitCount,
  String equipmentAmount,String sponsorPatientAmonut,String foodkitAmount,List<MonthBool> monthList) async {
    String timeString = "";

    DateTime now = DateTime.now();
    TimeStampModel? timeStampModel = await TimeService().getTime();

    if (timeStampModel != null) {
      now = timeStampModel.datetime.toLocal();
      timeString = outputDayNode.format(now).toString();
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageVersion = packageInfo.version;

    String amount = kpccAmountController.text.toString().replaceAll(',', '');

    String district = '';
    String assembly = '';
    String panchayath = '';
    String wardName = '';
    String wardNumber = '';

    HashMap<String, Object> map = HashMap();
    map['Payment Category'] = paymentCategory;
    print(paymentCategory+' IUXNIHSICC');if (paymentCategory == 'EQUIPMENT') {
      map['EquipmentID'] = equipmentID;
      map['EquipmentCount'] = equipmentCount;
      map['One_EquipmentAmount'] = oneEquipmentPrice;
    } else if (paymentCategory == 'SPONSOR_PATIENT') {
      map['Sponsoring_Category'] = equipmentID;
      map['Sponsoring_Count'] = equipmentCount;
      map['Sponsoring_OneItemAmount'] = oneEquipmentPrice;
    } else if (paymentCategory == 'FOODKIT') {
      map['FoodKitPrice'] = oneEquipmentPrice;
      map['FoodKitCount'] = equipmentCount;
    } else if (paymentCategory == 'SUBSCRIBER_PAYMENT') {
    } else if (paymentCategory == 'MULTIPLE_PAYMENT') {print('COISNDNFFU ');
      map['EquipmentID']=equipmentID;
      map['EquipmentCount']=equipmentCount;
      map['One_EquipmentAmount']=oneEquipmentPrice;
      map['EquipmentTotal']=equipmentAmount;

      map['Sponsoring_Category']=sponsorCategory;
      map['Sponsoring_OneItemAmount']=sponsorItemOnePrice;
      map['Sponsoring_Count']=sponsorCount;
      map['Sponsoring_Total']=sponsorPatientAmonut;

      map['zakathAmount']=zakathAmount;


      map['FoodKitPrice']=foodkitPrice;
      map['FoodKitCount']=footkitCount;
      map['FoodKitTotal']=foodkitAmount;
    map['MonthlyTotal']=deseaseName;

      print(
          '\n'+'equipmentCount  '+equipmentCount+'\n'+
              'equipmentID  '+equipmentID+'\n'+
              'oneEquipmentPrice  '+oneEquipmentPrice+'\n'+
              'equipmentAmount '+ equipmentAmount+'\n'+
              '\n'+'zakathAmount  '+zakathAmount+'\n'+
              '\n'+'\n'+'sponsorPatientAmonut  '+  sponsorPatientAmonut+'\n'+
              '\n'+'sponsorItemOnePrice  '+sponsorItemOnePrice+'\n'+
              '\n'+'sponsorCount  '+ sponsorCount+'\n'+
              '\n'+'sponsorCategory  '+  sponsorCategory+'\n'+
              '\n'+'\n'+'footkitCount  '+footkitCount+'\n'+
              'deseaseName '+deseaseName+'\n'+
              'foodkitPrice '+  foodkitPrice+'\n'+
              'foodkitAmount '+  foodkitAmount+'\n'+ 'PrCSCSSCCSCineeeeeeee');
    }

    if (loginUserID != '' || loginUsername != '') {
      map['LoginUserName'] = loginUsername;
      map['LoginUserID'] = loginUserID;
    }
    if (subScriberType != '') {
      map['LoginUserType'] = subScriberType;
    }

    if (loginUserPhone != '') {
      map['LoginUserPhone'] = loginUserPhone;
    }

    if(paymentCategory=='MONTHLY_PAYMENT' || paymentCategory=='MULTIPLE_PAYMENT'){
      if(monthList.where((elements) => elements.payStatus == 'NOTPAID' && elements.selectionBool).map((e) => e.monthName).toSet().toList().length>0) {
        map['ONE_MONTH_AMOUNT'] =
            double.parse(kpccAmountController.text) / monthList
                .where((element) =>
            element.payStatus == 'NOTPAID' && element.selectionBool)
                .length;
        map['SELECTED_MONTHS'] =monthList.where((elements) => elements.payStatus == 'NOTPAID' && elements.selectionBool).map((e) => e.monthName).toSet().toList();
        map['YEAR'] = DateTime
                .now()
                .year;
        map['SUBSRIBER_REF']='SUBSCRIBERS/'+loginUserID;
      }
    }

    map['AddedTime'] = DateTime.now();
    map['AddedTime_Millis'] = DateTime.now().millisecondsSinceEpoch.toString();
    map["Amount"] = amount;
    map["Name"] = nameTC.text;
    map["PhoneNumber"] = phoneTC.text;
    map["Payment_Date"] = timeString;
    map["Time"] = now.millisecondsSinceEpoch.toString();
    map["ID"] = orderID;

    if (selectedWard != null) {
      district = selectedWard!.district;
      assembly = selectedWard!.assembly;
      panchayath = selectedWard!.panchayath;
      wardName = selectedWard!.wardName;
      wardNumber = selectedWard!.wardNumber;
    } else {
      district = 'GENERAL';
      assembly = 'GENERAL';
      panchayath = 'GENERAL';
      wardName = 'GENERAL';
      wardNumber = 'GENERAL';
    }

    map["district"] = district;
    map["assembly"] = assembly;
    map["panchayath"] = panchayath;
    map["wardName"] = wardName;
    map["wardNumber"] = wardNumber;
    map["Ward"] = wardName;

    if (shownameBool) {
      map['NameShowStatus'] = 'NO';
    } else {
      map['NameShowStatus'] = 'YES';
    }
    // map["Ward"] = 'General';

    if (Platform.isIOS) {
      map["Platform"] = "IOS";
    } else if (Platform.isAndroid) {
      map["Platform"] = "ANDROID";
    } else {
      map["Platform"] = "NIL";
    }

    map["UpiID"] = "";
    map["RefNo"] = "App";

    map["PrintStatus"] = 'Not Printed';
    map["AppVersion"] = appver;

    String? strDeviceID = "";
    if (Platform.isAndroid) {
      strDeviceID = await DeviceInfo().fun_initPlatformState();
    } else if (Platform.isIOS) {
      try {
        strDeviceID = await UniqueIdentifier.serial;
      } on PlatformException {
        strDeviceID = 'Failed to get Unique Identifier';
      }
    } else {
      print("");
    }
    map["DeviceId"] = strDeviceID!;

    HashMap<String, Object> dataMap = map;
    double amt = 0.0;

    try {
      amt = double.parse(amount);
    } catch (e) {}
    dataMap["Amount"] = amt;

    db.collection('Attempts').doc(orderID).set(dataMap);

    notifyListeners();
  }

  Future<void> loopWardsToWardTotalAmount() async {
    print('looooooooooooping');
    var jsonText = await rootBundle.loadString('assets/KPCC_JSON.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map<dynamic, dynamic> jsonMap = await jsonResponse as Map;
    jsonMap.forEach((key, value) async {
      HashMap<String, Object> fireStore = HashMap();
      fireStore['district'] = value['district'].toString();
      fireStore['panchayath'] = value['panchayath'].toString();
      fireStore['wardname'] = value['wardname'].toString();
      fireStore['Amount'] = 0;
      await db
          .collection('WardTotalAmount')
          .doc(
              '${value['district'].toString()}_${value['panchayath'].toString()}_${value['wardname'].toString()}')
          .set(fireStore)
          .then((value) {
        print(1);
      });
    });
  }

  void showNameStatus() {
    if (shownameBool) {
      shownameBool = false;
    } else {
      shownameBool = true;
    }
    notifyListeners();
  }

  void selectAge(int index, String name) {
    if (ageSelectionList[index].selectionStatus) {
      ageSelectionList[index].selectionStatus = false;
    } else {
      ageSelectionList[index].selectionStatus = true;
    }
    for (var element in ageSelectionList) {
      if (element.name != name) {
        element.selectionStatus = false;
      }
    }
    notifyListeners();
  }

  void minimumAmountTrueOrFalse(String amt) {
    double checkamt = 0.0;
    if (!(amt == "")) {
      checkamt = double.parse(amt.toString());
    }
    if (checkamt >= 1) {
      minimumbool = false;
    }
    if (checkamt < 1) {
      minimumbool = true;
    }
    notifyListeners();
  }

  void selectGender(int index, String name) {
    if (genderList[index].selectionStatus) {
      genderList[index].selectionStatus = false;
    } else {
      genderList[index].selectionStatus = true;
    }

    for (var element in genderList) {
      if (element.name != name) {
        element.selectionStatus = false;
      }
    }
    notifyListeners();
  }

  void clearGenderAndAgedata() {
    for (var element in ageSelectionList) {
      element.selectionStatus = false;
    }
    for (var element in genderList) {
      element.selectionStatus = false;
    }
    shownameBool = false;
    notifyListeners();
  }

  void getDirectReceipt(
    String paymentid,
    BuildContext context,
    String loginUsername,
    String loginUserID,
    String subScriberType,
    String loginUserPhone,
    String zakathAmount,
    String deseaseName,
    String sponsorCategory,
    String sponsorCount,
    String sponsorItemOnePrice,
    String foodkitPrice,
    String footkitCount,
    String equipmentAmount,
    String sponsorPatientAmonut,
    String foodkitAmount,
  ) {
    db.collection("Payments").doc(paymentid).get().then((value) async {
      if (value.exists) {
        await getDonationDetailsForReceipt(paymentid);

        callNextReplacement(
            ReceiptPage(
              nameStatus: 'YES',
              loginUserID: loginUserID,
              loginUsername: loginUsername,
              subScriberType: subScriberType,
              loginUserPhone: loginUserPhone,
              zakathAmount: zakathAmount,
              sponsorPatientAmonut: sponsorPatientAmonut,
              sponsorItemOnePrice: sponsorItemOnePrice,
              sponsorCount: sponsorCount,
              sponsorCategory: sponsorCategory,
              footkitCount: footkitCount,
              deseaseName: deseaseName,
              foodkitPrice: foodkitPrice,
              equipmentAmount: equipmentAmount,
              foodkitAmount: foodkitAmount,
            ),
            context);
      } else {
        // callNextReplacement(HomeScreenNew(), context);
      }
    });
  }

  // void getOrganisation() {
  //   organisationList.clear();
  //   mRoot.child("ORGANISATION").once().then((value) {
  //     if (value.snapshot.exists) {
  //       Map<dynamic, dynamic> map = value.snapshot.value as Map;
  //       map.forEach((key, value) {
  //         organisationList.add(value.toString());
  //       });
  //     }
  //     notifyListeners();
  //   });
  // }

  void listenForPayment(
    String order_id,
    BuildContext paymentContext,
    String paymentCategory,
    String equipmentCount,
    String equipmentID,
    String oneEquipmentPrice,
    String loginUsername,
    String loginUserID,
    String subScriberType,
    String loginUserPhone,
    String zakathAmount,
    String deseaseName,
    String sponsorCategory,
    String sponsorCount,
    String sponsorItemOnePrice,
    String foodkitPrice,
    String footkitCount,
    String equipmentAmount,
    String sponsorPatientAmonut,
    String foodkitAmount,
      List<MonthBool> monthList
  ) {
    print("listencodehereeee111" + order_id);

    db
        .collection("MonitorNode")
        .where("ID", isEqualTo: order_id)
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        print("listencodehereeee22");

        Map<dynamic, dynamic> map = event.docs.first.data();

        print("listencodehereeee555");
        if (map["Status"] != null) {
          print("listencodehe88888888");
          getDonationDetailsForReceipt(order_id);
          callNextReplacement(
              DonationSuccess(
                paymentCategory: paymentCategory,
                loginUserPhone: loginUserPhone,
                equipmentID: equipmentID,
                equipmentCount: equipmentCount,
                oneEquipmentPrice: oneEquipmentPrice,
                loginUserID: loginUserID,
                loginUsername: loginUsername,
                subScriberType: subScriberType,
                zakathAmount: zakathAmount,
                sponsorPatientAmonut: sponsorPatientAmonut,
                sponsorItemOnePrice: sponsorItemOnePrice,
                sponsorCount: sponsorCount,
                sponsorCategory: sponsorCategory,
                footkitCount: footkitCount,
                deseaseName: deseaseName,
                foodkitPrice: foodkitPrice,
                equipmentAmount: equipmentAmount,
                foodkitAmount: foodkitAmount,monthList: monthList,
              ),
              paymentContext);
        }
        notifyListeners();
      }
      notifyListeners();
    });
    print("listencodehereeee33");
    print("msfpaperrevolutioncoderheree33");
  }

  Future<void> launchUrlUPI(BuildContext context, Uri _url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    } else {}
  }

  void updateFamilyName(String donorId) {
    db
        .collection('MonitorNode')
        .doc(donorId)
        .set({"FamilyName": familyNameTC.text}, SetOptions(merge: true));
    db
        .collection('Payments')
        .doc(donorId)
        .set({"FamilyName": familyNameTC.text}, SetOptions(merge: true));
    notifyListeners();
  }

// void getLength(){
//   db.collection('WardTotalAmount').get().then((value) {
//     print("length"+value.docs.length.toString());
//   });
// }

  createQrImage(String from, String donorName,
      ScreenshotController screenshotController) async {
    String imgName = DateTime.now().millisecondsSinceEpoch.toString();
    // ScreenshotController screenshotController = ScreenshotController();
    await screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        if (!kIsWeb) {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath =
              await File('${directory.path}/$imgName.png').create();
          await imagePath.writeAsBytes(image);

          if (from == 'Print') {
            OpenFile.open(imagePath.path);
          } else {
            Share.shareFiles(
              [imagePath.path],
            );
          }
        } else {
          ByteData bytes = ByteData.view(image.buffer);

          var blob = web_file.Blob([bytes], 'image/png', 'native');

          var anchorElement = web_file.AnchorElement(
            href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
          )
            ..setAttribute("download", "data.png")
            ..click();
        }
      }

      // Handle captured image
    });
  }

  double todayTopperAmount = 0;
  String todayTopperName = "No payments yet";
  String todayTopperPlace = "";
  String todayTopperPanchayath = "";

  void getTodayTopper() {
    DateTime today = DateTime.now();
    String todayDate = "";
    String nameShow = "";
    todayDate = outputDayNode.format(today).toString();
    db
        .collection('Payments')
        .where("Payment_Date", isEqualTo: todayDate)
        .orderBy('Amount', descending: true)
        .limit(1)
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        todayTopperAmount =
            double.parse(event.docs.first.get("Amount").toString());
        nameShow = event.docs.first.get("NameShowStatus").toString();
        if (nameShow == "YES") {
          todayTopperName = event.docs.first.get("Name").toString();
        } else {
          todayTopperName = "Confidential Donor";
        }
        if (event.docs.first.get("assembly").toString() != "GENERAL") {
          todayTopperPlace = event.docs.first.get("panchayath").toString();
          todayTopperPanchayath = event.docs.first.get("district").toString();
        } else {
          todayTopperPlace = "";
          todayTopperPanchayath = "";
        }
        notifyListeners();
      } else {
        todayTopperAmount = 0;
        todayTopperName = "No payments yet";
        notifyListeners();
      }
    });
  }

  String androidGooglePayButton = 'OFF';

  lockIosGooglePayButton() {
    mRoot.child('0').child('androidGooglePayButton').onValue.listen((event) {
      if (event.snapshot.exists) {
        androidGooglePayButton = event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }

  String androidPhonePayButton = 'OFF';

  lockIosPhonePayButton() {
    mRoot.child('0').child('androidPhonePayButton').onValue.listen((event) {
      if (event.snapshot.exists) {
        androidPhonePayButton = event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }

  ///QMCH Codes

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(
                    Icons.camera_enhance_sharp,
                    // color: cl172f55,
                  ),
                  title: const Text(
                    'Camera',
                  ),
                  onTap: () => {imageFromCamera(), Navigator.pop(context)}),
              SizedBox(
                height: 100,
                child: ListTile(
                    leading: const Icon(
                      Icons.photo,
                      //color: cl172f55
                    ),
                    title: const Text(
                      'Gallery',
                    ),
                    onTap: () => {imageFromGallery(), Navigator.pop(context)}),
              ),
            ],
          );
        });
    // ImageSource
  }

  imageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 15);

    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostDataNew();

    notifyListeners();
  }

  Future<void> retrieveLostDataNew() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      fileImage = File(response.file!.path);
      // filePanImage = File(response.file!.path);
      notifyListeners();
    }
  }

  imageFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    } else {}
    if (pickedFile!.path.isEmpty) {
      retrieveLostDataNew();
    }

    notifyListeners();
  }

  Future<void> fetchFoodKit(bool firstFetch, [dynamic lastDoc = false]) async {
    var collectionRef;
    if (!firstFetch) {
      collectionRef = db
          .collection("FOODKIT")
          .orderBy('ADDED_TIME', descending: true)
          .startAfter([lastDoc]).limit(limitHome);
      //click load more
    } else {
      fetchFoodKitList.clear();
      // filterFeedbacksList.clear();
      collectionRef = db
          .collection("FOODKIT")
          .orderBy('ADDED_TIME', descending: true)
          .limit(limitHome);
      // print('first fetch done');
    }

    QuerySnapshot querySnapshot = await db
        .collection("FOODKIT")
        .orderBy('ADDED_TIME', descending: true)
        .get();
    totalFoodListedCount = querySnapshot.size;
    collectionRef.get().then((value1) {
      if (value1.docs.isNotEmpty) {
        for (var element in value1.docs) {
          Map<dynamic, dynamic> map = element.data();
          DateTime scheduledTimeFrom = DateTime.now();
          Timestamp timestamp = map['ADDED_TIME'];
          scheduledTimeFrom = DateTime.parse(timestamp.toDate().toString());
          fetchFoodKitList.add(FoodKitModel(
            map["FOODKIT_NAME"],
            map["FOODKIT_DESCRIPTION"],
            map["FOODKIT_PRICE"],
            scheduledTimeFrom,
            map["ID"],
            map["ADDED_BY"],
            map["ADDED_ADMIN_ID"],
          ));
          print(fetchFoodKitList.map((e) => e.foodName));
          notifyListeners();

          // distributorModel selectedDropdowm = distributorModel(map["DISTRIBUTOR_NAME"],'');
        }
      }
    });
    notifyListeners();
  }

  int newsFeedCount = 0;

  Future<void> fetchAllNews(bool firstFetch, [dynamic lastDoc = false]) async {
    var collectionRef;
    if (!firstFetch) {
      newsFeedCount=newsFeedCount+limitHome;
      collectionRef = db
          .collection("NEWSFEED")
          .orderBy('ADDED_TIME', descending: true)
          .startAfter([lastDoc]).limit(limitHome);
      //click load more
    } else {
      newsFeedCount=newsFeedCount+limitHome;
      filterNewsList.clear();
      newsList.clear();
      collectionRef = db
          .collection("NEWSFEED")
          .orderBy('ADDED_TIME', descending: true)
          .limit(limitHome);
      // print('first fetch done');
    }

    collectionRef.get().then((value1) {
      if (value1.docs.isNotEmpty) {
        for (var element in value1.docs) {
          Map<dynamic, dynamic> map = element.data();
          String agoString = '';
          print("ucuisu" + element.id.toString());
          DateTime scheduledTimeFrom = DateTime.now();
          Timestamp timestamp = map['ADDED_TIME'];
          scheduledTimeFrom = DateTime.parse(timestamp.toDate().toString());
          Duration diff = DateTime.now().difference(map['ADDED_TIME'].toDate());
          if (diff.inDays > 365) {
            agoString =
                "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
          } else if (diff.inDays > 30) {
            agoString =
                "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
          } else if (diff.inDays > 7) {
            agoString =
                "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
          } else if (diff.inDays > 0) {
            agoString =
                "${DateFormat.E().add_jm().format(map['ADDED_TIME'].toDate())}";
          } else if (diff.inHours > 0) {
            agoString =
                "Today ${DateFormat('jm').format(map['ADDED_TIME'].toDate())}";
          } else if (diff.inMinutes > 0) {
            agoString =
                "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
          } else {
            agoString = "just now";
          }
          String image = '';
          if (map["PHOTO"] != null) {
            image = map["PHOTO"].toString();
          }
          newsList.add(NewsFeedModel(
              element.id,
              map['TITLE'] ?? '',
              map['DESCRIPTION'] ?? '',
              map['ADDED_ADMIN_ID'] ?? '',
              scheduledTimeFrom,
              agoString,
              image));
        }
        filterNewsList = newsList;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void setToController(String id) {
    db.collection('FOODKIT').doc(id).get().then((value) {
      Map<dynamic, dynamic> map = value.data() as Map;

      foodKitNameCT.text = map['FOODKIT_NAME'] ?? '';
      foodKitPriceCT.text = map['FOODKIT_PRICE'] ?? '';
      foodKitDiscriptionCT.text = map['FOODKIT_DESCRIPTION'] ?? '';
      fetchimage = map['FOOD_IMAGE'] ?? '';

      notifyListeners();
    });
  }

  void setToControllerActivities(String id) {
    db.collection('NEWSFEED').doc(id).get().then((value) {
      Map<dynamic, dynamic> map = value.data() as Map;

      newsTitleCT.text = map['TITLE'] ?? '';
      newsDiscriptionCT.text = map['DESCRIPTION'] ?? '';

      newsImage = map['PHOTO'] ?? '';

      notifyListeners();
    });
  }

  Future<void> deleteFood(String id) async {
    await db.collection('IMAGES').doc(id).delete();
    fetchFoodKit(true);

    notifyListeners();
  }

  void clearFoodController() {
    foodKitNameCT.text = '';
    foodKitPriceCT.text = '';
    foodKitDiscriptionCT.text = '';
    fileImage = null;
    notifyListeners();
  }

  Future<void> _cropImage(String path) async {
    print("hai$path");
    print(' njvkgfnbkjgnbg');
    final croppedFile = await ImageCropper().cropImage(
      // compressQuality: 100,
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    print("hello$path");

    if (croppedFile != null) {
      fileImage = File(croppedFile.path);

      carouselfileList.add(fileImage!);

      // imgCheck = true;
      notifyListeners();
    }
  }

  Reference ref = FirebaseStorage.instance.ref("ID_IMAGE");

  Future<void> addFoodKit(String from, String editID, String adminName,
      String adminID, File? pickedFile) async {
    print(' asmalskmdl');
    HashMap<String, Object> map = HashMap();
    DateTime now = DateTime.now();
    String key = DateTime.now().millisecondsSinceEpoch.toString();
    map['FOODKIT_NAME'] = foodKitNameCT.text;
    map['FOODKIT_PRICE'] = foodKitPriceCT.text;
    map['FOODKIT_DESCRIPTION'] = foodKitDiscriptionCT.text;
    if (from != 'edit') {
      map['ADDED_TIME'] = now;
      map['ADDED_TIME_MILLIS'] = key;
      map['ADDED_BY'] = adminName;
      map['ADDED_ADMIN_ID'] = adminID;
      map['ID'] = key;
    } else {
      print('edit works');
      map['EDITTED_TIME'] = now;
      map['EDITTED_TIME_MILLIS'] = key;
      map['EDITTED_BY'] = adminName;
      map['EDITTED_ADMIN_ID'] = adminID;
    }
    if (fileImage != null) {
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child('Images').child(time);
      await ref.putFile(fileImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          if (value != "" || value != null) {
            map['PHOTO'] = value;
          }
        });
      });
    }
    if (from != 'edit') {
      db.collection('FOODKIT').doc(key).set(map, SetOptions(merge: true));
    } else {
      db.collection('FOODKIT').doc(editID).set(map, SetOptions(merge: true));
    }
    fetchFoodKit(true);
  }

  Future<void> addNewsFeed(
      String from, String editID, String adminName, String adminID) async {
    print(from);
    HashMap<String, Object> map = HashMap();
    DateTime now = DateTime.now();
    String key = DateTime.now().millisecondsSinceEpoch.toString();
    map['TITLE'] = newsTitleCT.text;
    map['DESCRIPTION'] = newsDiscriptionCT.text;
    if (from != 'edit') {
      map['ADDED_TIME'] = now;
      map['ADDED_TIME_MILLIS'] = key;
      map['ADDED_BY'] = adminName;
      map['ADDED_ADMIN_ID'] = adminID;
      map['ID'] = key;
    } else {
      print('edit works');
      map['EDITTED_TIME'] = now;
      map['EDITTED_TIME_MILLIS'] = key;
      map['EDITTED_BY'] = adminName;
      map['EDITTED_ADMIN_ID'] = adminID;
    }
    if (fileImage != null) {
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child('Images').child(time);
      await ref.putFile(fileImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          if (value != "" || value != null) {
            map['PHOTO'] = value;
          }
        });
      });
    }
    if (from != 'edit') {
      db.collection('NEWSFEED').doc(key).set(map, SetOptions(merge: true));
    } else {
      db.collection('NEWSFEED').doc(editID).set(map, SetOptions(merge: true));
    }
    fetchAllNews(true);
  }

  Future<void> addEquipment(
      String from, String editID, String adminName, String adminID) async {
    print(' IUVFNVUFOVFV');
    HashMap<String, Object> map = HashMap();
    DateTime now = DateTime.now();
    String key = DateTime.now().millisecondsSinceEpoch.toString();
    map['EQUIPMENT_NAME'] = equipmentNameCT.text;
    map['EQUIPMENT_PRICE'] = equipmentPriceCT.text;
    map['EQUIPMENT_COUNT'] = int.parse(equipmentCountCT.text.toString());
    map['EQUIPMENT_DESCRIPTION'] = equipmentDiscriptionCT.text;
    map['EQUIPMENT_COLLECTED_COUNT'] = 0;

    if (from != 'edit') {
      map['ADDED_TIME'] = now;
      map['ADDED_TIME_MILLIS'] = key;
      map['ADDED_BY'] = adminName;
      map['ADDED_ADMIN_ID'] = adminID;
    } else {
      map['EDITTED_TIME'] = now;
      map['EDITTED_TIME_MILLIS'] = key;
      map['EDITTED_BY'] = adminName;
      map['EDITTED_ADMIN_ID'] = adminID;
    }

    if (fileImage != null) {
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child('Images').child(time);
      await ref.putFile(fileImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          if (value != "" || value != null) {
            map['PHOTO'] = value;
          }
        });
      });
    }

    if (from != 'edit') {
      db.collection('EQUIPMENTS').doc(key).set(map, SetOptions(merge: true));
    } else {
      print(' asgsgfasfaFV');
      print(editID);

      await db
          .collection('EQUIPMENTS')
          .doc(editID)
          .set(map, SetOptions(merge: true));
    }
 fetchEquipment(false,filterEquipmentsList[filterEquipmentsList.length - 1].addedTime);
    notifyListeners();

  }

  ///equipment_List.dart

  List<EquipmentModel> equipmentsList = [];
  List<EquipmentModel> filterEquipmentsList = [];
  List<SponsershipDiseaseModel> sponsershipDiseaseList = [];
  List<FoodKitSponsorModel> footkitSponserList = [];

  Future<void> fetchEquipment(bool firstFetch,
      [dynamic lastDoc = false]) async {
    var collectionRef;

    if (!firstFetch) {
      equipmentCount=equipmentCount+limit;

      collectionRef = db
          .collection("EQUIPMENTS")
          .orderBy('ADDED_TIME', descending: true)
          .startAfter([lastDoc]).limit(limit);
      //click load more
    } else {
      equipmentCount=equipmentCount+limit;
      equipmentsList.clear();
      filterEquipmentsList.clear();
      collectionRef = db
          .collection("EQUIPMENTS")
          .orderBy('ADDED_TIME', descending: true)
          .limit(limit);
      print('first fetch done');
    }

    collectionRef.get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data() as Map;
          DateTime scheduledTimeFrom = DateTime.now();
          Timestamp timestamp = map['ADDED_TIME'];
          scheduledTimeFrom = DateTime.parse(timestamp.toDate().toString());
          int requered = 0;
          int collected = 0;
          if (map['EQUIPMENT_COUNT'] != '' && map['EQUIPMENT_COUNT'] != null) {
            requered = int.parse(map['EQUIPMENT_COUNT'].toString());
          }

          if (map['EQUIPMENT_COLLECTED_COUNT'] != '' &&
              map['EQUIPMENT_COLLECTED_COUNT'] != null) {
            collected =
                double.parse(map['EQUIPMENT_COLLECTED_COUNT'].toString())
                    .toInt();
          }

          String image = '';
          if (map['PHOTO'] != null) {
            image = map['PHOTO'];
          }
          print('ununudufv' + collected.toString());
          equipmentsList.add(EquipmentModel(
              map["EQUIPMENT_NAME"].toString(),
              map["EQUIPMENT_PRICE"].toString(),
              0,
              scheduledTimeFrom,
              element.id,
              map["ADDED_BY"].toString(),
              map["ADDED_ADMIN_ID"].toString(),
              requered,
              collected,
              image,
              false));

          notifyListeners();
        }
        filterEquipmentsList = equipmentsList;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void setToControllerEquipment(String id) {
    db.collection('EQUIPMENTS').doc(id).get().then((value) {
      Map<dynamic, dynamic> map = value.data() as Map;

      equipmentNameCT.text = map['EQUIPMENT_NAME'] ?? '';
      equipmentCountCT.text = (map['EQUIPMENT_COUNT'] ?? '').toString();
      equipmentPriceCT.text = map['EQUIPMENT_PRICE'] ?? '';
      equipmentDiscriptionCT.text = map['EQUIPMENT_DESCRIPTION'] ?? '';
      fetchimage = map['PHOTO'] ?? '';
      equipmentPhotoUrl = map['PHOTO'] ?? '';

      notifyListeners();
    });
  }

  void deleteEquipment(String id) {
    db.collection('EQUIPMENTS').doc(id).delete();
    fetchEquipment(true);
  }

  void deleteNewsFeed(String id) {
    db.collection('NEWSFEED').doc(id).delete();
    fetchAllNews(true);
  }

  ///

  Future<void> addSponser(
      String from, String editID, String adminName, String adminID) async {
    HashMap<String, Object> map = HashMap();
    DateTime now = DateTime.now();

    String? strDeviceID = "";
    if (Platform.isAndroid) {
      strDeviceID = await DeviceInfo().fun_initPlatformState();
    } else if (Platform.isIOS) {
      try {
        strDeviceID = await UniqueIdentifier.serial;
      } on PlatformException {
        strDeviceID = 'Failed to get Unique Identifier';
      }
    }
    map['DEVICE_ID'] = strDeviceID.toString();

    String key = DateTime.now().millisecondsSinceEpoch.toString();
    map['SPONSOR_NAME'] = sponserNameCT.text;
    map['SPONSOR_PHONE'] = sponserphoneCT.text;

    if (from != 'edit') {
      map['ADDED_TIME'] = now;
      map['ADDED_TIME_MILLIS'] = key;
      map['ADDED_BY'] = adminName;
      map['ADDED_ADMIN_ID'] = adminID;
    } else {
      map['EDITTED_TIME'] = now;
      map['EDITTED_TIME_MILLIS'] = key;
      map['EDITTED_BY'] = adminName;
      map['EDITTED_ADMIN_ID'] = adminID;
    }
    FirebaseMessaging.instance.getToken().then((value) {
      map['fcmID'] = value.toString();
    });
    if (fileImage != null) {
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child('Images').child(time);
      await ref.putFile(fileImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          if (value != "" || value != null) {
            map['PHOTO'] = value;
          }
        });
      });
    }

    if (from != 'edit') {
      await db
          .collection('SPONSORS')
          .doc(key)
          .set(map, SetOptions(merge: true));
    } else {
      await db
          .collection('SPONSORS')
          .doc(editID)
          .set(map, SetOptions(merge: true));
    }
    fetchSponsers(false,filterSponsersList[filterSponsersList.length-1].addedTime);

  }

  void fetchSponserDetails(String id) {
    sponserImage = '';
    db.collection('SPONSORS').doc(id).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        sponserNameCT.text = map['SPONSOR_NAME'] ?? '';
        sponserphoneCT.text = map['SPONSOR_PHONE'] ?? '';
        if (map['PHOTO'] != null) {
          sponserImage = map['PHOTO'];
        }
        notifyListeners();
      }
    });
  }

  void fetchNewsFeedDetails(String id) {
    newsImage = '';
    db.collection('NEWSFEED').doc(id).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        newsTitleCT.text = map['TITLE'] ?? '';
        newsDiscriptionCT.text = map['DESCRIPTION'] ?? '';
        if (map['PHOTO'] != null) {
          newsImage = map['PHOTO'].toString();
        }
        notifyListeners();
      }
    });
  }

  void clearEquipmentScreen() {
    equipmentNameCT.clear();
    equipmentPriceCT.clear();
    equipmentCountCT.clear();
    equipmentDiscriptionCT.clear();

    fileImage = null;
    equipmentPhotoUrl = '';
    notifyListeners();
  }

  void clearSubcriptionScreen() {
    equipmentPhotoUrl = "";
    subscriberNameCT.clear();
    subscriberPhoneCT.clear();
    subscriberAddressCT.clear();
    fileImage = null;
    notifyListeners();
  }

  void clearSponserScreen() {
    sponserImage = '';
    sponserNameCT.clear();
    sponserphoneCT.clear();
    fileImage = null;
    notifyListeners();
  }

  void clearNews() {
    newsImage = '';
    newsTitleCT.clear();
    newsDiscriptionCT.clear();
    fileImage = null;
    notifyListeners();
  }

  ///fetch SubScribers List

  List<SubScriberModel> subScribersList = [];
  List<SubScriberModel> filterSubScribersList = [];
  List<SponserModel> sponsersList = [];
  List<SponserModel> filterSponsersList = [];

  Future<void> addSubcriber(
      String from, String editID, String adminName, String adminID) async {
    print(' IUVFNVUFOVFV');
    HashMap<String, Object> map = HashMap();
    HashMap<String, Object> userMap = HashMap();
    HashMap<String, Object> voulenteerMap = HashMap();

    String? strDeviceID = "";
    if (Platform.isAndroid) {
      strDeviceID = await DeviceInfo().fun_initPlatformState();
    } else if (Platform.isIOS) {
      try {
        strDeviceID = await UniqueIdentifier.serial;
      } on PlatformException {
        strDeviceID = 'Failed to get Unique Identifier';
      }
    }

    DateTime now = DateTime.now();
    String key = DateTime.now().millisecondsSinceEpoch.toString();

    //add to users Map
    userMap['NAME'] = subscriberNameCT.text;
    userMap['PHONE_NUMBER'] = '+91' + subscriberPhoneCT.text;

    map['SUBSCRIBER_NAME'] = subscriberNameCT.text;
    map['SUBSCRIBER_PHONE'] = subscriberPhoneCT.text;
    map['SUBSCRIBER_ADDRESS'] = subscriberAddressCT.text;

    voulenteerMap['Name'] = subscriberNameCT.text;
    voulenteerMap['Phone'] = subscriberPhoneCT.text;
    if (from != 'Edit') {
      map['ADDED_TIME'] = now;
      map['ADDED_TIME_MILLIS'] = key;
      map['ADDED_BY'] = adminName;
      map['ADDED_ADMIN_ID'] = adminID;
      map['ID'] = key;

      userMap['ADDED_ADMIN_ID'] = adminID;
      userMap['TYPE'] = "SUBSCRIBER";
      userMap['REF'] = "SUBSCRIBERS/" + key;
      userMap['ID'] = key;
      userMap['ADDED_TIME'] = now;
      userMap['ADDED_BY'] = adminName;

      voulenteerMap['Status'] = 'APPROVED';
      voulenteerMap['DeviceId'] = strDeviceID!;
      voulenteerMap['ADDED_TIME'] = now;
      voulenteerMap['ADDED_TIME_MILLIS'] = key;
      voulenteerMap['ADDED_BY'] = adminName;
      voulenteerMap['ADDED_ADMIN_ID'] = adminID;
    } else {
      map['EDITTED_TIME'] = now;
      map['EDITTED_TIME_MILLIS'] = key;
      map['EDITTED_BY'] = adminName;
      map['EDITTED_ADMIN_ID'] = adminID;

      userMap['EDITTED_BY'] = adminName;
      userMap['EDITTED_ADMIN_ID'] = adminID;

      voulenteerMap['EDITTED_TIME'] = now;
      voulenteerMap['EDITTED_TIME_MILLIS'] = key;
      voulenteerMap['EDITTED_BY'] = adminName;
      voulenteerMap['EDITTED_ADMIN_ID'] = adminID;
    }

    if (fileImage != null) {
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child('Images').child(time);
      await ref.putFile(fileImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          if (value != "" || value != null) {
            map['PHOTO'] = value;
            voulenteerMap['PHOTO'] = value;
          }
        });
      });
    }

    if (from != 'Edit') {
      db.collection('SUBSCRIBERS').doc(key).set(map, SetOptions(merge: true));
      db.collection('USERS').doc(key).set(userMap, SetOptions(merge: true));
      db
          .collection('VOLUNTEERS')
          .doc(key)
          .set(voulenteerMap, SetOptions(merge: true));
    } else {
      db.collection('USERS').doc(editID).set(userMap, SetOptions(merge: true));
      db
          .collection('SUBSCRIBERS')
          .doc(editID)
          .set(map, SetOptions(merge: true));
      db
          .collection('VOLUNTEERS')
          .doc(editID)
          .set(voulenteerMap, SetOptions(merge: true));
    }
  fetchSubScribersList(false,filterSubScribersList[filterSubScribersList.length-1].addedTime);
  }

  int subscriberCount = 0;

  Future<void> fetchSubScribersList(bool firstFetch,
      [dynamic lastDoc = false]) async {
    var collectionRef;

    if (!firstFetch) {
      equipmentCount=equipmentCount+limit;

      collectionRef = db
          .collection("SUBSCRIBERS")
          .orderBy('ADDED_TIME', descending: true)
          .startAfter([lastDoc]).limit(limit);
      //click load more
    } else {
      equipmentCount=equipmentCount+limit;

      subScribersList.clear();
      filterSubScribersList.clear();
      collectionRef = db
          .collection("SUBSCRIBERS")
          .orderBy('ADDED_TIME', descending: true)
          .limit(limit);
      print('first fetch done');
    }

    collectionRef.get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data() as Map;
          DateTime scheduledTimeFrom = DateTime.now();
          Timestamp timestamp = map['ADDED_TIME'];
          scheduledTimeFrom = DateTime.parse(timestamp.toDate().toString());
          String image = "";
          if (map["PHOTO"] != null) {
            image = map["PHOTO"].toString();
          }

          subScribersList.add(SubScriberModel(
              map["SUBSCRIBER_NAME"] ?? "",
              map["SUBSCRIBER_PHONE"] ?? "",
              map["SUBSCRIBER_ADDRESS"] ?? "",
              scheduledTimeFrom,
              element.id,
              map["ADDED_BY"] ?? "",
              map["ADDED_ADMIN_ID"] ?? "",
              image));
          notifyListeners();
        }
        filterSubScribersList = subScribersList;
        notifyListeners();
      }
    });

    notifyListeners();
  }

  int sponsersCount = 0;

  Future<void> fetchSponsers(bool firstFetch, [dynamic lastDoc = false]) async {
    var collectionRef;
    if (!firstFetch) {
      equipmentCount=equipmentCount+limit;

      collectionRef = db
          .collection("SPONSORS")
          .orderBy('ADDED_TIME', descending: true)
          .startAfter([lastDoc]).limit(limit);
      //click load more
    } else {
      equipmentCount=equipmentCount+limit;

      sponsersList.clear();
      filterSponsersList.clear();
      collectionRef = db.collection("SPONSORS").orderBy('ADDED_TIME', descending: true).limit(limit);
      print('first fetch done');
    }
    QuerySnapshot querySnapshot = await db
        .collection("IMAGES")
        .where('CONTEXT_TYPE', isEqualTo: 'COOKING CONTEXT')
        .get();
    collectionRef.get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data() as Map;

          DateTime scheduledTimeFrom = DateTime.now();
          Timestamp timestamp = map['ADDED_TIME'];
          scheduledTimeFrom = DateTime.parse(timestamp.toDate().toString());

          String photo = '';
          if (map['PHOTO'] != null) {
            photo = map['PHOTO'].toString();
          }
          sponsersList.add(SponserModel(
            element.id,
            map['SPONSOR_NAME'] ?? '',
            photo,
            scheduledTimeFrom,
            map['ADDED_ADMIN_ID'],
            map["SPONSOR_PHONE"] ?? "",
          ));
        }
        filterSponsersList = sponsersList;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void fetchSubScribersEditOne(String id) {
    equipmentPhotoUrl = '';
    db.collection("SUBSCRIBERS").doc(id).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        String image = "";
        if (map["PHOTO"] != null) {
          print("dgbfnnf");
          image = map["PHOTO"].toString();
        }
        //photo,subName,subPhonenumber,subAddress
        equipmentPhotoUrl = image;
        subscriberNameCT.text = map["SUBSCRIBER_NAME"];
        subscriberPhoneCT.text = map["SUBSCRIBER_PHONE"];
        subscriberAddressCT.text = map["SUBSCRIBER_ADDRESS"];
      }
      notifyListeners();
    });
  }

  void deleteSubScriberOne(String id,BuildContext context) {
    ///
    db.collection("SUBSCRIBERS").doc(id).collection('PAYMENTS').get().then((value){
      if(value.docs.isEmpty){
        db.collection("SUBSCRIBERS").doc(id).delete();
        db.collection("USERS").doc(id).delete();
        fetchSubScribersList(true);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor:Colors.black,
                content: Text("Successfully Deleted")));
        finish(context);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor:Colors.red,
                content: Text("Can't Delete paid subscribers")));
        finish(context);
      }
    });

    notifyListeners();
  }

  void deleteactivity(String id) {
    db.collection("NEWSFEED").doc(id).delete();
    fetchAllNews(true);

    notifyListeners();
  }

  void deleteSponser(String id) {
    db.collection('SPONSORS').doc(id).delete();
    db.collection('USERS').doc(id).delete();
    fetchSponsers(true);
  }

  Future<void> addCarouselImages(String adminName, String adminID) async {
    HashMap<String, Object> dataMapp = HashMap();
    DateTime now = DateTime.now();
    List<String> list = [];
    if (carouselfileList.length > 0) {
      for (int i = 0; i < carouselfileList.length; i++) {
        String time = DateTime.now().millisecondsSinceEpoch.toString();
        ref = FirebaseStorage.instance
            .ref()
            .child('Images')
            .child(time); // Specify the full path including the filename
        await ref.putFile(carouselfileList[i]).whenComplete(() async {
          await ref.getDownloadURL().then((value1) {
            list.add(value1);
            notifyListeners();
          });
        });
      }
    }
    for (var aa in carouselModelList) {
      list.add(aa);
      list = list.toSet().toList();
    }
    print(list.toString() + ' OIMROFMRF');
    dataMapp["IMAGELIST"] = list;
    dataMapp['ADDED_TIME'] = now;
    dataMapp['ADDED_TIME_MILLIS'] = now.millisecondsSinceEpoch.toString();
    dataMapp['ADDED_BY'] = adminName;
    dataMapp['ADDED_ADMIN_ID'] = adminID;
    db
        .collection('CAROUSEL IMAGES')
        .doc('CAROUSEL IMAGES')
        .set(dataMapp, SetOptions(merge: true));
  }

  void fetchCarouselImages() {
    carouselModelList.clear();
    db.collection('CAROUSEL IMAGES').doc('CAROUSEL IMAGES').get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;

        List<dynamic> list = [];
        if (map['IMAGELIST'] != null) {
          list = map['IMAGELIST'];
        }
        carouselModelList = list;
        notifyListeners();
      }
    });
  }

  void deleteImage(int index, String from) {
    if (from == 'fileImage') {
      carouselfileList.removeAt(index);
    } else if (from == 'FetchImage') {
      carouselModelList.removeAt(index);
    }
    notifyListeners();
  }

  void equipmentCountIncrease(
      int requiredCount, int index, int collectedCount, int limitCheck) {
    print(index.toString()+'*SUCH*USCH'+collectedCount.toString()+'    '+requiredCount.toString());
    if (!filterEquipmentsList
        .map((e) => e.selectedBool)
        .toSet()
        .toList()
        .contains(true)) {
      if(requiredCount>collectedCount){
        filterEquipmentsList[index].selectedBool = true;
      }
    }
    if (filterEquipmentsList[index].selectedBool) {
      print(limitCheck.toString() +
          ' inudiu ' +
          filterEquipmentsList[index].requeredCount.toString());
      if (limitCheck < filterEquipmentsList[index].requeredCount) {
        filterEquipmentsList[index].selectedCount++;
        notifyListeners();
      }
    }
  }

  void clearSelectedEquipments(){
    for(var ee in filterEquipmentsList){
      ee.selectedBool=false;
      ee.selectedCount=0;
      notifyListeners();
    }
  }

  void clearEquipments(){
    for(var elemets in filterEquipmentsList){
      elemets.selectedCount=0;
      elemets.selectedBool=false;
      allTotal=allTotal-equipmntTotal;
      equipmntTotal=0;
      notifyListeners();

    }
  }

  void equipmentCountDecrease(
      int requiredCount, int index, int collectedCount) {
    if (requiredCount > collectedCount) {
      if (filterEquipmentsList[index].selectedCount > 0) {
        filterEquipmentsList[index].selectedCount--;
      }
      if (filterEquipmentsList[index].selectedCount == 0) {
        filterEquipmentsList[index].selectedBool = false;
      }
    }
    notifyListeners();
  }

  double getTotalEquipmentAmount() {
    double value = 0.0;
    for (var elemets in filterEquipmentsList) {
      if (elemets.selectedCount > 0) {
        value = value +
            (elemets.selectedCount * double.parse(elemets.equipmentPrice));
      }
    }
    return value;
  }

  void addSponsershipDisease() {
    sponsershipDiseaseList.clear();
    sponsershipDiseaseList.add(SponsershipDiseaseModel(
        'Dialysis', 0, 1200, false, 'assets/homeImage.png'));
    sponsershipDiseaseList.add(SponsershipDiseaseModel(
        'Home care', 0, 2500, false, 'assets/dialysisImage.png'));
  }

  void incrementDiseasePrice(int index) {
    print(sponsershipDiseaseList
            .map((e) => e.selectionBool)
            .toSet()
            .toList()
            .toString() +
        ' OIJMoioidfsv');
    if (!sponsershipDiseaseList
        .map((e) => e.selectionBool)
        .toSet()
        .toList()
        .contains(true)) {
      print(' ijnienvjv');
      sponsershipDiseaseList[index].selectionBool = true;
    }
    print(
        sponsershipDiseaseList[index].selectionBool.toString() + ' LMKCDLMOEF');
    if (sponsershipDiseaseList[index].selectionBool) {
      sponsershipDiseaseList[index].count++;
      print(sponsershipDiseaseList[index].count.toString() + ' INiuncidunvifv');
      notifyListeners();
    }
    notifyListeners();
  }

  void decrementDiseasePrice(int index) {
    if (sponsershipDiseaseList[index].count == 0) {
      sponsershipDiseaseList[index].selectionBool = false;
    }

    if (sponsershipDiseaseList[index].count > 0) {
      sponsershipDiseaseList[index].count--;
    }
    if (sponsershipDiseaseList[index].count == 0) {
      print(' iJNIN');
      sponsershipDiseaseList[index].selectionBool = false;
    }
    notifyListeners();
  }

  double getTotalSposership() {
    double value = 0.0;
    for (var elemets in sponsershipDiseaseList) {
      if (elemets.count > 0) {
        value =
            value + (elemets.count * double.parse(elemets.price.toString()));
      }
    }
    return value;
  }

  void clearSponsership() {
    for (var elemets in sponsershipDiseaseList) {
      elemets.selectionBool = false;
      elemets.count = 0;
    }
  }

  String getAmount(double totalCollection) {
    final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
    String newText1 = formatter.format(totalCollection);
    String newText =
        formatter.format(totalCollection).substring(0, newText1.length - 3);
    return newText;
  }

  void addSponserFoodkit() {
    footkitSponserList.clear();
    footkitSponserList.add(FoodKitSponsorModel(500, 0));
    notifyListeners();
  }

  void incrementFoodKit() {
    footkitSponserList[0].count++;
    notifyListeners();
  }

  void decrementFoodkit() {
    if (footkitSponserList[0].count > 0) {
      footkitSponserList[0].count--;
      notifyListeners();
    }
  }

  double getTotalfoodAmount() {
    double value = 0.0;

    value = value + (footkitSponserList[0].count * footkitSponserList[0].price);

    return value;
  }

  void clearUserFoodkitt() {
    footkitSponserList[0].count = 0;
    notifyListeners();
  }

  bool dataSelected = false;
  void setControllerData(String name, String phone) {
    if (dataSelected) {
      nameTC.clear();
      phoneTC.clear();
      dataSelected = false;
    } else {
      nameTC.text = name;
      phoneTC.text = phone;
      dataSelected = true;
    }
    notifyListeners();
  }

  void clearDonateScreen() {
    nameTC.clear();
    phoneTC.clear();
    dataSelected = false;
    notifyListeners();
  }

  void clearSponsershipScreen() {
    for (var elemets in sponsershipDiseaseList) {
      if (elemets.selectionBool) {
        elemets.selectionBool = false;
        elemets.count = 0;
      }
    }
  }

  void calculateMultiplePay(String from) {

    if (from == 'ZAKATH') {
      zakathTotal = double.parse(zakathAmountCT.text);
    } else if (from == 'EQUIPMENT') {
      equipmntTotal =  filterEquipmentsList.where((element) => element.id==equipmentSelectedIDCT.text).first.selectedCount *
          double.parse((filterEquipmentsList
              .where((element) => element.id == equipmentSelectedIDCT.text)
              .first
              .equipmentPrice));
    } else if (from == 'PATIENT') {
      print(patientSelectedNameCT.text+' YHDR DBYDRDR');
      patientTotal = sponsershipDiseaseList.where((element) => element.name==patientSelectedNameCT.text).first.count *
          double.parse((sponsershipDiseaseList
              .where((element) => element.name == patientSelectedCT.text)
              .first
              .price
              .toString()));
      print(patientTotal.toString()+' OFMRMFRFR');
    } else if (from == 'FOODKIT') {
      footkitTotal =
         double.parse( footkitSponserList[0].count.toString()) * footkitSponserList[0].price;
    } else if (from == 'SUBSCRIBE') {

      totalMonthDifference = 1 ;

      print("dfhinigf"+subscribeDate1.toString());
      print("dfhinigf"+subscribeDate2.toString());


        double yearDifference = double.parse((subscribeDate2.year - subscribeDate1.year).toString());
      double  monthDifference = double.parse((subscribeDate2.month - subscribeDate1.month).toString());

        // Convert years to months and add to the month difference
         totalMonthDifference =( yearDifference * 12 + monthDifference);

        print('The difference in months is: $totalMonthDifference months');

        subscriptionTotal = 1000 * totalMonthDifference ;
      membersPaymentAmountCT.text=subscriptionTotal.toStringAsFixed(0);

        int SSS = subscribeDate2.month - subscribeDate1.month;
        print(SSS.toString() + ' OICMIOSCMCSC');
        print(subscriptionTotal.toString() + ' IEUNIFJRF  '+ (double.parse(calculateMonthsDiff(subscribeDate1,subscribeDate2).toString() ).toString()));
    }
    allTotal = zakathTotal +
        equipmntTotal +
        patientTotal +
        footkitTotal +
        subscriptionTotal;
    notifyListeners();
  }

  void setPickedID(String id){
    equipmentSelectedIDCT.text=id;
    notifyListeners();
  }

  void clearMultipleFoodkit(){
    for(var ee in filterEquipmentsList){
      ee.selectedCount=0;
      ee.selectedBool=false;
    }
  }
  void clearMultiplePaymentScreen() {
    for(var elemets in sponsershipDiseaseList){
      elemets.selectionBool=false;
      elemets.count=0;
      notifyListeners();
    }
    for(var elemts in footkitSponserList){
      elemts.count=0;
    }
    for(var ee in filterEquipmentsList){
      ee.selectedCount=0;
      ee.selectedBool=false;
    }
    patientTotal=0;
    monthlyPayAmount=0.0;
    zakathTotal = 0.0;
    allTotal = 0.0;
    equipmntTotal = 0.0;
    patientTotal = 0.0;
    footkitTotal = 0.0;
    subscriptionTotal = 0.0;
    zakathAmountCT.clear();
    equipmentAmountCT.clear();
    patientAmountCT.clear();
    foodkitAmountCT.clear();
    subscriptionAmountCT.clear();
    equipmentSelectedIDCT.clear();
    equipmentSelectedCT.clear();
    patientSelectedCT.clear();
    subscribeDate2=DateTime.now();
    subscribeDate1=DateTime.now();
    date2.clear();
    membersPaymentAmountCT.clear();
    date1.clear();
    patientSelectedNameCT.text='';
    notifyListeners();
  }

  DateTime _date = DateTime.now();

  Future<void> selectDate(BuildContext context, String from) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _date = picked;
      if (from == 'Date1') {
        date1.text = outputDayNode.format(_date).toString();
        subscribeDate1 = _date;
        calculateMultiplePay('SUBSCRIBE');
      } else if (from == 'Date2') {
        subscribeDate2 = _date;
        date2.text = outputDayNode.format(_date).toString();
        calculateMultiplePay('SUBSCRIBE');

      }
    }
    notifyListeners();
  }

  int calculateMonthsDiff(DateTime startDate, DateTime endDate) {
    if (startDate.isAfter(endDate)) {
      throw ArgumentError('Start date cannot be after end date');
    }

    final yearDiff = endDate.year - startDate.year;
    final monthDiff = (endDate.month - startDate.month) + (yearDiff * 12);

    if (endDate.day < startDate.day) {
      return monthDiff - 1;
    } else {
      return monthDiff;
    }
  }

  searchSubscribers(String item) {
    filterSubScribersList = subScribersList
        .where((element) =>
            element.subScriberName.toLowerCase().contains(item.toLowerCase()) ||
            element.id.toString().toLowerCase().contains(item.toLowerCase()) ||
            element.subScriberPhoneNumber.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
  }
  searchActivities(String item) {
    filterNewsList = newsList
        .where((element) =>
            element.title.toLowerCase().contains(item.toLowerCase()) ||
            element.description.toString().toLowerCase().contains(item.toLowerCase())).toList();
    notifyListeners();
  }
  searchEquipments(String item) {
    filterEquipmentsList = equipmentsList
        .where((element) =>
            element.equipmentName.toLowerCase().contains(item.toLowerCase()) ||
            element.equipmentPrice.toString().toLowerCase().contains(item.toLowerCase())).toList();
    notifyListeners();
  }
  searchSponsers(String item) {
    filterSponsersList = sponsersList
        .where((element) =>
            element.phone.toLowerCase().contains(item.toLowerCase()) ||
            element.name.toString().toLowerCase().contains(item.toLowerCase())).toList();
    notifyListeners();
  }

  void addMonths(){
    monthList.clear();
    monthList.add(MonthBool('January', 'NOTPAID', '', false));
    monthList.add(MonthBool('February', 'NOTPAID', '', false));
    monthList.add(MonthBool('March', 'NOTPAID', '', false));
    monthList.add(MonthBool('April', 'NOTPAID', '', false));
    monthList.add(MonthBool('May', 'NOTPAID', '', false));
    monthList.add(MonthBool('June', 'NOTPAID', '', false));
    monthList.add(MonthBool('July', 'NOTPAID', '', false));
    monthList.add(MonthBool('August', 'NOTPAID', '', false));
    monthList.add(MonthBool('September', 'NOTPAID', '', false));
    monthList.add(MonthBool('October', 'NOTPAID', '', false));
    monthList.add(MonthBool('November', 'NOTPAID', '', false));
    monthList.add(MonthBool('December', 'NOTPAID', '', false));
    notifyListeners();
  }

  void checkPendingPayments(String id){
    print('INFUOVJFV '+id);
    db.collection('SUBSCRIBERS').doc(id).collection('PAYMENTS').where('YEAR',isEqualTo: DateTime.now().year).get().then((value){
      if(value.docs.isNotEmpty){
        print('MOIERFMOREF');
        for(var mapdata in value.docs){
          Map<dynamic,dynamic> map=mapdata.data() as Map;
          for(var elements in monthList){
            if(elements.monthName.toString().toUpperCase()==map['MONTH'].toString().toUpperCase()){
              elements.selectionBool=true;
              elements.payStatus='PAID';
              notifyListeners();
            }
          }
        }
        notifyListeners();
      }
    });
  }

  void selectMonthofPay(int index){
    if(monthList[index].selectionBool==false){
      if(monthList[index].payStatus=='NOTPAID'&&!monthList[index].selectionBool){
        monthList[index].selectionBool=true;
        monthlyPayAmount=monthlyPayAmount+1000;
        allTotal=allTotal+1000;
        notifyListeners();
      }
    }else if(monthList[index].selectionBool){
      monthList[index].selectionBool=false;
      if(monthlyPayAmount>0){
        monthlyPayAmount=monthlyPayAmount-1000;
        allTotal=allTotal-1000;
        notifyListeners();
      }
    }
  }
  
  void fetchSubsciberPayments(String id){
    subscriberPaymentList.clear();
    db.collection('SUBSCRIBERS').doc(id).collection('PAYMENTS').get().then((value){
      if(value.docs.isNotEmpty){
        for(var elements in value.docs){
          Map<dynamic,dynamic>map=elements.data() as Map;
          if(map['REFERENCE']!=null){
                subscriberPaymentList.add(SubscriberPaymentModel(id, map['REFERENCE'], map['MONTH']??'', map['STATUS']??'',
                    map['YEAR'].toString()??'', map['ADDED_TIME_MILLIS']??'', map['AMOUNT'].toString(),arrangeList(map['MONTH'].toString())));
          }
        }
        subscriberPaymentList.sort((a, b) => a.position.compareTo(b.position));
        notifyListeners();
      }
    });
  }

  int arrangeList(String month){
   int count=13;
   if(month.toUpperCase()=='JANUARY'){
     count=0;
   }else if(month.toUpperCase()=='FEBRUARY'){
     count=1;
   }else if(month.toUpperCase()=='MARCH'){
     count=2;
   }else if(month.toUpperCase()=='APRIL'){
     count=3;
   }else if(month.toUpperCase()=='MAY'){
     count=4;
   }else if(month.toUpperCase()=='JUNE'){
     count=5;
   }else if(month.toUpperCase()=='JULY'){
     count=6;
   }else if(month.toUpperCase()=='AUGUST'){
     count=7;
   }else if(month.toUpperCase()=='SEPTEMBER'){
     count=8;
   }else if(month.toUpperCase()=='OCTOBER'){
     count=9;
   }else if(month.toUpperCase()=='NOVEMBER'){
     count=10;
   }else if(month.toUpperCase()=='DECEMBER'){
     count=11;
   }
   return count;
  }

  void clearSelections(){
    monthlyPayAmount=0;
    kpccAmountController.text='';
    for(var elemets in monthList){
      elemets.selectionBool=false;
      notifyListeners();
    }
  }

  void setPatientType(String name){
    patientSelectedNameCT.text=name;
    notifyListeners();
  }
  bool isWhyMyPaymentFailed=false;
  void clickWhyMyPaymentFailed(){
    print('hasnjkdnkasjd');

    isWhyMyPaymentFailed=isWhyMyPaymentFailed?false:true;
    print('hasnjkdnkasjd');
    notifyListeners();

  }

  void sponserMultipaymenrClear(){
    for(var elemets in sponsershipDiseaseList){
      elemets.selectionBool=false;
      elemets.count=0;
      allTotal=allTotal-patientTotal;
      patientTotal=0;
      notifyListeners();
    }
  }

  Future<void> updateUserProfile(String from,String loginID,BuildContext context) async {
    HashMap<String,Object> map=HashMap();
    if(from=='ADMIN'){
      if (fileImage != null) {
        String time = DateTime.now().millisecondsSinceEpoch.toString();
        ref = FirebaseStorage.instance.ref().child('Images').child(time);
        await ref.putFile(fileImage!).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            if (value != "" || value != null) {
              map['PHOTO'] = value;
            }
          });
        });
        db.collection('USERS').doc(loginID).set(map,SetOptions(merge: true));
        getAdminImg(loginID);
      }

    }if(from=='GENERAL'){
      if (fileImage != null) {
        String time = DateTime.now().millisecondsSinceEpoch.toString();
        ref = FirebaseStorage.instance.ref().child('Images').child(time);
        await ref.putFile(fileImage!).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            if (value != "" || value != null) {
              map['PHOTO'] = value;
            }
          });
        });
        db.collection('USERS').doc(loginID).set(map,SetOptions(merge: true));
        getUserImg(loginID,from);
      }
    }else if(from=='SUBSCRIBER'){
      if (fileImage != null) {
        String time = DateTime.now().millisecondsSinceEpoch.toString();
        ref = FirebaseStorage.instance.ref().child('Images').child(time);
        await ref.putFile(fileImage!).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            if (value != "" || value != null) {
              map['PHOTO'] = value;
            }
          });
        });
        db.collection('SUBSCRIBERS').doc(loginID).set(map,SetOptions(merge: true));
        getUserImg(loginID,from);
      }
    }else if(from=='VOLUNTEERS'){
      if (fileImage != null) {
        String time = DateTime.now().millisecondsSinceEpoch.toString();
        ref = FirebaseStorage.instance.ref().child('Images').child(time);
        await ref.putFile(fileImage!).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            if (value != "" || value != null) {
              map['PHOTO'] = value;
            }
          });
        });
        db.collection('VOLUNTEERS').doc(loginID).set(map,SetOptions(merge: true));
        getUserImg(loginID,from);
      }
    }
  }

  void getAdminImg(String loginID){
    adminImageUrl='';
    db.collection('USERS').doc(loginID).get().then((value){
      if(value.exists){
        Map<dynamic,dynamic> map = value.data() as Map;
        adminImageUrl=map['PHOTO'].toString();
        notifyListeners();
      }
    });
  }

  void getUserImg(String loginID,String from){
    userImgUrl='';
    if(from=='GENERAL'){
      db.collection('USERS').doc(loginID).get().then((value){
        if(value.exists){
          Map<dynamic,dynamic> map = value.data() as Map;
          userImgUrl=map['PHOTO'].toString();
          notifyListeners();
        }
      });
    }else if(from=='SUBSCRIBER'){
      db.collection('SUBSCRIBERS').doc(loginID).get().then((value){
        if(value.exists){
          Map<dynamic,dynamic> map = value.data() as Map;
          userImgUrl=map['PHOTO'].toString();
          notifyListeners();
        }
      });
    }else if(from=='VOLUNTEERS'){
      db.collection('USERS').doc(loginID).get().then((value){
        if(value.exists){
          Map<dynamic,dynamic> map = value.data() as Map;
          userImgUrl=map['PHOTO'].toString();
          notifyListeners();
        }
      });
    }

  }

}

void _launchURL(String _url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}
