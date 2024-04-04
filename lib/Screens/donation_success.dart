import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../qmchModels/subScriberModel.dart';
import 'cashfree/payment_gateway.dart';
import 'donate_page.dart';
import 'home.dart';
import 'home_screen.dart';

class DonationSuccess extends StatefulWidget {
  String paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice,loginUserPhone;
  String loginUsername,loginUserID,subScriberType;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  List<MonthBool> monthList;
  @override
   DonationSuccess({Key? key
    ,required this.paymentCategory
    ,required this.equipmentCount
    ,required this.equipmentID
    ,required this.oneEquipmentPrice
    ,required this.loginUsername,required this.loginUserID,required this.subScriberType
    ,required this.loginUserPhone,
    required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
    required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
    ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,required this.monthList,
   }) : super(key: key);
  _DonationSuccessState createState() => _DonationSuccessState();
}

class _DonationSuccessState extends State<DonationSuccess> {
  ConfettiController controllerCenter = ConfettiController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);

    Future.delayed(const Duration(seconds: 3), () {
      print(donationProvider.donorStatus.toString() + "11144555");

      if (donationProvider.donorStatus == "Success") {
        print("wise code here");

        // callNextReplacement(ReceiptPage(nameStatus: 'YES',), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    // homeProvider.checkInternet(context);
    if (!kIsWeb) {
      return mobile(context, controllerCenter,widget.paymentCategory,widget.equipmentCount,
          widget.equipmentID,widget.oneEquipmentPrice,widget.loginUsername,
      widget.loginUserID,widget.subScriberType,widget.loginUserPhone,widget.zakathAmount,widget.deseaseName,
          widget.sponsorCategory,widget.sponsorCount,widget.sponsorItemOnePrice,widget.foodkitPrice,widget.footkitCount,widget.equipmentAmount,widget.sponsorPatientAmonut,widget.foodkitAmount,widget.monthList);
    } else {
      return web(context,widget.paymentCategory,widget.equipmentCount,widget.equipmentID,widget.oneEquipmentPrice,widget.loginUsername,
          widget.loginUserID,widget.subScriberType,widget.loginUserPhone,widget.zakathAmount,widget.deseaseName,
          widget.sponsorCategory,widget.sponsorCount,widget.sponsorItemOnePrice,widget.foodkitPrice,widget.footkitCount,
          widget.equipmentAmount,widget.sponsorPatientAmonut,widget.foodkitAmount,widget.monthList);
    }
  }
}

Widget body(BuildContext context,String paymentCategory,String equipmentCount,
    String equipmentID,String oneEquipmentPrice, String loginUsername,
    String loginUserID,String subScriberType,String loginUserPhone,
String zakathAmount,String deseaseName,String sponsorCategory,String sponsorCount,String sponsorItemOnePrice,
    String foodkitPrice,String footkitCount,
String equipmentAmount,String sponsorPatientAmonut,String foodkitAmount,List<MonthBool> monthList) {
  DonationProvider donationProvider =
      Provider.of<DonationProvider>(context, listen: false);
  MediaQueryData queryData;
  queryData = MediaQuery.of(context);
  var width = queryData.size.width;
  var height = queryData.size.height;
  return SafeArea(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const SizedBox(height: 45,),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                // child:
                //       Consumer<HomeProvider>(
                //         builder: (context,value,child) {
                //           return Align(alignment: Alignment.topRight,
                //             child: InkWell(onTap: (){
                //               launch("whatsapp://send?phone=${value.contactNumber}");
                //             },
                //               child:
                //               Card(
                // shape: const RoundedRectangleBorder(
                // borderRadius: BorderRadius.all(Radius.circular(25))),
                //                 elevation: 5,
                //                child:   SizedBox(
                //                  height: height*0.06,width: width*0.35,
                //                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                    children: [
                //                      Image.asset(
                //                           "assets/whatsapIconNew.png",
                //                           scale: 3,
                //                         ),
                //                      const Text( "Get Support",
                //                                  style: TextStyle(color: myBlack3,fontSize: 15),
                //                                ),
                //                    ],
                //                  ),
                //                )
                //               ),
                //             ),
                //           );
                //         }
                //       ),
              ),

              Consumer<DonationProvider>(builder: (context, value, child) {
                // value.donorStatus = "Success";
                return value.donorStatus == "Success"
                    ? SizedBox(
                        height: height * 0.15,
                      )
                    : SizedBox(
                        height: height * 0.15,
                      );
              }),

              SizedBox(
                child: Consumer<DonationProvider>(
                    builder: (context, value, child) {
                  return value.donorStatus == "Success"
                      ? SizedBox(
                    width: 70,
                    height: 70,
                        child: Image.asset(
                            "assets/paymentSuccess.png",
                            scale: 2.5,
                          ),
                      )
                      : value.donorStatus == "Failed"
                          ? SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.asset("assets/paymentFail.png",
                                  // scale: 2.5
                              ),
                            )
                          : const Center(
                              child: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: CircularProgressIndicator(
                                    color: cl323A71,
                                  )),
                            );
                }),
              ),
            ],
          ),
        ),

        Consumer<DonationProvider>(builder: (context, value, child) {
          return value.donorStatus == "Success"
              ? Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 3.0),
                          child: Text(
                            "₹",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 35,
                                color: Colors.black),
                          ),
                        ),
                        Text(
                          value.donorAmount,
                            style: const TextStyle(
                                fontFamily: 'PoppinsMedium',
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color:myBlack
                            )
                        ),
                      ],
                    ),


                    const SizedBox(
                      height: 10,
                    ),

                    const Text(
                      "Payment was Successful!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: 'MontserratMedium',
                        color: cl59AA37,),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Text(
                      'We have received your payment \n Thankyou.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: cl565656,
                        fontSize: 10.66,
                        fontFamily: 'MontserratMedium',
                        fontWeight: FontWeight.w500,
                        // height: 0.03,
                      ),
                    ),

                  ],
                )
              : value.donorStatus == "Failed"
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Text(
                                "₹",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 35,
                                    color: Colors.black),
                              ),
                            ),
                            Text(
                              value.donorAmount,
                              style: const TextStyle(
                                  fontFamily: 'PoppinsMedium',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color:myBlack
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        const Text('Payment was failed !',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'MontserratMedium',
                                color: KnmFailedtxtColor)
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        const Text(
                          'Something went wrong. \nWe couldn’t process your payment.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: cl565656,
                            fontSize: 10.66,
                            fontFamily: 'MontserratMedium',
                            fontWeight: FontWeight.w500,
                            // height: 0.03,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        InkWell(
                          onTap: () {
                            print('askfmkasjdfm');
                            value.clickWhyMyPaymentFailed();
                          },
                          child: SizedBox(
                            height: 20,
                            // width: 100,
                            child: const Text(
                              'Why my payment was failed.?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: cl2E1FD4,
                                fontSize: 12,
                                fontFamily: 'MontserratMedium',
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        value.isWhyMyPaymentFailed?

                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: width*.17),
                              child: CustomPaint(
                                size: const Size(10, 10),
                                painter: TrianglePainter(),
                              ),
                            ),

                            MessageContainer(),


                          ],
                        ):SizedBox(),

                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    )
                  : const SizedBox();
        }),

        const Spacer(),
        // const SizedBox(height: 25,),
        Consumer<DonationProvider>(builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30,
                ),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 25),
                    //   child: Consumer<DonationProvider>(
                    //       builder: (context, value, child) {
                    //         return Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             Row(mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 value.donorStatus == "Failed"?
                    //                 SizedBox()
                    //                 // SizedBox(
                    //                 //   width: 30,
                    //                 //   child: Column(
                    //                 //     children: [
                    //                 //       Image.asset(
                    //                 //         "assets/rupaIcon.png",
                    //                 //         scale: 4,
                    //                 //         color: primary,
                    //                 //       ),
                    //                 //     ],
                    //                 //   ),
                    //                 // )
                    //                     :   SizedBox(
                    //                   width: 30,
                    //                   child: Column(
                    //                     children: [
                    //                       Image.asset(
                    //                         "assets/rs.png",
                    //                         scale: 4,
                    //                         color: Colors.black,
                    //                       ),
                    //                       // SizedBox(height: 10,)
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 value.donorStatus == "Failed"? SizedBox()
                    //                 // Text(
                    //                 //   value.donorAmount,
                    //                 //   style: skyBluePoppinsFailed,
                    //                 // )
                    //                     :Text(
                    //                   value.donorAmount,
                    //                   style: skyBluePoppinsM35New,
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         );
                    //       }),
                    // ),
                    value.donorStatus == "Failed"
                        ? Center(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 13.0),
                              child: InkWell(
                                onTap: () {
                                  print("retryworkkk");
                                  HomeProvider homeProvider =
                                      Provider.of<HomeProvider>(context,
                                          listen: false);
                                  donationProvider.transactionID.text =
                                      DateTime.now()
                                              .microsecondsSinceEpoch
                                              .toString() +
                                          generateRandomString(2);
                                  donationProvider.attempt(
                                      value.transactionID.text,
                                      homeProvider.appVersion.toString(),paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice,loginUsername,loginUserID,subScriberType,loginUserPhone,
                                      zakathAmount, deseaseName, sponsorCategory, sponsorCount, sponsorItemOnePrice, foodkitPrice, footkitCount, equipmentAmount,sponsorPatientAmonut,foodkitAmount,monthList);
                                  String amount = donationProvider
                                      .kpccAmountController.text
                                      .toString()
                                      .replaceAll(',', '');
                                  String name = donationProvider.nameTC.text;
                                  String phone = donationProvider.phoneTC.text;

                                  callNext(PaymentGateway(paymentCategory: paymentCategory,
                                      subScriberType: subScriberType,loginUserPhone: loginUserPhone,
                                    equipmentCount: equipmentCount,
                                    equipmentID:equipmentID,
                                    oneEquipmentPrice: oneEquipmentPrice,
                                      loginUserID: loginUserID,
                                      loginUsername: loginUsername,
                                    zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                    sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                    foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount,monthList: monthList, ), context);
                                },
                                child: Container(
                                  width: 90.86,
                                  height: 43.48,
                                  // width: 248,
                                  // height: 46,
                                  decoration: ShapeDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment(-1.00, -0.00),
                                      end: Alignment(1, 0),
                                      colors: [cl3E4FA3, cl253068],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.refresh,color: myWhite,size: 20,),
                                      Text(
                                        'Retry',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        )
                        : const SizedBox(),

                    const SizedBox(width: 20,),


                    value.donorStatus == "Failed"
                        ? Center(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 13.0),
                              child: InkWell(
                                onTap: () {
                                  callNextReplacement(
                                       HomeScreenNew(loginUserPhone: loginUserPhone,
                                           loginUserID: loginUserID,loginUsername: loginUsername,
                                           subScriberType: subScriberType, zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                         sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                         foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                                },
                                child: Container(
                                  width: 115,
                                  height: 43,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x0A000000),
                                        blurRadius: 5.15,
                                        offset: Offset(0, 2.58),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Home",
                                      style: TextStyle(
                                          color: myBlack,
                                          fontFamily: 'MontserratMedium',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        )
                        : const SizedBox(),

                    // Text(
                    //   "Details",
                    //   style: blackPoppinsBoldM20,
                    // ),
                    // const SizedBox(height: 20,),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(child: Text("Transaction ID", style: black14New)),
                    //     Text(
                    //       ":  ",
                    //       style: black14New,
                    //     ),
                    //     Expanded(child: Consumer<DonationProvider>(
                    //         builder: (context, value, child) {
                    //           return Text(value.donorID, style: black14New);
                    //         }))
                    //   ],
                    // ),
                    // const SizedBox(height: 10,),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(child: Text("Name", style: black14New)),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 15),
                    //       child: Text(
                    //         ":  ",
                    //         style: black14New,
                    //       ),
                    //     ),
                    //     Expanded(child: Consumer<DonationProvider>(
                    //         builder: (context, value, child) {
                    //           return Text(value.donorName, style: black14New);
                    //         }))
                    //   ],
                    // ),
                    // const SizedBox(height: 10,),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(child: Text("Phone number", style: black14New)),
                    //     Text(
                    //       ":  ",
                    //       style: black14New,
                    //     ),
                    //     Expanded(child: Consumer<DonationProvider>(
                    //         builder: (context, value, child) {
                    //           return Text(value.donorNumber, style: black14New);
                    //         }))
                    //   ],
                    // ),
                    // const SizedBox(height: 10,),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(child: Text("Unit", style: black14New)),
                    //     Text(
                    //       ":  ",
                    //       style: black14New,
                    //     ),
                    //     Expanded(child: Consumer<DonationProvider>(
                    //         builder: (context, value, child) {
                    //           return Text(value.donorPlace, style: black14New);
                    //         }))
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    ///commented
                    // value.donorStatus == "Failed"
                    // ?Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     InkWell(
                    //       onTap: (){
                    //         value.transactionID.text = DateTime.now().millisecondsSinceEpoch.toString();
                    //         donationProvider.attempt(value.transactionID.text);
                    //         String amount = value.dhothiAmount.toString();
                    //         String name = value.nameTC.text;
                    //         String phone = donationProvider.phoneTC.text;
                    //         donationProvider.upiIntent(
                    //             context, amount, name, phone, value.donorApp);
                    //       },
                    //       child: Container(
                    //         width: 150,
                    //         height: 50,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(30),
                    //           color: myWhite
                    //         ),
                    //         alignment: Alignment.center,
                    //         child:Text(
                    //           'Retry',
                    //           style: blackPoppinsBoldM15,
                    //         ),
                    //       ),
                    //     ),
                    //     // InkWell(
                    //     //   onTap: (){
                    //     //     callNext(DonatePage(), context);
                    //     //   },
                    //     //   child: Container(
                    //     //     width: 150,
                    //     //     height: 50,
                    //     //     decoration: BoxDecoration(
                    //     //         borderRadius: BorderRadius.circular(30),
                    //     //       color: myWhite
                    //     //     ),
                    //     //     alignment: Alignment.center,
                    //     //     child:Text(
                    //     //       'Edit Dhoti',
                    //     //       style: blackPoppinsBoldM15,
                    //     //     ),
                    //     //   ),
                    //     // ),
                    //   ],
                    // )
                    //     :const SizedBox(),
                    // const SizedBox(height: 20,),
                    // InkWell(
                    //   onTap: (){
                    //     if (value.donorStatus == 'Success') {
                    //       callNextReplacement(ReceiptPage(), context);
                    //     }else{
                    //       callNextReplacement(HomeScreen(), context);
                    //     }
                    //   },
                    //   child: Container(
                    //     width: width,
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(30),
                    //       color: myWhite
                    //     ),
                    //     alignment: Alignment.center,
                    //     child:value.donorStatus == "Success"
                    //         ?Text('Done', style: blackPoppinsBoldM15,)
                    //         :value.donorStatus == "Failed"?
                    //     Text('Home', style: blackPoppinsBoldM15,)
                    //         :const SizedBox(),
                    //   )
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              // value.donorStatus == "Success"?
              // InkWell(
              //     onTap: (){
              //       callNextReplacement(ReceiptPage(nameStatus: '',), context);
              //     },
              //     child: Container(
              //         width:248,
              //         height:46,
              //         decoration: BoxDecoration(
              //             gradient: const LinearGradient(
              //                 begin: Alignment.centerLeft,
              //                 end: Alignment.centerRight,
              //                 colors: [cl323A71, cl1177BB]),
              //             border: Border.all(color: primary,width: 0.5),
              //
              //             borderRadius: BorderRadius.circular(20),
              //         ),
              //         alignment: Alignment.center,
              //         child:Text('Get Receipt', style: blackPoppinsBoldM15,)
              //     )
              // ):SizedBox()

              // value.donorStatus == "Failed"
              //     ?Column(
              //   children: [
              //     InkWell(
              //       onTap:(){
              //         callNextReplacement(const HomeScreen(), context);
              //       },
              //       child:
              //       Card(
              //         color: myWhite,
              //         elevation:0,
              //         margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //         shape: const RoundedRectangleBorder(
              //           borderRadius: BorderRadius.only(
              //             bottomLeft: Radius.circular(0),
              //             bottomRight: Radius.circular(0),
              //           ),
              //         ),
              //         child: Container(
              //             width: width,
              //             height: 65,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(30),
              //                 color: myWhite
              //             ),
              //             child: Center(child: Text('Home', style: blackPoppinsBoldM15New,))),),
              //     ),
              //     InkWell(
              //       onTap:(){
              //         value.transactionID.text = DateTime.now().microsecondsSinceEpoch.toString();
              //         donationProvider.attempt(value.transactionID.text);
              //         String amount = value.knmAmountController.text.toString();
              //         String name = value.nameTC.text;
              //         String phone = donationProvider.phoneTC.text;
              //         donationProvider.upiIntent(
              //             context, amount, name, phone, value.donorApp);
              //       },
              //       child: Card(color: myWhite,
              //           elevation:0,
              //           margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //           shape: const RoundedRectangleBorder(
              //             borderRadius: BorderRadius.only(
              //               bottomLeft: Radius.circular(30),
              //               bottomRight: Radius.circular(30),
              //             ),
              //           ),
              //           child: Container(
              //             width: width,
              //             height: 65,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(30),
              //                 color: myWhite
              //             ),
              //             alignment: Alignment.center,
              //             child:Text(
              //               'Retry',
              //               style: blackPoppinsBoldM15New,
              //             ),
              //
              //           )),
              //     )
              //   ],
              // ):const SizedBox();
            ],
          );
        }),

        Consumer<DonationProvider>(
          builder: (context, value, child) {
            return value.donorStatus == "Success"
                ? Column(
                  children: [
                    Center(
              child: Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: InkWell(
                      onTap: () {
                        callNextReplacement(
                             HomeScreenNew(loginUserPhone: loginUserPhone,
                                 loginUsername:loginUsername,loginUserID: loginUserID,
                                 subScriberType: subScriberType, zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                               sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                               foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                      },
                      child: Container(
                        width: 115,
                        height: 43,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x0A000000),
                              blurRadius: 5.15,
                              offset: Offset(0, 2.58),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Home",
                            style: TextStyle(
                                color: myBlack,
                                fontFamily: 'MontserratMedium',
                                fontWeight: FontWeight.w700,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ),
              ),
            ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                )
                : const SizedBox();
          }
        ),
      ],
    ),
  );
}

