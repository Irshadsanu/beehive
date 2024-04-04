import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import 'package:provider/provider.dart';
import '../../qmchModels/subScriberModel.dart';
import '../bank_payment_page.dart';
import '../district_report.dart';
import '../new_payment_gateway_Screen.dart';
import 'cashfree_upi.dart';

class PaymentGateway extends StatelessWidget {
  String paymentCategory, equipmentCount, equipmentID,oneEquipmentPrice,subScriberType,loginUserPhone;
  String loginUsername,loginUserID;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  List<MonthBool> monthList;
  PaymentGateway({Key? key
    ,required this.paymentCategory
    ,required this.equipmentCount
    ,required this.equipmentID,
    required this.oneEquipmentPrice,required this.loginUsername,required this.loginUserID
    ,required this.subScriberType,required this.loginUserPhone,
    required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
    required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
    ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,required this.monthList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    // homeProvider.checkInternet(context);
    DonationProvider donationProvider = Provider.of<DonationProvider>(
        context, listen: false);



    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }
  Widget body(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);

    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);

    return SingleChildScrollView(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10,),

          Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Consumer<DonationProvider>(
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("₹",style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 38,
                              color:Colors.black),),
                          Text(
                            value.kpccAmountController.text.toString(),
                            style: rupeeBig3,
                          ),
                        ],
                      );
                    }
                ),
              )),
          SizedBox(height:47,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: clF6F6F6),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 25),
                    child: Text(
                      'Select Payment Platform',
                      style: black11,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer<HomeProvider>(
                        builder: (context,value,child) {
                          return value.intentPaymentOption=="ON"?Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  String amount=donationProvider.kpccAmountController.text.toString();
                                  String name=donationProvider.nameTC.text;
                                  String phone=donationProvider.phoneTC.text;
                                  donationProvider.upiIntent(context, amount, name, phone,"GPay",homeProvider.appVersion.toString(),paymentCategory,equipmentCount,
                                    equipmentID,oneEquipmentPrice,loginUsername,loginUserID,subScriberType,loginUserPhone,
                                    zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice, foodkitPrice, footkitCount,equipmentAmount, sponsorPatientAmonut, foodkitAmount,monthList
                                  );
                                },
                                child: Container(
                                    width: width*.73,
                                    height: 61,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white
                                    ),
                                    child: Image.asset('assets/gpay.png',scale: 3,)),
                              ),
                              // SizedBox(height: 20,),
                              // InkWell(
                              //   onTap: () {
                              //     String amount=donationProvider.kpccAmountController.text.toString();
                              //     String name=donationProvider.nameTC.text;
                              //     String phone=donationProvider.phoneTC.text;
                              //     donationProvider.upiIntent(context, amount, name, phone,"Paytm",homeProvider.appVersion.toString());
                              //   },
                              //   child:
                              //   Container(
                              //       width: width*.73,
                              //       height: 61,
                              //       decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(15),
                              //           color: Colors.white
                              //
                              //       ),
                              //       child: Image.asset('assets/paytm.png',scale: 3,)),
                              // ),
                              SizedBox(height: 20,),

                              InkWell(
                                onTap: () {
                                  HomeProvider homeProvider =
                                  Provider.of<HomeProvider>(context, listen: false);
                                  String amount=donationProvider.kpccAmountController.text.toString();
                                  String name=donationProvider.nameTC.text;
                                  String phone=donationProvider.phoneTC.text;
                                  donationProvider.upiIntent(context, amount, name, phone,"BHIM",homeProvider.appVersion.toString(),paymentCategory,
                                  equipmentCount,equipmentID,oneEquipmentPrice,loginUsername,loginUserID,subScriberType,loginUserPhone,
                                    zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice, foodkitPrice, footkitCount,equipmentAmount, sponsorPatientAmonut, foodkitAmount,monthList);
                                },
                                child:
                                Container(
                                    width: width*.73,
                                    height: 61,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white

                                    ),
                                    child: Image.asset('assets/bhim.png',scale: 3,)),
                              ),

                            ],
                          ):SizedBox();
                        }
                      ),
                      Consumer<HomeProvider>(
                        builder: (context,value,child) {
                          return value.lockMindGateOption=="ON"?Column(
                            children: [
                              SizedBox(height: 20,),
                              Consumer<DonationProvider>(
                                  builder: (context,value,child) {
                                    return InkWell(
                                      onTap: () {

                                        String amount=donationProvider.kpccAmountController.text.toString();
                                        // String amount="1";
                                        var string =
                                        // await donationProvider.encryptQR(
                                            "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=qa%20${donationProvider.transactionID.text}&am=${amount}&cu=INR";
                                        // );

                                        callNext(NewPaymentGatewayScreen(id:string,subScriberType: subScriberType,loginUserPhone: loginUserPhone,
                                            paymentCategory: paymentCategory,
                                            equipmentCount: equipmentCount,
                                            equipmentID: equipmentID,oneEquipmentPrice: oneEquipmentPrice,
                                            loginUserID: loginUserID,loginUsername: loginUsername,
                                          zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                          sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                          foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, monthList: monthList), context);


                                      },
                                      child: Card(

                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          //set border radius more than 50% of height and width to make circle
                                        ),


                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            gradient:  LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [cl1177BB, cl1177BB]),
                                          ),
                                          height: 50,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Image.asset('assets/icon_qrcode.png'),
                                                Text(
                                                  'Scan QR & Pay',
                                                  style: black17,
                                                ),


                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                              ),
                              SizedBox(height: 20,),
                              Consumer<DonationProvider>(
                                  builder: (context,value,child) {
                                    return InkWell(
                                      onTap: (){

                                        String amount=donationProvider.kpccAmountController.text.toString();
                                        // String amount="1";


                                        var string =
                                        // await donationProvider.encryptQR(
                                            "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=qa%20${donationProvider.transactionID.text}&am=${amount}&cu=INR";
                                        // );

                                        print(string + " QQQQQQQQQQQ");
                                        _launchUrlUPI(context, Uri.parse(string));
                                        donationProvider.listenForPayment(donationProvider.transactionID.text.toString(),
                                            context,paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice,loginUsername,
                                            loginUserID,subScriberType,loginUserPhone,
                                          zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice, foodkitPrice, footkitCount,equipmentAmount, sponsorPatientAmonut, foodkitAmount,monthList);



                                      },
                                      child: Card(

                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          //set border radius more than 50% of height and width to make circle
                                        ),


                                        child: Container(
                                          height: 50,
                                          alignment: Alignment.center,

                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'All Upi Apps',
                                                  style: black16,
                                                ),
                                                SizedBox(width:10,),
                                                Image.asset('assets/phonepay.png',scale: 5,),
                                                SizedBox(width:7,),
                                                Image.asset('assets/gpay.png',scale: 5),
                                                SizedBox(width:7,),
                                                Image.asset('assets/img1.png',scale: 5),




                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                              ),

                            ],
                          ):SizedBox();
                        }
                      )







                    ],
                  ),
                ),


              ],
            ),
          ),








        ],
      ),
    );
  }
  

  Widget mobile(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar:   PreferredSize(
            preferredSize: Size.fromHeight(84),

            child: AppBar(
              leading:   InkWell(
                  onTap: (){
                    finish(context);
                  },
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: myBlack.withOpacity(0.05000000074505806),
                      child: const Padding(
                        padding: EdgeInsets.only(left:8.0),
                        child: Icon(Icons.arrow_back_ios,color:myBlack),
                      ),
                    ),
                  )),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
title:   Text('Participate Now',style:TextStyle(color: myBlack,
      fontSize: 15,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w800,
      letterSpacing: 0.5),


),



            ),
          ),
          body: body(context),
        ),
      ),
    );
  }
  Widget web(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    return Stack(
      children: [
        Row(
          children: [
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/KnmWebBacound1.jpg'),fit: BoxFit.cover
                  )
              ),
              child: Row(
                children: [
                  SizedBox(
                      height: height,
                      width: width / 3,
                      child: Image.asset("assets/Grou 2.png",scale: 4,)),
                  SizedBox(
                    height: height,
                    width: width / 3,
                  ),
                  SizedBox(
                      height: height,
                      width: width / 3,
                      child: Image.asset("assets/Grup 3.png",scale: 6,)),
                ],
              ),
            ),


          ],
        ),
        Center(child: queryData.orientation==Orientation.portrait?  Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: width/3,),
            SizedBox(width: width,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: myGreen,
                  centerTitle: true,
                  title: Text(
                    'Payment Method',
                    style: white18,
                  ),
                ),
                body: body(context),
              ),
            ),
            // SizedBox(width: width/3,),
          ],
        ):
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: width/3,),
            SizedBox(width: width/3,
              child: Scaffold(

                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: myGreen,
                  centerTitle: true,
                  title: Text(
                    'Payment Method',
                    style: white18,
                  ),
                ),
                body: body(context),
              ),
            ),
            // SizedBox(width: width/3,),
          ],
        ),)
      ],
    );
  }


  void showLoaderDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) =>
          Center(
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
              ),
            ),
          ),
    );
  }
  Future<void> _launchUrlUPI(BuildContext context, Uri _url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    } else {
      // callNext(PaymentGateway(), context);

    }
  }

}