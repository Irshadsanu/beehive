import 'dart:io';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:beehive/Screens/payment_history.dart';
import 'package:beehive/Screens/receiptlist_monitor_screen.dart';
import 'package:beehive/Screens/reciept_list_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../QmchScreens/activity_home_screen.dart';
import '../QmchScreens/login_screen.dart';
import '../QmchScreens/multiple_payment_screen.dart';
import '../QmchScreens/sponsorOnBoardingScreen.dart';
import '../QmchScreens/subscriptionPayments.dart';
import '../QmchScreens/userEquipmentListScreen.dart';
import '../QmchScreens/userFoodKitScreen.dart';
import '../QmchScreens/userRegistrationScreen.dart';
import '../QmchScreens/voulenteerTransactionsScreen.dart';
import '../constants/alerts.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/strings.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import '../providers/home_provider_reciept.dart';
import '../providers/login_provider.dart';
import '../providers/web_provider.dart';
import 'district_report.dart';
import 'donate_page.dart';
import 'enrollerPayments_screen.dart';
import 'leadReport.dart';
import 'no_paymet_gatway.dart';

class HomeScreenNew extends StatefulWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
   HomeScreenNew({Key? key,required this.loginUsername,required this.loginUserID
     ,required this.subScriberType,required this.loginUserPhone,
     required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
  }

  final List<int> amount = [1000, 2000, 5000, 10000];

  final List<Color> colors = [clB3EFD2, clEFB3B3, clCAE8F1, clB3EFEF];

  final List<String> amountInWords = [
    "Five Hundred",
    "Thousand",
    "Five Thousand",
    "Ten Thousand",
    "Twenty Five Thousand",
    "Fifty Thousand",
  ];

  List<String> images = [
    "assets/carouselBg1.png",
    "assets/carouselBg1.png",
    "assets/carouselBg1.png",
    "assets/carouselBg1.png",
  ];

  List<String> contriImg = [
    "assets/Transactions.png",
    "assets/MyHistory.png",
    // "assets/TopVolunteers.png",
    "assets/Reports.png",
  ];

  List<String> gridOneImg=[
    "assets/generalContribution2x.png",
    "assets/zakatImg.png",
    "assets/SponsoraPatientImg.png",
    "assets/contributionImg.png",
    "assets/SponsorEquipmentImg.png",
    "assets/SubscriptionPayment.png",
  ];

  List<String> gridOnetext=[
    "General Contribution",
    "Zakat",
    "Patient Sponsorship",
    "Food kit Sponsorship",
    "Equipment Sponsorship",
    "Members Payment",
  ];

  List<String> gridTwoImg=[
    "assets/Volunteer RegistrationImg.png",
    "assets/MultiplePaymentImg.png",
  ];

  List<String> gridTwotext=[
    "Be a \n Volunteer",
    "   Multiple\n  Payment",
  ];

  List<String> contriText = [
    "Transactions",
    "My History",
    // "Top Voluteers",
    "Reports",
  ];

  List<String> PTCImg = [
    "assets/privacyPolicy.png",
    "assets/TermsAndCondition.png",
    "assets/helpline.png",
  ];

  List<String> PTCText = [
    "Privacy Policy",
    "Terms and condition",
    "About Us",
  ];

  List<String> reportText = ["Transactions", "My History", "Receipt", "Report"];

  List<String> reportImg = [
    "assets/transactions.png",
    "assets/History.png",
    "assets/Reciept.png",
    "assets/report.png",
  ];

  int activeIndex = 0;

  // List<Widget> statsScreens = [
  //   WardHistory(),
  //   ReceiptListPage(
  //     from: 'home',
  //     total: '',
  //     ward: '',
  //     panchayath: '',
  //     district: '',
  //     target: '',
  //   ),
  //   DistrictReport(
  //     from: '',
  //       loginUserID: widget.loginUserID,loginUsername: widget.loginUsername
  //   ),
  //   PaymentHistory()
  // ];
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    // print( widget.loginUserPhone+' FOIIF' +widget.loginUserID+ widget.subScriberType);
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget mobile(context) {

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    LoginProvider loginProvider =
    Provider.of<LoginProvider>(context, listen: false);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);

    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    homeProvider.sss();
    homeProvider.getAppVersion();
    if (Platform.isIOS) {
      amount.clear();
    }

    return WillPopScope(
      onWillPop: () {
        return showExitPopup(context);
      },
      child: queryData.orientation == Orientation.portrait
          ? Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              backgroundColor: clFFFFFF,

              body: SafeArea(
                child: SizedBox(
                  height: height,
                  child: Stack(children: [
                    Container(
                        height: 600,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/homeTopBg.png"),
                          fit: BoxFit.cover,
                        ))),
                    ListView(
                        children: [
                      Container(
                    // color:Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          // height: 580,
                          child: Column(children: [
                            ///qmch appBar

                            SizedBox(
                                height: 55,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0.0),
                                              child: SizedBox(
                                                  width: 52,
                                                  height: 42,
                                                  child: Image.asset(
                                                      "assets/qmchBg.png")),
                                            ),
                                            const SizedBox(width: 10),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    'QUAID-E-MILLATH',
                                                    style: TextStyle(
                                                      color: myBlack,
                                                      fontSize: 12,
                                                      fontFamily: 'JaldiBold',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  Text(
                                                    'CENTRE FOR HUMANITY',
                                                    style: TextStyle(
                                                      color: myBlack,
                                                      fontSize: 12,
                                                      fontFamily: 'JaldiBold',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                      1 == 1
                                          ? Row(
                                            children: [
                                            // (widget.loginUserID==''||widget.loginUserID=='null') ?const SizedBox():
                                            // InkWell(onTap: (){
                                            //     logoutAlert(context,widget.loginUsername,widget.loginUserID, widget.subScriberType,);
                                            //   },
                                            //       child: const Icon(Icons.exit_to_app)),
                                            //   const SizedBox(width: 5,),
                                              widget.loginUserID!=''&&widget.loginUserID!='null'?
                                              Consumer<DonationProvider>(
                                                builder: (context,value,child) {
                                                  return
                                                  value.userImgUrl!=''?
                                                    InkWell(onTap: (){
                                                      if(value.userImgUrl=='' || value.userImgUrl=='null'){
                                                        donationProvider.getUserImg(widget.loginUserID,widget.subScriberType);
                                                      }
                                                      _showTopSheet(context,widget.loginUsername,widget.loginUserID, widget.subScriberType,widget.loginUserPhone);
                                                    },
                                                      child: Container(
                                                        width: 35,
                                                        height: 35,
                                                        decoration:  BoxDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage(value.userImgUrl),  fit: BoxFit.fill,),
                                                            gradient: SweepGradient(
                                                              center: Alignment(0, 1),
                                                              startAngle: 0,
                                                              endAngle: 1,
                                                              colors: [Color(0xFF3E4FA3), Color(0xFF253068)],),
                                                            shape: BoxShape.circle),

                                                      ),
                                                    ):Container(
                                                      width: 35,
                                                      height: 35,
                                                      decoration: const BoxDecoration(
                                                          gradient: SweepGradient(
                                                            center: Alignment(0, 1),
                                                            startAngle: 0,
                                                            endAngle: 1,
                                                            colors: [
                                                              Color(0xFF3E4FA3),
                                                              Color(0xFF253068)
                                                            ],
                                                          ),
                                                          shape: BoxShape.circle),
                                                      child: InkWell(
                                                          onTap:(){
                                                            _showTopSheet(context,widget.loginUsername,widget.loginUserID, widget.subScriberType,widget.loginUserPhone);
                                                            },
                                                        child: const Icon(
                                                            Icons.person_outline,
                                                            color: myWhite),
                                                      ));
                                                }
                                              ):
                                              InkWell(onTap: (){
                                                callNext(const LoginScreen(), context);
                                              },
                                                        child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: const BoxDecoration(
                                                        gradient: SweepGradient(
                                                          center: Alignment(0, 1),
                                                          startAngle: 0,
                                                          endAngle: 1,
                                                          colors: [
                                                            Color(0xFF3E4FA3),
                                                            Color(0xFF253068)
                                                          ],
                                                        ),
                                                        shape: BoxShape.circle),
                                                  child: const Icon(
                                                        Icons.login,
                                                        color: myWhite)),
                                                      ),
                                            ],
                                          )
                                          : Row(children: [
                                              // Container(
                                              //   // width:60,
                                              //   height: 40,
                                              //     color:Colors.red,
                                              //   child: Stack(
                                              //     children: [
                                              //       Align(
                                              //   alignment:Alignment.centerRight,
                                              //         child: Container(
                                              //             width: 40,
                                              //             height: 40,
                                              //             decoration: const BoxDecoration(
                                              //                 gradient: SweepGradient(
                                              //                   center: Alignment(0, 1),
                                              //                   startAngle: 0,
                                              //                   endAngle: 1,
                                              //                   colors: [cl3E4FA3, cl253068],
                                              //                 ),
                                              //                 shape: BoxShape.circle
                                              //             ),
                                              //             child:const Icon(Icons.notifications_active_outlined,color:myWhite,
                                              //             size: 20,
                                              //             weight: 100,
                                              //             )
                                              //         ),
                                              //       ),
                                              //
                                              //       Positioned(
                                              //
                                              //           child:Row(
                                              //             children: [
                                              //               Container(
                                              //                 // margin: EdgeInsets.only(right: 20),
                                              //                 padding: EdgeInsets.symmetric(horizontal:7),
                                              //                 height: 20,
                                              //                 decoration:BoxDecoration(
                                              //                   color: Colors.white,
                                              //                     borderRadius: BorderRadius.circular(15)
                                              //                 ),
                                              //                   child:Text(
                                              //                     '12345',
                                              //                     style: TextStyle(
                                              //                       color: cl2C3878,
                                              //                       fontSize: 12,
                                              //                       fontFamily: 'JaldiBold',
                                              //                       fontWeight: FontWeight.w400,
                                              //                       // height: 0.08,
                                              //                     ),
                                              //                   ),
                                              //               ),
                                              //               Container(width:20,
                                              //               height:10,
                                              //               color:Colors.green,
                                              //               ),
                                              //             ],
                                              //           )
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),

                                              Badge(
                                                alignment: AlignmentDirectional
                                                    .topStart,
                                                backgroundColor: myWhite,
                                                label: const Text(
                                                  '33',
                                                  style: TextStyle(
                                                    color: cl2C3878,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration:
                                                        const BoxDecoration(
                                                            gradient:
                                                                SweepGradient(
                                                              center: Alignment(
                                                                  0, 1),
                                                              startAngle: 0,
                                                              endAngle: 1,
                                                              colors: [
                                                                cl3E4FA3,
                                                                cl253068
                                                              ],
                                                            ),
                                                            shape: BoxShape
                                                                .circle),
                                                    child: const Icon(
                                                      Icons
                                                          .notifications_active_outlined,
                                                      color: myWhite,
                                                      size: 20,
                                                      weight: 100,
                                                    )),
                                              ),

                                              const SizedBox(width: 10),

                                              Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    image: const DecorationImage(
                                                        image: AssetImage(
                                                            "assets/qmchBg.png")),
                                                    border: Border.all(
                                                        color: cl3E4FA3),
                                                    shape: BoxShape.circle),
                                              )
                                            ]
                                      )
                                    ])),

                            ///height SizedBox
                            const SizedBox(height: 15),

                            ///Carousel builder
                            Container(
                              height: 220,
                              // color:Colors.blue,
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 200,
                                        width: width,
                                        decoration: BoxDecoration(

                                          borderRadius: BorderRadius.circular(7),
                                        ),
                                        child: CarouselSlider.builder(
                                          itemCount: images.length,
                                          itemBuilder:
                                              (context, index, realIndex) {
                                            //final image=value.imgList[index];
                                            final image = images[index];
                                            return buildImage(image, context);
                                          },
                                          options: CarouselOptions(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              // autoPlayCurve: Curves.linear,
                                              height: 200,
                                              viewportFraction: 1,
                                              autoPlay: true,
                                              //enableInfiniteScroll: false,
                                              pageSnapping: true,
                                              enlargeStrategy:
                                                  CenterPageEnlargeStrategy
                                                      .height,
                                              enlargeCenterPage: true,
                                              autoPlayInterval:
                                                  const Duration(seconds: 3),
                                              onPageChanged: (index, reason) {
                                                setState(() {
                                                  activeIndex = index;
                                                });
                                              }),
                                        ),
                                      ),
                                      buidIndiaCator(images.length, context)
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 5),

                            ///collected amount
                            InkWell(
                              onTap: () {
                                mRoot
                                    .child('0')
                                    .child('PaymentGateway36')
                                    .onValue
                                    .listen((event) {
                                  if (event.snapshot.value.toString() == 'ON') {
                                    DonationProvider donationProvider =
                                        Provider.of<DonationProvider>(context,
                                            listen: false);
                                    donationProvider.amountTC.text = "";
                                    donationProvider.nameTC.text = "";
                                    donationProvider.phoneTC.text = "";
                                    donationProvider.kpccAmountController.text =
                                        "";
                                    donationProvider.onAmountChange('');
                                    donationProvider.clearGenderAndAgedata();
                                    donationProvider.selectedPanjayathChip =
                                        null;
                                    donationProvider.chipsetWardList.clear();
                                    donationProvider.selectedWard = null;
                                    '1';
                                    donationProvider.minimumbool = true;
                                    donationProvider.clearDonateScreen();
                                    callNext(DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,
                                        subScriberType: widget.subScriberType,oneEquipmentPrice: '',
                                      paymentCategory: 'GENERAL',equipmentCount: '',equipmentID: '',
                                        loginUserID: widget.loginUserID,loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                      sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                      sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                      foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount, ), context);
                                  } else {
                                    callNext( NoPaymentGateway(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,
                                        loginUserID: widget.loginUserID,loginUsername: widget.loginUsername,
                                      zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                      sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                      sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                      foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                  }
                                });
                              },
                              child: Consumer<HomeProvider>(
                                  builder: (context, value, child) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding:const EdgeInsets.symmetric(horizontal:15),
                                      height:55,
                                      width:width,
                                      // color:Colors.blue,
                                      child: FittedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 6),
                                              child: Image.asset(
                                                'assets/indian_rupee.png',
                                                // height:15,
                                                scale: 2.7,
                                                color: myBlack,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 5),
                                              child: Text(
                                                getAmount(value.totalCollection),
                                                style: const TextStyle(
                                                  color: myBlack,
                                                  fontSize: 50,
                                                  fontFamily: 'ChangaOneRegular',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                // GoogleFonts.akshar(
                                                //     textStyle: whiteGoogle38)
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    const Text(
                                      'Total Amount Received for the month',
                                      style: TextStyle(
                                        color: cl3E4FA3,
                                        fontSize: 11,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        // height: 0.11,
                                      ),
                                    ),
                                    ///red container
                                    // InkWell(onTap:(){
                                    //   donationProvider. clearMultiplePaymentScreen();
                                    //   donationProvider.fetchEquipment(true);
                                    //   callNext(MultiplePaymentScreen(loginUserID: widget.loginUserID,
                                    //       loginUsername: widget.loginUsername,
                                    //   subScriberType: widget.subScriberType,
                                    //       loginUserPhone: widget.loginUserPhone,
                                    //     zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                    //     sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                    //     sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                    //     foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                    // },
                                    //     child: Container(height: 40,width: 200,color: Colors.red,))
                                  ],
                                );
                              }),
                            ),

                            //     Container(
                            //       decoration:const BoxDecoration(
                            //         color: myWhite,
                            //        // border:Border.all(color: Colors.white,width: 0.2),
                            //         ),
                            //       //  color: myRed,
                            //       //  height: 50,
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             Padding(
                            //          padding: const EdgeInsets.only(left: 20.0),
                            //         child: Text(
                            //           !Platform.isIOS?"Contribute":"Reports",
                            //           style: b_myContributiontx,
                            //         ),
                            //       ),
                            //       // SizedBox(
                            //       //   width: width * .5,
                            //       // ),
                            //       Padding(
                            //         padding: const EdgeInsets.only(right: 12.0),
                            //         child: InkWell(
                            //           onTap: (){
                            //             print("1254");
                            //
                            //             alertSupport(context);
                            //
                            //           },
                            //             child: Image.asset("assets/Helpline.png",scale: 3,)),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            ///height sizedbox
                            // const SizedBox(
                            //   height: 15,
                            // ),

                            ///support and how to pay
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     Container(
                            //       height: 38,
                            //       width: 163,
                            //       decoration: BoxDecoration(
                            //           color: Colors.white,
                            //           boxShadow: const [
                            //             BoxShadow(
                            //               color: Colors.grey,
                            //               blurRadius: 2
                            //             )
                            //           ],
                            //           borderRadius: BorderRadius.circular(19)
                            //       ),
                            //       child: InkWell(
                            //         onTap: (){
                            //           alertSupport(context);
                            //         },
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //           children: [
                            //             const Text("Support",
                            //               style: TextStyle(
                            //                 fontSize: 12,
                            //                 fontWeight: FontWeight.w400,
                            //                 fontFamily: "PoppinsMedium",
                            //               ),),
                            //             Row(
                            //               children: [
                            //                 const Icon(Icons.phone,size: 17,),
                            //                 SizedBox(width: 1,),
                            //                 Image.asset("assets/whatsapp.png",scale:3.6,),
                            //               ],
                            //             )
                            //
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //
                            //     InkWell(
                            //       onTap: (){
                            //         homeProvider.getVideo(context);
                            //       },
                            //       child: Row(
                            //         children: [
                            //           Padding(
                            //             padding: const EdgeInsets.only(left: 10.0,right: 2),
                            //             child: Image.asset("assets/youtube.png",scale: 2,),
                            //           ),
                            //           const Text("How to Pay?",
                            //             style: TextStyle(fontSize: 12,
                            //               fontWeight: FontWeight.w400,
                            //               fontFamily: "PoppinsMedium",
                            //             ),),
                            //         ],
                            //       ),
                            //     ),
                            //
                            //
                            //   ],
                            // ),

                            ///today topper
                            //  Padding(
                            //    padding: const EdgeInsets.only(top: 20.0,bottom: 8),
                            //    child: Container(
                            //    height: 100,
                            //      width: width,
                            //      decoration: const BoxDecoration(
                            //      color: clFFFFFF,
                            //        boxShadow: [
                            //          BoxShadow(
                            //            color: cl0x40CACACA,
                            //            blurRadius: 16
                            //          )
                            //        ]
                            //      ),
                            //      child: Row(
                            //        children: [
                            //          Padding(
                            //            padding: const EdgeInsets.only(left:12,bottom: 8,right: 8),
                            //            child: Image.asset("assets/todaysTopper.png",scale: 2.8,),
                            //          ),
                            //          Container(width: 1,color: clD4D4D4,margin: EdgeInsets.only(top: 12,bottom: 12),),
                            //          Consumer<DonationProvider>(
                            //            builder: (context,value,child) {
                            //              return SizedBox(
                            //                // color: Colors.yellow,
                            //                width: width/1.9,
                            //                child: Padding(
                            //                  padding: const EdgeInsets.only(left: 10.0),
                            //                  child: Column(
                            //                    mainAxisAlignment: MainAxisAlignment.center,
                            //                    crossAxisAlignment: CrossAxisAlignment.start,
                            //                    children: [
                            //                      SizedBox(height: 2,),
                            //                      SizedBox(
                            //                        width: width/2,
                            //                        // color: Colors.red,
                            //                        child: Text(
                            //                          value.todayTopperName,
                            //                          style: const TextStyle(
                            //                              height: 1.3,
                            //                              fontSize: 14,
                            //                              fontWeight: FontWeight.bold,
                            //                              fontFamily: "PoppinsMedium",
                            //                              color: clblue),
                            //                        ),
                            //                      ),
                            //                      SizedBox(height: 2,),
                            //                      value.todayTopperPlace != ""
                            //                          ? Text(
                            //                        value.todayTopperPlace,
                            //                        style: const TextStyle(
                            //                            height: 1.3,
                            //                            fontSize: 12,
                            //                            fontWeight: FontWeight.w400,
                            //                            fontFamily: "PoppinsMedium",
                            //                            color: cl6B6B6B),
                            //                      )
                            //                          : const SizedBox(),
                            //                      Row(
                            //                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //                        crossAxisAlignment: CrossAxisAlignment.center,
                            //                        children: [
                            //                          value.todayTopperPanchayath=="FAMILY CONTRIBUTION"?SizedBox():
                            //                          Text(
                            //                            value.todayTopperPanchayath,
                            //                            style: const TextStyle(
                            //                                height: 1.3,
                            //                                fontSize: 12,
                            //                                fontWeight: FontWeight.w400,
                            //                                fontFamily: "PoppinsMedium",
                            //                                color: cl6B6B6B
                            //                            ),
                            //                          ),
                            //                          Row(
                            //                            mainAxisAlignment: MainAxisAlignment.start,
                            //                            crossAxisAlignment: CrossAxisAlignment.start,
                            //                            children: [
                            //                              const Padding(
                            //                                padding: EdgeInsets.only(
                            //                                    right: 2),
                            //                                child: SizedBox(
                            //                                  height: 15,
                            //                                  child: Text(
                            //                                    "₹",
                            //                                    style: TextStyle(color: clblue,fontSize: 16),
                            //                                    // scale: 7,
                            //                                    // color: myBlack2,
                            //                                  ),
                            //                                ),
                            //                              ),
                            //                              AutoSizeText(
                            //                                getAmount(value.todayTopperAmount),
                            //                                style: const TextStyle(
                            //                                    fontWeight: FontWeight.w700,
                            //                                    fontFamily: "PoppinsMedium",
                            //                                    fontSize: 18,
                            //                                    color: clblue),
                            //                              )
                            //                            ],
                            //                          ),
                            //
                            //                          // AutoSizeText.rich(
                            //                          //   TextSpan(children: [
                            //                          //     const TextSpan(
                            //                          //         text: "₹ ",
                            //                          //         style: TextStyle(fontSize: 14,color: cl323A71)),
                            //                          //     TextSpan(
                            //                          //       text: getAmount(value.todayTopperAmount),
                            //                          //       style: const TextStyle(
                            //                          //           fontWeight: FontWeight.w700,
                            //                          //           fontFamily: "PoppinsMedium",
                            //                          //           fontSize: 18,
                            //                          //           color: cl323A71
                            //                          //       ),
                            //                          //     )
                            //                          //   ]),
                            //                          //   textAlign: TextAlign.center,
                            //                          //   minFontSize: 5,
                            //                          //   maxFontSize: 18,
                            //                          //   maxLines: 1,
                            //                          // ),
                            //                        ],
                            //                      ),
                            //                      SizedBox(width: 40,),
                            //
                            //                    ],
                            //                  ),
                            //                ),
                            //              );
                            //            }
                            //          ),
                            //        ],
                            //      ),
                            // ),
                            //  ),
                            
                          ])),

                      const SizedBox(height:20),

                      Stack(
                        children: [

                          Column(
                            children: [
                              const SizedBox(height:17),

                              Container( 
                                  padding:const EdgeInsets.fromLTRB(10, 15, 10, 15),
                                  width: width,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: myWhite,//myWhitemyWhite
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child:Column(
                                      children:[

                                        // const SizedBox(height:10),

                                        GridView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            padding: const EdgeInsets.all(10),
                                            shrinkWrap: true,
                                            itemCount:gridOneImg.length,
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 12,
                                                mainAxisExtent: 145
                                        ), itemBuilder: (BuildContext context,int index){
                                              return
                                            index!=5?
                                            InkWell(
                                                onTap: (){
                                                  donationProvider.clearDonateScreen();
                                                  if(index==0){
                                                    mRoot
                                                        .child('0')
                                                        .child('PaymentGateway36')
                                                        .onValue
                                                        .listen((event) {
                                                      if (event.snapshot.value.toString() == 'ON') {
                                                        DonationProvider donationProvider =
                                                        Provider.of<DonationProvider>(context,
                                                            listen: false);
                                                        donationProvider.amountTC.text = "";
                                                        donationProvider.nameTC.text = "";
                                                        donationProvider.phoneTC.text = "";
                                                        donationProvider.kpccAmountController.text = "";
                                                        donationProvider.onAmountChange('');
                                                        donationProvider.clearGenderAndAgedata();
                                                        donationProvider.selectedPanjayathChip = null;
                                                        donationProvider.chipsetWardList.clear();
                                                        donationProvider.selectedWard = null;
                                                        '1';
                                                        donationProvider.minimumbool = true;
                                                        donationProvider.clearDonateScreen();
                                                        callNext(DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,
                                                            subScriberType: widget.subScriberType,oneEquipmentPrice: '',
                                                            paymentCategory: 'GENERAL',equipmentCount: '',
                                                            equipmentID: '',loginUserID: widget.loginUserID,
                                                            loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                          sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                          sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                          foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                      } else {
                                                        callNext( NoPaymentGateway(loginUserPhone: widget.loginUserPhone,
                                                            subScriberType: widget.subScriberType,loginUserID: widget.loginUserID,
                                                            loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                          sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                          sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                          foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                      }
                                                    });

                                                  }
                                                  else if(index==1){
                                                    //zakat
                                                    mRoot
                                                        .child('0')
                                                        .child('PaymentGateway36')
                                                        .onValue
                                                        .listen((event) {
                                                      if (event.snapshot.value.toString() == 'ON') {
                                                        DonationProvider donationProvider =
                                                        Provider.of<DonationProvider>(context,
                                                            listen: false);
                                                        donationProvider.amountTC.text = "";
                                                        donationProvider.nameTC.text = "";
                                                        donationProvider.phoneTC.text = "";
                                                        donationProvider.kpccAmountController.text = "";
                                                        donationProvider.onAmountChange('');
                                                        donationProvider.clearGenderAndAgedata();
                                                        donationProvider.selectedPanjayathChip = null;
                                                        donationProvider.chipsetWardList.clear();
                                                        donationProvider.selectedWard = null;
                                                        '1';
                                                        donationProvider.minimumbool = true;
                                                        callNext(DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,
                                                            subScriberType: widget.subScriberType,paymentCategory: 'ZAKATH',
                                                            equipmentCount: '',equipmentID: '',
                                                            oneEquipmentPrice: '',loginUserID: widget.loginUserID,
                                                            loginUsername: widget.loginUsername,
                                                          zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                          sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                          sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                          foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                      } else {
                                                        callNext( NoPaymentGateway(loginUserPhone: widget.loginUserPhone,
                                                            subScriberType: widget.subScriberType,
                                                            loginUserID: widget.loginUserID,
                                                            loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                          sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                          sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                          foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                      }
                                                    });
                                                  }
                                                  else if(index==2){
                                                   donationProvider.clearSponsershipScreen();
                                                    //Patient Sponsorship
                                                    loginProvider.checkSponserAlreadyExist(context,widget.loginUserPhone,widget.loginUsername,widget.subScriberType,widget.loginUserID);
                                                  }
                                                  else if(index==3){
                                                    //Food kit sponsorship
                                                    donationProvider.clearUserFoodkitt();
                                                    callNext( UserFoodKitScreen(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,
                                                        loginUserID: widget.loginUserID,loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                      sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                      sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                      foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                  }
                                                  else if(index==4){
                                                    //Equipment sponsorship
                                                    donationProvider.fetchEquipment(true);
                                                    donationProvider.clearSelectedEquipments();
                                                    callNext(UserEquipmentListScreen(loginUserPhone: widget.loginUserPhone,
                                                        subScriberType: widget.subScriberType,paymentCategory: 'EQUIPMENT',
                                                        loginUserID: widget.loginUserID,loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                      sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                      sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                      foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                  }
                                                  else if(index==5){
                                                    //Members Payment
                                                    donationProvider.fetchSubsciberPayments(widget.loginUserID);
                                                    donationProvider.checkPendingPayments(widget.loginUserID);
                                                    callNext(SubscriptionPayments(loginUserPhone: widget.loginUserPhone,subScriberType:widget.subScriberType ,
                                                        loginUsername:widget.loginUsername ,loginUserID:widget.loginUserID, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                      sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                      sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                      foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                  }
                                                },
                                                child: Container(
                                                  // padding:const EdgeInsets.all(10),
                                                  decoration: ShapeDecoration(
                                                    color: myWhite,
                                                    shape: RoundedRectangleBorder(
                                                      side:  const BorderSide(
                                                        width: 0.10,
                                                        // strokeAlign: BorderSide.strokeAlignOutside,
                                                        color: myWhite,
                                                      ),
                                                      borderRadius: BorderRadius.circular(18),
                                                    ),
                                                    shadows: const [
                                                      BoxShadow(
                                                        color: Color(0x0A000000),
                                                        blurRadius: 1.15,
                                                        offset: Offset(0, 1),
                                                        spreadRadius: 0,
                                                      )
                                                    ],

                                                    // borderRadius: BorderRadius.circular(18),
                                                  //   gradient: LinearGradient(
                                                  //     begin: Alignment(0.00, -1.00),
                                                  //     end: Alignment(0, 1),
                                                  //     colors: [Color(0xFFAFBCFF), Colors.white],
                                                  // ),
                                                  ),
///
                                                    // clipBehavior: Clip.antiAlias,
                                                    // decoration: ShapeDecoration(
                                                    //   color: Colors.white,
                                                    //   shape: RoundedRectangleBorder(
                                                    //     borderRadius: BorderRadius.circular(18),
                                                    //   ),
                                                    //   shadows: [
                                                    //     BoxShadow(
                                                    //       color: Color(0x0A000000),
                                                    //       blurRadius: 5.15,
                                                    //       offset: Offset(0, 2.58),
                                                    //       spreadRadius: 0,
                                                    //     )
                                                    //   ],
                                                    // ),

                                                  child:Stack(
                                                    children:[

                                                      Align(
                                                        alignment:Alignment.topCenter,
                                                        child: Container(
                                                          margin: const EdgeInsets.only(top:13),
                                                          // color:Colors.green,
                                                          height:80,
                                                          width:80,
                                                          child:Image.asset(gridOneImg[index],
                                                          alignment: Alignment.center,
                                                          // height: 100,
                                                          scale: index==0?1:1,
                                                          )
                                                        ),
                                                      ),

                                                      Align(
                                                        alignment:Alignment.topCenter,
                                                        child:  Container(
                                                          width: width,
                                                          height: 30,
                                                          decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topRight:Radius.circular(18),
                                                              topLeft:Radius.circular(18),
                                                            ),
                                                            gradient: LinearGradient(
                                                              begin: Alignment.topCenter,//(0.00, -1.00)
                                                              end: Alignment.bottomCenter,//(0, 1)
                                                              colors: [Color(0xFFF6F7FF), Colors.white],
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      Align(
                                                        alignment:Alignment.bottomCenter,
                                                        child: Container(
                                                          margin:const EdgeInsets.only(bottom:12,right:4,left:4),
                                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                                          child: Text(gridOnetext[index],
                                                          textAlign: TextAlign.center,
                                                          style: const TextStyle(
                                                            color: myBlack,
                                                            fontSize: 12,
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w500,
                                                            // height: 0.10,
                                                          ),),
                                                        ),
                                                      )
                                                    ]
                                                  )
                                                ),
                                              ):
                                            index==5&&widget.subScriberType=='SUBSCRIBER'?InkWell(
                                              onTap: (){
                                                if(index==0){
                                                  mRoot
                                                      .child('0')
                                                      .child('PaymentGateway36')
                                                      .onValue
                                                      .listen((event) {
                                                    if (event.snapshot.value.toString() == 'ON') {
                                                      DonationProvider donationProvider =
                                                      Provider.of<DonationProvider>(context,
                                                          listen: false);
                                                      donationProvider.amountTC.text = "";
                                                      donationProvider.nameTC.text = "";
                                                      donationProvider.phoneTC.text = "";
                                                      donationProvider.kpccAmountController.text = "";
                                                      donationProvider.onAmountChange('');
                                                      donationProvider.clearGenderAndAgedata();
                                                      donationProvider.selectedPanjayathChip = null;
                                                      donationProvider.chipsetWardList.clear();
                                                      donationProvider.selectedWard = null;
                                                      '1';
                                                      donationProvider.minimumbool = true;
                                                      donationProvider.clearDonateScreen();
                                                      callNext(DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,
                                                        subScriberType: widget.subScriberType,oneEquipmentPrice: '',
                                                        paymentCategory: 'GENERAL',equipmentCount: '',
                                                        equipmentID: '',loginUserID: widget.loginUserID,
                                                        loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                        sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                        sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                        foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                    } else {
                                                      callNext( NoPaymentGateway(loginUserPhone: widget.loginUserPhone,
                                                        subScriberType: widget.subScriberType,loginUserID: widget.loginUserID,
                                                        loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                        sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                        sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                        foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                    }
                                                  });

                                                }
                                                else if(index==1){
                                                  //zakat
                                                  mRoot
                                                      .child('0')
                                                      .child('PaymentGateway36')
                                                      .onValue
                                                      .listen((event) {
                                                    if (event.snapshot.value.toString() == 'ON') {
                                                      DonationProvider donationProvider =
                                                      Provider.of<DonationProvider>(context,
                                                          listen: false);
                                                      donationProvider.amountTC.text = "";
                                                      donationProvider.nameTC.text = "";
                                                      donationProvider.phoneTC.text = "";
                                                      donationProvider.kpccAmountController.text = "";
                                                      donationProvider.onAmountChange('');
                                                      donationProvider.clearGenderAndAgedata();
                                                      donationProvider.selectedPanjayathChip = null;
                                                      donationProvider.chipsetWardList.clear();
                                                      donationProvider.selectedWard = null;
                                                      '1';
                                                      donationProvider.minimumbool = true;
                                                      callNext(DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,
                                                        subScriberType: widget.subScriberType,paymentCategory: 'ZAKATH',
                                                        equipmentCount: '',equipmentID: '',
                                                        oneEquipmentPrice: '',loginUserID: widget.loginUserID,
                                                        loginUsername: widget.loginUsername,
                                                        zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                        sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                        sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                        foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                    } else {
                                                      callNext( NoPaymentGateway(loginUserPhone: widget.loginUserPhone,
                                                        subScriberType: widget.subScriberType,
                                                        loginUserID: widget.loginUserID,
                                                        loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                        sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                        sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                        foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                    }
                                                  });
                                                }
                                                else if(index==2){
                                                  donationProvider.clearSponsershipScreen();
                                                  //Patient Sponsorship
                                                  loginProvider.checkSponserAlreadyExist(context,widget.loginUserPhone,widget.loginUsername,widget.subScriberType,widget.loginUserID);
                                                }
                                                else if(index==3){
                                                  //Food kit sponsorship
                                                  donationProvider.clearUserFoodkitt();
                                                  callNext( UserFoodKitScreen(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,
                                                    loginUserID: widget.loginUserID,loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                    sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                    sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                    foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                }
                                                else if(index==4){
                                                  //Equipment sponsorship
                                                  donationProvider.fetchEquipment(true);
                                                  callNext(UserEquipmentListScreen(loginUserPhone: widget.loginUserPhone,
                                                    subScriberType: widget.subScriberType,paymentCategory: 'EQUIPMENT',
                                                    loginUserID: widget.loginUserID,loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                    sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                    sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                    foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                }
                                                else if(index==5){
                                                  print('IHRUVHI');
                                                  //Members Payment
                                                  donationProvider.kpccAmountController.text='';
                                                  donationProvider.fetchSubsciberPayments(widget.loginUserID);
                                                  donationProvider.checkPendingPayments(widget.loginUserID);
                                                  callNext(SubscriptionPayments(loginUserPhone: widget.loginUserPhone,subScriberType:widget.subScriberType ,
                                                    loginUsername:widget.loginUsername ,loginUserID:widget.loginUserID, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                    sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                    sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                    foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                }
                                              },
                                              child: Container(
                                                  decoration: ShapeDecoration(
                                                    color: myWhite,
                                                    shape: RoundedRectangleBorder(
                                                      side:  const BorderSide(
                                                        width: 0.10,
                                                        // strokeAlign: BorderSide.strokeAlignOutside,
                                                        color: myWhite,
                                                      ),
                                                      borderRadius: BorderRadius.circular(18),
                                                    ),
                                                    shadows: const [
                                                      BoxShadow(
                                                        color: Color(0x0A000000),
                                                        blurRadius: 1.15,
                                                        offset: Offset(0, 1),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),

                                                  child:Stack(
                                                      children:[
                                                        Align(
                                                          alignment:Alignment.topCenter,
                                                          child: Container(
                                                              margin: const EdgeInsets.only(top:13),
                                                              // color:Colors.green,
                                                              height:80,
                                                              width:80,
                                                              child:Image.asset(gridOneImg[index],
                                                              )
                                                          ),
                                                        ),

                                                        Align(
                                                          alignment:Alignment.topCenter,
                                                          child:  Container(
                                                            width: width,
                                                            height: 30,
                                                            decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                topRight:Radius.circular(18),
                                                                topLeft:Radius.circular(18),
                                                              ),
                                                              gradient: LinearGradient(
                                                                begin: Alignment.topCenter,//(0.00, -1.00)
                                                                end: Alignment.bottomCenter,//(0, 1)
                                                                colors: [Color(0xFFF6F7FF), Colors.white],
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Align(
                                                          alignment:Alignment.bottomCenter,
                                                          child: Container(
                                                            margin:const EdgeInsets.only(bottom:12),
                                                            child: Text(gridOnetext[index],
                                                              textAlign: TextAlign.center,
                                                              style: const TextStyle(
                                                                color: myBlack,
                                                                fontSize: 12,
                                                                fontFamily: 'Poppins',
                                                                fontWeight: FontWeight.w500,
                                                                // height: 0.10,
                                                              ),),
                                                          ),
                                                        )
                                                      ]
                                                  )
                                              ),
                                            ):const SizedBox();
                                        }),

                                        const SizedBox(height:20),

                                        ///Food kit Sponsorship
                                        Container(
                                          margin:const EdgeInsets.symmetric(horizontal:5),
                                          // height:100,
                                          padding: const EdgeInsets.all(15),
                                          width: MediaQuery.of(context).size.width,
                                          // margin: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage("assets/carouselBg1.png"),
                                              fit: BoxFit.cover,
                                            ),
                                            // color: Colors.yellow,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Column(
                                            // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.centerRight,
                                                  height: 30,
                                                  width: width,
                                                  child: const SizedBox(
                                                      height: 30,
                                                      width: 30,
                                                      child: Image(
                                                          image: AssetImage(
                                                              "assets/qmchBg.png"))),
                                                ),
                                                const SizedBox(height: 25),
                                                const Text(
                                                  'Food kit Sponsorship',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: myWhite,
                                                    fontSize: 20,
                                                    fontFamily: 'JaldiBold',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0.03,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                const Text(
                                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                                      'Ut viverra sapien in est porta, vel cursus urna rutrum.',
                                                  style: TextStyle(
                                                    color: myWhite,
                                                    fontSize: 11,
                                                    fontFamily: 'JaldiBold',
                                                    fontWeight: FontWeight.w400,
                                                    height: 1,
                                                  ),
                                                ),
                                              ]),
                                          // child: ClipRRect(
                                          //   borderRadius: BorderRadius.circular(30),
                                          //   child: Image.asset(image, fit: BoxFit.fill),
                                          // ),
                                        ),

                                        const SizedBox(height:5),

                                        ///2items container
                                        GridView.builder(
                                            padding: const EdgeInsets.all(10),
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:gridTwoImg.length,
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 12,
                                              childAspectRatio: 1.2,
                                              crossAxisSpacing: 12,
                                            ), itemBuilder: (BuildContext context,int index){

                                          return Consumer<HomeProvider>(
                                              builder: (context,value2,child) {
                                              return InkWell(
                                                onTap: (){
                                                  if(index==0){
                                                      HomeProvider homeProvider =
                                                      Provider.of<HomeProvider>(context, listen: false);
                                                      LoginProvider loginProvider =
                                                      Provider.of<LoginProvider>(context, listen: false);
                                                      loginProvider.clearForm();
                                                      if(widget.loginUserPhone!=''){
                                                        if(value2.voulenteerStatus=='PENDING'){
                                                          VoulenteerNotApprovedAlert(context,value2.voulenteerID,value2.voulenteerName,value2.voulenteerStatus);
                                                        }else if(value2.voulenteerStatus=='APPROVED'){
                                                          homeProvider.getEnrollerPayments(widget.loginUserPhone);
                                                          callNext(EnrollerPaymentsScreen(loginUserPhone: widget.loginUserPhone,subScriberType:widget.subScriberType ,
                                                            loginUsername:widget.loginUsername ,loginUserID:widget.loginUserID,
                                                            zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                            sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                            sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                            foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                        }else if(widget.subScriberType!=''){
                                                          sendVoulenteerRequest(context,widget.loginUsername,widget.loginUserID,widget.subScriberType,widget.loginUserPhone);
                                                          /// alert to send request for general logined persons to becom a voulenteer
                                                        }
                                                      }else{
                                                        LoginProvider loginProvider =
                                                        Provider.of<LoginProvider>(context, listen: false);
                                                        homeProvider.clearEnrollerData();
                                                        callNext(UserRegistrationScreen(from: 'VOLUNTEER'), context);
                                                        // callNext(BeAnEnroller(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,loginUserID: widget.loginUserID,loginUsername:widget.loginUsername), context);
                                                      }
                                                      // await homeProvider.checkEnrollerDeviceID();
                                                      // if (value2.enrollerDeviceID) {
                                                      //   deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                                      // } else {
                                                      //   homeProvider.clearEnrollerData();
                                                      //   callNext(BeAnEnroller(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,loginUserID: widget.loginUserID,loginUsername:widget.loginUsername), context);
                                                      // }
                                                  }
                                                  else if(index==1){
                                                    donationProvider. clearMultiplePaymentScreen();
                                                    donationProvider.clearSelections();
                                                    if(widget.loginUserID!=''&&widget.loginUserID!='null'){
                                                      donationProvider.checkPendingPayments(widget.loginUserID);
                                                    }
                                                              donationProvider.fetchEquipment(true);
                                                              callNext(MultiplePaymentScreen(loginUserID: widget.loginUserID,
                                                                  loginUsername: widget.loginUsername,
                                                              subScriberType: widget.subScriberType,
                                                                  loginUserPhone: widget.loginUserPhone,
                                                                zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                                sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                                sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                                foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);                                                  }
                                                },
                                                child: Container(
                                                  height: 10,
                                                   decoration:ShapeDecoration(
                                                     // color: Colors.blue,


                                                     color: myWhite,
                                                     shape: RoundedRectangleBorder(
                                                       side:  const BorderSide(
                                                         width: 0.10,
                                                         // strokeAlign: BorderSide.strokeAlignOutside,
                                                         color: myWhite,
                                                       ),
                                                       borderRadius: BorderRadius.circular(18),
                                                     ),
                                                     shadows: const [
                                                       BoxShadow(
                                                         color: Color(0x0A000000),
                                                         blurRadius: 1.15,
                                                         offset: Offset(0, 1),
                                                         spreadRadius: 0,
                                                       )
                                                     ],
                                                   ),
                                                    child:Stack(
                                                        children:[

                                                          Align(
                                                            alignment:Alignment.topCenter,
                                                            child:  Container(
                                                              width: width,
                                                              height: 30,
                                                              decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                  topRight:Radius.circular(18),
                                                                  topLeft:Radius.circular(18),
                                                                ),
                                                                gradient: LinearGradient(
                                                                  begin: Alignment.topCenter,//(0.00, -1.00)
                                                                  end: Alignment.bottomCenter,//(0, 1)
                                                                  colors: [Color(0xFFF6F7FF), Colors.white],
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          Align(
                                                            alignment:Alignment.topLeft,
                                                            child: Consumer<HomeProvider>(
                                                                builder: (context,value,child) {
                                                        return index==0
                                                            ? Container(
                                                          alignment: Alignment.center,
                                                            width: 106,
                                                            height: 23,
                                                            padding: const EdgeInsets.only(left: 10, right: 10,),
                                                            clipBehavior: Clip.antiAlias,
                                                            decoration: const ShapeDecoration(
                                                              gradient: LinearGradient(
                                                                begin: Alignment(-1.00, -0.00),
                                                                end: Alignment(1, 0),
                                                                colors: [cl3E4FA3,cl253068],
                                                              ),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.only(
                                                                    bottomRight: Radius.circular(18),
                                                                    topLeft: Radius.circular(18),
                                                                ),
                                                              ),
                                                            ),
                                                            child: FittedBox(
                                                              child: Text(
                                                              value.voulenteerStatus==''?'Join Now':
                                                              value.voulenteerStatus=='PENDING'?'PENDING':
                                                              value.voulenteerStatus=='APPROVED'?'TRANSACTIONS': value.voulenteerStatus
                                                                ,
                                                                style: const TextStyle(
                                                                  color: myWhite,
                                                                  fontSize: 14,
                                                                  fontFamily: 'Poppins',
                                                                  fontWeight: FontWeight.w600,
                                                                  // height: 0.08,
                                                                ),
                                                              ),
                                                            ),
                                                        )
                                                        :const SizedBox(height: 23,);
                                                      }
                                                    ),
                                                          ),

                                                          Align(
                                                            alignment:Alignment.topCenter,
                                                            child: Container(
                                                                margin: const EdgeInsets.only(top:30),
                                                                // color:Colors.green,
                                                                height:50,
                                                                width:75,
                                                                child:Image.asset(gridTwoImg[index],
                                                                  scale: index==0?2.9:0.5,
                                                                )
                                                            ),
                                                          ),

                                                          Align(
                                                            alignment:Alignment.center,
                                                            child: Container(
                                                              margin:const EdgeInsets.only(top:70),
                                                              child: Text(gridTwotext[index],
                                                                textAlign: TextAlign.center,
                                                                style: const TextStyle(
                                                                  color: myBlack,
                                                                  fontSize: 12,
                                                                  fontFamily: 'Poppins',

                                                                  fontWeight: FontWeight.w500,
                                                                  // height: 0.10,
                                                                ),),
                                                            ),
                                                          )
                                                        ]
                                                    )
                                                ),
                                              );
                                            }
                                          );
                                        }),

                                        const SizedBox(height:5),

                                        ///Be a Volunteer
                                        // Consumer<HomeProvider>(
                                        //     builder: (context,value2,child) {
                                        //     return InkWell(onTap: ()async{
                                        //       //Be a Volunteer
                                        //       //Volunteer Registration
                                        //
                                        //
                                        //       // await homeProvider.checkEnrollerDeviceID();
                                        //       // if (value2.enrollerDeviceID) {
                                        //       //   deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                        //       // } else {
                                        //       //   homeProvider.clearEnrollerData();
                                        //       //   callNext(BeAnEnroller(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,loginUserID: widget.loginUserID,loginUsername:widget.loginUsername), context);
                                        //       // }
                                        //     },
                                        //       child: Container(
                                        //           padding: const EdgeInsets.all(8),
                                        //           clipBehavior: Clip.antiAlias,
                                        //           decoration: ShapeDecoration(
                                        //             color: myWhite,
                                        //             shape: RoundedRectangleBorder(
                                        //               side: const BorderSide(
                                        //                 width: 0.20,
                                        //                 strokeAlign: BorderSide.strokeAlignOutside,
                                        //                 color: clCACACA,
                                        //               ),
                                        //               borderRadius: BorderRadius.circular(18),
                                        //             ),
                                        //             shadows: const [
                                        //               BoxShadow(
                                        //                 color: Color(0x0A000000),
                                        //                 blurRadius: 5.15,
                                        //                 offset: Offset(0, 2.58),
                                        //                 spreadRadius: 0,
                                        //               )
                                        //             ],
                                        //           ),
                                        //           child: Column(children: [
                                        //             Row(children: [
                                        //               Container(
                                        //                 width: 58,
                                        //                 height: 58,
                                        //                 padding: const EdgeInsets.all(3),
                                        //                 clipBehavior: Clip.antiAlias,
                                        //                 decoration: ShapeDecoration(
                                        //                     color: myWhite,
                                        //                     shape: RoundedRectangleBorder(
                                        //                       borderRadius:
                                        //                       BorderRadius.circular(8.83),
                                        //                     ),
                                        //                     image: const DecorationImage(
                                        //                         image: AssetImage(
                                        //                             "assets/Volunteer RegistrationImg.png"),
                                        //                     scale: 3.2
                                        //                     )),
                                        //               ),
                                        //               const SizedBox(width: 10),
                                        //               Flexible(
                                        //                   fit: FlexFit.tight,
                                        //                   child: Column(
                                        //                       mainAxisAlignment:
                                        //                       MainAxisAlignment.start,
                                        //                       crossAxisAlignment:
                                        //                       CrossAxisAlignment.start,
                                        //                       children: const [
                                        //                         Text(
                                        //                           'Be a Volunteer',
                                        //                           style: TextStyle(
                                        //                             color: cl3E4FA3,
                                        //                             fontSize: 14,
                                        //                             fontFamily: 'JaldiBold',
                                        //                             fontWeight: FontWeight.w400,
                                        //                             // height: 0.06,
                                        //                           ),
                                        //                         ),
                                        //                         Text(
                                        //                           'Join our mission, lend your heart. Register as a volunteer today.',
                                        //                           style: TextStyle(
                                        //                             color: myBlack,
                                        //                             fontSize: 11,
                                        //                             fontFamily: 'Poppins',
                                        //                             fontWeight: FontWeight.w400,
                                        //                             // height: 0.11,
                                        //                           ),
                                        //                         ),
                                        //                       ]))
                                        //             ]),
                                        //
                                        //             const SizedBox(height: 10),
                                        //
                                        //             ///Join now
                                        //             InkWell(onTap: ()  {
                                        //             },
                                        //               child: SizedBox(
                                        //                 width: width,
                                        //                 height: 36,
                                        //                 // color: Colors.green,
                                        //                 child: Stack(
                                        //                   children: [
                                        //                     Align(
                                        //                       alignment: Alignment.centerLeft,
                                        //                       child: Container(
                                        //                           width: width * .80,
                                        //                           height: 5,
                                        //                           decoration: const BoxDecoration(
                                        //                               color: cl3E4FA3,
                                        //                               borderRadius:
                                        //                               BorderRadius.only(
                                        //                                 topLeft:
                                        //                                 Radius.circular(10),
                                        //                                 bottomLeft:
                                        //                                 Radius.circular(10),
                                        //                               ))),
                                        //                     ),
                                        //                     Align(
                                        //                       alignment: Alignment.centerRight,
                                        //                       child: InkWell(
                                        //                         onTap: () async {
                                        //                           HomeProvider homeProvider =
                                        //                           Provider.of<HomeProvider>(context, listen: false);
                                        //                           LoginProvider loginProvider =
                                        //                           Provider.of<LoginProvider>(context, listen: false);
                                        //                           loginProvider.clearForm();
                                        //                           if(widget.loginUserPhone!=''){
                                        //                             if(value2.voulenteerStatus=='PENDING'){
                                        //                               VoulenteerNotApprovedAlert(context,value2.voulenteerID,value2.voulenteerName,value2.voulenteerStatus);
                                        //                             }else if(value2.voulenteerStatus=='APPROVED'){
                                        //                               homeProvider.getEnrollerPayments(widget.loginUserPhone);
                                        //                               callNext(EnrollerPaymentsScreen(loginUserPhone: widget.loginUserPhone,subScriberType:widget.subScriberType ,
                                        //                                   loginUsername:widget.loginUsername ,loginUserID:widget.loginUserID,
                                        //                                 zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                        //                                 sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                        //                                 sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                        //                                 foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                        //                             }else if(widget.subScriberType!=''){
                                        //                               sendVoulenteerRequest(context,widget.loginUsername,widget.loginUserID,widget.subScriberType,widget.loginUserPhone);
                                        //                               /// alert to send request for general logined persons to becom a voulenteer
                                        //                             }
                                        //                           }else{
                                        //                             LoginProvider loginProvider =
                                        //                             Provider.of<LoginProvider>(context, listen: false);
                                        //                             homeProvider.clearEnrollerData();
                                        //                             callNext(UserRegistrationScreen(from: 'VOLUNTEER'), context);
                                        //                               // callNext(BeAnEnroller(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,loginUserID: widget.loginUserID,loginUsername:widget.loginUsername), context);
                                        //                           }
                                        //
                                        //
                                        //                           // await homeProvider.checkEnrollerDeviceID();
                                        //                           // if (value2.enrollerDeviceID) {
                                        //                           //   deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                        //                           // } else {
                                        //                           //   homeProvider.clearEnrollerData();
                                        //                           //   callNext(BeAnEnroller(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,loginUserID: widget.loginUserID,loginUsername:widget.loginUsername), context);
                                        //                           // }
                                        //                         },
                                        //                         child: Container(
                                        //                           alignment: Alignment.center,
                                        //                           width: 154,
                                        //                           height: 36,
                                        //                           padding:
                                        //                           const EdgeInsets.symmetric(
                                        //                               horizontal: 10),
                                        //                           clipBehavior: Clip.antiAlias,
                                        //                           decoration: ShapeDecoration(
                                        //                             gradient: const LinearGradient(
                                        //                               begin:
                                        //                               Alignment(-1.00, -0.00),
                                        //                               end: Alignment(1, 0),
                                        //                               colors: [cl3E4FA3, cl253068],
                                        //                             ),
                                        //                             shape: RoundedRectangleBorder(
                                        //                               borderRadius:
                                        //                               BorderRadius.circular(34),
                                        //                             ),
                                        //                           ),
                                        //                           child: Consumer<HomeProvider>(
                                        //                             builder: (context,value,child) {
                                        //                               return  Text(
                                        //                                 value.voulenteerStatus==''?'Join Now':
                                        //                                 value.voulenteerStatus=='PENDING'?'PENDING':
                                        //                                 value.voulenteerStatus=='APPROVED'?'TRANSACTIONS': value.voulenteerStatus
                                        //                                 ,
                                        //                                 style: const TextStyle(
                                        //                                   color: myWhite,
                                        //                                   fontSize: 14,
                                        //                                   fontFamily: 'Poppins',
                                        //                                   fontWeight: FontWeight.w600,
                                        //                                   // height: 0.08,
                                        //                                 ),
                                        //                               );
                                        //                             }
                                        //                           ),
                                        //                         ),
                                        //                       ),
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //             )
                                        //           ])),
                                        //     );
                                        //   }
                                        // ),
                                        //
                                        // const SizedBox(height:20),


                                        Container(
                                          // height: 150,
                                          padding: const EdgeInsets.symmetric(horizontal:10,),
                                          // color: Colors.green,
                                          // color:myWhite,
                                          child: GridView.builder(
                                              physics: const ScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  mainAxisSpacing: 0,
                                                  crossAxisSpacing: 13,
                                                  crossAxisCount: 3,
                                                  childAspectRatio: 1.5
                                              ),
                                              itemCount: contriImg.length,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                return Consumer<HomeProvider>(
                                                    builder: (context, value2, child) {
                                                      return InkWell(
                                                        onTap: () async {
                                                          if(index==0){
                                                            if (!kIsWeb) {
                                                              PackageInfo packageInfo =
                                                              await PackageInfo
                                                                  .fromPlatform();
                                                              String packageName =
                                                                  packageInfo.packageName;
                                                              if (packageName !=
                                                                  'com.spine.quaide_millatMonitor' &&
                                                                  packageName != 'com.spine.dhotiTv') {
                                                                print("ifconditionwork");
                                                                homeProvider.searchEt.text =
                                                                "";
                                                                homeProvider.currentLimit =
                                                                50;
                                                                homeProvider
                                                                    .fetchReceiptList(50);
                                                                callNext(
                                                                    ReceiptListPage(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,
                                                                        from: "home",
                                                                        total: '',
                                                                        ward: '',
                                                                        panchayath: '',
                                                                        district: '',
                                                                        target: '',
                                                                        loginUserID: widget.loginUserID,loginUsername: widget.loginUsername,
                                                                      zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                                      sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                                      sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                                      foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,
                                                                    ),
                                                                    context);
                                                              } else {
                                                                homeProvider.currentLimit =
                                                                50;
                                                                homeProvider
                                                                    .fetchReceiptListForMonitorApp(
                                                                    50);
                                                                callNext(
                                                                    ReceiptListMonitorScreen(loginUserPhone: widget.loginUserPhone,
                                                                      subScriberType: widget.subScriberType,loginUserID: widget.loginUserID,
                                                                      loginUsername: widget.loginUsername,zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                                      sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                                      sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                                      foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,),
                                                                    context);

                                                                // homeProvider.fetchPaymentReceiptList();
                                                              }
                                                            } else {
                                                              homeProvider.searchEt.text = "";
                                                              homeProvider.currentLimit = 50;
                                                              homeProvider
                                                                  .fetchReceiptList(50);
                                                              callNext(
                                                                  ReceiptListPage(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,
                                                                      from: "home",
                                                                      total: '',
                                                                      ward: '',
                                                                      panchayath: '',
                                                                      district: '',
                                                                      target: '',
                                                                      loginUserID: widget.loginUserID,loginUsername: widget.loginUsername,
                                                                    zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                                    sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                                    sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                                    foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,
                                                                  ),
                                                                  context);
                                                            }
                                                          }else if(index==1){
                                                            if(widget.loginUserPhone!=''){
                                                              homeProvider.fetchHistoryWithMobileNo(widget.loginUserPhone);
                                                            }else{
                                                              homeProvider
                                                                  .fetchHistoryFromFireStore();
                                                            }
                                                            callNext(
                                                                PaymentHistory(loginUserPhone: widget.loginUserPhone,
                                                                    subScriberType: widget.subScriberType,
                                                                    loginUserID: widget.loginUserID,loginUsername: widget.loginUsername,
                                                                  zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                                  sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                                  sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                                  foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                                          }
                                                          ///
//                                                 if (index == 2) {
//                                                   homeProvider.selectedDistrict =
//                                                       null;
//                                                   homeProvider.selectedPanjayath =
//                                                       null;
//                                                   homeProvider.selectedUnit = null;
//                                                   homeProvider.panchayathTarget =
//                                                       0.0;
//                                                   homeProvider
//                                                       .panchayathPosterPanchayath = "";
//                                                   homeProvider
//                                                       .panchayathPosterAssembly = "";
//                                                   homeProvider
//                                                       .panchayathPosterDistrict = "";
//                                                   homeProvider
//                                                           .panchayathPosterComplete =
//                                                       false;
//                                                   homeProvider
//                                                           .panchayathPosterNotCompleteComplete =
//                                                       false;
//                                                   homeProvider.fetchDropdown(
//                                                       '', '');
//                                                   homeProvider.fetchWard();
//                                                   callNext(WardHistory(), context);
//                                                 }
//                                                 else if (index == 6) {
//                                                   if (!kIsWeb) {
//                                                     PackageInfo packageInfo =
//                                                         await PackageInfo
//                                                             .fromPlatform();
//                                                     String packageName =
//                                                         packageInfo.packageName;
//                                                     if (packageName !=
//                                                             'com.spine.quaide_millatMonitor' &&
//                                                         packageName !=
//                                                             'com.spine.dhotiTv') {
//                                                       print("ifconditionwork");
//                                                       homeProvider.searchEt.text =
//                                                           "";
//                                                       homeProvider.currentLimit =
//                                                           50;
//                                                       homeProvider
//                                                           .fetchReceiptList(50);
//                                                       callNext(
//                                                           ReceiptListPage(
//                                                             from: "home",
//                                                             total: '',
//                                                             ward: '',
//                                                             panchayath: '',
//                                                             district: '',
//                                                             target: '',
//                                                           ),
//                                                           context);
//                                                     } else {
//                                                       homeProvider.currentLimit =
//                                                           50;
//                                                       homeProvider
//                                                           .fetchReceiptListForMonitorApp(
//                                                               50);
//                                                       callNext(
//                                                           ReceiptListMonitorScreen(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,),
//                                                           context);
//
//                                                       // homeProvider.fetchPaymentReceiptList();
//                                                     }
//                                                   } else {
//                                                     homeProvider.searchEt.text = "";
//                                                     homeProvider.currentLimit = 50;
//                                                     homeProvider
//                                                         .fetchReceiptList(50);
//                                                     callNext(
//                                                         ReceiptListPage(
//                                                           from: "home",
//                                                           total: '',
//                                                           ward: '',
//                                                           panchayath: '',
//                                                           district: '',
//                                                           target: '',
//                                                         ),
//                                                         context);
//                                                   }
//                                                 }
//                                                 else if (index == 7) {
//                                                   homeProvider
//                                                       .fetchHistoryFromFireStore();
//                                                   callNext(
//                                                       PaymentHistory(), context);
//                                                 }
//                                                 else if (index == 0) {
//                                                   homeProvider.getTopEnrollers();
//                                                   callNext(
//                                                       const TopEnrollersScreen(),
//                                                       context);
//                                                 }
//                                                 else if (index == 3) {
//                                                   homeProvider.topLeadPayments();
//                                                   callNext(LeadReport(), context);
//                                                 }
//                                                 else if (index == 1) {
//                                                   // callNext( DistrictReport(from: '',), context);
//                                                   callNext(
//                                                       ToppersHomeScreen(), context);
//                                                   homeProvider.fetchTopWardReport();
//                                                 }
//                                                 else if (index == 4) {
//                                                   print("device click here");
//                                                   HomeProvider homeProvider =
//                                                       Provider.of<HomeProvider>(
//                                                           context,
//                                                           listen: false);
//                                                   await homeProvider
//                                                       .checkEnrollerDeviceID();
//                                                   if (value2.enrollerDeviceID) {
//                                                     print("deviceid already exixt");
//                                                     deviceIdAlreadyExistAlert(
//                                                         context,
//                                                         value2.EnrollerID,
//                                                         value2.EnrollerName);
//                                                   } else {
//                                                     homeProvider
//                                                         .clearEnrollerData();
//                                                     callNext(
//                                                         BeAnEnroller(), context);
//                                                   }
//                                                 }
//                                                 else if (index == 5) {
//                                                   print("clikk22334");
//                                                   homeProvider
//                                                       .clearEnrollerDetails();
//                                                   callNext(
//                                                       const EnrollerPaymentsScreen(),
//                                                       context);
//                                                 }
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Align(
                                                              alignment:Alignment.bottomCenter,
                                                              child:  Container(
                                                                  padding:
                                                                  const EdgeInsets.symmetric(
                                                                      horizontal: 8),
                                                                  alignment: Alignment.center,
                                                                  height: 47,
                                                                  decoration: ShapeDecoration(
                                                                    color: myWhite,
                                                                    shape: RoundedRectangleBorder(
                                                                      side: const BorderSide(
                                                                        width: 0.05,
                                                                        color: clCACACA,
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(18),
                                                                    ),
                                                                    shadows: const [
                                                                      BoxShadow(
                                                                        color: Color(0x0A000000),
                                                                        blurRadius: 1.15,
                                                                        offset: Offset(0, 2.58),
                                                                        spreadRadius: 0,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  child: Container(
                                                                      alignment:
                                                                      Alignment.center,
                                                                      // width: width,
                                                                      height: 35,
                                                                      // color:Colors.yellow,
                                                                      child: Text(
                                                                        contriText[index],
                                                                        textAlign:
                                                                        TextAlign.center,
                                                                        style: const TextStyle(
                                                                            color: cl3E4FA3,
                                                                            fontFamily:
                                                                            "Poppins",
                                                                            fontSize: 11,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w600),
                                                                        overflow:
                                                                        TextOverflow.fade,
                                                                      ))),
                                                            ),

                                                            Align(
                                                                alignment:Alignment.topCenter,
                                                              child: Container(
                                                                  // margin: const EdgeInsets.only(bottom:3),
                                                                  width: 30,
                                                                  height: 30,
                                                                  decoration: const BoxDecoration(
                                                                    gradient: SweepGradient(
                                                                      colors: [cl3E4FA3, cl253068],
                                                                      startAngle: 1,
                                                                      endAngle: 3,
                                                                      tileMode: TileMode.mirror,
                                                                    ),
                                                                    shape:BoxShape.circle,
                                                                  ),
                                                                  child: Image.asset(
                                                                    contriImg[index],
                                                                    scale: 3,color: myWhite,)
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              }),
                                        ),

                                        const SizedBox(height:20),

                                        ///Contribution
                                        Container(
                                            padding: const EdgeInsets.all(8),
                                            // height: 190,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: clF5F5F5,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(7)),
                                            ),
                                            child: Column(
                                                children: [
                                              const Text(
                                                'General Contribution',
                                                style: TextStyle(
                                                  color: myBlack,
                                                  fontSize: 14,
                                                  fontFamily: 'JaldiBold',
                                                  fontWeight: FontWeight.w400,
                                                  // height: 0.06,
                                                ),
                                              ),

                                              const Text(
                                                'consectetur adipiscing elit. Ut viverra sapien in est porta, vel cursus urna rutrum.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: cl5C5C5C,
                                                  fontSize: 11,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  // height: 0.11,
                                                ),
                                              ),

                                              const SizedBox(height: 5),

                                              ///1000,2000,5000 amounts list
                                              amount.isEmpty
                                                  ? const SizedBox()
                                                  : SizedBox(
                                                height: 60,
                                                child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    shrinkWrap: true,
                                                    physics:
                                                    const ScrollPhysics(),
                                                    itemCount: amount.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                        int index) {
                                                      return Center(
                                                        child: InkWell(
                                                          onTap: () {
                                                            donationProvider
                                                                .kpccAmountController
                                                                .text = amount[
                                                            index]
                                                                .toString();

                                                            donationProvider
                                                                .nameTC.text = "";
                                                            donationProvider
                                                                .phoneTC.text = "";
                                                            donationProvider
                                                                .clearGenderAndAgedata();
                                                            donationProvider
                                                                .selectedPanjayathChip =
                                                            null;
                                                            donationProvider
                                                                .chipsetWardList
                                                                .clear();
                                                            donationProvider
                                                                .selectedWard = null;
                                                            donationProvider
                                                                .minimumbool = false;
                                                            donationProvider.clearDonateScreen();
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,oneEquipmentPrice: '',
                                                                            paymentCategory: 'GENERAL',
                                                                            equipmentCount: '',equipmentID: '',
                                                                            loginUserID: widget.loginUserID,
                                                                            loginUsername: widget.loginUsername,
                                                                          zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                                          sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                                          sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                                          foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,)));
                                                          },
                                                          child: Container(
                                                              margin: const EdgeInsets
                                                                  .only(
                                                                  left: 3, right: 10),
                                                              padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 13),
                                                              height: 35,
                                                              decoration:
                                                              ShapeDecoration(
                                                                color: myWhite,
                                                                shape:
                                                                RoundedRectangleBorder(
                                                                  side: const BorderSide(
                                                                      width: 0.20,
                                                                      color:
                                                                      cl26316A),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      50),
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  const Text("₹ ",
                                                                      style: TextStyle(
                                                                          color:
                                                                          clblue,
                                                                          fontSize:
                                                                          14,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500)),
                                                                  Text(
                                                                      '${amount[index]}',
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                          "PoppinsMedium",
                                                                          color:
                                                                          clblue,
                                                                          fontSize:
                                                                          15,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                                ],
                                                              )),
                                                        ),
                                                      );
                                                    }),
                                              ),

                                              const SizedBox(height: 5),
                                            ])),

                                        ///Privacy,terms and,aboun us

                                          const SizedBox(height: 20),

                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 10, 10,0),
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: 3,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics:const NeverScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context, int index) {
                                              return InkWell(
                                                onTap:(){
                                                  if(index==1){
                                                    alertTermsAndConditions(context);
                                                  }else if(index==2){
                                                    alertContact(context);
                                                  }else if(index==0){
                                                    alertTerm(context);

                                                  }

                                                },
                                                child: ListTile(
                                                  leading:SizedBox(
                                                    height:15,
                                                    width:15,
                                                    child:index==0?
                                                        const Icon(Icons.gpp_maybe_outlined,color:cl253068):
                                                        index==1?
                                                        const Icon(Icons.handyman,color:cl253068)
                                                          :const Icon(Icons.wifi_tethering_sharp,color:cl253068)
                                                  ),

                                                  title: Text(
                                                    PTCText[index],
                                                    style: const TextStyle(
                                                        color: myBlack,
                                                        fontSize: 11,
                                                        fontFamily: "Lato",
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                  trailing:const Icon(Icons.keyboard_arrow_right_outlined)
                                                ),
                                              );
                                            },
                                          ),
                                        ),


                                        const SizedBox(height: 20),


                                        const SizedBox(height: 70),
                                      ]
                                  )
                              ),
                            ],
                          ),

                          Align(
                            alignment:Alignment.center,
                            child: InkWell(
                              onTap:(){
                                alertSupport(context);
                              },
                              child: Container(
                                  padding:const EdgeInsets.all(5),
                                  width: 115,
                                  height: 30,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: myWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 3),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/callIcon.png",scale:3,color:cl373E79),
                                        const SizedBox(width:3),
                                        Image.asset("assets/whatsapp.png",scale:5,color:cl373E79),
                                        const SizedBox(width:3),
                                        const Text(
                                          'Helpline',
                                          style: TextStyle(
                                            color: cl373E79,
                                            fontSize: 10,
                                            fontFamily: 'MontserratMedium',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                      ])),
                            ),
                          ),
                        ],
                      ),

                    ]),
                  ]),

                  // SingleChildScrollView(
                  //     physics: const ScrollPhysics(),
                  //     child: Column(
                  //         children: [
                  //       Container(
                  //           padding: const EdgeInsets.symmetric(horizontal: 10),
                  //           decoration: const BoxDecoration(
                  //               image: DecorationImage(
                  //             image: AssetImage("assets/homeTopBg.png"),
                  //             fit: BoxFit.cover,
                  //           )),
                  //           child: Column(
                  //           children: [



                        ///version
                        // Consumer<HomeProvider>(
                        //     builder: (context, value, child) {
                        //   print("aaaaaaaaaaaaaaaa" + value.buildNumber);
                        //   return Container(
                        //     // color: myWhite,
                        //     child: Align(
                        //         alignment: Alignment.center,
                        //         child: Text(
                        //           "Version:${value.appVersion}.${value.buildNumber}.${value.currentVersion}",
                        //           style: const TextStyle(
                        //               fontWeight: FontWeight.bold, fontSize: 8),
                        //         )),
                        //   );
                        // }),
                      // ]
                      // )
                  // ),
                ),
              ),

              ///old body singlechid ,dont remove it
              ///

              ///floating action button
              floatingActionButton:
                  Consumer<HomeProvider>(builder: (context, value, child) {
                return
                  ((kIsWeb ||
                            Platform.isAndroid ||
                            value.iosPaymentGateway == 'ON') &&
                        !Platform.isIOS)
                    ? Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 2),
                        child: InkWell(
                          onTap: () {
                            mRoot
                                .child('0')
                                .child('PaymentGateway36')
                                .onValue
                                .listen((event) {
                              if (event.snapshot.value.toString() == 'ON') {
                                DonationProvider donationProvider =
                                    Provider.of<DonationProvider>(context,
                                        listen: false);
                                donationProvider.amountTC.text = "";
                                donationProvider.nameTC.text = "";
                                donationProvider.phoneTC.text = "";
                                donationProvider.kpccAmountController.text = "";
                                donationProvider.onAmountChange('');
                                donationProvider.clearGenderAndAgedata();
                                donationProvider.selectedPanjayathChip = null;
                                donationProvider.chipsetWardList.clear();
                                donationProvider.selectedWard = null;
                                '1';
                                donationProvider.minimumbool = true;
                                donationProvider.clearDonateScreen();
                                callNext(DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,oneEquipmentPrice: '',
                                    paymentCategory: 'GENERAL',equipmentCount: '',
                                    equipmentID: '',loginUserID: widget.loginUserID,loginUsername: widget.loginUsername,
                                  zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                  sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                  sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                  foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                              } else {
                                callNext( NoPaymentGateway(loginUserPhone: widget.loginUserPhone,
                                    subScriberType: widget.subScriberType,
                                    loginUserID: widget.loginUserID,
                                    loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                  sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                  sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                  foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                              }
                            });
                          },
                          child:
                              // SizedBox(
                              //   width: width * .900,
                              //   child: SwipeableButtonView(
                              //
                              //     buttonText: 'Participate Now',
                              //   buttontextstyle: const TextStyle(
                              //     fontSize: 21,
                              //       color: myWhite, fontWeight: FontWeight.bold
                              //   ),
                              //   //  buttonColor: Colors.yellow,
                              //     buttonWidget: Container(
                              //       child: const Icon(
                              //         Icons.arrow_forward_ios_rounded,
                              //         color: Colors.grey,
                              //       ),
                              //     ),
                              //    // activeColor:isFinished==false? const Color(0xFF051270):Colors.white.withOpacity(0.8),
                              //
                              //     activeColor:isFinished==false?  cl_34CC04:cl_34CC04,//change button color
                              //     disableColor: Colors.purple,
                              //
                              //     isFinished: isFinished,
                              //     onWaitingProcess: () {
                              //       Future.delayed(const Duration(milliseconds: 10), () {
                              //         setState(() {
                              //           isFinished = true;
                              //         });
                              //       });
                              //     },
                              //     onFinish: () async {
                              //       mRoot.child('0').child('PaymentGateway35').onValue.listen((event) {
                              //         if (event.snapshot.value.toString() == 'ON') {
                              //           DonationProvider donationProvider =
                              //           Provider.of<DonationProvider>(context,
                              //               listen: false);
                              //           donationProvider.amountTC.text = "";
                              //           donationProvider.nameTC.text = "";
                              //           donationProvider.phoneTC.text = "";
                              //           donationProvider.kpccAmountController.text = "";
                              //           donationProvider.onAmountChange('');
                              //           donationProvider.clearGenderAndAgedata();
                              //           donationProvider.selectedPanjayathChip = null;
                              //           donationProvider.chipsetWardList.clear();
                              //           donationProvider.selectedWard = null;
                              //           '1';
                              //
                              //           callNext(DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,), context);
                              //         } else {
                              //           callNext(const NoPaymentGateway(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,), context);
                              //         }
                              //       });
                              //       setState(() {
                              //         isFinished = false;
                              //       });
                              //     },
                              //   ),
                              // )
                              ///
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal:15),
                            height: 50,
                            width: width * .760,
                            decoration: BoxDecoration(
                              boxShadow: [
                                const BoxShadow(
                                  color: cl1883B2,
                                ),
                                BoxShadow(
                                  color: cl000000.withOpacity(0.25),
                                  spreadRadius: -5.0,
                                  // blurStyle: BlurStyle.inner,
                                  blurRadius: 20.0,
                                ),
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(35)),
                              gradient: const LinearGradient(
                                begin: Alignment(-1.00, -0.00),
                                end: Alignment(1, 0),
                                colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Image.asset("assets/CoinGif.gif"),

                            const Text(
                              "Support our noble cause",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "PoppinsMedium",
                                  color: myWhite,
                                  fontWeight: FontWeight.w500),
                            ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox();
              }),
            )
          : Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/webApp.jpg",
                      ),
                      fit: BoxFit.fill)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width / 3,
                    child: Scaffold(
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerFloat,
                      backgroundColor: clFFFFFF,

                      body: SizedBox(
                        height: height,

                        // decoration: const BoxDecoration(
                        //   gradient: LinearGradient(
                        //     begin: Alignment.topCenter,
                        //       end: Alignment.bottomCenter,
                        //       colors: [myWhite,myWhite])
                        // ),
                        child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(children: [
                              SizedBox(
                                height: height * .58,
                                // color: Colors.red,
                                // decoration:BoxDecoration(
                                //    color:Colors.red,
                                //   border: Border.all(color: myWhite),
                                // ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      child: Container(
                                        width: width,
                                        // height:340,
                                        height: 0.42 * height,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff616072),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/carousel.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 0,
                                      left: 0,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        height: 135,
                                        width: width,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                "assets/homeAmount_bgrnd.png",
                                              ),
                                              fit: BoxFit.fill),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Image.asset(
                                            //   "assets/splash_text.png",
                                            //   scale: 5.5,
                                            // ),
                                            SizedBox(
                                              height: 0.105 * height,
                                              child: Consumer<HomeProvider>(
                                                  builder:
                                                      (context, value, child) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Collected so far,",
                                                      style: blackPoppinsM12,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0,
                                                                  bottom: 10),
                                                          child: Image.asset(
                                                            'assets/rs.png',
                                                            // height:15,
                                                            scale: 2,
                                                            color: myWhite,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5),
                                                          child: Text(
                                                              getAmount(value
                                                                  .totalCollection),
                                                              style: GoogleFonts
                                                                  .akshar(
                                                                      textStyle:
                                                                          whiteGoogle38)),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Positioned(
                                    //   left: 0,
                                    //   bottom: 10,
                                    //   child: Stack(
                                    //     children: [
                                    //       SizedBox(
                                    //         height: 0.251*height,
                                    //         width: width,
                                    //         //color: Colors.purple,
                                    //         // decoration: BoxDecoration(
                                    //         //  //  color: Colors.purple,
                                    //         //   borderRadius: BorderRadius.circular(30),
                                    //         // ),
                                    //         child: CarouselSlider.builder(
                                    //           itemCount: images.length,
                                    //           itemBuilder: (context, index, realIndex) {
                                    //             //final image=value.imgList[index];
                                    //             final image = images[index];
                                    //             return buildImage(image, context);
                                    //           },
                                    //           options: CarouselOptions(
                                    //             clipBehavior: Clip.antiAliasWithSaveLayer,
                                    //            // autoPlayCurve: Curves.linear,
                                    //               height: 0.212*height,
                                    //               viewportFraction: 1,
                                    //               autoPlay: true,
                                    //               //enableInfiniteScroll: false,
                                    //               pageSnapping: true,
                                    //               enlargeStrategy: CenterPageEnlargeStrategy.height,
                                    //               enlargeCenterPage: true,
                                    //               autoPlayInterval: const Duration(seconds: 3),
                                    //               onPageChanged: (index, reason) {
                                    //                 setState(() {
                                    //                   activeIndex = index;
                                    //                 });
                                    //               }),
                                    //         ),
                                    //       ),
                                    //       Positioned(
                                    //           left: 150,
                                    //           bottom: 20,
                                    //           child: buidIndiaCator(images.length, context))
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              // const SizedBox(height: 23,),

                              //     Container(
                              //       decoration:const BoxDecoration(
                              //         color: myWhite,
                              //        // border:Border.all(color: Colors.white,width: 0.2),
                              //         ),
                              //       //  color: myRed,
                              //       //  height: 50,
                              //         child: Row(
                              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Padding(
                              //          padding: const EdgeInsets.only(left: 20.0),
                              //         child: Text(
                              //           !Platform.isIOS?"Contribute":"Reports",
                              //           style: b_myContributiontx,
                              //         ),
                              //       ),
                              //       // SizedBox(
                              //       //   width: width * .5,
                              //       // ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(right: 12.0),
                              //         child: InkWell(
                              //           onTap: (){
                              //             print("1254");
                              //
                              //             alertSupport(context);
                              //
                              //           },
                              //             child: Image.asset("assets/Helpline.png",scale: 3,)),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 38,
                                    width: 163,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.grey, blurRadius: 2)
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(19)),
                                    child: InkWell(
                                      onTap: () {
                                        alertSupport(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Support",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "PoppinsMedium",
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.phone,
                                                size: 17,
                                              ),
                                              const SizedBox(
                                                width: 1,
                                              ),
                                              Image.asset(
                                                "assets/whatsapp.png",
                                                scale: 3.6,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      homeProvider.getVideo(context,widget.loginUsername,widget.loginUserID,
                                          widget.subScriberType,widget.loginUserPhone,widget.zakathAmount,widget.deseaseName,
                                        widget.sponsorCategory,widget.sponsorCount,widget.sponsorItemOnePrice,widget.foodkitPrice,
                                        widget.footkitCount,widget.equipmentAmount,widget.sponsorPatientAmonut,widget.foodkitAmount,);
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 2),
                                          child: Image.asset(
                                            "assets/youtube.png",
                                            scale: 2,
                                          ),
                                        ),
                                        const Text(
                                          "How to Pay?",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "PoppinsMedium",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, bottom: 8),
                                child: Container(
                                  height: 100,
                                  width: width / 3,
                                  decoration: const BoxDecoration(
                                      color: clFFFFFF,
                                      boxShadow: [
                                        BoxShadow(
                                            color: cl0x40CACACA, blurRadius: 16)
                                      ]),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, bottom: 8, right: 8),
                                        child: Image.asset(
                                          "assets/todaysTopper.png",
                                          scale: 2.8,
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        color: clD4D4D4,
                                        margin: const EdgeInsets.only(
                                            top: 12, bottom: 12),
                                      ),
                                      // const VerticalDivider(color: clD4D4D4,thickness: 1,endIndent: 12,indent: 12,),
                                      Consumer<DonationProvider>(
                                          builder: (context, value, child) {
                                        return SizedBox(
                                          // color: Colors.yellow,
                                          width: width / 4.5,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                SizedBox(
                                                  width: 300,
                                                  // color: Colors.red,
                                                  child: Text(
                                                    value.todayTopperName,
                                                    style: const TextStyle(
                                                        height: 1.3,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "PoppinsMedium",
                                                        color: clblue),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                value.todayTopperPlace != ""
                                                    ? Text(
                                                        value.todayTopperPlace,
                                                        style: const TextStyle(
                                                            height: 1.3,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "PoppinsMedium",
                                                            color: cl6B6B6B),
                                                      )
                                                    : const SizedBox(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      value
                                                          .todayTopperPanchayath,
                                                      style: const TextStyle(
                                                          height: 1.3,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              "PoppinsMedium",
                                                          color: cl6B6B6B),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: SizedBox(
                                                            height: 15,
                                                            child: Text(
                                                              "₹",
                                                              style: TextStyle(
                                                                  color: clblue,
                                                                  fontSize: 16),
                                                              // scale: 7,
                                                              // color: myBlack2,
                                                            ),
                                                          ),
                                                        ),
                                                        AutoSizeText(
                                                          getAmount(value
                                                              .todayTopperAmount),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  "PoppinsMedium",
                                                              fontSize: 18,
                                                              color: clblue),
                                                        )
                                                      ],
                                                    ),

                                                    // AutoSizeText.rich(
                                                    //   TextSpan(children: [
                                                    //     const TextSpan(
                                                    //         text: "₹ ",
                                                    //         style: TextStyle(fontSize: 14,color: cl323A71)),
                                                    //     TextSpan(
                                                    //       text: getAmount(value.todayTopperAmount),
                                                    //       style: const TextStyle(
                                                    //           fontWeight: FontWeight.w700,
                                                    //           fontFamily: "PoppinsMedium",
                                                    //           fontSize: 18,
                                                    //           color: cl323A71
                                                    //       ),
                                                    //     )
                                                    //   ]),
                                                    //   textAlign: TextAlign.center,
                                                    //   minFontSize: 5,
                                                    //   maxFontSize: 18,
                                                    //   maxLines: 1,
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                              amount.isEmpty
                                  ? const SizedBox()
                                  : Container(
                                      height: 125,
                                      alignment: Alignment.center,
                                      child: GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  mainAxisSpacing: 2,
                                                  crossAxisSpacing: 8,
                                                  crossAxisCount: 2,
                                                  mainAxisExtent: 50),
                                          padding: const EdgeInsets.all(12),
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: amount.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                donationProvider
                                                        .kpccAmountController
                                                        .text =
                                                    amount[index].toString();

                                                donationProvider.nameTC.text =
                                                    "";
                                                donationProvider.phoneTC.text =
                                                    "";
                                                donationProvider
                                                    .clearGenderAndAgedata();
                                                donationProvider
                                                        .selectedPanjayathChip =
                                                    null;
                                                donationProvider.chipsetWardList
                                                    .clear();
                                                donationProvider.selectedWard =
                                                    null;
                                                donationProvider.minimumbool =
                                                    false;
                                                donationProvider.clearDonateScreen();
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,
                                                                subScriberType: widget.subScriberType,
                                                                oneEquipmentPrice: '',
                                                                paymentCategory: 'GENERAL',equipmentCount: '',
                                                                equipmentID: '',loginUserID: widget.loginUserID,
                                                                loginUsername: widget.loginUsername,
                                                              zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                              sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                              sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                              foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,)));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8,
                                                    top: 4,
                                                    bottom: 4),
                                                child: Container(
                                                    height: 42,
                                                    width: 144,
                                                    decoration:
                                                        const BoxDecoration(
                                                            boxShadow: [
                                                          BoxShadow(
                                                              color:
                                                                  cl0x40CACACA,
                                                              spreadRadius: 2,
                                                              blurRadius: 20)
                                                        ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                            color: clFFFFFF),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 0,
                                                                    top: 2.0,
                                                                    bottom: 2),
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  colors[index],
                                                              radius: 33,
                                                              foregroundImage:
                                                                  const AssetImage(
                                                                "assets/CoinGif.gif",
                                                              ),
                                                              // child: Image.asset("assets/CoinGif.gif",width: 80,),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            5.0),
                                                                child: Text(
                                                                    "₹ ",
                                                                    style: TextStyle(
                                                                        color:
                                                                            myBlack,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                              ),
                                                              Text(
                                                                  '${amount[index]}',
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          "PoppinsMedium",
                                                                      color:
                                                                          clblue,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                              const SizedBox(
                                                                width: 10,
                                                              )
                                                              // RichText(textAlign: TextAlign.start,
                                                              //   text: TextSpan(children: [
                                                              //     const TextSpan(
                                                              //         text: "₹ ",
                                                              //         style: TextStyle(
                                                              //             color: myBlack,
                                                              //             fontSize: 12,
                                                              //             fontWeight: FontWeight.w500),),
                                                              //     TextSpan(
                                                              //         text: '${amount[index]}',
                                                              //         style: const TextStyle(
                                                              //             fontFamily: "PoppinsMedium",
                                                              //             color: cl323A71,
                                                              //             fontSize: 20,
                                                              //             fontWeight: FontWeight.w700)),
                                                              //   ]),
                                                              // ),
                                                            ],
                                                          )
                                                        ])),
                                              ),
                                            );
                                          }),
                                    ),
                              Container(
                                padding: const EdgeInsets.all(0),
                                // color:myWhite,
                                child: GridView.builder(
                                    padding: const EdgeInsets.all(25),
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 2,
                                            crossAxisSpacing: 0,
                                            crossAxisCount: 4,
                                            mainAxisExtent: 95),
                                    itemCount: contriImg.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Consumer<HomeProvider>(
                                          builder: (context, value2, child) {
                                        return InkWell(
                                          onTap: () async {
                                            if (index == 2) {
                                              // homeProvider.selectedDistrict = null;
                                              // homeProvider.selectedPanjayath = null;
                                              // homeProvider.selectedUnit = null;
                                              // homeProvider.fetchDropdown('', '');
                                              // homeProvider.fetchWard();
                                              // callNext(WardHistory(), context);
                                            } else if (index == 6) {
                                              if (!kIsWeb) {
                                                PackageInfo packageInfo =
                                                    await PackageInfo
                                                        .fromPlatform();
                                                String packageName =
                                                    packageInfo.packageName;
                                                if (packageName !=
                                                        'com.spine.quaide_millatMonitor' &&
                                                    packageName !=
                                                        'com.spine.dhotiTv') {
                                                  print("ifconditionwork");
                                                  homeProvider.searchEt.text =
                                                      "";
                                                  homeProvider.currentLimit =
                                                      50;
                                                  homeProvider
                                                      .fetchReceiptList(50);
                                                  callNext(
                                                      ReceiptListPage(loginUserPhone: widget.loginUserPhone,
                                                          subScriberType: widget.subScriberType,
                                                        from: "home",
                                                        total: '',
                                                        ward: '',
                                                        panchayath: '',
                                                        district: '',
                                                        target: '',
                                                          loginUserID: widget.loginUserID,loginUsername: widget.loginUsername,
                                                        zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                        sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                        sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                        foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,
                                                      ),
                                                      context);
                                                } else {
                                                  homeProvider.currentLimit =
                                                      50;
                                                  homeProvider
                                                      .fetchReceiptListForMonitorApp(
                                                          50);
                                                  callNext(
                                                      ReceiptListMonitorScreen(loginUserPhone: widget.loginUserPhone,
                                                          subScriberType: widget.subScriberType,
                                                          loginUserID: widget.loginUserID,
                                                          loginUsername: widget.loginUsername,zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                        sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                        sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                        foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,),
                                                      context);

                                                  // homeProvider.fetchPaymentReceiptList();
                                                }
                                              } else {
                                                homeProvider.searchEt.text = "";
                                                homeProvider.currentLimit = 50;
                                                homeProvider
                                                    .fetchReceiptList(50);
                                                callNext(
                                                    ReceiptListPage(subScriberType: widget.subScriberType,loginUserPhone: widget.loginUserPhone,
                                                      from: "home",
                                                      total: '',
                                                      ward: '',
                                                      panchayath: '',
                                                      district: '',
                                                      target: '',
                                                        loginUserID: widget.loginUserID,loginUsername: widget.loginUsername,
                                                      zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                      sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                      sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                      foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,
                                                    ),
                                                    context);
                                              }
                                            } else if (index == 7) {
                                              // homeProvider.fetchHistoryFromFireStore();
                                              // callNext(PaymentHistory(), context);
                                            } else if (index == 0) {
                                              // homeProvider.getTopEnrollers();
                                              // callNext(const TopEnrollersScreen(), context);
                                            } else if (index == 3) {
                                              // homeProvider.topLeadPayments();
                                              // callNext(LeadReport(), context);
                                            } else if (index == 1) {
                                              // homeProvider.fetchDistrictWiseReport();
                                              // callNext( ToppersHomeScreen(), context);
                                            } else if (index == 4) {
                                              // print("device click here");
                                              // HomeProvider homeProvider =
                                              // Provider.of<HomeProvider>(context, listen: false);
                                              // await homeProvider.checkEnrollerDeviceID();
                                              // if (value2.enrollerDeviceID) {
                                              //   print("deviceid already exixt");
                                              //   deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                              // } else {
                                              //   homeProvider.clearEnrollerData();
                                              //   callNext(BeAnEnroller(), context);
                                              // }
                                            } else if (index == 5) {
                                              // print("clikk22334");
                                              // homeProvider.clearEnrollerDetails();
                                              // callNext(const EnrollerPaymentsScreen(), context);
                                            }
                                          },
                                          child: Center(
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                alignment: Alignment.center,
                                                width: width * .20,
                                                // height: 48,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 55,
                                                      child: Image.asset(
                                                        contriImg[index],
                                                        scale: 2,
                                                      ),
                                                    ),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: width,
                                                        height: 35,
                                                        // color:Colors.yellow,
                                                        child: Text(
                                                          contriText[index],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  "PoppinsMedium",
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          overflow:
                                                              TextOverflow.fade,
                                                        )),
                                                  ],
                                                )),
                                          ),
                                        );
                                      });
                                    }),
                              ),

                              Container(
                                // color: myWhite,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                  child: SizedBox(

                                      // padding: const EdgeInsets.all(8),
                                      height: 0.15 * height,
                                      // color: Colors.yellow,
                                      // decoration: const BoxDecoration(
                                      //     color: clFFFFFF,
                                      //     borderRadius: BorderRadius.all(
                                      //       Radius.circular(25),
                                      //     ),
                                      //     boxShadow: [
                                      //       BoxShadow(
                                      //         color: Colors.grey,
                                      //         blurRadius: 5.0,
                                      //       ),
                                      //     ]),
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: 3,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              if (index == 1) {
                                                alertTermsAndConditions(
                                                    context);
                                              } else if (index == 2) {
                                                alertContact(context);
                                              } else if (index == 0) {
                                                alertTerm(context);
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12.0, left: 12),
                                              child: Column(children: [
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: clF8F8F8,
                                                  child: Image.asset(
                                                    PTCImg[index],
                                                    scale: 3,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  PTCText[index],
                                                  style: const TextStyle(
                                                      color: myBlack,
                                                      fontSize: 11,
                                                      fontFamily: "Lato",
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(height: 5),
                                              ]),
                                            ),
                                          );
                                        },
                                      )),
                                ),
                              ),

                              Consumer<HomeProvider>(
                                  builder: (context, value, child) {
                                print("aaaaaaaaaaaaaaaa" + value.buildNumber);
                                return Container(
                                  // color: myWhite,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Version:${value.appVersion}.${value.buildNumber}.${value.currentVersion}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8),
                                      )),
                                );
                              }),
                              Container(
                                // color: myWhite,
                                height: 80,
                              )
                            ])),
                      ),

                      ///old body singlechid ,dont remove it
                      ///

                      ///floating action button
                      floatingActionButton: Consumer<HomeProvider>(
                          builder: (context, value, child) {
                        return ((kIsWeb ||
                                    Platform.isAndroid ||
                                    value.iosPaymentGateway == 'ON') &&
                                !Platform.isIOS)
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 0.0, right: 2),
                                child: InkWell(
                                  onTap: () {
                                    mRoot
                                        .child('0')
                                        .child('PaymentGateway36')
                                        .onValue
                                        .listen((event) {
                                      if (event.snapshot.value.toString() ==
                                          'ON') {
                                        DonationProvider donationProvider =
                                            Provider.of<DonationProvider>(
                                                context,
                                                listen: false);
                                        donationProvider.amountTC.text = "";
                                        donationProvider.nameTC.text = "";
                                        donationProvider.phoneTC.text = "";
                                        donationProvider
                                            .kpccAmountController.text = "";
                                        donationProvider.onAmountChange('');
                                        donationProvider
                                            .clearGenderAndAgedata();
                                        donationProvider.selectedPanjayathChip =
                                            null;
                                        donationProvider.chipsetWardList
                                            .clear();
                                        donationProvider.selectedWard = null;
                                        '1';
                                        donationProvider.minimumbool = true;
                                        donationProvider.clearDonateScreen();
                                        callNext(DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,oneEquipmentPrice: '',
                                            paymentCategory: 'GENERAL',equipmentCount: '',
                                            equipmentID: '',loginUserID:widget. loginUserID,loginUsername: widget.loginUsername,
                                          zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                          sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                          sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                          foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                      } else {
                                        callNext(
                                             NoPaymentGateway(loginUserPhone: widget.loginUserPhone,
                                                 subScriberType: widget.subScriberType,
                                                 loginUserID: widget.loginUserID,
                                                 loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                               sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                               sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                               foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                      }
                                    });
                                  },
                                  child:
                                      // SizedBox(
                                      //   width: width * .900,
                                      //   child: SwipeableButtonView(
                                      //
                                      //     buttonText: 'Participate Now',
                                      //   buttontextstyle: const TextStyle(
                                      //     fontSize: 21,
                                      //       color: myWhite, fontWeight: FontWeight.bold
                                      //   ),
                                      //   //  buttonColor: Colors.yellow,
                                      //     buttonWidget: Container(
                                      //       child: const Icon(
                                      //         Icons.arrow_forward_ios_rounded,
                                      //         color: Colors.grey,
                                      //       ),
                                      //     ),
                                      //    // activeColor:isFinished==false? const Color(0xFF051270):Colors.white.withOpacity(0.8),
                                      //
                                      //     activeColor:isFinished==false?  cl_34CC04:cl_34CC04,//change button color
                                      //     disableColor: Colors.purple,
                                      //
                                      //     isFinished: isFinished,
                                      //     onWaitingProcess: () {
                                      //       Future.delayed(const Duration(milliseconds: 10), () {
                                      //         setState(() {
                                      //           isFinished = true;
                                      //         });
                                      //       });
                                      //     },
                                      //     onFinish: () async {
                                      //       mRoot.child('0').child('PaymentGateway35').onValue.listen((event) {
                                      //         if (event.snapshot.value.toString() == 'ON') {
                                      //           DonationProvider donationProvider =
                                      //           Provider.of<DonationProvider>(context,
                                      //               listen: false);
                                      //           donationProvider.amountTC.text = "";
                                      //           donationProvider.nameTC.text = "";
                                      //           donationProvider.phoneTC.text = "";
                                      //           donationProvider.kpccAmountController.text = "";
                                      //           donationProvider.onAmountChange('');
                                      //           donationProvider.clearGenderAndAgedata();
                                      //           donationProvider.selectedPanjayathChip = null;
                                      //           donationProvider.chipsetWardList.clear();
                                      //           donationProvider.selectedWard = null;
                                      //           '1';
                                      //
                                      //           callNext(DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,), context);
                                      //         } else {
                                      //           callNext(const NoPaymentGateway(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,), context);
                                      //         }
                                      //       });
                                      //       setState(() {
                                      //         isFinished = false;
                                      //       });
                                      //     },
                                      //   ),
                                      // )
                                      ///
                                      Container(
                                    height: 50,
                                    width: width * .760,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        const BoxShadow(
                                          color: cl1883B2,
                                        ),
                                        BoxShadow(
                                          color: cl000000.withOpacity(0.25),
                                          spreadRadius: -5.0,
                                          // blurStyle: BlurStyle.inner,
                                          blurRadius: 20.0,
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(35)),
                                      gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [cl1883B2, cl19A391]),
                                    ),
                                    child: const Center(
                                        child: Text(
                                      "Participate Now",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "PoppinsMedium",
                                          color: myWhite,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                ),
                              )
                            : const SizedBox();
                      }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget web(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    WebProvider webProvider = Provider.of<WebProvider>(context, listen: false);

    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        return showExitPopup(context);
      },
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/webApp.jpg",
                ),
                fit: BoxFit.fill)),
        child: Stack(
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
                            floatingActionButtonLocation:
                                FloatingActionButtonLocation.centerFloat,
                            backgroundColor: clFFFFFF,

                            body: SizedBox(
                              height: height,

                              // decoration: const BoxDecoration(
                              //   gradient: LinearGradient(
                              //     begin: Alignment.topCenter,
                              //       end: Alignment.bottomCenter,
                              //       colors: [myWhite,myWhite])
                              // ),
                              child: SingleChildScrollView(
                                  physics: const ScrollPhysics(),
                                  child: Column(children: [
                                    SizedBox(
                                      height: height * .58,
                                      // color: Colors.red,
                                      // decoration:BoxDecoration(
                                      //    color:Colors.red,
                                      //   border: Border.all(color: myWhite),
                                      // ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)),
                                            child: Container(
                                              width: width,
                                              // height:340,
                                              height: 0.42 * height,
                                              decoration: const BoxDecoration(
                                                color: Color(0xff616072),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/carousel.png"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 5,
                                            right: 0,
                                            left: 0,
                                            child: InkWell(
                                              onTap: () {},
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                height: 135,
                                                width: width,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        "assets/homeAmount_bgrnd.png",
                                                      ),
                                                      fit: BoxFit.fill),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // Image.asset(
                                                    //   "assets/splash_text.png",
                                                    //   scale: 5.5,
                                                    // ),
                                                    SizedBox(
                                                      height: 0.105 * height,
                                                      child: Consumer<
                                                              HomeProvider>(
                                                          builder: (context,
                                                              value, child) {
                                                        return Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Collected so far,",
                                                              style:
                                                                  blackPoppinsM12,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 0,
                                                                      bottom:
                                                                          10),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/rs.png',
                                                                    // height:15,
                                                                    scale: 2,
                                                                    color:
                                                                        myWhite,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 5),
                                                                  child: Text(
                                                                      getAmount(
                                                                          value
                                                                              .totalCollection),
                                                                      style: GoogleFonts.akshar(
                                                                          textStyle:
                                                                              whiteGoogle38)),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Positioned(
                                          //   left: 0,
                                          //   bottom: 10,
                                          //   child: Stack(
                                          //     children: [
                                          //       SizedBox(
                                          //         height: 0.251*height,
                                          //         width: width,
                                          //         //color: Colors.purple,
                                          //         // decoration: BoxDecoration(
                                          //         //  //  color: Colors.purple,
                                          //         //   borderRadius: BorderRadius.circular(30),
                                          //         // ),
                                          //         child: CarouselSlider.builder(
                                          //           itemCount: images.length,
                                          //           itemBuilder: (context, index, realIndex) {
                                          //             //final image=value.imgList[index];
                                          //             final image = images[index];
                                          //             return buildImage(image, context);
                                          //           },
                                          //           options: CarouselOptions(
                                          //             clipBehavior: Clip.antiAliasWithSaveLayer,
                                          //            // autoPlayCurve: Curves.linear,
                                          //               height: 0.212*height,
                                          //               viewportFraction: 1,
                                          //               autoPlay: true,
                                          //               //enableInfiniteScroll: false,
                                          //               pageSnapping: true,
                                          //               enlargeStrategy: CenterPageEnlargeStrategy.height,
                                          //               enlargeCenterPage: true,
                                          //               autoPlayInterval: const Duration(seconds: 3),
                                          //               onPageChanged: (index, reason) {
                                          //                 setState(() {
                                          //                   activeIndex = index;
                                          //                 });
                                          //               }),
                                          //         ),
                                          //       ),
                                          //       Positioned(
                                          //           left: 150,
                                          //           bottom: 20,
                                          //           child: buidIndiaCator(images.length, context))
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    // const SizedBox(height: 23,),

                                    //     Container(
                                    //       decoration:const BoxDecoration(
                                    //         color: myWhite,
                                    //        // border:Border.all(color: Colors.white,width: 0.2),
                                    //         ),
                                    //       //  color: myRed,
                                    //       //  height: 50,
                                    //         child: Row(
                                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //           children: [
                                    //             Padding(
                                    //          padding: const EdgeInsets.only(left: 20.0),
                                    //         child: Text(
                                    //           !Platform.isIOS?"Contribute":"Reports",
                                    //           style: b_myContributiontx,
                                    //         ),
                                    //       ),
                                    //       // SizedBox(
                                    //       //   width: width * .5,
                                    //       // ),
                                    //       Padding(
                                    //         padding: const EdgeInsets.only(right: 12.0),
                                    //         child: InkWell(
                                    //           onTap: (){
                                    //             print("1254");
                                    //
                                    //             alertSupport(context);
                                    //
                                    //           },
                                    //             child: Image.asset("assets/Helpline.png",scale: 3,)),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 38,
                                          width: 163,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 2)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(19)),
                                          child: InkWell(
                                            onTap: () {
                                              alertSupport(context);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Text(
                                                  "Support",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "PoppinsMedium",
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.phone,
                                                      size: 17,
                                                    ),
                                                    const SizedBox(
                                                      width: 1,
                                                    ),
                                                    Image.asset(
                                                      "assets/whatsapp.png",
                                                      scale: 3.6,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            homeProvider.getVideo(context,widget.loginUsername,widget.loginUserID,widget.subScriberType,
                                                widget.loginUserPhone,widget.zakathAmount,widget.deseaseName,
                                              widget.sponsorCategory,widget.sponsorCount,widget.sponsorItemOnePrice,widget.foodkitPrice,
                                              widget.footkitCount,widget.equipmentAmount,widget.sponsorPatientAmonut,widget.foodkitAmount,);
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 2),
                                                child: Image.asset(
                                                  "assets/youtube.png",
                                                  scale: 2,
                                                ),
                                              ),
                                              const Text(
                                                "How to Pay?",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "PoppinsMedium",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, bottom: 8),
                                      child: Container(
                                        height: 100,
                                        width: width,
                                        decoration: const BoxDecoration(
                                            color: clFFFFFF,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: cl0x40CACACA,
                                                  blurRadius: 16)
                                            ]),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12,
                                                  bottom: 8,
                                                  right: 8),
                                              child: Image.asset(
                                                "assets/todaysTopper.png",
                                                scale: 2.8,
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              color: clD4D4D4,
                                              margin: const EdgeInsets.only(
                                                  top: 12, bottom: 12),
                                            ),
                                            // const VerticalDivider(color: clD4D4D4,thickness: 1,endIndent: 12,indent: 12,),
                                            Consumer<DonationProvider>(builder:
                                                (context, value, child) {
                                              return SizedBox(
                                                // color: Colors.yellow,
                                                width: width / 1.9,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      SizedBox(
                                                        width: width / 2,
                                                        // color: Colors.red,
                                                        child: Text(
                                                          value.todayTopperName,
                                                          style: const TextStyle(
                                                              height: 1.3,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "PoppinsMedium",
                                                              color: clblue),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      value.todayTopperPlace !=
                                                              ""
                                                          ? Text(
                                                              value
                                                                  .todayTopperPlace,
                                                              style: const TextStyle(
                                                                  height: 1.3,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      "PoppinsMedium",
                                                                  color:
                                                                      cl6B6B6B),
                                                            )
                                                          : const SizedBox(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            value
                                                                .todayTopperPanchayath,
                                                            style: const TextStyle(
                                                                height: 1.3,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    "PoppinsMedium",
                                                                color:
                                                                    cl6B6B6B),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            2),
                                                                child: SizedBox(
                                                                  height: 15,
                                                                  child: Text(
                                                                    "₹",
                                                                    style: TextStyle(
                                                                        color:
                                                                            clblue,
                                                                        fontSize:
                                                                            16),
                                                                    // scale: 7,
                                                                    // color: myBlack2,
                                                                  ),
                                                                ),
                                                              ),
                                                              AutoSizeText(
                                                                getAmount(value
                                                                    .todayTopperAmount),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontFamily:
                                                                        "PoppinsMedium",
                                                                    fontSize:
                                                                        18,
                                                                    color:
                                                                        clblue),
                                                              )
                                                            ],
                                                          ),

                                                          // AutoSizeText.rich(
                                                          //   TextSpan(children: [
                                                          //     const TextSpan(
                                                          //         text: "₹ ",
                                                          //         style: TextStyle(fontSize: 14,color: cl323A71)),
                                                          //     TextSpan(
                                                          //       text: getAmount(value.todayTopperAmount),
                                                          //       style: const TextStyle(
                                                          //           fontWeight: FontWeight.w700,
                                                          //           fontFamily: "PoppinsMedium",
                                                          //           fontSize: 18,
                                                          //           color: cl323A71
                                                          //       ),
                                                          //     )
                                                          //   ]),
                                                          //   textAlign: TextAlign.center,
                                                          //   minFontSize: 5,
                                                          //   maxFontSize: 18,
                                                          //   maxLines: 1,
                                                          // ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        width: 40,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    amount.isEmpty
                                        ? const SizedBox()
                                        : Container(
                                            height: 125,
                                            alignment: Alignment.center,
                                            child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        mainAxisSpacing: 2,
                                                        crossAxisSpacing: 8,
                                                        crossAxisCount: 2,
                                                        mainAxisExtent: 50),
                                                padding:
                                                    const EdgeInsets.all(12),
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: amount.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      donationProvider
                                                          .kpccAmountController
                                                          .text = amount[
                                                              index]
                                                          .toString();

                                                      donationProvider
                                                          .nameTC.text = "";
                                                      donationProvider
                                                          .phoneTC.text = "";
                                                      donationProvider
                                                          .clearGenderAndAgedata();
                                                      donationProvider
                                                              .selectedPanjayathChip =
                                                          null;
                                                      donationProvider
                                                          .chipsetWardList
                                                          .clear();
                                                      donationProvider
                                                          .selectedWard = null;
                                                      donationProvider
                                                          .minimumbool = false;
                                                      donationProvider.clearDonateScreen();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,oneEquipmentPrice: '',
                                                                      paymentCategory: 'GENERAL',
                                                                      equipmentCount: '',
                                                                      equipmentID: '',loginUserID: widget.loginUserID,loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                                    sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                                    sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                                    foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,)));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8,
                                                              top: 4,
                                                              bottom: 4),
                                                      child: Container(
                                                          height: 42,
                                                          width: 144,
                                                          decoration: const BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color:
                                                                        cl0x40CACACA,
                                                                    spreadRadius:
                                                                        2,
                                                                    blurRadius:
                                                                        20)
                                                              ],
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                              color: clFFFFFF),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 0,
                                                                      top: 2.0,
                                                                      bottom:
                                                                          2),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        colors[
                                                                            index],
                                                                    radius: 33,
                                                                    foregroundImage:
                                                                        const AssetImage(
                                                                      "assets/CoinGif.gif",
                                                                    ),
                                                                    // child: Image.asset("assets/CoinGif.gif",width: 80,),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Padding(
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 5.0),
                                                                      child: Text(
                                                                          "₹ ",
                                                                          style: TextStyle(
                                                                              color: myBlack,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w500)),
                                                                    ),
                                                                    Text(
                                                                        '${amount[index]}',
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                "PoppinsMedium",
                                                                            color:
                                                                                clblue,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w700)),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    )
                                                                    // RichText(textAlign: TextAlign.start,
                                                                    //   text: TextSpan(children: [
                                                                    //     const TextSpan(
                                                                    //         text: "₹ ",
                                                                    //         style: TextStyle(
                                                                    //             color: myBlack,
                                                                    //             fontSize: 12,
                                                                    //             fontWeight: FontWeight.w500),),
                                                                    //     TextSpan(
                                                                    //         text: '${amount[index]}',
                                                                    //         style: const TextStyle(
                                                                    //             fontFamily: "PoppinsMedium",
                                                                    //             color: cl323A71,
                                                                    //             fontSize: 20,
                                                                    //             fontWeight: FontWeight.w700)),
                                                                    //   ]),
                                                                    // ),
                                                                  ],
                                                                )
                                                              ])),
                                                    ),
                                                  );
                                                }),
                                          ),
                                    Container(
                                      padding: const EdgeInsets.all(0),
                                      // color:myWhite,
                                      child: GridView.builder(
                                          padding: const EdgeInsets.all(25),
                                          physics: const ScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  mainAxisSpacing: 2,
                                                  crossAxisSpacing: 0,
                                                  crossAxisCount: 4,
                                                  mainAxisExtent: 95),
                                          itemCount: contriImg.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Consumer<HomeProvider>(
                                                builder:
                                                    (context, value2, child) {
                                              return InkWell(
                                                onTap: () async {
                                                  if (index == 2) {
                                                    // homeProvider.selectedDistrict = null;
                                                    // homeProvider.selectedPanjayath = null;
                                                    // homeProvider.selectedUnit = null;
                                                    // homeProvider.fetchDropdown('', '');
                                                    // homeProvider.fetchWard();
                                                    // callNext(WardHistory(), context);
                                                  } else if (index == 6) {
                                                    if (!kIsWeb) {
                                                      PackageInfo packageInfo =
                                                          await PackageInfo
                                                              .fromPlatform();
                                                      String packageName =
                                                          packageInfo
                                                              .packageName;
                                                      if (packageName !=
                                                              'com.spine.quaide_millatMonitor' &&
                                                          packageName !=
                                                              'com.spine.dhotiTv') {
                                                        print(
                                                            "ifconditionwork");
                                                        homeProvider
                                                            .searchEt.text = "";
                                                        homeProvider
                                                            .currentLimit = 50;
                                                        homeProvider
                                                            .fetchReceiptList(
                                                                50);
                                                        callNext(
                                                            ReceiptListPage(subScriberType: widget.subScriberType,
                                                                loginUserPhone: widget.loginUserPhone,
                                                              from: "home",
                                                              total: '',
                                                              ward: '',
                                                              panchayath: '',
                                                              district: '',
                                                              target: '',
                                                                loginUserID: widget.loginUserID,loginUsername: widget.loginUsername,
                                                              zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                              sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                              sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                              foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,
                                                            ),
                                                            context);
                                                      } else {
                                                        homeProvider
                                                            .currentLimit = 50;
                                                        homeProvider
                                                            .fetchReceiptListForMonitorApp(
                                                                50);
                                                        callNext(
                                                            ReceiptListMonitorScreen(loginUserPhone: widget.loginUserPhone,
                                                                subScriberType: widget.subScriberType,
                                                                loginUserID: widget.loginUserID,
                                                                loginUsername: widget.loginUsername,
                                                              zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                              sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                              sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                              foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,),
                                                            context);

                                                        // homeProvider.fetchPaymentReceiptList();
                                                      }
                                                    } else {
                                                      // homeProvider.searchEt.text = "";
                                                      // homeProvider.currentLimit = 50;
                                                      // homeProvider.fetchReceiptList(50);
                                                      // callNext(ReceiptListPage(from: "home", total: '', ward: '',),
                                                      //     context);
                                                      homeProvider
                                                          .currentLimit = 50;
                                                      homeProvider
                                                          .fetchReceiptListForMonitorApp(
                                                              50);
                                                      callNext(
                                                          ReceiptListMonitorScreen(loginUserPhone: widget.loginUserPhone,
                                                              subScriberType: widget.subScriberType,
                                                              loginUserID: widget.loginUserID,
                                                              loginUsername: widget.loginUsername,
                                                            zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                            sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                            sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                            foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,),
                                                          context);
                                                    }
                                                  } else if (index == 7) {
                                                    // homeProvider.fetchHistoryFromFireStore();
                                                    // callNext(PaymentHistory(), context);
                                                  } else if (index == 0) {
                                                    // homeProvider.getTopEnrollers();
                                                    // callNext(const TopEnrollersScreen(), context);
                                                  } else if (index == 3) {
                                                    // homeProvider.topLeadPayments();
                                                    // callNext(LeadReport(), context);
                                                  } else if (index == 1) {
                                                    // homeProvider.fetchDistrictWiseReport();
                                                    // callNext( ToppersHomeScreen(), context);
                                                  } else if (index == 4) {
                                                    // print("device click here");
                                                    // HomeProvider homeProvider =
                                                    // Provider.of<HomeProvider>(context, listen: false);
                                                    // await homeProvider.checkEnrollerDeviceID();
                                                    // if (value2.enrollerDeviceID) {
                                                    //   print("deviceid already exixt");
                                                    //   deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                                    // } else {
                                                    //   homeProvider.clearEnrollerData();
                                                    //   callNext(BeAnEnroller(), context);
                                                    // }
                                                  } else if (index == 5) {
                                                    // print("clikk22334");
                                                    // homeProvider.clearEnrollerDetails();
                                                    // callNext(const EnrollerPaymentsScreen(), context);
                                                  }
                                                },
                                                child: Center(
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      alignment:
                                                          Alignment.center,
                                                      width: width * .20,
                                                      // height: 48,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 55,
                                                            child: Image.asset(
                                                              contriImg[index],
                                                              scale: 2,
                                                            ),
                                                          ),
                                                          Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: width,
                                                              height: 35,
                                                              // color:Colors.yellow,
                                                              child: Text(
                                                                contriText[
                                                                    index],
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        "PoppinsMedium",
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                              )),
                                                        ],
                                                      )),
                                                ),
                                              );
                                            });
                                          }),
                                    ),

                                    Container(
                                      // color: myWhite,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 10, 30, 0),
                                        child: SizedBox(

                                            // padding: const EdgeInsets.all(8),
                                            height: 0.15 * height,
                                            // color: Colors.yellow,
                                            // decoration: const BoxDecoration(
                                            //     color: clFFFFFF,
                                            //     borderRadius: BorderRadius.all(
                                            //       Radius.circular(25),
                                            //     ),
                                            //     boxShadow: [
                                            //       BoxShadow(
                                            //         color: Colors.grey,
                                            //         blurRadius: 5.0,
                                            //       ),
                                            //     ]),
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: 3,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    if (index == 1) {
                                                      alertTermsAndConditions(
                                                          context);
                                                    } else if (index == 2) {
                                                      alertContact(context);
                                                    } else if (index == 0) {
                                                      alertTerm(context);
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 12.0,
                                                            left: 12),
                                                    child: Column(children: [
                                                      CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            clF8F8F8,
                                                        child: Image.asset(
                                                          PTCImg[index],
                                                          scale: 3,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        PTCText[index],
                                                        style: const TextStyle(
                                                            color: myBlack,
                                                            fontSize: 11,
                                                            fontFamily: "Lato",
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(height: 5),
                                                    ]),
                                                  ),
                                                );
                                              },
                                            )),
                                      ),
                                    ),

                                    Consumer<HomeProvider>(
                                        builder: (context, value, child) {
                                      print("aaaaaaaaaaaaaaaa" +
                                          value.buildNumber);
                                      return Container(
                                        // color: myWhite,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Version:${value.appVersion}.${value.buildNumber}.${value.currentVersion}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 8),
                                            )),
                                      );
                                    }),
                                    Container(
                                      // color: myWhite,
                                      height: 80,
                                    )
                                  ])),
                            ),

                            ///old body singlechid ,dont remove it
                            ///

                            ///floating action button
                            floatingActionButton: Consumer<HomeProvider>(
                                builder: (context, value, child) {
                              return ((kIsWeb ||
                                          Platform.isAndroid ||
                                          value.iosPaymentGateway == 'ON') &&
                                      !Platform.isIOS)
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0.0, right: 2),
                                      child: InkWell(
                                        onTap: () {
                                          mRoot
                                              .child('0')
                                              .child('PaymentGateway36')
                                              .onValue
                                              .listen((event) {
                                            if (event.snapshot.value
                                                    .toString() ==
                                                'ON') {
                                              DonationProvider
                                                  donationProvider =
                                                  Provider.of<DonationProvider>(
                                                      context,
                                                      listen: false);
                                              donationProvider.amountTC.text =
                                                  "";
                                              donationProvider.nameTC.text = "";
                                              donationProvider.phoneTC.text =
                                                  "";
                                              donationProvider
                                                  .kpccAmountController
                                                  .text = "";
                                              donationProvider
                                                  .onAmountChange('');
                                              donationProvider
                                                  .clearGenderAndAgedata();
                                              donationProvider
                                                  .selectedPanjayathChip = null;
                                              donationProvider.chipsetWardList
                                                  .clear();
                                              donationProvider.selectedWard =
                                                  null;
                                              '1';
                                              donationProvider.minimumbool =
                                                  true;
                                              donationProvider.clearDonateScreen();
                                              callNext(DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,
                                                  subScriberType: widget.subScriberType,oneEquipmentPrice: '',
                                                  paymentCategory: 'GENERAL',
                                                  equipmentCount: '',equipmentID: '',
                                                  loginUserID: widget.loginUserID,
                                                  loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                            } else {
                                              callNext( NoPaymentGateway(loginUserPhone: widget.loginUserPhone,
                                                  subScriberType: widget.subScriberType,
                                                  loginUserID: widget.loginUserID,
                                                  loginUsername: widget.loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,),
                                                  context);
                                            }
                                          });
                                        },
                                        child:
                                            // SizedBox(
                                            //   width: width * .900,
                                            //   child: SwipeableButtonView(
                                            //
                                            //     buttonText: 'Participate Now',
                                            //   buttontextstyle: const TextStyle(
                                            //     fontSize: 21,
                                            //       color: myWhite, fontWeight: FontWeight.bold
                                            //   ),
                                            //   //  buttonColor: Colors.yellow,
                                            //     buttonWidget: Container(
                                            //       child: const Icon(
                                            //         Icons.arrow_forward_ios_rounded,
                                            //         color: Colors.grey,
                                            //       ),
                                            //     ),
                                            //    // activeColor:isFinished==false? const Color(0xFF051270):Colors.white.withOpacity(0.8),
                                            //
                                            //     activeColor:isFinished==false?  cl_34CC04:cl_34CC04,//change button color
                                            //     disableColor: Colors.purple,
                                            //
                                            //     isFinished: isFinished,
                                            //     onWaitingProcess: () {
                                            //       Future.delayed(const Duration(milliseconds: 10), () {
                                            //         setState(() {
                                            //           isFinished = true;
                                            //         });
                                            //       });
                                            //     },
                                            //     onFinish: () async {
                                            //       mRoot.child('0').child('PaymentGateway35').onValue.listen((event) {
                                            //         if (event.snapshot.value.toString() == 'ON') {
                                            //           DonationProvider donationProvider =
                                            //           Provider.of<DonationProvider>(context,
                                            //               listen: false);
                                            //           donationProvider.amountTC.text = "";
                                            //           donationProvider.nameTC.text = "";
                                            //           donationProvider.phoneTC.text = "";
                                            //           donationProvider.kpccAmountController.text = "";
                                            //           donationProvider.onAmountChange('');
                                            //           donationProvider.clearGenderAndAgedata();
                                            //           donationProvider.selectedPanjayathChip = null;
                                            //           donationProvider.chipsetWardList.clear();
                                            //           donationProvider.selectedWard = null;
                                            //           '1';
                                            //
                                            //           callNext(DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,), context);
                                            //         } else {
                                            //           callNext(const NoPaymentGateway(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,), context);
                                            //         }
                                            //       });
                                            //       setState(() {
                                            //         isFinished = false;
                                            //       });
                                            //     },
                                            //   ),
                                            // )
                                            ///
                                            Container(
                                          height: 50,
                                          width: width * .760,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              const BoxShadow(
                                                color: cl1883B2,
                                              ),
                                              BoxShadow(
                                                color:
                                                    cl000000.withOpacity(0.25),
                                                spreadRadius: -5.0,
                                                // blurStyle: BlurStyle.inner,
                                                blurRadius: 20.0,
                                              ),
                                            ],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(35)),
                                            gradient: const LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [cl1883B2, cl19A391]),
                                          ),
                                          child: const Center(
                                              child: Text(
                                            "Participate Now",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "PoppinsMedium",
                                                color: myWhite,
                                                fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            }),
                          ),
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
                            floatingActionButtonLocation:
                                FloatingActionButtonLocation.centerFloat,
                            backgroundColor: clFFFFFF,

                            body: SizedBox(
                              height: height,

                              // decoration: const BoxDecoration(
                              //   gradient: LinearGradient(
                              //     begin: Alignment.topCenter,
                              //       end: Alignment.bottomCenter,
                              //       colors: [myWhite,myWhite])
                              // ),
                              child: SingleChildScrollView(
                                  physics: const ScrollPhysics(),
                                  child: Column(children: [
                                    SizedBox(
                                      height: height * .58,
                                      // color: Colors.red,
                                      // decoration:BoxDecoration(
                                      //    color:Colors.red,
                                      //   border: Border.all(color: myWhite),
                                      // ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)),
                                            child: Container(
                                              width: width,
                                              // height:340,
                                              height: 0.42 * height,
                                              decoration: const BoxDecoration(
                                                color: Color(0xff616072),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/carousel.png"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 5,
                                            right: 0,
                                            left: 0,
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              height: 135,
                                              width: width,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/homeAmount_bgrnd.png",
                                                    ),
                                                    fit: BoxFit.fill),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // Image.asset(
                                                  //   "assets/splash_text.png",
                                                  //   scale: 5.5,
                                                  // ),
                                                  SizedBox(
                                                    height: 0.105 * height,
                                                    child:
                                                        Consumer<HomeProvider>(
                                                            builder: (context,
                                                                value, child) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Collected so far,",
                                                            style:
                                                                blackPoppinsM12,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 0,
                                                                        bottom:
                                                                            10),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/rs.png',
                                                                  // height:15,
                                                                  scale: 2,
                                                                  color:
                                                                      myWhite,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5),
                                                                child: Text(
                                                                    getAmount(value
                                                                        .totalCollection),
                                                                    style: GoogleFonts.akshar(
                                                                        textStyle:
                                                                            whiteGoogle38)),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // Positioned(
                                          //   left: 0,
                                          //   bottom: 10,
                                          //   child: Stack(
                                          //     children: [
                                          //       SizedBox(
                                          //         height: 0.251*height,
                                          //         width: width,
                                          //         //color: Colors.purple,
                                          //         // decoration: BoxDecoration(
                                          //         //  //  color: Colors.purple,
                                          //         //   borderRadius: BorderRadius.circular(30),
                                          //         // ),
                                          //         child: CarouselSlider.builder(
                                          //           itemCount: images.length,
                                          //           itemBuilder: (context, index, realIndex) {
                                          //             //final image=value.imgList[index];
                                          //             final image = images[index];
                                          //             return buildImage(image, context);
                                          //           },
                                          //           options: CarouselOptions(
                                          //             clipBehavior: Clip.antiAliasWithSaveLayer,
                                          //            // autoPlayCurve: Curves.linear,
                                          //               height: 0.212*height,
                                          //               viewportFraction: 1,
                                          //               autoPlay: true,
                                          //               //enableInfiniteScroll: false,
                                          //               pageSnapping: true,
                                          //               enlargeStrategy: CenterPageEnlargeStrategy.height,
                                          //               enlargeCenterPage: true,
                                          //               autoPlayInterval: const Duration(seconds: 3),
                                          //               onPageChanged: (index, reason) {
                                          //                 setState(() {
                                          //                   activeIndex = index;
                                          //                 });
                                          //               }),
                                          //         ),
                                          //       ),
                                          //       Positioned(
                                          //           left: 150,
                                          //           bottom: 20,
                                          //           child: buidIndiaCator(images.length, context))
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    // const SizedBox(height: 23,),

                                    //     Container(
                                    //       decoration:const BoxDecoration(
                                    //         color: myWhite,
                                    //        // border:Border.all(color: Colors.white,width: 0.2),
                                    //         ),
                                    //       //  color: myRed,
                                    //       //  height: 50,
                                    //         child: Row(
                                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //           children: [
                                    //             Padding(
                                    //          padding: const EdgeInsets.only(left: 20.0),
                                    //         child: Text(
                                    //           !Platform.isIOS?"Contribute":"Reports",
                                    //           style: b_myContributiontx,
                                    //         ),
                                    //       ),
                                    //       // SizedBox(
                                    //       //   width: width * .5,
                                    //       // ),
                                    //       Padding(
                                    //         padding: const EdgeInsets.only(right: 12.0),
                                    //         child: InkWell(
                                    //           onTap: (){
                                    //             print("1254");
                                    //
                                    //             alertSupport(context);
                                    //
                                    //           },
                                    //             child: Image.asset("assets/Helpline.png",scale: 3,)),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 38,
                                          width: 163,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 2)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(19)),
                                          child: InkWell(
                                            onTap: () {
                                              alertSupport(context);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Text(
                                                  "Support",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "PoppinsMedium",
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.phone,
                                                      size: 17,
                                                    ),
                                                    const SizedBox(
                                                      width: 1,
                                                    ),
                                                    Image.asset(
                                                      "assets/whatsapp.png",
                                                      scale: 3.6,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            homeProvider.getVideo(context,widget.loginUsername,widget.loginUserID,
                                                widget.subScriberType,widget.loginUserPhone,widget.zakathAmount,widget.deseaseName,
                                                widget.sponsorCategory,widget.sponsorCount,widget.sponsorItemOnePrice,widget.foodkitPrice,
                                                widget.footkitCount,widget.equipmentAmount,widget.sponsorPatientAmonut,widget.foodkitAmount);
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 2),
                                                child: Image.asset(
                                                  "assets/youtube.png",
                                                  scale: 2,
                                                ),
                                              ),
                                              const Text(
                                                "How to Pay?",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "PoppinsMedium",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, bottom: 8),
                                      child: Container(
                                        height: 100,
                                        width: width / 3,
                                        decoration: const BoxDecoration(
                                            color: clFFFFFF,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: cl0x40CACACA,
                                                  blurRadius: 16)
                                            ]),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12,
                                                  bottom: 8,
                                                  right: 8),
                                              child: Image.asset(
                                                "assets/todaysTopper.png",
                                                scale: 2.8,
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              color: clD4D4D4,
                                              margin: const EdgeInsets.only(
                                                  top: 12, bottom: 12),
                                            ),
                                            // const VerticalDivider(color: clD4D4D4,thickness: 1,endIndent: 12,indent: 12,),
                                            Consumer<DonationProvider>(builder:
                                                (context, value, child) {
                                              return SizedBox(
                                                // color: Colors.yellow,
                                                width: width / 4.5,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        // color: Colors.red,
                                                        child: Text(
                                                          value.todayTopperName,
                                                          style: const TextStyle(
                                                              height: 1.3,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "PoppinsMedium",
                                                              color: clblue),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      value.todayTopperPlace !=
                                                              ""
                                                          ? Text(
                                                              value
                                                                  .todayTopperPlace,
                                                              style: const TextStyle(
                                                                  height: 1.3,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      "PoppinsMedium",
                                                                  color:
                                                                      cl6B6B6B),
                                                            )
                                                          : const SizedBox(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            value
                                                                .todayTopperPanchayath,
                                                            style: const TextStyle(
                                                                height: 1.3,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    "PoppinsMedium",
                                                                color:
                                                                    cl6B6B6B),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            10),
                                                                child: SizedBox(
                                                                  height: 15,
                                                                  child: Text(
                                                                    "₹",
                                                                    style: TextStyle(
                                                                        color:
                                                                            clblue,
                                                                        fontSize:
                                                                            16),
                                                                    // scale: 7,
                                                                    // color: myBlack2,
                                                                  ),
                                                                ),
                                                              ),
                                                              AutoSizeText(
                                                                getAmount(value
                                                                    .todayTopperAmount),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontFamily:
                                                                        "PoppinsMedium",
                                                                    fontSize:
                                                                        18,
                                                                    color:
                                                                        clblue),
                                                              )
                                                            ],
                                                          ),

                                                          // AutoSizeText.rich(
                                                          //   TextSpan(children: [
                                                          //     const TextSpan(
                                                          //         text: "₹ ",
                                                          //         style: TextStyle(fontSize: 14,color: cl323A71)),
                                                          //     TextSpan(
                                                          //       text: getAmount(value.todayTopperAmount),
                                                          //       style: const TextStyle(
                                                          //           fontWeight: FontWeight.w700,
                                                          //           fontFamily: "PoppinsMedium",
                                                          //           fontSize: 18,
                                                          //           color: cl323A71
                                                          //       ),
                                                          //     )
                                                          //   ]),
                                                          //   textAlign: TextAlign.center,
                                                          //   minFontSize: 5,
                                                          //   maxFontSize: 18,
                                                          //   maxLines: 1,
                                                          // ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    amount.isEmpty
                                        ? const SizedBox()
                                        : Container(
                                            height: 125,
                                            alignment: Alignment.center,
                                            child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        mainAxisSpacing: 2,
                                                        crossAxisSpacing: 8,
                                                        crossAxisCount: 2,
                                                        mainAxisExtent: 50),
                                                padding:
                                                    const EdgeInsets.all(12),
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: amount.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      donationProvider
                                                          .kpccAmountController
                                                          .text = amount[
                                                              index]
                                                          .toString();

                                                      donationProvider
                                                          .nameTC.text = "";
                                                      donationProvider
                                                          .phoneTC.text = "";
                                                      donationProvider
                                                          .clearGenderAndAgedata();
                                                      donationProvider
                                                              .selectedPanjayathChip =
                                                          null;
                                                      donationProvider
                                                          .chipsetWardList
                                                          .clear();
                                                      donationProvider
                                                          .selectedWard = null;
                                                      donationProvider
                                                          .minimumbool = false;
                                                      donationProvider.clearDonateScreen();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,
                                                                      subScriberType: widget.subScriberType,oneEquipmentPrice: '',
                                                                      paymentCategory: 'GENERAL',
                                                                      equipmentCount: '',
                                                                      equipmentID: '',loginUserID: widget.loginUserID,
                                                                      loginUsername:widget. loginUsername, zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                                    sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                                    sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                                    foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,)));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8,
                                                              top: 4,
                                                              bottom: 4),
                                                      child: Container(
                                                          height: 42,
                                                          width: 144,
                                                          decoration: const BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color:
                                                                        cl0x40CACACA,
                                                                    spreadRadius:
                                                                        2,
                                                                    blurRadius:
                                                                        20)
                                                              ],
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                              color: clFFFFFF),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 0,
                                                                      top: 2.0,
                                                                      bottom:
                                                                          2),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        colors[
                                                                            index],
                                                                    radius: 33,
                                                                    foregroundImage:
                                                                        const AssetImage(
                                                                      "assets/CoinGif.gif",
                                                                    ),
                                                                    // child: Image.asset("assets/CoinGif.gif",width: 80,),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Padding(
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 5.0),
                                                                      child: Text(
                                                                          "₹ ",
                                                                          style: TextStyle(
                                                                              color: myBlack,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w500)),
                                                                    ),
                                                                    Text(
                                                                        '${amount[index]}',
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                "PoppinsMedium",
                                                                            color:
                                                                                clblue,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w700)),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    )
                                                                    // RichText(textAlign: TextAlign.start,
                                                                    //   text: TextSpan(children: [
                                                                    //     const TextSpan(
                                                                    //         text: "₹ ",
                                                                    //         style: TextStyle(
                                                                    //             color: myBlack,
                                                                    //             fontSize: 12,
                                                                    //             fontWeight: FontWeight.w500),),
                                                                    //     TextSpan(
                                                                    //         text: '${amount[index]}',
                                                                    //         style: const TextStyle(
                                                                    //             fontFamily: "PoppinsMedium",
                                                                    //             color: cl323A71,
                                                                    //             fontSize: 20,
                                                                    //             fontWeight: FontWeight.w700)),
                                                                    //   ]),
                                                                    // ),
                                                                  ],
                                                                )
                                                              ])),
                                                    ),
                                                  );
                                                }),
                                          ),
                                    Container(
                                      padding: const EdgeInsets.all(0),
                                      // color:myWhite,
                                      child: GridView.builder(
                                          padding: const EdgeInsets.all(25),
                                          physics: const ScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  mainAxisSpacing: 2,
                                                  crossAxisSpacing: 0,
                                                  crossAxisCount: 4,
                                                  mainAxisExtent: 95),
                                          itemCount: contriImg.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Consumer<HomeProvider>(
                                                builder:
                                                    (context, value2, child) {
                                              return InkWell(
                                                onTap: () async {
                                                  if (index == 2) {
                                                    // homeProvider.selectedDistrict = null;
                                                    // homeProvider.selectedPanjayath = null;
                                                    // homeProvider.selectedUnit = null;
                                                    // homeProvider.fetchDropdown('', '');
                                                    // homeProvider.fetchWard();
                                                    // callNext(WardHistory(), context);
                                                  } else if (index == 6) {
                                                    if (!kIsWeb) {
                                                      PackageInfo packageInfo =
                                                          await PackageInfo
                                                              .fromPlatform();
                                                      String packageName =
                                                          packageInfo
                                                              .packageName;
                                                      if (packageName !=
                                                              'com.spine.quaide_millatMonitor' &&
                                                          packageName !=
                                                              'com.spine.dhotiTv') {
                                                        print(
                                                            "ifconditionwork");
                                                        homeProvider
                                                            .searchEt.text = "";
                                                        homeProvider
                                                            .currentLimit = 50;
                                                        homeProvider
                                                            .fetchReceiptList(
                                                                50);
                                                        callNext(
                                                            ReceiptListPage(subScriberType: widget.subScriberType,loginUserPhone: widget.loginUserPhone,
                                                              from: "home",
                                                              total: '',
                                                              ward: '',
                                                              panchayath: '',
                                                              district: '',
                                                              target: '',
                                                                loginUserID: widget.loginUserID,loginUsername: widget.loginUsername,
                                                              zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                              sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                              sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                              foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,
                                                            ),
                                                            context);
                                                      } else {
                                                        homeProvider
                                                            .currentLimit = 50;
                                                        homeProvider
                                                            .fetchReceiptListForMonitorApp(
                                                                50);
                                                        callNext(
                                                            ReceiptListMonitorScreen(loginUserPhone: widget.loginUserPhone,
                                                                subScriberType: widget.subScriberType,
                                                                loginUserID: widget.loginUserID,
                                                                loginUsername: widget.loginUsername,zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                              sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                              sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                              foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,),
                                                            context);

                                                        // homeProvider.fetchPaymentReceiptList();
                                                      }
                                                    } else {
                                                      // homeProvider.searchEt.text = "";
                                                      // homeProvider.currentLimit = 50;
                                                      // homeProvider.fetchReceiptList(50);
                                                      // callNext(ReceiptListPage(from: "home", total: '', ward: '',),
                                                      //     context);
                                                      homeProvider
                                                          .currentLimit = 50;
                                                      homeProvider
                                                          .fetchReceiptListForMonitorApp(
                                                              50);
                                                      callNext(
                                                          ReceiptListMonitorScreen(loginUserPhone: widget.loginUserPhone,
                                                              subScriberType: widget.subScriberType,
                                                              loginUserID: widget.loginUserID,
                                                              loginUsername: widget.loginUsername,zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                            sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                            sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                            foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,),
                                                          context);
                                                    }
                                                  } else if (index == 7) {
                                                    // homeProvider.fetchHistoryFromFireStore();
                                                    // callNext(PaymentHistory(), context);
                                                  } else if (index == 0) {
                                                    // homeProvider.getTopEnrollers();
                                                    // callNext(const TopEnrollersScreen(), context);
                                                  } else if (index == 3) {
                                                    // homeProvider.topLeadPayments();
                                                    // callNext(LeadReport(), context);
                                                  } else if (index == 1) {
                                                    // homeProvider.fetchDistrictWiseReport();
                                                    // callNext( ToppersHomeScreen(), context);
                                                  } else if (index == 4) {
                                                    // print("device click here");
                                                    // HomeProvider homeProvider =
                                                    // Provider.of<HomeProvider>(context, listen: false);
                                                    // await homeProvider.checkEnrollerDeviceID();
                                                    // if (value2.enrollerDeviceID) {
                                                    //   print("deviceid already exixt");
                                                    //   deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                                    // } else {
                                                    //   homeProvider.clearEnrollerData();
                                                    //   callNext(BeAnEnroller(), context);
                                                    // }
                                                  } else if (index == 5) {
                                                    // print("clikk22334");
                                                    // homeProvider.clearEnrollerDetails();
                                                    // callNext(const EnrollerPaymentsScreen(), context);
                                                  }
                                                },
                                                child: Center(
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      alignment:
                                                          Alignment.center,
                                                      width: width * .20,
                                                      // height: 48,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 55,
                                                            child: Image.asset(
                                                              contriImg[index],
                                                              scale: 2,
                                                            ),
                                                          ),
                                                          Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: width,
                                                              height: 35,
                                                              // color:Colors.yellow,
                                                              child: Text(
                                                                contriText[
                                                                    index],
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        "PoppinsMedium",
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                              )),
                                                        ],
                                                      )),
                                                ),
                                              );
                                            });
                                          }),
                                    ),

                                    Container(
                                      // color: myWhite,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 10, 30, 0),
                                        child: SizedBox(

                                            // padding: const EdgeInsets.all(8),
                                            height: 0.15 * height,
                                            // color: Colors.yellow,
                                            // decoration: const BoxDecoration(
                                            //     color: clFFFFFF,
                                            //     borderRadius: BorderRadius.all(
                                            //       Radius.circular(25),
                                            //     ),
                                            //     boxShadow: [
                                            //       BoxShadow(
                                            //         color: Colors.grey,
                                            //         blurRadius: 5.0,
                                            //       ),
                                            //     ]),
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: 3,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    if (index == 1) {
                                                      alertTermsAndConditions(
                                                          context);
                                                    } else if (index == 2) {
                                                      alertContact(context);
                                                    } else if (index == 0) {
                                                      alertTerm(context);
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 12.0,
                                                            left: 12),
                                                    child: Column(children: [
                                                      CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            clF8F8F8,
                                                        child: Image.asset(
                                                          PTCImg[index],
                                                          scale: 3,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        PTCText[index],
                                                        style: const TextStyle(
                                                            color: myBlack,
                                                            fontSize: 11,
                                                            fontFamily: "Lato",
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(height: 5),
                                                    ]),
                                                  ),
                                                );
                                              },
                                            )),
                                      ),
                                    ),

                                    Consumer<HomeProvider>(
                                        builder: (context, value, child) {
                                      print("aaaaaaaaaaaaaaaa" +
                                          value.buildNumber);
                                      return Container(
                                        // color: myWhite,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Version:${value.appVersion}.${value.buildNumber}.${value.currentVersion}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 8),
                                            )),
                                      );
                                    }),
                                    Container(
                                      // color: myWhite,
                                      height: 80,
                                    )
                                  ])),
                            ),

                            ///old body singlechid ,dont remove it
                            ///

                            ///floating action button
                            floatingActionButton: Consumer<HomeProvider>(
                                builder: (context, value, child) {
                              return ((kIsWeb ||
                                          Platform.isAndroid ||
                                          value.iosPaymentGateway == 'ON') &&
                                      !Platform.isIOS)
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0.0, right: 2),
                                      child: InkWell(
                                        onTap: () {
                                          mRoot
                                              .child('0')
                                              .child('PaymentGateway36')
                                              .onValue
                                              .listen((event) {
                                            if (event.snapshot.value
                                                    .toString() ==
                                                'ON') {
                                              DonationProvider
                                                  donationProvider =
                                                  Provider.of<DonationProvider>(
                                                      context,
                                                      listen: false);
                                              donationProvider.amountTC.text =
                                                  "";
                                              donationProvider.nameTC.text = "";
                                              donationProvider.phoneTC.text =
                                                  "";
                                              donationProvider
                                                  .kpccAmountController
                                                  .text = "";
                                              donationProvider
                                                  .onAmountChange('');
                                              donationProvider
                                                  .clearGenderAndAgedata();
                                              donationProvider
                                                  .selectedPanjayathChip = null;
                                              donationProvider.chipsetWardList
                                                  .clear();
                                              donationProvider.selectedWard =
                                                  null;
                                              '1';
                                              donationProvider.minimumbool =
                                                  true;
                                              donationProvider.clearDonateScreen();
                                              callNext(DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,oneEquipmentPrice: '',
                                                  paymentCategory: 'GENERAL',
                                                  equipmentCount: '',equipmentID: '',
                                                  loginUserID: widget.loginUserID,loginUsername:widget. loginUsername,
                                                zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                                            } else {
                                              callNext( NoPaymentGateway(loginUserPhone: widget.loginUserPhone,
                                                  subScriberType: widget.subScriberType,
                                                  loginUserID: widget.loginUserID,loginUsername: widget.loginUsername,
                                                zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                                                sponsorItemOnePrice: widget.sponsorItemOnePrice,
                                                sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                                                foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,),
                                                  context);
                                            }
                                          });
                                        },
                                        child:
                                            // SizedBox(
                                            //   width: width * .900,
                                            //   child: SwipeableButtonView(
                                            //
                                            //     buttonText: 'Participate Now',
                                            //   buttontextstyle: const TextStyle(
                                            //     fontSize: 21,
                                            //       color: myWhite, fontWeight: FontWeight.bold
                                            //   ),
                                            //   //  buttonColor: Colors.yellow,
                                            //     buttonWidget: Container(
                                            //       child: const Icon(
                                            //         Icons.arrow_forward_ios_rounded,
                                            //         color: Colors.grey,
                                            //       ),
                                            //     ),
                                            //    // activeColor:isFinished==false? const Color(0xFF051270):Colors.white.withOpacity(0.8),
                                            //
                                            //     activeColor:isFinished==false?  cl_34CC04:cl_34CC04,//change button color
                                            //     disableColor: Colors.purple,
                                            //
                                            //     isFinished: isFinished,
                                            //     onWaitingProcess: () {
                                            //       Future.delayed(const Duration(milliseconds: 10), () {
                                            //         setState(() {
                                            //           isFinished = true;
                                            //         });
                                            //       });
                                            //     },
                                            //     onFinish: () async {
                                            //       mRoot.child('0').child('PaymentGateway35').onValue.listen((event) {
                                            //         if (event.snapshot.value.toString() == 'ON') {
                                            //           DonationProvider donationProvider =
                                            //           Provider.of<DonationProvider>(context,
                                            //               listen: false);
                                            //           donationProvider.amountTC.text = "";
                                            //           donationProvider.nameTC.text = "";
                                            //           donationProvider.phoneTC.text = "";
                                            //           donationProvider.kpccAmountController.text = "";
                                            //           donationProvider.onAmountChange('');
                                            //           donationProvider.clearGenderAndAgedata();
                                            //           donationProvider.selectedPanjayathChip = null;
                                            //           donationProvider.chipsetWardList.clear();
                                            //           donationProvider.selectedWard = null;
                                            //           '1';
                                            //
                                            //           callNext(DonatePage(monthList: [],loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,), context);
                                            //         } else {
                                            //           callNext(const NoPaymentGateway(loginUserPhone: widget.loginUserPhone,subScriberType: widget.subScriberType,), context);
                                            //         }
                                            //       });
                                            //       setState(() {
                                            //         isFinished = false;
                                            //       });
                                            //     },
                                            //   ),
                                            // )
                                            ///
                                            Container(
                                          height: 50,
                                          width: width * .760,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              const BoxShadow(
                                                color: cl1883B2,
                                              ),
                                              BoxShadow(
                                                color:
                                                    cl000000.withOpacity(0.25),
                                                spreadRadius: -5.0,
                                                // blurStyle: BlurStyle.inner,
                                                blurRadius: 20.0,
                                              ),
                                            ],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(35)),
                                            gradient: const LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [cl1883B2, cl19A391]),
                                          ),
                                          child: const Center(
                                              child: Text(
                                            "Participate Now",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "PoppinsMedium",
                                                color: myWhite,
                                                fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            }),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TpcContainer(double width, String Ctext, String ImgTxt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: width,
        decoration: const BoxDecoration(
          color: knmGradient5,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: knmGradient2,
                child: Image.asset(
                  ImgTxt,
                  height: 18,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Text(
                Ctext,
                style: const TextStyle(
                    color: knmGradient6,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Heebo"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildImage(var image, context) {
    return Consumer<DonationProvider>(
      builder: (context,value,child) {
        return Container(
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          // margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill,
            ),
            // color: Colors.yellow,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children:  [
                const Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Image(image: AssetImage("assets/qmchBg.png"))
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:[
                    const Flexible(
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit  Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                        style: TextStyle(
                          color: myWhite,
                          fontSize: 10,
                          fontFamily: 'JaldiBold',
                          fontWeight: FontWeight.w400,
                          height: 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40,left: 22),
                      child: InkWell(
                        onTap: () {
                          value.fetchAllNews(true);
                          callNext( UserActivityHomeScreen(), context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 30,
                          // margin: const EdgeInsets.only(
                          //   bottom: 5,
                          // ),
                          decoration: ShapeDecoration(
                            color: Colors.black.withOpacity(.1),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(5),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(
                                child: Text(
                                  'Activities',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontFamily: 'MontserratMedium',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 12,)
                            ],
                          ),
                        ),
                      ),
                    )
                  ]
                )

              ]),
          // child: ClipRRect(
          //   borderRadius: BorderRadius.circular(30),
          //   child: Image.asset(image, fit: BoxFit.fill),
          // ),
        );
      }
    );
  }

  buidIndiaCator(int count, BuildContext context) {
    int imgCount = count;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: imgCount,
            effect: ExpandingDotsEffect(
                activeDotColor: cl253068,
                dotColor: myBlack.withOpacity(0.20),
                dotHeight: 7,
                dotWidth: 8)
            // JumpingDotEffect(
            //     dotWidth:activeIndex==1?20:7,
            //     dotHeight: 7,
            //     activeDotColor: myBlack,
            //     dotColor: Color(0xffaba17c)),
            ),
      ),
    );
  }

  ///exit function
  Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 95,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit?"),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Expanded(
                          flex:1,
                          child:
                          InkWell(onTap: (){
                            exit(0);
                          },

                            child: Container(
                              height: 35,
                              alignment:Alignment.center,
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment(-1.00, -0.00),
                                  end: Alignment(1, 0),
                                  colors: [cl3E4FA3, cl253068],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                  color: myWhite,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                      ),
                      const SizedBox(width: 15),

                      Expanded(
                        flex:1,
                        child: InkWell(
                          onTap:(){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment:Alignment.center,
                            height: 35,
                            decoration: ShapeDecoration(
                              color: myWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x1C000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: const Text(
                              'No',
                              style: TextStyle(
                                color:cl253068,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           exit(0);
                  //         },
                  //         style: ElevatedButton.styleFrom(primary: Color(0xFF3E4FA3),),
                  //         child: const Text("Yes"),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 15),
                  //     Expanded(
                  //         child: ElevatedButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop(false);
                  //           },
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor: Colors.white,
                  //           ),
                  //           child: const Text("No",
                  //               style: TextStyle(color: Colors.black)),
                  //         ))
                  //   ],
                  // )
                ],
              ),
            ),
          );
        });
  }
  Future<AlertDialog?> deviceIdAlreadyExistAlert(
      BuildContext context, String id, String name) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Center(
                child: Column(
                  children: [
                    const Text(
                      "Already you are a volunteer.",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "PoppinsMedium",
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(
                              children: [
                                const TextSpan(
                                    text: "Volunteer ID : ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: myBlack,
                                    )),
                                TextSpan(
                                  text: id,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: myBlack),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      Clipboard.setData(
                                              new ClipboardData(text: id))
                                          .then((_) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          backgroundColor: myWhite,
                                          content: Text(
                                            "Copied ID !",
                                            style: TextStyle(color: myBlack),
                                          ),
                                        ));
                                      });
                                    },
                                ),
                              ],
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: id))
                                    .then((_) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    backgroundColor: myWhite,
                                    content: Text(
                                      "Copied ID !",
                                      style: TextStyle(color: myBlack),
                                    ),
                                  ));
                                });
                              },
                              child: const Text(
                                "CopyID",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline),
                              ),
                              // const Icon(
                              //   Icons.content_copy,
                              //   color: myBlack,
                              //   size: 25,
                              // ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                              children: [
                                const TextSpan(
                                    text: " Name            : ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: myBlack,
                                    )),
                                TextSpan(
                                  text: name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: myBlack),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              backgroundColor: myWhite,
              contentPadding: const EdgeInsets.only(
                top: 15.0,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              content: Consumer<HomeProvider>(builder: (context, value, child) {
                return Container(
                    width: 400,
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                    decoration: const BoxDecoration(
                        color: myWhite,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10))),
                    child: SingleChildScrollView(
                        child: Form(
                      key: _formKey,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Consumer<HomeProvider>(
                            builder: (context, value3, child) {
                          return InkWell(
                            onTap: () {
                              finish(context);
                            },
                            child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(35)),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [cl323A71, cl1177BB])),
                                child: const Center(
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          );
                        }),
                      ]),
                    )));
              }));
        });
  }

  Future<AlertDialog?> VoulenteerNotApprovedAlert(
      BuildContext context, String id, String name,String status) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final width=MediaQuery.of(context).size.width;
          return AlertDialog(
              backgroundColor: myWhite,
              insetPadding: EdgeInsets.zero,
              titlePadding: const EdgeInsets.only(top:15,bottom:0),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),

              title: const Text(
                'Pending Admin Approval',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: myBlack,
                  fontSize: 16,
                  fontFamily: 'JaldiBold',
                  fontWeight: FontWeight.w400,
                ),
              ),

              content:SizedBox(
                height:120,
                child:Consumer<HomeProvider>(builder: (context, value, child) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                      text: "Volunteer ID : ",
                                      style: TextStyle(
                                        color: myBlack,
                                        fontSize: 13,
                                        fontFamily: 'JaldiBold',
                                        fontWeight: FontWeight.w400,
                                      )
                                  ),
                                  TextSpan(
                                    text: id,
                                    style: const TextStyle(
                                      color: myBlack,
                                      fontSize: 13,
                                      fontFamily: 'Jaldi',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        Clipboard.setData(
                                            new ClipboardData(text: id))
                                            .then((_) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            backgroundColor: myWhite,
                                            content: Text(
                                              "Copied ID !",
                                              style: TextStyle(color: myBlack),
                                            ),
                                          ));
                                        });
                                      },
                                  ),
                                ],
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: id))
                                    .then((_) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    backgroundColor: myWhite,
                                    content: Text(
                                      "Copied ID !",
                                      style: TextStyle(color: myBlack),
                                    ),
                                  ));
                                });
                              },
                              child: const Icon(Icons.copy,size:15,color:Colors.blue)
                          ),
                        ],
                      ),

                      RichText(
                          textAlign:TextAlign.center,
                          maxLines: 2,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: " Name  : ",
                                  style: TextStyle(
                                    color: myBlack,
                                    fontSize: 13,
                                    fontFamily: 'JaldiBold',
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                              TextSpan(
                                text: name,
                                style: const TextStyle(
                                  color: myBlack,
                                  fontSize: 13,
                                  fontFamily: 'Jaldi',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height:20),
                      SizedBox(
                        width:width*.50,
                        height: 40,
                        child: Form(
                          key: _formKey,
                          child: Consumer<HomeProvider>(
                              builder: (context, value3, child) {
                                return InkWell(
                                  onTap: () {
                                    finish(context);
                                  },
                                  child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * 0.7,
                                      decoration: ShapeDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment(-1.00, -0.00),
                                          end: Alignment(1, 0),
                                          colors: [cl3E4FA3, cl253068],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(34),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Ok",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                );
                              }),
                        ),
                      ),
                    ],
                  );
                })
              )
          );
        });
  }
  OutlineInputBorder border2 = OutlineInputBorder(
      borderSide: BorderSide(color: textfieldTxt.withOpacity(0.7)),
      borderRadius: BorderRadius.circular(10));
}

