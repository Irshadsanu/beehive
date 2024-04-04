import 'dart:io';
import 'dart:ui';
import 'package:beehive/Screens/payment_history.dart';
import 'package:beehive/Screens/reciept_list_page.dart';
import 'package:beehive/Screens/ward_history.dart';
import 'package:beehive/Screens/web_homescreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'donate_page.dart';
import 'home_screen.dart';
import 'no_paymet_gatway.dart';

class HomeScreen extends StatefulWidget {
  String loginUsername,loginUserID,subScriberType;
   HomeScreen({Key? key,required this.loginUsername,required this.loginUserID,required this.subScriberType}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();

  ValueNotifier<int> bodyActiveIndex = ValueNotifier(0);


  final List<Color> colorsBack = [
    myLightGreenNewUI,
    myLightBlueNewUI,
    myLightRedNewUI,
    myLightOrangeNewUI,
    myLightYellowNewUI
  ];



  //  List<Widget> screens=[
  //    HomeScreenNew(),
  //   ReceiptListPage(from: 'home', total: '',),
  //   WardHistory(),
  //   PaymentHistory()
  // ];

  List<Widget> webScreens=[
    const WebHomeScreen(),
    ReceiptListPage(from: 'home', total: '',ward: '', panchayath: '', district: '', target: '',
        loginUserID: '',loginUsername: '',subScriberType: '',loginUserPhone: '',equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
        sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''),
    WardHistory(loginUserID: '',loginUsername: '',subScriberType: '',loginUserPhone: '',equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
        sponsorCategory: '',foodkitAmount: '',foodkitPrice: ''),
    PaymentHistory(loginUserID: '',loginUsername: '',subScriberType: '',loginUserPhone: '',equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
        sponsorCategory: '',foodkitPrice: '',foodkitAmount: '',)
  ];

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () async {
    //   mRootReference.child("0").child("alertImage").once().then((event) async {
    //     if(event.snapshot.exists){
    //       SharedPreferences userPreference = await SharedPreferences.getInstance();
    //       if (userPreference.getString("AlertImageUrl") == null&&userPreference.getString("AlertImageUrl")!=event.snapshot.value.toString()) {
    //         showAlert(event.snapshot.value.toString(),context);
    //       }
    //       userPreference.setString("AlertImageUrl", event.snapshot.value.toString());
    //     }
    //   });
    // });
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    if (!kIsWeb) {
      return queryData.orientation == Orientation.portrait
          ? mobile(context)
          : web(context);
    } else {
      return web(context);
    }
  }
//below body screen navigator to new home screen
// Widget body(BuildContext context) {
  //   final double height = MediaQuery.of(context).size.height;
  //   final double width = MediaQuery.of(context).size.width;
  //   final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  //
  //   DonationProvider donationProvider =
  //       Provider.of<DonationProvider>(context, listen: false);
  //
  //   HomeProvider homeProvider =
  //       Provider.of<HomeProvider>(context, listen: false);
  //
  //   // return Container(
  //   //   decoration: const BoxDecoration(
  //   //       image: DecorationImage(
  //   //           image: AssetImage("assets/homeBackground.png",),
  //   //           fit:BoxFit.fill
  //   //       )
  //   //   ),
  //   //   child: Padding(
  //   //     padding: const EdgeInsets.only(top: 24),
  //   //     child: SingleChildScrollView(
  //   //       child: Column(
  //   //         crossAxisAlignment: CrossAxisAlignment.start,
  //   //         mainAxisAlignment: MainAxisAlignment.start,
  //   //         children: [
  //   //           Padding(
  //   //             padding: const EdgeInsets.all(15.0),
  //   //             child: Column(
  //   //               mainAxisSize: MainAxisSize.min,
  //   //               children: [
  //   //                 const SizedBox(height:15),
  //   //                 Row(
  //   //                   mainAxisAlignment:
  //   //                   MainAxisAlignment.spaceBetween,
  //   //                   children: [
  //   //                     Text(
  //   //                       "KNM !",
  //   //                       style: whitePoppinsBoldM18,
  //   //                     ),
  //   //
  //   //                     Consumer<HomeProvider>(
  //   //                         builder: (context,value,child){
  //   //                           return Text('Ver ${value.currentVersion}',style: TextStyle(color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.bold) ,);
  //   //                         }
  //   //                     )
  //   //
  //   //                   ],
  //   //                 ),
  //   //                 InkWell(
  //   //                   onTap: (){
  //   //                     if(!kIsWeb){
  //   //
  //   //                       mRoot.child('0').child('PaymentGateway34').onValue.listen((event) {
  //   //                         if(event.snapshot.value.toString()=='ON'){
  //   //                           DonationProvider donationProvider =
  //   //                           Provider.of<DonationProvider>(context, listen: false);
  //   //                           donationProvider.amountTC.text = "";
  //   //                           donationProvider.nameTC.text = "";
  //   //                           donationProvider.phoneTC.text = "";
  //   //                           donationProvider.onAmountChange('');
  //   //                           donationProvider.selectedPanjayathChip=null;
  //   //                           donationProvider.chipsetWardList.clear();
  //   //                           donationProvider.selectedWard=null;
  //   //                           donationProvider.dhothiAmount=600;
  //   //                           donationProvider.dhothiCounter=1;
  //   //                           donationProvider.dhotiCounterController.text='1';
  //   //                           callNext(DonatePage(), context);
  //   //                         }
  //   //                       });
  //   //
  //   //                     }
  //   //                   },
  //   //                   child: Stack(
  //   //                     children: [
  //   //                       Padding(
  //   //                         padding: const EdgeInsets.only(top: 20.0,bottom: 15),
  //   //                         child: Container(
  //   //                           height: 85,
  //   //                           width: width,
  //   //                           decoration:  BoxDecoration(
  //   //                             borderRadius: BorderRadius.circular(15),
  //   //                             color: Colors.white.withOpacity(0.2),
  //   //                           ),
  //   //                           child: Padding(
  //   //                             padding: const EdgeInsets.only(left: 10.0),
  //   //                             child: Column(
  //   //                               crossAxisAlignment: CrossAxisAlignment.start,
  //   //                               mainAxisAlignment: MainAxisAlignment.center,
  //   //                               children:  [
  //   //                                 Consumer<HomeProvider>(
  //   //                                   builder: (context,value,child) {
  //   //                                     return Text(getAmount(value.totalCollection),style: whitePoppinsBoldM25,);
  //   //                                   }
  //   //                                 ),
  //   //                                 Text("Collected So Far",style: greyPoppinsR15,),
  //   //                               ],
  //   //                             ),
  //   //                           ),
  //   //                         )
  //   //                       ),
  //   //                       Positioned(
  //   //                         right: 0,
  //   //                         top: 10,
  //   //                         child: Container(
  //   //                           padding: const EdgeInsets.all(4),
  //   //                           decoration: const BoxDecoration(
  //   //                             shape: BoxShape.circle,
  //   //                             color: Colors.red,
  //   //                           ),
  //   //                           child: const Icon(
  //   //                             Icons.currency_rupee_rounded,
  //   //                             size: 20.0,
  //   //                             color: Colors.white,
  //   //                           ),
  //   //                         ),
  //   //                       ),
  //   //                     ],
  //   //                   ),
  //   //                 ),
  //   //
  //   //                 InkWell(
  //   //                   onTap: (){
  //   //                     if(!kIsWeb){
  //   //
  //   //                       mRoot.child('0').child('PaymentGateway34').onValue.listen((event) {
  //   //                         if(event.snapshot.value.toString()=='ON'){
  //   //                           DonationProvider donationProvider =
  //   //                           Provider.of<DonationProvider>(context, listen: false);
  //   //                           donationProvider.amountTC.text = "";
  //   //                           donationProvider.nameTC.text = "";
  //   //                           donationProvider.phoneTC.text = "";
  //   //                           donationProvider.onAmountChange('');
  //   //                           donationProvider.selectedPanjayathChip=null;
  //   //                           donationProvider.chipsetWardList.clear();
  //   //                           donationProvider.selectedWard=null;
  //   //                           donationProvider.dhothiAmount=600;
  //   //                           donationProvider.dhothiCounter=1;
  //   //                           donationProvider.dhotiCounterController.text='1';
  //   //                           callNext(DonatePage(), context);
  //   //                         }
  //   //                       });
  //   //
  //   //                     }
  //   //                   },
  //   //                   child: Stack(
  //   //                     children: [
  //   //                       Padding(
  //   //                         padding: const EdgeInsets.only(top: 11.0,bottom: 15),
  //   //                         child: Container(
  //   //                           height: 85,
  //   //                           width: width,
  //   //                           decoration:  BoxDecoration(
  //   //                             borderRadius: BorderRadius.circular(15),
  //   //                             color: Colors.white.withOpacity(0.2),
  //   //                           ),
  //   //                           child: Padding(
  //   //                             padding: const EdgeInsets.only(left: 10.0),
  //   //                             child: Column(
  //   //                               crossAxisAlignment: CrossAxisAlignment.start,
  //   //                               mainAxisAlignment: MainAxisAlignment.center,
  //   //                               children:  [
  //   //                                 Consumer<HomeProvider>(
  //   //                                   builder: (context,value,child) {
  //   //                                     return Text((value.totalCollection/600).toStringAsFixed(0),style: whitePoppinsBoldM25,);
  //   //                                   }
  //   //                                 ),
  //   //                                 Text("Number Of Participants",style: greyPoppinsR15,),
  //   //                               ],
  //   //                             ),
  //   //                           ),
  //   //                         ),
  //   //                       ),
  //   //
  //   //                       Positioned(
  //   //                         right: 0,
  //   //                         top: 1,
  //   //                         child: Container(
  //   //                           height: 30,
  //   //                           width: 30,
  //   //                           alignment: Alignment.center,
  //   //                           padding: const EdgeInsets.all(4),
  //   //                           decoration: const BoxDecoration(
  //   //                             shape: BoxShape.circle,
  //   //                             color: Colors.red,
  //   //                           ),
  //   //                           child:
  //   //                               Image.asset('assets/participants.png',height: 20,color: Colors.white,)
  //   //                           // Icon(
  //   //                           //   Icons.currency_rupee_rounded,
  //   //                           //   size: 20.0,
  //   //                           //   color: Colors.white,
  //   //                           // ),
  //   //                         ),
  //   //                       ),
  //   //                     ],
  //   //                   ),
  //   //                 ),
  //   //
  //   //
  //   //                 // Padding(
  //   //                 //   padding:
  //   //                 //   const EdgeInsets.only(top: 15, left: 10, right: 10),
  //   //                 //   child: Card(
  //   //                 //       elevation: 10,
  //   //                 //       shadowColor: const Color(0xFFF1F8FA).withOpacity(0.5),
  //   //                 //       shape: const RoundedRectangleBorder(
  //   //                 //         borderRadius: BorderRadius.all(Radius.circular(30)),
  //   //                 //       ),
  //   //                 //       child: Container(
  //   //                 //         height: 120,
  //   //                 //         decoration: const BoxDecoration(
  //   //                 //           borderRadius: BorderRadius.all(
  //   //                 //             Radius.circular(30),
  //   //                 //           ),
  //   //                 //         ),
  //   //                 //         child: Padding(
  //   //                 //           padding:
  //   //                 //           const EdgeInsets.symmetric(horizontal: 15),
  //   //                 //           child: Image.asset(
  //   //                 //             "assets/leadersgif.gif",
  //   //                 //             fit: BoxFit.contain,
  //   //                 //           ),
  //   //                 //         ),
  //   //                 //       )),
  //   //                 // ),
  //   //
  //   //
  //   //
  //   //                 // Padding(
  //   //                 //   padding:
  //   //                 //   const EdgeInsets.only(top: 15.0, left: 10, bottom: 5),
  //   //                 //   child: Align(
  //   //                 //       alignment: Alignment.centerLeft,
  //   //                 //       child: Text("My Hadiya", style: blackPoppinsR15)),
  //   //                 // ),
  //   //                 // (kIsWeb||Platform.isAndroid||homeProvider.iosPaymentGateway=='ON')?ListView.builder(
  //   //                 //     padding: EdgeInsets.zero,
  //   //                 //     shrinkWrap: true,
  //   //                 //     physics: const NeverScrollableScrollPhysics(),
  //   //                 //     itemCount: amount.length,
  //   //                 //     itemBuilder: (BuildContext context, int index) {
  //   //                 //       return InkWell(
  //   //                 //         onTap: () {
  //   //                 //           DonationProvider donationProvider =
  //   //                 //           Provider.of<DonationProvider>(context,
  //   //                 //               listen: false);
  //   //                 //           donationProvider.amountTC.text = amount[index];
  //   //                 //           donationProvider.amountTC.value=CurrencyInputFormatter().formatEditUpdate(donationProvider.amountTC.value, donationProvider.amountTC.value);
  //   //                 //           donationProvider.selectedPanjayathChip=null;
  //   //                 //           donationProvider.chipsetWardList.clear();
  //   //                 //           donationProvider.selectedWard=null;
  //   //                 //           callNext(DonatePage(), context);
  //   //                 //         },
  //   //                 //         child: Container(
  //   //                 //             height: 65,
  //   //                 //             margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
  //   //                 //             decoration: BoxDecoration(
  //   //                 //                 color: myWhite,
  //   //                 //                 borderRadius: BorderRadius.circular(18),
  //   //                 //                 boxShadow: [
  //   //                 //                   BoxShadow(
  //   //                 //                       color: Colors.grey.shade300,
  //   //                 //                       offset: const Offset(3.0, 3.0),
  //   //                 //                       blurRadius: 3.0),
  //   //                 //                   BoxShadow(
  //   //                 //                       color: Colors.grey.shade300,
  //   //                 //                       offset: const Offset(-1.0, -1.0),
  //   //                 //                       blurRadius: 3.0),
  //   //                 //                 ]),
  //   //                 //             child: Row(
  //   //                 //               crossAxisAlignment: CrossAxisAlignment.start,
  //   //                 //               children: [
  //   //                 //                 Stack(
  //   //                 //                   children: [
  //   //                 //                     Image.asset(
  //   //                 //                       "assets/circle.png",
  //   //                 //                       color: colorsBack[index],
  //   //                 //                       fit: BoxFit.fitWidth,
  //   //                 //                       scale: 4,
  //   //                 //                     ),
  //   //                 //                     Padding(
  //   //                 //                       padding: const EdgeInsets.only(
  //   //                 //                           left: 15.0, top: 10),
  //   //                 //                       child: Image.asset(
  //   //                 //                         "assets/money_bag.png",
  //   //                 //                         fit: BoxFit.fitWidth,
  //   //                 //                         scale: 5,
  //   //                 //                       ),
  //   //                 //                     ),
  //   //                 //                   ],
  //   //                 //                 ),
  //   //                 //                 Expanded(
  //   //                 //                   child: Row(
  //   //                 //                     mainAxisAlignment:
  //   //                 //                     MainAxisAlignment.spaceBetween,
  //   //                 //                     children: [
  //   //                 //                       Padding(
  //   //                 //                         padding:
  //   //                 //                         const EdgeInsets.only(left: 10),
  //   //                 //                         child: Column(
  //   //                 //                           mainAxisAlignment:
  //   //                 //                           MainAxisAlignment.center,
  //   //                 //                           crossAxisAlignment:
  //   //                 //                           CrossAxisAlignment.start,
  //   //                 //                           children: [
  //   //                 //                             Text(
  //   //                 //                               amount[index],
  //   //                 //                               style: blackPoppinsM18,
  //   //                 //                             ),
  //   //                 //                             Text(
  //   //                 //                               "Gift of " +
  //   //                 //                                   amountInWords[index],
  //   //                 //                               style: blackPoppinsR12,
  //   //                 //                             ),
  //   //                 //                           ],
  //   //                 //                         ),
  //   //                 //                       ),
  //   //                 //                       Padding(
  //   //                 //                         padding: const EdgeInsets.only(
  //   //                 //                             right: 15),
  //   //                 //                         child: Image.asset(
  //   //                 //                           "assets/round_arrow.png",
  //   //                 //                           scale: 4,
  //   //                 //                           color: colorsBack[index],
  //   //                 //                         ),
  //   //                 //                       ),
  //   //                 //                     ],
  //   //                 //                   ),
  //   //                 //                 ),
  //   //                 //               ],
  //   //                 //             )),
  //   //                 //       );
  //   //                 //     }):const SizedBox(),
  //   //                 //
  //   //
  //   //
  //   //                 const SizedBox(height: 10,),
  //   //
  //   //                 InkWell(
  //   //                   onTap: (){
  //   //                     if(!kIsWeb){
  //   //
  //   //                       mRoot.child('0').child('PaymentGateway34').onValue.listen((event) {
  //   //                         if(event.snapshot.value.toString()=='ON'){
  //   //                           DonationProvider donationProvider =
  //   //                           Provider.of<DonationProvider>(context, listen: false);
  //   //                           donationProvider.amountTC.text = "";
  //   //                           donationProvider.nameTC.text = "";
  //   //                           donationProvider.phoneTC.text = "";
  //   //                           donationProvider.onAmountChange('');
  //   //                           donationProvider.selectedPanjayathChip=null;
  //   //                           donationProvider.chipsetWardList.clear();
  //   //                           donationProvider.selectedWard=null;
  //   //                           donationProvider.dhothiAmount=600;
  //   //                           donationProvider.dhothiCounter=1;
  //   //                           donationProvider.dhotiCounterController.text='1';
  //   //                           callNext(DonatePage(), context);
  //   //                         }
  //   //                       });
  //   //
  //   //                     }
  //   //                   },
  //   //                   child: Container(
  //   //                     alignment: Alignment.center,
  //   //                     height: 200,
  //   //                     width: width,
  //   //                     decoration:  BoxDecoration(
  //   //                       borderRadius: BorderRadius.circular(15),
  //   //                     //  color: Colors.white.withOpacity(0.2),
  //   //                       //color:Colors.yellow,
  //   //                     ),
  //   //                     child:
  //   //                     Column(
  //   //                       mainAxisAlignment: MainAxisAlignment.center,
  //   //                       children: [
  //   //                         CarouselSlider.builder(
  //   //                           itemCount: images.length,
  //   //                           itemBuilder: (context,index,realIndex){
  //   //                             //final image=value.imgList[index];
  //   //                             final image=images[index];
  //   //                             return buildImage(image);
  //   //                           },
  //   //
  //   //                           options:
  //   //                           CarouselOptions(
  //   //                               height: height*.20,
  //   //                               viewportFraction: 1,
  //   //                               autoPlay: true,
  //   //                               //enableInfiniteScroll: false,
  //   //                               pageSnapping: true,
  //   //
  //   //                               enlargeStrategy: CenterPageEnlargeStrategy.height,
  //   //                               enlargeCenterPage: true,
  //   //                               autoPlayInterval: const Duration(seconds:3),
  //   //                               onPageChanged: (index,reason){
  //   //                                 setState(() {
  //   //                                   activeIndex=index;
  //   //                                 });
  //   //                               }
  //   //                           ),
  //   //
  //   //                         ),
  //   //
  //   //                         SizedBox(height: height*.002,),
  //   //                         buidIndiaCator(images.length),
  //   //                       ],
  //   //                     )
  //   //                   ),
  //   //                 ),
  //   //
  //   //                 const SizedBox(height: 10,),
  //   //
  //   //                 Container(
  //   //                   width: width,
  //   //                   decoration:  BoxDecoration(
  //   //                     borderRadius: BorderRadius.circular(15),
  //   //                     color: myWhite2.withOpacity(0.95),
  //   //                   ),
  //   //                   child: Center(
  //   //                     child: SingleChildScrollView(
  //   //                       scrollDirection: Axis.horizontal,
  //   //                       child: Padding(
  //   //                         padding: const EdgeInsets.all(20.0),
  //   //                         child: Row(
  //   //                           children: [
  //   //                             InkWell(
  //   //                               onTap: (){
  //   //                                 callNext( PaymentHistory(), context);
  //   //                               },
  //   //                               child: Column(
  //   //                                 children: [
  //   //                                   SizedBox(
  //   //                                     height: 100,
  //   //                                     width: 100,
  //   //                                     child: Center(
  //   //                                       child: Image.asset("assets/history_icon.png",scale: 2.5,),
  //   //                                     ),
  //   //                                   ),
  //   //                                   const SizedBox(height: 12,),
  //   //                                    Text("History",style: greyBoldPoppinsR12,)
  //   //                                 ],
  //   //                               ),
  //   //                             ),
  //   //                              const SizedBox(width: 15,),
  //   //                             InkWell(
  //   //
  //   //
  //   //                               onTap: () async {
  //   //                                 if(!kIsWeb){
  //   //                                   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   //                                   String packageName = packageInfo.packageName;
  //   //                                   if(packageName!='com.spine.dhotiMonitor'&&packageName!='com.spine.dhotiTv'){
  //   //                                     homeProvider.currentLimit=50;
  //   //                                     homeProvider.fetchReceiptList(50);
  //   //                                     callNext(ReceiptListPage(from: "home",total: ''), context);
  //   //                                   }else{
  //   //                                     HomeProviderReceiptApp homeProvider = Provider.of<HomeProviderReceiptApp>(context, listen: false);
  //   //                                     homeProvider.increaseLimit(20);
  //   //                                     homeProvider.fetchReceiptList(DateTime.now());
  //   //                                     homeProvider.filteredPaymentDetailsList=homeProvider.paymentDetailsList;
  //   //                                     callNext(ReceiptListPageOld(), context);
  //   //
  //   //                                     // homeProvider.fetchPaymentReceiptList();
  //   //                                   }
  //   //                                 }else{
  //   //                                   homeProvider.currentLimit=50;
  //   //                                   homeProvider.fetchReceiptList(50);
  //   //                                   callNext(ReceiptListPage(from: "home",total: ''), context);
  //   //                                 }
  //   //                               },
  //   //
  //   //
  //   //
  //   //                               child: Column(
  //   //                                 children: [
  //   //                                   SizedBox(
  //   //                                     height: 100,
  //   //                                     width: 100,
  //   //                                     child: Image.asset("assets/transaction.png",),
  //   //                                   ),
  //   //                                   const SizedBox(height: 12,),
  //   //                                   Text("Transactions",style: greyBoldPoppinsR12,)
  //   //                                 ],
  //   //                               ),
  //   //                             ),
  //   //                             const SizedBox(width: 15,),
  //   //                             InkWell(
  //   //                               onTap: (){
  //   //                                 // homeProvider.selectedDistrict=null;
  //   //                                 // homeProvider.selectedPanjayath=null;
  //   //                                 // homeProvider.selectedUnit=null;
  //   //                                 // homeProvider.fetchDropdown('','');
  //   //                                 // homeProvider.fetchWard();
  //   //                                  callNext( WardHistory(), context);
  //   //                               },
  //   //
  //   //                               child: Column(
  //   //                                 children: [
  //   //                                   SizedBox(
  //   //                                     height: 100,
  //   //                                     width: 100,
  //   //                                     child: Center(
  //   //                                       child: Image.asset("assets/report_icon.png",scale: 2.5,),
  //   //                                     ),
  //   //                                   ),
  //   //                                   const SizedBox(height: 12,),
  //   //                                   Text("Report",style: greyBoldPoppinsR12,)
  //   //                                 ],
  //   //                               ),
  //   //                             ),
  //   //
  //   //                           ],
  //   //                         ),
  //   //                       ),
  //   //                     ),
  //   //                   ),
  //   //
  //   //                 ),
  //   //
  //   //                 Padding(
  //   //                     padding: const EdgeInsets.only(top: 20.0,bottom: 15),
  //   //                     child: InkWell(
  //   //                       onTap: (){
  //   //                         // alertSupport(context);
  //   //                       },
  //   //                       child: Container(
  //   //                         height: 60,
  //   //                         width: width,
  //   //                         decoration:  BoxDecoration(
  //   //                           borderRadius: BorderRadius.circular(15),
  //   //                           color: Colors.white.withOpacity(0.2),
  //   //                         ),
  //   //                         child:
  //   //                         Padding(
  //   //                           padding: const EdgeInsets.only(right:20,left:20),
  //   //                           child: Row(
  //   //                            // crossAxisAlignment: CrossAxisAlignment.center,
  //   //                             mainAxisAlignment:
  //   //                             MainAxisAlignment.spaceBetween,
  //   //                             children: [
  //   //                               Text(
  //   //                                 "Support Call",
  //   //                                 style: whitePoppinsBoldM18,
  //   //                               ),
  //   //
  //   //                               Container(
  //   //                                 //alignment: Alignment.center,
  //   //                                 decoration: const BoxDecoration(
  //   //                                     shape: BoxShape.circle,
  //   //                                    // borderRadius: BorderRadius.circular(50),
  //   //                                     color: myWhite
  //   //                                 ),
  //   //                                 child: Center(
  //   //                                     child: Padding(
  //   //                                       padding: const EdgeInsets.all(8.0),
  //   //                                       child: Image.asset(
  //   //                                         'assets/help.png',
  //   //                                         scale: 4,
  //   //                                       ),
  //   //                                     )),
  //   //                               ),
  //   //                             ],
  //   //                           ),
  //   //                         ),
  //   //                       ),
  //   //                     )
  //   //                 ),
  //   //
  //   //                 //terms and condition
  //   //                 // InkWell(
  //   //                 //   onTap: (){
  //   //                 //     alertTermsAndConditions(context);
  //   //                 //   },
  //   //                 //   child: SizedBox(
  //   //                 //     height:34,
  //   //                 //     width:width,
  //   //                 //     //color:Colors.yellow,
  //   //                 //     child: Padding(
  //   //                 //         padding: const EdgeInsets.only(top: 2.0,bottom: 2),
  //   //                 //         child: Row(
  //   //                 //           // crossAxisAlignment: CrossAxisAlignment.center,
  //   //                 //           // mainAxisAlignment:
  //   //                 //           // MainAxisAlignment.spaceBetween,
  //   //                 //           children: [
  //   //                 //             const SizedBox(width: 10,),
  //   //                 //             Container(
  //   //                 //               //alignment: Alignment.center,
  //   //                 //               decoration: const BoxDecoration(
  //   //                 //                   shape: BoxShape.circle,
  //   //                 //                   // borderRadius: BorderRadius.circular(50),
  //   //                 //                   color: Colors.white
  //   //                 //               ),
  //   //                 //               child: Center(
  //   //                 //                   child: Padding(
  //   //                 //                     padding: const EdgeInsets.all(5.0),
  //   //                 //                     child: Image.asset(
  //   //                 //                       'assets/Layer24copy.png',
  //   //                 //                       fit: BoxFit.cover,
  //   //                 //                       color: Colors.black,
  //   //                 //                       scale: 3,
  //   //                 //                     ),
  //   //                 //                   )),
  //   //                 //             ),
  //   //                 //             const SizedBox(width: 8,),
  //   //                 //             SizedBox(
  //   //                 //               height:23,
  //   //                 //               width:190,
  //   //                 //               //color:Colors.red,
  //   //                 //               child: Text(
  //   //                 //                 "Terms and Conditions",
  //   //                 //                 style: whitePoppinsBoldB1,
  //   //                 //               ),
  //   //                 //             ),
  //   //                 //           ],
  //   //                 //         )
  //   //                 //     ),
  //   //                 //   ),
  //   //                 // ),
  //   //                 // const SizedBox(height: 5,),
  //   //                 // //Privacy policy
  //   //                 // InkWell(
  //   //                 //   onTap: (){
  //   //                 //     alertTerm(context);
  //   //                 //   },
  //   //                 //   child: SizedBox(
  //   //                 //     height:34,
  //   //                 //     width:width,
  //   //                 //    // color:Colors.yellow,
  //   //                 //     child: Padding(
  //   //                 //         padding: const EdgeInsets.only(top: 2.0,bottom: 2),
  //   //                 //         child: Row(
  //   //                 //           // crossAxisAlignment: CrossAxisAlignment.center,
  //   //                 //           // mainAxisAlignment:
  //   //                 //           // MainAxisAlignment.spaceBetween,
  //   //                 //           children: [
  //   //                 //             const SizedBox(width: 10,),
  //   //                 //             Container(
  //   //                 //               //alignment: Alignment.center,
  //   //                 //               decoration: const BoxDecoration(
  //   //                 //                   shape: BoxShape.circle,
  //   //                 //                   // borderRadius: BorderRadius.circular(50),
  //   //                 //                   color: myWhite
  //   //                 //               ),
  //   //                 //               child: Center(
  //   //                 //                   child: Padding(
  //   //                 //                     padding: const EdgeInsets.all(3.0),
  //   //                 //                     child: Image.asset(
  //   //                 //                       'assets/Layer22copy.png',
  //   //                 //                       fit: BoxFit.cover,
  //   //                 //                       color: Colors.black,
  //   //                 //                       scale: 2,
  //   //                 //                     ),
  //   //                 //                   )),
  //   //                 //             ),
  //   //                 //             const SizedBox(width: 8,),
  //   //                 //             SizedBox(
  //   //                 //               height:23,
  //   //                 //               width:190,
  //   //                 //               // color:Colors.red,
  //   //                 //               child: Text(
  //   //                 //                 "Privacy Policy",
  //   //                 //                 style: whitePoppinsBoldB1,
  //   //                 //               ),
  //   //                 //             ),
  //   //                 //           ],
  //   //                 //         )
  //   //                 //     ),
  //   //                 //   ),
  //   //                 // ),
  //   //                 // //Contact Us
  //   //                 // const SizedBox(height: 5,),
  //   //                 // InkWell(
  //   //                 //   onTap: (){
  //   //                 //     alertContact(context);
  //   //                 //   },
  //   //                 //   child: SizedBox(
  //   //                 //     height:30,
  //   //                 //     width:width,
  //   //                 //     //color:Colors.yellow,
  //   //                 //     child: Padding(
  //   //                 //         padding: const EdgeInsets.only(top: 2.0,bottom: 2),
  //   //                 //         child: Row(
  //   //                 //           // crossAxisAlignment: CrossAxisAlignment.center,
  //   //                 //           // mainAxisAlignment:
  //   //                 //           // MainAxisAlignment.spaceBetween,
  //   //                 //           children: [
  //   //                 //             const SizedBox(width: 13,),
  //   //                 //             Container(
  //   //                 //               //alignment: Alignment.center,
  //   //                 //               decoration: const BoxDecoration(
  //   //                 //                   shape: BoxShape.circle,
  //   //                 //                   // borderRadius: BorderRadius.circular(50),
  //   //                 //                   color: myWhite
  //   //                 //               ),
  //   //                 //               child: Center(
  //   //                 //                   child: Padding(
  //   //                 //                     padding: const EdgeInsets.all(2.0),
  //   //                 //                     child: Image.asset(
  //   //                 //                       'assets/Layer23copy.png',
  //   //                 //                       color: Colors.black,
  //   //                 //                       fit: BoxFit.cover,
  //   //                 //                       scale: 2,
  //   //                 //                     ),
  //   //                 //                   )),
  //   //                 //             ),
  //   //                 //             const SizedBox(width: 8,),
  //   //                 //             SizedBox(
  //   //                 //               height:23,
  //   //                 //               width:190,
  //   //                 //
  //   //                 //               child: Text(
  //   //                 //                 "Contact Us",
  //   //                 //                 style: whitePoppinsBoldB1,
  //   //                 //               ),
  //   //                 //             ),
  //   //                 //           ],
  //   //                 //         )
  //   //                 //     ),
  //   //                 //   ),
  //   //                 // ),
  //   //
  //   //                 const SizedBox(height: 30,),
  //   //                 Consumer<HomeProvider>(
  //   //                     builder: (context,value,child){
  //   //                       return Text('App Build : 001',style: TextStyle(color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.bold) ,);
  //   //                     }
  //   //                 )
  //   //
  //   //
  //   //
  //   //               ],
  //   //             ),
  //   //           ),
  //   //
  //   //
  //   //
  //   //
  //   //           // Align(
  //   //           //   alignment: Alignment.center,
  //   //           //   child: Consumer<HomeProvider>(
  //   //           //       builder: (context,value,child){
  //   //           //       return Text('Ver ${value.currentVersion}',style: TextStyle(color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.bold) ,);
  //   //           //     }
  //   //           //   ),
  //   //           // ),
  //   //
  //   //           const SizedBox(
  //   //             height: 65,
  //   //           ),
  //   //         ],
  //   //       ),
  //   //     ),
  //   //   ),
  //   // );
  //
  //   return SingleChildScrollView(
  //     child: Stack(
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //                 width: width,
  //                 // height: 250,
  //                 decoration: const BoxDecoration(
  //                     gradient: LinearGradient(
  //                         begin: Alignment.topLeft,
  //                         end: Alignment.bottomRight,
  //                         colors: [myGradient1, myGradient2])),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     const SizedBox(
  //                       height: 60,
  //                     ),
  //                     const Padding(
  //                       padding: EdgeInsets.only(left: 10.0),
  //                       child: Text(
  //                         'Kerala Nadvathul Mujahideen!',
  //                         style: TextStyle(color: myWhite),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 30,
  //                     ),
  //                     Center(
  //                       child: SizedBox(
  //                         height: 110,
  //                         // color: Colors.blueGrey,
  //                         width: 300,
  //                         child: Stack(
  //                           children: [
  //                             Image.asset("assets/Layer 12.png"),
  //                             Padding(
  //                               padding: const EdgeInsets.only(
  //                                 left: 37.0,
  //                                 top: 52,
  //                               ),
  //                               child: SizedBox(
  //                                 height: 30,
  //                                 //width:  width*.70,
  //                                 // color: Colors.yellow,
  //                                 child: Row(
  //                                   children: [
  //                                     Padding(
  //                                       padding: const EdgeInsets.fromLTRB(
  //                                           3, 3, 14, 3),
  //                                       child: Image.asset(
  //                                         "assets/RsIcon.png",
  //                                         color: myWhite,
  //                                         height: height * .040,
  //                                       ),
  //                                     ),
  //                                     Consumer<HomeProvider>(
  //                                         builder: (context, value, child) {
  //                                       return Text(
  //                                         getAmount(value.totalCollection),
  //                                         style: TextStyle(
  //                                             fontSize: width * .060,
  //                                             fontWeight: FontWeight.w600,
  //                                             color: myWhite),
  //                                       );
  //                                     }),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                             const Positioned(
  //                                 right: 10,
  //                                 bottom: 2,
  //                                 child: Text(
  //                                   'Total amount',
  //                                   style: TextStyle(
  //                                       color: myWhite, fontFamily: "Heebo"),
  //                                 ))
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 70,
  //                     ),
  //                   ],
  //                 )),
  //             Column(
  //               children: [
  //                 const SizedBox(
  //                   height: 45,
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     const Text(
  //                       "Support Call",
  //                       style: TextStyle(
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.w400,
  //                           fontFamily: "Heebo"),
  //                     ),
  //                     const SizedBox(
  //                       width: 10,
  //                     ),
  //                     InkWell(
  //                         onTap: () {
  //                           alertSupport(context);
  //                         },
  //                         child: Container(
  //                           decoration: const BoxDecoration(
  //                             shape: BoxShape.circle,
  //                             boxShadow: [
  //                               BoxShadow(
  //                                   blurRadius: 0.5,
  //                                   color: Colors.grey,
  //                                   spreadRadius: 0.5)
  //                             ],
  //                           ),
  //                           child: const CircleAvatar(
  //                             backgroundColor: myWhite,
  //                             radius: 18.0,
  //                             child: Icon(Icons.call, color: knmCallIcon),
  //                           ),
  //                         )),
  //                     const SizedBox(
  //                       width: 10,
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(left: 10.0),
  //               child: Text(
  //                 "My Contribution",
  //                 style: b_myContributiontx,
  //               ),
  //             ),
  //             amount.isEmpty
  //                 ? const SizedBox()
  //                 : GridView.builder(
  //                     padding: const EdgeInsets.all(10),
  //                     physics: const ScrollPhysics(),
  //                     shrinkWrap: true,
  //                     gridDelegate:
  //                         const SliverGridDelegateWithFixedCrossAxisCount(
  //                       mainAxisSpacing: 7,
  //                       crossAxisSpacing: 7,
  //                       childAspectRatio: 2,
  //                       crossAxisCount: 2,
  //                     ),
  //                     itemCount: amount.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return InkWell(
  //                         onTap: () {
  //                           donationProvider.knmAmountController.text =
  //                               amount[index].toString();
  //                           //donationProvider.knmAmountController
  //                           Navigator.push(
  //                               context,
  //                               MaterialPageRoute(
  //                                   builder: (context) => DonatePage()));
  //                         },
  //                         child: Container(
  //                             decoration: BoxDecoration(
  //                                 color: myWhite,
  //                                 borderRadius: index == 0
  //                                     ? const BorderRadius.only(
  //                                         topLeft: Radius.circular(20),
  //                                         topRight: Radius.circular(5),
  //                                         bottomRight: Radius.circular(5),
  //                                         bottomLeft: Radius.circular(5),
  //                                       )
  //                                     : index == 1
  //                                         ? const BorderRadius.only(
  //                                             topLeft: Radius.circular(5),
  //                                             topRight: Radius.circular(20),
  //                                             bottomRight: Radius.circular(5),
  //                                             bottomLeft: Radius.circular(5),
  //                                           )
  //                                         : index == amount.length - 1
  //                                             ? const BorderRadius.only(
  //                                                 topLeft: Radius.circular(5),
  //                                                 topRight: Radius.circular(5),
  //                                                 bottomRight:
  //                                                     Radius.circular(20),
  //                                                 bottomLeft:
  //                                                     Radius.circular(5),
  //                                               )
  //                                             : index == amount.length - 2
  //                                                 ? const BorderRadius.only(
  //                                                     topLeft:
  //                                                         Radius.circular(5),
  //                                                     topRight:
  //                                                         Radius.circular(5),
  //                                                     bottomRight:
  //                                                         Radius.circular(5),
  //                                                     bottomLeft:
  //                                                         Radius.circular(20),
  //                                                   )
  //                                                 : const BorderRadius.all(
  //                                                     Radius.circular(5))),
  //                             child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   Text(
  //                                     "₹${amount[index]}",
  //                                     style: const TextStyle(
  //                                         color: gold_b7950e, fontSize: 17),
  //                                   ),
  //                                   Text(
  //                                     amountInWords[index],
  //                                     style: const TextStyle(
  //                                         color: gold_b7950e,
  //                                         fontFamily: "Heebo"),
  //                                   )
  //                                 ])),
  //                       );
  //                     }),
  //             InkWell(
  //                 onTap: () {
  //                   alertTermsAndConditions(context);
  //                 },
  //                 child: TpcContainer(width, "Terms and Conditions",
  //                     "assets/Layer24copy.png")),
  //             InkWell(
  //                 onTap: () {
  //                   alertTerm(context);
  //                 },
  //                 child: TpcContainer(
  //                     width, "Privacy Policy", "assets/Layer22copy.png")),
  //             InkWell(
  //                 onTap: () {
  //                   alertContact(context);
  //                 },
  //                 child: TpcContainer(
  //                     width, "Contact Us", "assets/Layer23copy.png")),
  //             const SizedBox(
  //               height: 80,
  //             ),
  //           ],
  //         ),
  //         Positioned(
  //             right: width * .10,
  //             left: width * .10,
  //             top: 230,
  //             child: SizedBox(
  //               //height: 90,
  //               width: width,
  //               // color:Colors.yellow,
  //               child: Column(
  //                 children: [
  //                   CarouselSlider.builder(
  //                     itemCount: images.length,
  //                     itemBuilder: (context, index, realIndex) {
  //                       //final image=value.imgList[index];
  //                       final image = images[index];
  //                       return buildImage(image);
  //                     },
  //                     options: CarouselOptions(
  //                         height: 100,
  //                         viewportFraction: 1,
  //                         autoPlay: true,
  //                         //enableInfiniteScroll: false,
  //                         pageSnapping: true,
  //                         enlargeStrategy: CenterPageEnlargeStrategy.height,
  //                         enlargeCenterPage: true,
  //                         autoPlayInterval: const Duration(seconds: 3),
  //                         onPageChanged: (index, reason) {
  //                           setState(() {
  //                             activeIndex = index;
  //                           });
  //                         }),
  //                   ),
  //                   const SizedBox(
  //                     height: 2,
  //                   ),
  //                   buidIndiaCator(images.length),
  //                 ],
  //               ),
  //             )),
  //       ],
  //     ),
  //   );
  // }

//CustomWidget


  Future<bool> showExitPopup() async {
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
                  const SizedBox(height: 19),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                            },
                          style: ElevatedButton.styleFrom(
                              primary: cl2C4680),
                          child: const Text("Yes"),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text("No", style: TextStyle(
                                color: Colors.black)),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }


  Widget mobile(BuildContext context) {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
    return ValueListenableBuilder(
        valueListenable: bodyActiveIndex,
        builder: (context, int bodyIndex, child) {
          return WillPopScope(
            onWillPop: ()async{
              if(bodyIndex==0){
                 return showExitPopup();
              }else if(bodyIndex==1){
                bodyActiveIndex.value=0;
                 return true;
              }else if(bodyIndex==2){
                homeProvider.streamSubscriptionCancel();
                bodyActiveIndex.value=0;
                return true;

              }else {
                homeProvider.streamSubscriptionCancel();
                bodyActiveIndex.value=0;
                return true;

              }
            },
            child: const Scaffold(
                backgroundColor: cl_c8b3e6,
                body: Center(child: Text("Screen Not Working"),),
                // body:
                // screens[bodyIndex],
                    ///////////

                // floatingActionButton: bodyIndex == 0
                //     ? Consumer<HomeProvider>(builder: (context, value, child) {
                //         return (kIsWeb || Platform.isAndroid ||
                //                 value.iosPaymentGateway == 'ON')
                //             ? Padding(
                //                 padding:
                //                     const EdgeInsets.only(left: 0.0, right:2),
                //                 child: InkWell(
                //                   onTap:(){
                //                       mRoot.child('0')
                //                           .child('PaymentGateway34')
                //                           .onValue
                //                           .listen((event) {
                //                         if (event.snapshot.value.toString() == 'ON') {
                //                           DonationProvider
                //                           donationProvider =
                //                           Provider.of<
                //                               DonationProvider>(
                //                               context,
                //                               listen: false);
                //                           donationProvider.amountTC.text = "";
                //                           donationProvider.nameTC.text = "";
                //                           donationProvider.phoneTC.text = "";
                //                           donationProvider.knmAmountController.text = "";
                //                           donationProvider.onAmountChange('');
                //                           donationProvider.selectedPanjayathChip = null;
                //                           donationProvider.chipsetWardList.clear();
                //                           donationProvider.selectedWard = null;
                //                           '1';
                //                           callNext(DonatePage(), context);
                //                         } else {
                //                           callNext(const NoPaymentGateway(), context);
                //                         }
                //                       });
                //
                //                   },
                //                   child:
                //                   Container(
                //                     height: 50,
                //                     width: width * .900,
                //                     decoration: const BoxDecoration(
                //                         borderRadius:
                //                             BorderRadius.all(Radius.circular(35)),
                //                         gradient: LinearGradient(
                //                             begin: Alignment.centerLeft,
                //                             end: Alignment.centerRight,
                //                             colors: [primary, secondary])),
                //                     child: Row(
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       children: const [
                //                         Icon(
                //                           Icons.add_circle,
                //                           color: myWhite,
                //                           size: 20,
                //                         ),
                //                         SizedBox(width: 5,),
                //                         Center(
                //                           child: Text("Contribute",style: TextStyle(color: myWhite,fontWeight: FontWeight.bold),)
                //                         ),
                //
                //
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               )
                //             : const SizedBox();
                //       })
                //     : null,
                // bottomNavigationBar:
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //       decoration: const BoxDecoration(
                //         borderRadius: BorderRadius.only(
                //           topRight: Radius.circular(30),
                //           topLeft: Radius.circular(30),
                //           bottomLeft: Radius.circular(30),
                //           bottomRight: Radius.circular(30),
                //         ),
                //         boxShadow: [
                //           BoxShadow(
                //               color: Colors.black38,
                //               spreadRadius: 0,
                //               blurRadius: 3),
                //         ],
                //       ),
                //       child: ClipRRect(
                //         borderRadius: const BorderRadius.only(
                //           topLeft: Radius.circular(30.0),
                //           topRight: Radius.circular(30.0),
                //           bottomLeft: Radius.circular(30.0),
                //           bottomRight: Radius.circular(30.0),
                //         ),
                //         child: ValueListenableBuilder(
                //             valueListenable: bodyActiveIndex,
                //             builder: (context, int selectedValue, child) {
                //               return BottomNavigationBar(
                //                 iconSize: 25,
                //                 currentIndex: selectedValue,
                //                 onTap: (int index) async {
                //                   if (index == 0) {
                //                     homeProvider.streamSubscriptionCancel();
                //                     bodyActiveIndex.value = 0;
                //                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreenNew()));
                //                   } else if (index == 1) {
                //                     if (!kIsWeb) {
                //                       PackageInfo packageInfo = await PackageInfo.fromPlatform();
                //                       String packageName = packageInfo.packageName;
                //                       if (packageName != 'com.spine.knmMonitor') {
                //                         print("code here1");
                //                         homeProvider.knmMonitor = false;
                //                         homeProvider.currentLimit = 50;
                //                         homeProvider.fetchReceiptList(50);
                //
                //
                //                       } else {
                //                         print("else code work");
                //                         HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                //                         homeProvider.knmMonitor = true;
                //                         homeProvider.currentLimit=50;
                //                         homeProvider.fetchReceiptListForMonitorApp(50);
                //                         // homeProvider.filteredPaymentDetailsList = homeProvider.paymentDetailsList;
                //
                //                         //bodyActiveIndex.value = 1;
                //                       }
                //                     } else {
                //                       homeProvider.currentLimit = 50;
                //                       homeProvider.fetchReceiptList(50);
                //
                //                       //bodyActiveIndex.value = 1;
                //
                //                     }
                //                     bodyActiveIndex.value = 1;
                //                     //Navigator.push(context,
                //                        // MaterialPageRoute(builder: (context)=>    ReceiptListPage(from: 'home', total: '',),));
                //
                //                   } else if (index == 2) {
                //                     print("click hereee");
                //                     homeProvider.streamSubscriptionCancel();
                //                     homeProvider.fetchDropdown("", "");
                //                     // homeProvider.selectedDistrict = null;
                //                     // homeProvider.selectedPanjayath = null;
                //                     // homeProvider.selectedUnit = null;
                //                     // homeProvider.fetchDropdown('', '');
                //                     // homeProvider.fetchWard();
                //                     bodyActiveIndex.value = 2;
                //                     //Navigator.push(context, MaterialPageRoute(builder: (context)=>WardHistory()));
                //
                //                     //activeBottomIndex.value = 2;
                //                   } else if (index == 3) {
                //                     homeProvider.streamSubscriptionCancel();
                //                     homeProvider.fetchHistoryFromFireStore();
                //                     bodyActiveIndex.value = 3;
                //                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentHistory()));
                //
                //                     //activeBottomIndex.value = 3;
                //                   }
                //                 },
                //                 items: <BottomNavigationBarItem>[
                //                   BottomNavigationBarItem(
                //                       icon: Image.asset(
                //                         "assets/homeicon2.png",
                //                         height: 22,
                //                         color: selectedValue == 0
                //                             ? knmGradient3
                //                             : knmGradient4,
                //                       ),
                //                       label: ' '),
                //                   BottomNavigationBarItem(
                //                       icon: Image.asset(
                //                           "assets/transactionicon2.png",
                //                           height: 22,
                //                           color: selectedValue == 1
                //                               ? knmGradient3
                //                               : knmGradient4),
                //                       label: ''),
                //                   BottomNavigationBarItem(
                //                       icon: Image.asset("assets/reporticon2.png",
                //                           height: 22,
                //                           color: selectedValue == 2
                //                               ? knmGradient3
                //                               : knmGradient4),
                //                       label: ''),
                //                   BottomNavigationBarItem(
                //                       icon: Image.asset(
                //                           "assets/historyicon2.png",
                //                           height: 22,
                //                           color: selectedValue == 3
                //                               ? knmGradient3
                //                               : knmGradient4),
                //                       label: ''),
                //                 ],
                //               );
                //             }),
                //       )
                //   ),
                //
                // )
            ),
          );
        });
  }

  Widget web(BuildContext context) {
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
    return Stack(
        children: [
      Row(
        children: [
          Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/KnmWebBackground1.jpg'),fit: BoxFit.cover
                )
              ),
            child: Row(
              children: [
                SizedBox(
                    height: height,
                    width: width / 3,
                    child: Image.asset("assets/Group 2.png",scale: 4,)),
                SizedBox(
                  height: height,
                  width: width / 3,
                ),
                SizedBox(
                    height: height,
                    width: width / 3,
                    child: Image.asset("assets/Group 3.png",scale: 6,)),
              ],
            ),
          ),


        ],
      ),
      Center(
        child: queryData.orientation == Orientation.portrait
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(width: width/3,),
                  SizedBox(
                    width: width,
                    child: ValueListenableBuilder(
                      valueListenable: bodyActiveIndex,
                      builder: (context,int dWVAlue,child) {
                        return WillPopScope(
                          onWillPop: ()async{
                            if(dWVAlue==0){
                              return showExitPopup();
                            }else if(dWVAlue==1){
                              bodyActiveIndex.value=0;
                              return true;
                            }else if(dWVAlue==2){
                              homeProvider.streamSubscriptionCancel();
                              bodyActiveIndex.value=0;
                              return true;

                            }else {
                              homeProvider.streamSubscriptionCancel();
                              bodyActiveIndex.value=0;
                              return true;

                            }
                          },
                          child: Scaffold(
                            backgroundColor: myGradient4,
                              body:  webScreens[dWVAlue],
                            // floatingActionButton:dWVAlue == 0?
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 0.0,right: 60),
                            //   child:
                            //
                            //   Container(
                            //     height: 65,
                            //     width: width * .700,
                            //     decoration: const BoxDecoration(
                            //         borderRadius:
                            //         BorderRadius.all(Radius.circular(35)),
                            //         gradient: LinearGradient(
                            //             begin: Alignment.centerRight,
                            //             end: Alignment.centerLeft,
                            //             colors: [myGradient1, myGradient2])),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: const [
                            //         Center(
                            //           child: GradientText(
                            //             'Contribute Now',
                            //             style: TextStyle(
                            //                 fontSize: 21,
                            //                 fontWeight: FontWeight.bold),
                            //             gradient: LinearGradient(colors: [
                            //               knmGolden,
                            //               knmGolden2,
                            //             ]),
                            //           ),
                            //         ),
                            //         SizedBox(width: 5,),
                            //         CircleAvatar(
                            //           backgroundColor: knmGolden,
                            //           radius: 17,
                            //           child: CircleAvatar(
                            //             backgroundColor: myGradient1,
                            //             radius: 13,
                            //             child: Icon(
                            //               Icons.arrow_forward_ios_sharp,
                            //               color: knmGolden,
                            //               size: 20,
                            //             ),
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ):null,
                              bottomNavigationBar: ValueListenableBuilder(
                                  valueListenable: bodyActiveIndex,
                                  builder: (context, int selectedValue, child) {
                                    return BottomNavigationBar(
                                      iconSize: 25,
                                      currentIndex: selectedValue,
                                      onTap: (int index) async {
                                        if (index == 0) {
                                          homeProvider.streamSubscriptionCancel();
                                          bodyActiveIndex.value = 0;
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreenNew()));
                                        } else if (index == 1) {
                                          if (!kIsWeb) {
                                            PackageInfo packageInfo = await PackageInfo.fromPlatform();
                                            String packageName = packageInfo.packageName;
                                            if (packageName != 'com.spine.knmMonitor') {
                                              print("code here1");
                                              homeProvider.kpccMonitor = false;
                                              homeProvider.currentLimit = 50;
                                              homeProvider.fetchReceiptList(50);


                                            } else {
                                              print("else code work");
                                              HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                                              homeProvider.kpccMonitor = true;
                                              homeProvider.currentLimit=50;
                                              homeProvider.fetchReceiptListForMonitorApp(50);
                                              homeProvider.checkStarRating();
                                              // homeProvider.filteredPaymentDetailsList = homeProvider.paymentDetailsList;

                                              //bodyActiveIndex.value = 1;
                                            }
                                          } else {
                                            homeProvider.currentLimit = 50;
                                            homeProvider.fetchReceiptList(50);

                                            //bodyActiveIndex.value = 1;

                                          }
                                          bodyActiveIndex.value = 1;
                                          //Navigator.push(context,
                                          // MaterialPageRoute(builder: (context)=>    ReceiptListPage(from: 'home', total: '',),));

                                        } else if (index == 2) {
                                          print("click hereee");
                                          homeProvider.streamSubscriptionCancel();
                                          homeProvider.fetchDropdown("", "");
                                          // homeProvider.selectedDistrict = null;
                                          // homeProvider.selectedPanjayath = null;
                                          // homeProvider.selectedUnit = null;
                                          // homeProvider.fetchDropdown('', '');
                                          // homeProvider.fetchWard();
                                          bodyActiveIndex.value = 2;
                                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>WardHistory()));

                                          //activeBottomIndex.value = 2;
                                        } else if (index == 3) {
                                          homeProvider.streamSubscriptionCancel();
                                          homeProvider.fetchHistoryFromFireStore();
                                          bodyActiveIndex.value = 3;
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentHistory()));

                                          //activeBottomIndex.value = 3;
                                        }
                                      },
                                      items: <BottomNavigationBarItem>[
                                        BottomNavigationBarItem(
                                            icon:
                                                Image.asset(selectedValue == 0
                                              ?"assets/homeicon2.png"
                                                  :"assets/homeGreay.png",
                                              height: 22,),
                                            label: ' '),
                                        BottomNavigationBarItem(
                                            icon: Image.asset(selectedValue == 1
                                              ?"assets/transactionicon2.png"
                                              :"assets/transactionGreay.png",
                                              height: 22,),
                                            label: ''),
                                        BottomNavigationBarItem(
                                            icon:
                                                Image.asset(selectedValue == 2
                                              ?"assets/reporticon2.png"
                                              :"assets/reportGreay.png",
                                              height: 22,),
                                            label: ''),
                                        BottomNavigationBarItem(
                                            icon:Image.asset(selectedValue == 3
                                             ? "assets/historyicon2.png"
                                              :"assets/historyGreay.png",
                                              height: 22,),
                                            label: ''),
                                      ],
                                    );
                                  })

                          ),
                        );
                      }
                    ),
                  ),
                  // SizedBox(width: width/3,)
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(width: width/3,),
                  SizedBox(
                    width: width / 3,
                    child: ValueListenableBuilder(
                      valueListenable: bodyActiveIndex,
                      builder: (context,int dWVAlue,child) {
                        return WillPopScope(
                          onWillPop: ()async{
                            if(dWVAlue==0){
                              return showExitPopup();
                            }else if(dWVAlue==1){
                              bodyActiveIndex.value=0;
                              return true;
                            }else if(dWVAlue==2){
                              homeProvider.streamSubscriptionCancel();
                              bodyActiveIndex.value=0;
                              return true;

                            }else {
                              homeProvider.streamSubscriptionCancel();
                              bodyActiveIndex.value=0;
                              return true;

                            }
                          },
                          child: Scaffold(
                            backgroundColor: myWhite,
                            body:  webScreens[dWVAlue],

                              bottomNavigationBar: ValueListenableBuilder(
                                  valueListenable: bodyActiveIndex,
                                  builder: (context, int selectedValue, child) {
                                    return BottomNavigationBar(
                                      iconSize: 25,
                                      currentIndex: selectedValue,
                                      onTap: (int index) async {
                                        if (index == 0) {
                                          homeProvider.streamSubscriptionCancel();
                                          bodyActiveIndex.value = 0;
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreenNew()));
                                        } else if (index == 1) {
                                          if (!kIsWeb) {
                                            PackageInfo packageInfo = await PackageInfo.fromPlatform();
                                            String packageName = packageInfo.packageName;
                                            if (packageName != 'com.spine.knmMonitor') {
                                              print("code here1");
                                              homeProvider.kpccMonitor = false;
                                              homeProvider.currentLimit = 50;
                                              homeProvider.fetchReceiptList(50);


                                            } else {
                                              print("else code work");
                                              HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                                              homeProvider.kpccMonitor = true;
                                              homeProvider.currentLimit=50;
                                              homeProvider.fetchReceiptListForMonitorApp(50);
                                              homeProvider.checkStarRating();
                                              // homeProvider.filteredPaymentDetailsList = homeProvider.paymentDetailsList;

                                              //bodyActiveIndex.value = 1;
                                            }
                                          } else {
                                            homeProvider.currentLimit = 50;
                                            homeProvider.fetchReceiptList(50);

                                            //bodyActiveIndex.value = 1;

                                          }
                                          bodyActiveIndex.value = 1;
                                          //Navigator.push(context,
                                          // MaterialPageRoute(builder: (context)=>    ReceiptListPage(from: 'home', total: '',),));

                                        } else if (index == 2) {
                                          print("click hereee");
                                          homeProvider.streamSubscriptionCancel();
                                          homeProvider.fetchDropdown("", "");
                                          // homeProvider.selectedDistrict = null;
                                          // homeProvider.selectedPanjayath = null;
                                          // homeProvider.selectedUnit = null;
                                          // homeProvider.fetchDropdown('', '');
                                          // homeProvider.fetchWard();
                                          bodyActiveIndex.value = 2;
                                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>WardHistory()));

                                          //activeBottomIndex.value = 2;
                                        } else if (index == 3) {
                                          homeProvider.streamSubscriptionCancel();
                                          homeProvider.fetchHistoryFromFireStore();
                                          bodyActiveIndex.value = 3;
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentHistory()));

                                          //activeBottomIndex.value = 3;
                                        }
                                      },
                                      items: <BottomNavigationBarItem>[
                                        BottomNavigationBarItem(
                                            icon: Image.asset(
                                              "assets/homeicon2.png",
                                              height: 22,
                                              color: selectedValue == 0
                                                  ? knmGradient3
                                                  : knmGradient4,
                                            ),
                                            label: ' '),
                                        BottomNavigationBarItem(
                                            icon: Image.asset(
                                                "assets/transactionicon2.png",
                                                height: 22,
                                                color: selectedValue == 1
                                                    ? knmGradient3
                                                    : knmGradient4),
                                            label: ''),
                                        BottomNavigationBarItem(
                                            icon: Image.asset("assets/reporticon2.png",
                                                height: 22,
                                                color: selectedValue == 2
                                                    ? knmGradient3
                                                    : knmGradient4),
                                            label: ''),
                                        BottomNavigationBarItem(
                                            icon: Image.asset(
                                                "assets/historyicon2.png",
                                                height: 22,
                                                color: selectedValue == 3
                                                    ? knmGradient3
                                                    : knmGradient4),
                                            label: ''),
                                      ],
                                    );
                                  })
                          ),
                        );
                      }
                    ),
                  ),
                  // SizedBox(width: width/3,)
                ],
              ),
      ),
    ]);
  }

  final colors = [
    lightBlue,
    orange,
  ];

  showAlert(String url, BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      backgroundColor: Colors.white,
      actions: [
        SizedBox(
          width: 400,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 430,
                width: 300,
                child: Image.network(
                  url,
                  fit: BoxFit.fill,
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
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String getAmount(double totalCollection) {
    final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
    String newText1 = formatter.format(totalCollection);
    String newText =
    formatter.format(totalCollection).substring(0, newText1.length - 3);
    return newText;
  }

}
