import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/gradientTextClass.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import '../qmchModels/subScriberModel.dart';

class NewPaymentGatewayScreen extends StatefulWidget {
  String paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice;
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String id;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  List<MonthBool> monthList;
  NewPaymentGatewayScreen({Key? key, required this.id
    ,required this.paymentCategory
    ,required this.equipmentCount
    ,required this.equipmentID
    ,required this.oneEquipmentPrice,required this.loginUsername,required this.loginUserID,
    required this.subScriberType,required this.loginUserPhone,
    required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
    required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
    ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,required this.monthList,
  }) : super(key: key);

  @override
  State<NewPaymentGatewayScreen> createState() =>
      _NewPaymentGatewayScreenState();
}

class _NewPaymentGatewayScreenState extends State<NewPaymentGatewayScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    donationProvider.listenForPayment(
        donationProvider.transactionID.text.toString(), context,widget.paymentCategory,widget.equipmentCount,widget.equipmentID,
        widget.oneEquipmentPrice,widget.loginUsername,widget.loginUserID,widget.subScriberType,widget.loginUserPhone,
        widget.zakathAmount,widget.deseaseName,
        widget.sponsorCategory,widget.sponsorCount,widget.sponsorItemOnePrice,widget.foodkitPrice,
        widget.footkitCount,widget.equipmentAmount,widget.sponsorPatientAmonut,widget.foodkitAmount,widget.monthList);
    return Scaffold(
      appBar: AppBar(
        // actions: [Icon(Icons.qr_code)],
        automaticallyImplyLeading: false,
        // leading: Icon(Icons.arrow_back_ios_outlined),
        backgroundColor: Colors.white,
        elevation: 0,
        // title: Center(child: Text('My Contribution')),
        flexibleSpace: Center(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [cl1177BB, cl1177BB]),
              //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:  Radius.circular(30))
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.03,
                  ),
                  InkWell(
                      onTap: () {
                        finish(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: width * 0.2,
                  ),

                  const Text(
                    'PAYMENT METHOD',
                    style: TextStyle(
                        fontFamily: "PoppinsLight",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  // SizedBox(width: width*0.2,),

                  // Image.asset(
                  //   "assets/help2.png",color: myWhite,scale: 4,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<DonationProvider>(builder: (context, value, child) {
              return Screenshot(
                controller: screenshotController,
                child: InkWell(
                  onTap: () {
                    donationProvider.launchUrlUPI(context, Uri.parse(widget.id));
                  },
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          height: 440,
                          width: width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/qr_poster.jpeg"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 80,
                              ),
                              Consumer<DonationProvider>(
                                  builder: (context, value, child) {
                                return GradientText(
                                  '₹${value.kpccAmountController.text.toString()}',
                                  style: rupeeBig7,
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Colors.white, Colors.white]),
                                );
                              }),
                              Consumer<DonationProvider>(
                                  builder: (context, value, child) {
                                return Text(
                                  value.nameTC.text.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                );
                              }),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                color: Colors.white,
                                width: 170,
                                height: 170,
                                child: QrImage(
                                  data: widget.id,
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Scan or Share",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey.shade400),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Scan and await your receipt"),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                    width: 10, height: 10, child: CircularProgressIndicator())
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {


                donationProvider.createQrImage('Send', "test", screenshotController);

              },
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.85,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // color: cl2195da,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [cl1177BB, cl1177BB]),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      const Text(
                        'Share',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Consumer<DonationProvider>(builder: (context, val3, child) {
              return Platform.isAndroid?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  val3.androidGooglePayButton == "ON"
                      ? InkWell(
                          onTap: () {
                            var androidGpay =
                                "tez://upi/pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=qa%20${donationProvider.transactionID.text}&am=${donationProvider.kpccAmountController.text}&cu=INR";
                            _launchUrlUPI(context, Uri.parse(androidGpay));
                          },
                          child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.2),
                                    blurRadius: 12.0),
                              ], shape: BoxShape.circle, color: Colors.white),
                              child: Center(
                                  child: Image.asset(
                                "assets/gpayIphone.png",
                                scale: 1.4,
                              ))),
                        )
                      : SizedBox(),
                  SizedBox(
                    width: 25,
                  ),
                  val3.androidPhonePayButton == "ON"
                      ? InkWell(
                          onTap: () {
                            var androidPhonepe =
                                "phonepe://upi/pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=qa%20${donationProvider.transactionID.text}&am=${donationProvider.kpccAmountController.text}&cu=INR";
                            _launchUrlUPI(context, Uri.parse(androidPhonepe));
                          },
                          child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.2),
                                    blurRadius: 12.0),
                              ], shape: BoxShape.circle, color: Colors.white),
                              child: Center(
                                child: Image.asset(
                                  "assets/PhonepayIphone.png",
                                  scale: 1.4,
                                ),
                              )),
                        )
                      : SizedBox(),
                ],
              ):SizedBox();
            }),
            Consumer<DonationProvider>(builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  donationProvider.launchUrlUPI(context, Uri.parse(widget.id));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                    //set border radius more than 50% of height and width to make circle
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Select Apps',
                          style: black16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/phonepay.png',
                          scale: 4,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Image.asset(
                          'assets/gpay.png',
                          scale: 6,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Image.asset(
                          'assets/sbi.png',
                          scale: 6,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Image.asset(
                          'assets/paytm.png',
                          scale: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrlUPI(BuildContext context, Uri _url) async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  } else {
    // callNext(PaymentGateway(), context);
  }
}