Widget mobile(BuildContext context, ConfettiController controllerCenter,String paymentCategory
    ,String equipmentCount,String equipmentID,String oneEquipmentPrice ,String loginUsername,
String loginUserID,String subScriberType,String loginUserPhone,
String zakathAmount,String deseaseName,String sponsorCategory,String sponsorCount,String sponsorItemOnePrice,String foodkitPrice,String footkitCount,
String equipmentAmount,String sponsorPatientAmonut,String foodkitAmount,List<MonthBool> monthList) {
  return WillPopScope(
    onWillPop: () async {
      return false;
    },
    child: Builder(builder: (context) {
      MediaQueryData queryData;
      queryData = MediaQuery.of(context);
      var width = queryData.size.width;
      var height = queryData.size.height;
      DonationProvider donationProvider =
          Provider.of<DonationProvider>(context, listen: false);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,

          // leading: Center(
          //   child: CircleAvatar(
          //       radius: 22,
          //       backgroundColor: myBlack.withOpacity(0.1),
          //       child: const Padding(
          //         padding: EdgeInsets.only(right: 8.0),
          //         child: Icon(
          //           Icons.arrow_back_ios_new_outlined,
          //           size: 20,
          //           color: myBlack,
          //         ),
          //       )),
          // ),
          centerTitle: true,
          title: const Text(
            "Payment Status",
            style: TextStyle(
              color: myBlack,
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          // shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
          // flexibleSpace: Container(
          //   height: height*0.12,
          //   decoration: const BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(17),bottomRight:  Radius.circular(17))
          //
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: const [
          //
          //       Text('My Contribution',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: cl323A71),),
          //
          //     ],),
          // ),
        ),
        backgroundColor: donationProvider.donorStatus == "Success"
            ? Colors.white
            : donationProvider.donorStatus == "Failed"
                ? Colors.white
                : Colors.white,
        body: body(context,paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice,loginUsername,loginUserID,subScriberType,loginUserPhone,
            zakathAmount, deseaseName,sponsorCategory, sponsorCount, sponsorItemOnePrice, foodkitPrice, footkitCount, equipmentAmount,
          sponsorPatientAmonut,foodkitAmount,monthList),
      );
    }),
  );
}

Widget web(BuildContext context,String paymentCategory,String equipmentCount,String equipmentID,String oneEquipmentPrice,
String loginUsername,String loginUserID,String subScriberType,String loginUserPhone,
String zakathAmount,String deseaseName,String sponsorCategory,String sponsorCount,String sponsorItemOnePrice,String foodkitPrice,String footkitCount,
String equipmentAmount,String sponsorPatientAmonut,String foodkitAmount,List<MonthBool> monthList) {
  MediaQueryData queryData;
  queryData = MediaQuery.of(context);
  var width = queryData.size.width;
  DonationProvider donationProvider =
      Provider.of<DonationProvider>(context, listen: false);
  return Stack(
    children: [
      Center(
          child: queryData.orientation == Orientation.portrait
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width,
                      child: Scaffold(
                        backgroundColor: myGreen,
                        body: body(context,paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice,loginUsername,loginUserID,subScriberType,loginUserPhone,
                          zakathAmount, deseaseName, sponsorCategory, sponsorCount, sponsorItemOnePrice, foodkitPrice, footkitCount, equipmentAmount, sponsorPatientAmonut, foodkitAmount,monthList
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width / 3,
                      child: Scaffold(
                        backgroundColor: myGreen,
                        body: body(context,paymentCategory,equipmentCount,equipmentID,
                            oneEquipmentPrice,loginUsername,loginUserID,
                            subScriberType,loginUserPhone,
                          zakathAmount,   deseaseName,
                          sponsorCategory,
                          sponsorCount,
                          sponsorItemOnePrice,
                          foodkitPrice,
                          footkitCount,
                          equipmentAmount,
                          sponsorPatientAmonut,
                          foodkitAmount,
                            monthList
                        ),
                      ),
                    ),
                  ],
                ))
    ],
  );
}

Path drawStar(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =  Color(0xffE1F4D6)

    ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


class MessageContainer extends StatelessWidget {
  final String message = "Your transaction has failed due to some \ntechnical error. Please try again.";

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return Container(
      width: 230,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      height: 65,
      decoration: ShapeDecoration(
        color: Color(0xffE1F4D6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9.50),
        ),
        // shadows: [
        //   BoxShadow(
        //     color: Color(0x3F000000),
        //     blurRadius: 3.80,
        //     offset: Offset(0, 0),
        //     spreadRadius: 0,
        //   )
        // ],
      ),
      child: Text(
        message,
        style:  const TextStyle(
          color: cl565656,
          fontSize: 10,
          fontFamily: 'MontserratMedium',
          fontWeight: FontWeight.w500,
          // height: 0.10,
        ),
      ),
    );
  }
}
