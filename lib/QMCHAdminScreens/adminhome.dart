import 'dart:io';

import 'package:beehive/QMCHAdminScreens/sponsersListScreen.dart';
import 'package:beehive/QMCHAdminScreens/subScribersListScreen.dart';
import 'package:beehive/QMCHAdminScreens/voulenteersListScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../QmchScreens/login_screen.dart';
import '../Screens/home_screen.dart';
import '../Screens/reciept_list_page.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import 'add_carousel_image_screen.dart';
import 'add_equipments_screen.dart';
import 'add_sponser_screen.dart';
import 'add_subscribers_screen.dart';
import 'admin_add_volunteerScreen.dart';
import 'admin_view_news.dart';
import 'equipment_List.dart';

class AdminHome extends StatefulWidget {
  String adminName,adminID,adminPhone;
   AdminHome({Key? key,required this.adminName,required this.adminID,required this.adminPhone}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List<String> images = [
    "assets/clipboard.png",
    "assets/card_membership.png",
    "assets/groups.png",
    "assets/cooking.png",
    "assets/handshake.png",
    "assets/service_toolbox.png",
  "assets/contract-right.png",
  ];
  List<String> gridOneImg=[
    "assets/generalContribution.png",
    "assets/zakatImg.png",
    "assets/SponsoraPatientImg.png",
    "assets/contributionImg.png",
    "assets/SponsorEquipmentImg.png",
    "assets/SubscriptionPayment.png",
  ];
  List<String> images2 = [
    "assets/carouselBg1.png",
    "assets/carouselBg1.png",
    "assets/carouselBg1.png",
    "assets/carouselBg1.png",
  ];

  List<String> textTittle = [
'Live Transactions',
    'Subscribers',
    'Volunteers',
    'Activities',
    'Sponsors',
    "Equipment's",
    'Reports',
  ];

  List<String> textDiscription = [
   '',
    'Payment Report',
    'Transaction Details\n  Collection Report ',
    'News Feeds List\n  Add Activities',
    'Payment Report',
    "Equipment's List\nAdd Equipments",
    'Payment Report',
  ];

  List<Color> colorsList = [
    Color(0xFFA8DFFF),
    Color(0xFF9BFFE9),
    Color(0xFFC1CBFF),
    Color(0xFFFFDCA8),
    Color(0xFFFFA8C2),
    Color(0xFFF1FFA0),
    Color(0xFFBDFF9E),
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);

    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return WillPopScope(
      onWillPop: () {
        return showExitPopup(context);

      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            // backgroundColor: Colors.redAccent.withOpacity(0.2),
            body: SizedBox(width: width,height: height,
              child: SingleChildScrollView(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 12.0,right: 12),
                      child: SizedBox(
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
                               Row(
                                  children: [

                                    Consumer<DonationProvider>(
                                      builder: (context,value,child) {
                                        return value.adminImageUrl!=''?
                                          InkWell(onTap: (){
                                            if(value.adminImageUrl=='' || value.adminImageUrl=='null'){
                                              value.getAdminImg(widget.adminID);
                                            }
                                            _showTopSheetNew(context,widget.adminName,widget.adminID,widget.adminPhone);
                                          },
                                            child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration:  BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(value.adminImageUrl),  fit: BoxFit.fill,),
                                                gradient: SweepGradient(
                                                center: Alignment(0, 1),
                                             startAngle: 0,
                                        endAngle: 1,
                                        colors: [Color(0xFF3E4FA3), Color(0xFF253068)],),
                                        shape: BoxShape.circle),

                                            ),
                                          ):
                                        Container(
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
                                            child: Consumer<DonationProvider>(
                                              builder: (context,value,child) {
                                                return InkWell(
                                                  onTap:(){
                                                    if(value.adminImageUrl=='' || value.adminImageUrl=='null'){
                                                      value.getAdminImg(widget.adminID);
                                                    }
                                                     _showTopSheetNew(context,widget.adminName,widget.adminID,widget.adminPhone);
                                                  },
                                                  child:
                                                  Icon(
                                                      Icons.person_outline,
                                                      color: myWhite)
                                                );
                                              }
                                            ));
                                      }
                                    )

                                  ],
                                )

                              ])),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      height: 220,
                      // color:Colors.blue,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              height: 200,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: CarouselSlider.builder(
                                itemCount: images2.length,
                                itemBuilder:
                                    (context, index, realIndex) {
                                  //final image=value.imgList[index];
                                  final image = images2[index];
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
                          ),
                          buidIndiaCator( images2.length, context)
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),



                    Consumer<HomeProvider>(
                        builder: (context, value, child) {
                        return FittedBox(
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
                        fontSize: 48,
                        fontFamily: 'ChangaOneRegular',
                        fontWeight: FontWeight.w400,
                        ),
                        // GoogleFonts.akshar(
                        //     textStyle: whiteGoogle38)
                        ),
                        )
                        ],
                        ),
                        );
                      }
                    ),
                    const SizedBox(height: 5),
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

                  GridView.builder(
                  padding: const EdgeInsets.all(25),
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          mainAxisExtent: 120
          ),
          itemCount:images.length,
          itemBuilder: (BuildContext context,
          int index) {
            return InkWell(
              onTap: (){
                if(index==0) {
                  homeProvider.searchEt.text = "";
                  homeProvider.currentLimit = 50;
                  homeProvider.fetchReceiptList(50);
               callNext(  ReceiptListPage(from: 'admin_home', total: '',ward: '', panchayath: '', district: '',
               target: '', loginUserID: '',loginUsername: '',subScriberType: 'ADMIN',loginUserPhone: '',deseaseName: '',equipmentAmount: '',foodkitAmount: '',foodkitPrice: ','
                       ,footkitCount: '',sponsorCategory: '',sponsorCount: '',sponsorItemOnePrice: '',sponsorPatientAmonut: '',zakathAmount: ''),
               context);

                } else if(index==1){
                  donationProvider.equipmentCount=0;
                  donationProvider.fetchSubScribersList(true);
                  callNext( SubScribersListScreen( adminID: widget.adminID, adminName: widget.adminName,),context);

                } else if(index==2){

                  homeProvider.fetchVoulenteers(true);
                  callNext(VoulnteersListScreen(adminID: widget.adminID,adminName: widget.adminName),context);

                }else if(index==3){
                  donationProvider.clearNews();
                  donationProvider.fetchAllNews(true);
                  callNext(AdminViewAllNews(adminID: widget.adminID,adminName: widget.adminName,), context);

                }else if(index==4){

                  donationProvider.equipmentCount=0;

                  donationProvider.fetchSponsers(true);
                  callNext(SponsersListScreen(adminID: widget.adminID,adminName: widget.adminName), context);

                }else if(index==5){
                  donationProvider.equipmentCount=0;


                  donationProvider.fetchEquipment(true);
                  donationProvider.clearEquipmentScreen();
                  callNext(AdminViewEquipmentList(adminID: widget.adminID,adminName: widget.adminName),context);

                }
              },
              child: Container(
                height: 45,
               // width: width*.2,
                  clipBehavior: Clip.antiAlias,
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
               child :   Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Padding(
                       padding: const EdgeInsets.only(bottom: 4.0),
                       child: Container(
                           width: 40,
                           height: 40,
                           // padding: const EdgeInsets.only(top: 6, left: 5, right: 5, bottom: 4),
                           clipBehavior: Clip.antiAlias,
                           decoration: ShapeDecoration(
                             color: colorsList[index],
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(41),
                             ),
                           ),
                           child: Center(child: Image.asset(images[index],scale: 1.2,)),),
                     ),
                      Text(
                          textTittle[index],
                         style: TextStyle(
                           color: Color(0xFF253068),
                           fontSize: 12,
                           fontFamily: 'Poppins',
                           fontWeight: FontWeight.w500,
                         ),
                     ),
                 // SizedBox(height: height*.008,),
                 Opacity(
                  opacity: 0.33,
                  child: Text(
                    textDiscription[index],
                  style: const TextStyle(
                  color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,

                  ),
                ),
              )
                    ],
                  )
              ),
            );
          }),

                    // SizedBox(height: 10,),
                    // InkWell(onTap: (){
                    //   donationProvider.carouselfileList.clear();
                    //   donationProvider.fetchCarouselImages();
                    //   callNext(AddCarouselImagesScreen(adminID: adminID,adminName: adminName,), context);
                    // },
                    //   child: Container(height: 100,width: 200,color: Colors.blue,
                    //     child: Center(child: Text('Carousel Image ')),),
                    // ),

                    // SizedBox(height: 10,),