String getAmount(double totalCollection) {
  final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
  String newText1 = formatter.format(totalCollection);
  String newText =
      formatter.format(totalCollection).substring(0, newText1.length - 3);
  return newText;
}
Future<bool> logoutAlert(context,String loginUsername,String loginUserID,String subScriberType) async {
  HomeProvider homeProvider =
  Provider.of<HomeProvider>(context, listen: false);
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        final width=MediaQuery.of(context).size.width;
        return AlertDialog(
          // shadowColor: Colors.transparent,
          backgroundColor: myWhite,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          content: Container(
            width:width*.70,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),

              image: const DecorationImage(
                scale: 1.5,
                image: AssetImage('assets/logoForAlert.png',), // Replace with your image asset
                // fit: BoxFit.fill, // Adjust the background size as needed
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const Text(
                  'Confirm logout',
                  style: TextStyle(
                    color: myBlack,
                    fontSize: 14,
                    fontFamily: 'JaldiBold',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height:10),

                const Text(
                  'Are you sure want to log out?',
                  style: TextStyle(
                    color: cl5C5C5C,
                    fontSize: 12,
                    fontFamily: 'JaldiBold',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex:1,
                      child: InkWell(
                        onTap:(){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment:Alignment.center,
                          height: 35,
                          decoration: ShapeDecoration(
                            color: myWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(34),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x1C000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color:cl253068,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      flex:1,
                      child:InkWell(
                        onTap:(){
                          FirebaseAuth auth = FirebaseAuth.instance;
                          auth.signOut();
                          homeProvider.clearVoulenteerStatus();
                          callNextReplacement( HomeScreenNew(subScriberType: '',
                            loginUsername: '', loginUserID: '',loginUserPhone: '',
                          sponsorCategory: '',sponsorCount: '',sponsorItemOnePrice: '',sponsorPatientAmonut: '',
                          zakathAmount: '',footkitCount: '',foodkitPrice: '',foodkitAmount: '',equipmentAmount: '',deseaseName: ''), context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor:Colors.black,
                                  content: Text("Successfully Logged out")));
                        },
                        child: Container(
                          height: 35,
                            alignment:Alignment.center,
                            decoration: ShapeDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(-1.00, -0.00),
                                end: Alignment(1, 0),
                                colors: [cl3E4FA3, cl253068],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(34),
                              ),
                            ),
                          child: const Text(
                            'Ok',
                            style: TextStyle(
                              color: myWhite,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

Future<bool> sendVoulenteerRequest(context,String loginUsername,String loginUserID,String subScriberType,String loginUserPhone) async {
  HomeProvider homeProvider =
  Provider.of<HomeProvider>(context, listen: false);
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        final width=MediaQuery.of(context).size.width;
        return AlertDialog(
          // shadowColor: Colors.transparent,
          backgroundColor: myWhite,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          content: SizedBox(
            width:width*.70,
            height: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const Text(
                   'Volunteer Registration',
                  style: TextStyle(
                    color: myBlack,
                    fontSize: 14,
                    fontFamily: 'JaldiBold',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height:10),

                const Text(
                 'Do you want to become a volunteer?',
                  style: TextStyle(
                    color: cl5C5C5C,
                    fontSize: 12,
                    fontFamily: 'JaldiBold',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex:1,
                      child: InkWell(
                        onTap:(){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment:Alignment.center,
                          height: 35,
                          decoration: ShapeDecoration(
                            color: myWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(34),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x1C000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),

                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color:cl253068,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      flex:1,
                      child: InkWell(
                        onTap:(){
                          homeProvider.requestasVoulenteer(context,loginUsername,loginUserID,subScriberType,loginUserPhone);
                          homeProvider.checkVoulenteerApproved(loginUserPhone);Navigator.of(context).pop();
                          const snackBar = SnackBar(
                            content: Center(child: Text('Request send successfully',style: TextStyle(color: Colors.white),)),
                            backgroundColor: Colors.green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Container(
                          alignment:Alignment.center,
                          height: 35,
                          decoration: ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(-1.00, -0.00),
                              end: Alignment(1, 0),
                              colors: [cl3E4FA3, cl253068],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(34),
                            ),
                          ),
                          child: const Text(
                            'Request Send',
                            style: TextStyle(
                              color: myWhite,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      });
}

void _showTopSheet(BuildContext context,String loginUsername,String loginUserID, String subScriberType,
    String phone) {
  DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withOpacity(0.2),
    transitionDuration: const Duration(milliseconds: 800),
    pageBuilder: (context, animation1, animation2) {
      final width = MediaQuery.of(context).size.width;

      return  Align(
          alignment: Alignment.topCenter,
          child: Container(
            // width: width*.80,
            // height: 400,
            height: 370,
            decoration: BoxDecoration(
              color: myWhite,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(
                    height: 155,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                              height: 120,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(26),
                                    topLeft: Radius.circular(26),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage("assets/VolunRA.png"),
                                    fit: BoxFit.cover,
                                  )
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    InkWell(
                                      onTap: (){
                                        donationProvider.fileImage=null;
                                        editProfileImage(context,loginUsername,loginUserID,subScriberType);
                                      },
                                      child: const Icon(Icons.arrow_back_ios,color: myWhite,size: 20,),
                                    ),

                                    const Text(
                                      'Profile',
                                      style: TextStyle(
                                        color: myWhite,
                                        fontSize: 12,
                                        fontFamily: 'PoppinsRegular',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    const SizedBox()
                                  ]
                              ),
                            ),
                            Container(height: 30,),
                          ],
                        ),

                         Align(
                          alignment: Alignment.bottomCenter,
                          child: Consumer<DonationProvider>(
                            builder: (context,value,child) {

                              return
                                value.userImgUrl!=''?
                                InkWell(onTap: (){
                                  donationProvider.fileImage=null;
                                  finish(context);
                                  editProfileImage(context,loginUsername,loginUserID,subScriberType);
                                },
                                  child: Container(
                                    width: 55,
                                    height: 55,
                                    decoration:  BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(value.userImgUrl),
                                          fit: BoxFit.cover,
                                        ),
                                        gradient: SweepGradient(
                                          center: Alignment(0, 1),
                                          startAngle: 0,
                                          endAngle: 1,
                                          colors: [Color(0xFF3E4FA3), Color(0xFF253068)],),
                                        shape: BoxShape.circle),

                                  ),
                                ): Stack(
                                  children: [
                                    InkWell(onTap:(){
                                      print('INCFIEV');
                                      donationProvider.fileImage=null;
                                      finish(context);
                                      editProfileImage(context,loginUsername,loginUserID,subScriberType);
                                    },
                                      child: CircleAvatar(

                                        radius: 29,
                                        backgroundColor: Colors.grey.shade200,
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.white,
                                          child: Image.asset('assets/profile.png', scale: 5),
                                        ),
                                      ),
                                    ),
                                    Positioned(bottom: 10,right: 0,
                                        child: CircleAvatar(radius: 8,backgroundColor:Color(0xFF3E4FA3),
                                            child: Icon(Icons.add,color: Colors.white,size: 8,)))
                                  ],
                                );
                            }
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height:5),

                  ///

                  Container(
                    margin:const EdgeInsets.symmetric(horizontal:15),
                    padding: const EdgeInsets.all(8),
                    decoration: ShapeDecoration(
                      color: myWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),

                        Row(
                            children:[
                              Flexible(
                                  fit:FlexFit.tight,
                                  child: Container(
                                    // color: Colors.red,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name*',
                                          style: TextStyle(
                                            color: myBlack.withOpacity(0.3),
                                            fontSize: 10,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.10,
                                          ),
                                        ),

                                        const SizedBox(height: 5,),

                                         Text(
                                           loginUsername,
                                          style: const TextStyle(
                                            color: myBlack,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            // height: 0.11,
                                            letterSpacing: 0.12,
                                          ),
                                        ),

                                      ],
                                    ),
                                  )),

                              const SizedBox(width: 10,),

                              // CircleAvatar(
                              //   backgroundColor:myBlack.withOpacity(0.07),
                              //   radius: 20,
                              //   child: const Icon(Icons.edit_outlined,color: myBlack,),
                              // )
                            ]
                        ),

                        const SizedBox(height: 10,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile Number*',
                              style: TextStyle(
                                color: myBlack.withOpacity(0.3),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.10,
                              ),
                            ),

                            const SizedBox(height: 5),

                             Text(
                              phone,
                              style: const TextStyle(
                                color: myBlack,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                // height: 0.11,
                                letterSpacing: 0.12,
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(height: 10,),

                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       'Address*',
                        //       style: TextStyle(
                        //         color: myBlack.withOpacity(0.3),
                        //         fontSize: 10,
                        //         fontFamily: 'Poppins',
                        //         fontWeight: FontWeight.w400,
                        //         letterSpacing: 0.10,
                        //       ),
                        //     ),
                        //
                        //     const SizedBox(height: 5),
                        //
                        //     const Text(
                        //       'Chengayi (H) Chennai, THIRUVOTRIYUR, 676519',
                        //       style: TextStyle(
                        //         color: myBlack,
                        //         fontSize: 12,
                        //         fontFamily: 'Poppins',
                        //         fontWeight: FontWeight.w500,
                        //         // height: 0.11,
                        //         letterSpacing: 0.12,
                        //       ),
                        //     ),
                        //
                        //   ],
                        // ),

                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),

                  const SizedBox(height:15),

                  InkWell(
                    onTap:(){
                      logoutAlert(context,loginUsername,loginUserID,subScriberType,);
                    },
                    child: Container(
                      width: 98,
                      height: 31,
                      decoration: ShapeDecoration(
                        color: myWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 4,
                            offset: Offset(0, 3),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:const [
                          Text(
                            'Log out ',
                            style: TextStyle(
                              color: myBlack,
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(Icons.logout,color:clA43F3F,size:15)
                        ]
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
        );

    },
    transitionBuilder: (context, animation1, animation2, child) {
      return SlideTransition(
        position:
        Tween(begin: const Offset(0.0, -1.0), end: const Offset(0.0, 0.0))
            .animate(animation1),
        child: child,
      );
    },
  );
}

editProfileImage(context,String loginUsername,String loginUserID,String loginType) async {
  HomeProvider homeProvider =
  Provider.of<HomeProvider>(context, listen: false);
  DonationProvider donationProvider =
  Provider.of<DonationProvider>(context, listen: false);
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        final width=MediaQuery.of(context).size.width;
        return AlertDialog(
          // shadowColor: Colors.transparent,
          backgroundColor: myWhite,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          content: Container(
            width:width*.70,
            // height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),

              image: const DecorationImage(
                scale: 1.5,
                image: AssetImage('assets/logoForAlert.png',), // Replace with your image asset
                // fit: BoxFit.fill, // Adjust the background size as needed
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [

                const Text(
                  'Change Profile Image',
                  style: TextStyle(
                    color: myBlack,
                    fontSize: 14,
                    fontFamily: 'JaldiBold',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height:10),


                InkWell(onTap: () {
                  donationProvider.showBottomSheet(context);
                }, child: Consumer<DonationProvider>(
                    builder: (context, value, child) {

                      return value.fileImage != null
                          ?  Container(
                          width: 90,
                          height: 90,

                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x0A000000),
                                  blurRadius: 5.15,
                                  offset: Offset(0, 2.58),
                                  spreadRadius: 0,
                                )
                              ],
                              image: DecorationImage(
                                  image: FileImage(value.fileImage!),fit: BoxFit.cover)))
                          : value.userImgUrl != ""
                          ? Container(
                          width: 90,
                          height: 90,

                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 5.15,
                                offset: Offset(0, 2.58),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Image.network(value.userImgUrl!,fit: BoxFit.cover,))
                          : Column(
                        children: [
                          Container(
                            width: 90,
                            height: 90,

                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x0A000000),
                                    blurRadius: 5.15,
                                    offset: Offset(0, 2.58),
                                    spreadRadius: 0,
                                  )
                                ],
                                image: const DecorationImage(
                                    image: AssetImage(
                                      "assets/upload_poto.png",),scale: 1.5)
                            ),),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Opacity(
                              opacity: 0.22,
                              child: Text(
                                'Add Photo',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,

                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    })),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex:1,
                      child: InkWell(
                        onTap:(){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment:Alignment.center,
                          height: 35,
                          decoration: ShapeDecoration(
                            color: myWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(34),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x1C000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color:cl253068,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                        flex:1,
                        child:
                        InkWell(onTap: (){
                          finish(context);
                          donationProvider.updateUserProfile(loginType,loginUserID,context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.blue,
                            content: Center(child: Text("Profile image successfully updated")),
                            duration: Duration(milliseconds: 3000),
                          ));
                        },

                          child: Container(
                            height: 35,
                            alignment:Alignment.center,
                            decoration: ShapeDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(-1.00, -0.00),
                                end: Alignment(1, 0),
                                colors: [cl3E4FA3, cl253068],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(34),
                              ),
                            ),
                            child: const Text(
                              'Update',
                              style: TextStyle(
                                color: myWhite,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