//               InkWell(onTap: (){
//                 donationProvider.clearFoodController();
//                 donationProvider.fetchFoodKit(true);
//
//                 callNext(AdminViewFoodKit(adminID: adminID,adminName: adminName,), context);
//                 // callNext(AdminAddFoodKitScreen(adminName: adminName, adminID: adminID), context);
//
//                 // donationProvider.clearSponserScreen();
//                 // callNext(AddSponserScreen(adminID: adminID,adminName: adminName),context);
//               },
//                 child: Container(height: 100,width: 200,color: Colors.blue,
//                   child: Center(child: Text('Add FODD KIT ')),),
//               ),
                  ],
                ),
              ),
            )
          ),
        ),
      ),
    );
  }

  buildImage(var image, context) {
    return Container(
      padding: const EdgeInsets.all(15),
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
          children: const [
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image(image: AssetImage("assets/qmchBg.png"))),
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                  'Ut viverra sapien in est porta, vel cursus urna rutrum.',
              style: TextStyle(
                color: myWhite,
                fontSize: 10,
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
   logoutAlertNew(context,String loginUsername,String loginUserID,) async {
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
                          child:
                              InkWell(onTap: (){
                                FirebaseAuth auth = FirebaseAuth.instance;
                                auth.signOut();
                                callNextReplacement(LoginScreen(), context);
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


  editProfileImage(context,String loginUsername,String loginUserID,) async {
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
                            : value.adminImageUrl != ""
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
                            child: Image.network(value.adminImageUrl!,fit: BoxFit.cover,))
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
                            donationProvider.updateUserProfile('ADMIN',loginUserID,context);
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

  _showTopSheetNew(BuildContext context,String loginUsername,String loginUserID,String phone ) {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
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
            height: 370,
            decoration: BoxDecoration(
              color: myWhite,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 155,
                    color: myWhite,
                    child: Stack(
                      children: [
                        Align(
                          alignment:Alignment.topCenter,
                          child: SizedBox(
                            height: 125,
                            child:
                                Container(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                                  height: 110,
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
                                            finish(context);
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
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Consumer<DonationProvider>(
                            builder: (context,value,child) {
                              return
                                value.adminImageUrl!=''?
                                InkWell(onTap: (){
                                  donationProvider.fileImage=null;
                                  finish(context);
                                  editProfileImage(context,loginUsername,loginUserID);
                                },
                                  child: Container(
                                    width: 55,
                                    height: 55,
                                    decoration:  BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(value.adminImageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                        gradient: SweepGradient(
                                          center: Alignment(0, 1),
                                          startAngle: 0,
                                          endAngle: 1,
                                          colors: [Color(0xFF3E4FA3), Color(0xFF253068)],),
                                        shape: BoxShape.circle),

                                  ),
                                ):
                                Stack(
                                children: [
                                  InkWell(onTap:(){
                                    donationProvider.fileImage=null;
                                    finish(context);
                                    editProfileImage(context,loginUsername,loginUserID);
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
                        )                      ],
                    ),
                  ),

                  const SizedBox(height:15),

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
                                          style: TextStyle(
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
                              style: TextStyle(
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
                      ],
                    ),
                  ),

                  const SizedBox(height:15),

                  InkWell(
                    onTap:(){
                      logoutAlertNew(context,loginUsername,loginUserID,);
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
                  ),
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

  String getAmount(double totalCollection) {
    final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
    String newText1 = formatter.format(totalCollection);
    String newText =
    formatter.format(totalCollection).substring(0, newText1.length - 3);
    return newText;
  }
}

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
