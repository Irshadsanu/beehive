import 'package:beehive/Screens/topMuncipalityReport.dart';
import 'package:beehive/Screens/topWardReport.dart';
import 'package:beehive/Screens/top_assembly_report.dart';
import 'package:beehive/Screens/top_panchayath_report.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../providers/home_provider.dart';
import 'district_report.dart';

class ToppersHomeScreen extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  ToppersHomeScreen({Key? key,required this.loginUsername,
    required this.loginUserID,required this.subScriberType,required this.loginUserPhone,  required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
    required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
    ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);

  List mainScreens = [
     TopWardReport(loginUsername: '',loginUserID: '',subScriberType: '',loginUserPhone: '',equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
         sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''),
     TopMuncipalityReport(loginUserID: '',loginUsername: '',subScriberType: '',loginUserPhone: '',equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
         sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''),
     TopPanchayathReport(loginUserID: '',loginUsername: '',subScriberType: '',loginUserPhone: '',equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
         sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''),
     TopAssemblyReport(loginUserID: '',loginUsername: '',subScriberType: '',loginUserPhone: '',equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
         sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''),
    DistrictReport(from: "",loginUserID: '',loginUsername: '',subScriberType: '',loginUserPhone: '',equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
        sponsorCategory: '',foodkitPrice: '',foodkitAmount: ''),
  ];
  ValueNotifier<int> screenValue = ValueNotifier(0);
  final _controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build (BuildContext context){
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);

    if(kIsWeb){
      return mob(context);
    }else
    {return mob(context);}
  }
  Widget mob (BuildContext context){
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(5, 2, 5, 10),
        decoration: const BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        child: ValueListenableBuilder(
            valueListenable: screenValue,
            builder: (context, int newValue, child) {
              return GNav(iconSize: 16,
                tabBorderRadius: 12,
                // backgroundColor: Colors.red,
                // color: Colors.white,
                selectedIndex: newValue,
                // activeColor: Colors.white,
                tabBackgroundColor: clBDFFEF,

                // tabShadow: const [
                //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                gap: 1,
                tabs: [

                  GButton(
                    // shadow: const [
                    //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],

                    leading: Column(
                      children: [
                        Container(
                            // color: clF9F9F9,
                          // height:newValue==0?35:40 ,
                          alignment: Alignment.center,
                          // width: newValue==0?35:40,
                          child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
                        ),
                        const Center(
                          child: Text("Unit",
                            textAlign:TextAlign.center,
                            style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
                        )
                      ],
                    ),
                    icon: Icons.military_tech,
                    iconSize: newValue==0?18:25,
                    onPressed: () {
                      screenValue.value = 0;
                    },
                  ),
                  GButton(
                    // shadow: const [
                    //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],

                    leading: Column(
                      children: [
                        Container(
                            // color: clF9F9F9,
                          // height:newValue==0?35:40 ,
                          alignment: Alignment.center,
                          // width: newValue==0?35:40,
                          child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
                        ),
                        const Center(
                          child: Text("Municipality",
                            textAlign:TextAlign.center,
                            style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
                        )
                      ],
                    ),
                    icon: Icons.military_tech,
                    iconSize: newValue==0?18:25,
                    onPressed: () {
                      screenValue.value = 1;
                      homeProvider.fetchTopPanchayathReport();
                    },
                  ),
                  GButton(
                    // shadow: const [
                    //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],

                    leading: Column(
                      children: [
                        Container(
                            // color: clF9F9F9,
                          // height:newValue==0?35:40 ,
                          alignment: Alignment.center,
                          // width: newValue==0?35:40,
                          child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
                        ),
                        const Center(
                          child: Text("Panchayath",
                            textAlign:TextAlign.center,
                            style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
                        )
                      ],
                    ),
                    icon: Icons.military_tech,
                    iconSize: newValue==0?18:25,
                    onPressed: () {
                      screenValue.value = 2;
                      homeProvider.fetchTopPanchayathReport();
                    },
                  ),
                  GButton(
                    // shadow: const [
                    //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],

                    leading: Column(
                      children: [
                        Container(
                            // color: clF9F9F9,
                          // height:newValue==0?35:40 ,
                          alignment: Alignment.center,
                          // width: newValue==0?35:40,
                          child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
                        ),
                        const Center(
                          child: Text("Assembly",
                            textAlign:TextAlign.center,
                            style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
                        )
                      ],
                    ),
                    icon: Icons.military_tech,
                    iconSize: newValue==0?18:25,
                    onPressed: () {
                      homeProvider.fetchTopAssemblyReport();
                      screenValue.value = 3;
                    },
                  ),
                  GButton(
                    // shadow: const [
                    //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],

                    leading: Column(
                      children: [
                        Container(
                            // color: clF9F9F9,
                          // height:newValue==0?35:40 ,
                          alignment: Alignment.center,
                          // width: newValue==0?35:40,
                          child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
                        ),
                        const Center(
                          child: Text("District",
                            textAlign:TextAlign.center,
                            style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
                        )
                      ],
                    ),
                    icon: Icons.military_tech,
                    iconSize: newValue==0?18:25,
                    onPressed: () {
                      screenValue.value = 4;
                      homeProvider.fetchDistrictWiseReport();
                    },
                  ),



                ],
              );
            }),
      ),
      body: ValueListenableBuilder(
          valueListenable: screenValue,
          builder: (context, int value, child) {
            return mainScreens[value];
          }),
    );
  }
  // Widget web (BuildContext context){
  //   HomeProvider homeProvider =
  //   Provider.of<HomeProvider>(context, listen: false);
  //   LanguageProvider languageProvider =
  //   Provider.of<LanguageProvider>(context, listen: false);
  //   return MediaQuery.of(context).orientation == Orientation.portrait
  //       ?Scaffold(
  //
  //     bottomNavigationBar: Container(
  //       margin: const EdgeInsets.fromLTRB(5, 12, 5, 10),
  //       decoration: const BoxDecoration(
  //           color:Colors.white,
  //           borderRadius: BorderRadius.only(
  //               topRight: Radius.circular(15), topLeft: Radius.circular(15))),
  //       child: ValueListenableBuilder(
  //           valueListenable: screenValue,
  //           builder: (context, int newValue, child) {
  //             return GNav(iconSize: 20,
  //               tabBorderRadius: 30,
  //               //backgroundColor: Colors.red,
  //               color: Colors.white,
  //               selectedIndex: newValue,
  //               activeColor: Colors.white,
  //               tabBackgroundColor: cl005A87,
  //               padding:
  //               const EdgeInsets.fromLTRB(14, 10, 15, 10),
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               gap: 5,
  //               tabs: [
  //
  //                 GButton(
  //                   leading: Column(
  //                     children: [
  //
  //                       Row(
  //                         children: [
  //                           Container(
  //                             height:newValue==0?35:40 ,
  //                             alignment: Alignment.center,
  //                             width: newValue==0?35:40,
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular( newValue==0?100:10),
  //                               color: Colors.white,
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   blurStyle: BlurStyle.solid,
  //                                   color: cl7E7E7E.withOpacity(.6),
  //                                   spreadRadius: 0,
  //                                   blurRadius: 5,
  //                                   offset: const Offset(0, 1,), // changes position of shadow
  //                                 ),
  //                               ],
  //                             ),
  //                             child: Icon(Icons.military_tech,color: cl005A87, size:  newValue==0?20:25,),
  //                           ),
  //                           if (newValue==0) Consumer<LanguageProvider>(
  //                               builder: (context,value2,child) {
  //                                 return Padding(
  //                                   padding: const EdgeInsets.only(left: 3.0,right: 10),
  //                                   child: Text(value2.individualLeaders,
  //                                     textAlign:TextAlign.center,
  //                                     style: const TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 12),),
  //                                 );
  //                               }
  //                           ) else const SizedBox()
  //                         ],
  //                       ),
  //                       if (newValue!=0) Consumer<LanguageProvider>(
  //                           builder: (context,value2,child) {
  //                             return Padding(
  //                               padding: const EdgeInsets.only(top: 5.0),
  //                               child: Text(value2.individualLeaders,
  //                                 textAlign:TextAlign.center,
  //                                 style: const TextStyle(color: cl005A87,fontWeight: FontWeight.bold,fontSize: 12),),
  //                             );
  //                           }
  //                       ) else const SizedBox()
  //                     ],
  //                   ),
  //                   icon: Icons.military_tech,
  //                   iconColor: cl005A87,
  //                   iconSize: newValue==0?18:25,
  //                   // text: languageProvider.individualLeaders,
  //                   onPressed: () {
  //                     screenValue.value = 0;
  //                   },
  //                 ),
  //                 GButton(
  //
  //                   leading: Column(
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Container(
  //                             height:newValue==1?35:40 ,
  //                             alignment: Alignment.center,
  //                             width: newValue==1?35:40,
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular( newValue==1?100:10),
  //                               color: Colors.white,
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   blurStyle: BlurStyle.solid,
  //                                   color: cl7E7E7E.withOpacity(.6),
  //                                   spreadRadius: 0,
  //                                   blurRadius: 5,
  //                                   offset: const Offset(
  //                                     0,
  //                                     1,
  //                                   ), // changes position of shadow
  //                                 ),
  //                               ], ),
  //
  //                             child: Icon(Icons.currency_rupee,color: cl005A87,size: newValue==1?20:25,),
  //                           ),
  //                           if (newValue==1) Consumer<LanguageProvider>(
  //                               builder: (context,value,child) {
  //                                 return  Padding(
  //                                   padding: const EdgeInsets.only(left: 3.0,right: 10),
  //                                   child: Text(value.aggregatorAmount,
  //                                     textAlign:TextAlign.center,
  //                                     style: const TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 12),),
  //                                 );
  //                               }
  //                           ) else const SizedBox()
  //                         ],
  //                       ),
  //                       if (newValue!=1) Consumer<LanguageProvider>(
  //                           builder: (context,value,child) {
  //                             return  Padding(
  //                               padding: const EdgeInsets.only(top: 5.0),
  //                               child: Text(value.aggregatorAmount,
  //                                 textAlign:TextAlign.center,
  //                                 style: const TextStyle(color: cl005A87,fontWeight: FontWeight.bold,fontSize: 12),),
  //                             );
  //                           }
  //                       ) else const SizedBox()
  //                     ],
  //                   ),
  //                   icon: Icons.currency_rupee,
  //                   iconColor: cl005A87,
  //                   iconSize: newValue==1?18:25,
  //                   // text: languageProvider.aggregatorAmount,
  //                   onPressed: () {
  //                     homeProvider.getTopEnrollers();
  //
  //                     screenValue.value = 1;
  //
  //                   },
  //                 ),
  //                 GButton(
  //
  //                   leading: Column(
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Container(
  //                             height:newValue==2?35:40 ,
  //                             alignment: Alignment.center,
  //                             width: newValue==2?35:40,
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular( newValue==2?100:10),
  //                               color: Colors.white,
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   blurStyle: BlurStyle.solid,
  //                                   color: cl7E7E7E.withOpacity(.6),
  //                                   spreadRadius: 0,
  //                                   blurRadius: 5,
  //                                   offset: const Offset(0, 1,), // changes position of shadow
  //                                 ),
  //                               ], ),
  //
  //                             child: Icon(Icons.people_outline,color: cl005A87,size: newValue==2?20:25,),
  //                           ),
  //                           if (newValue==2) Consumer<LanguageProvider>(
  //                               builder: (context,value,child) {
  //                                 return Padding(
  //                                   padding: const EdgeInsets.only(left: 3.0,right: 10),
  //                                   child: Text(value.aggregatorParticipant,
  //                                     textAlign:TextAlign.center,
  //                                     style: const TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 12),),
  //                                 );
  //                               }
  //                           ) else const SizedBox()
  //                         ],
  //                       ),
  //                       if (newValue!=2) Consumer<LanguageProvider>(
  //                           builder: (context,value,child) {
  //                             return Padding(
  //                               padding: const EdgeInsets.only(top: 5.0),
  //                               child: Text(value.aggregatorParticipant,
  //                                 textAlign:TextAlign.center,
  //                                 style: const TextStyle(color: cl005A87,fontWeight: FontWeight.bold,fontSize: 12),),
  //                             );
  //                           }
  //                       ) else const SizedBox()
  //                     ],
  //                   ),
  //                   icon: Icons.ac_unit_rounded,
  //                   iconColor: cl005A87,
  //                   iconSize: newValue==2?18:25,
  //                   // text: languageProvider.aggregatorParticipant,
  //                   onPressed: () {
  //                     homeProvider.getTopEnrollersParticipantsBase();
  //                     screenValue.value = 2;
  //
  //                   },
  //                 ),
  //
  //               ],
  //             );
  //           }),
  //     ),
  //     body: ValueListenableBuilder(
  //         valueListenable: screenValue,
  //         builder: (context, int value, child) {
  //           return mainScreens[value];
  //         }),
  //   ):Center(
  //     child: SizedBox(
  //       width: 450,
  //       child: Scaffold(
  //         bottomNavigationBar: Container(
  //           margin: const EdgeInsets.fromLTRB(5, 12, 5, 10),
  //           decoration: const BoxDecoration(
  //               color:Colors.white,
  //               borderRadius: BorderRadius.only(
  //                   topRight: Radius.circular(15), topLeft: Radius.circular(15))),
  //           child: ValueListenableBuilder(
  //               valueListenable: screenValue,
  //               builder: (context, int newValue, child) {
  //                 return GNav(iconSize: 20,
  //                   tabBorderRadius: 30,
  //                   //backgroundColor: Colors.red,
  //                   color: Colors.white,
  //                   selectedIndex: newValue,
  //                   activeColor: Colors.white,
  //                   tabBackgroundColor: cl005A87,
  //                   padding:
  //                   const EdgeInsets.fromLTRB(14, 10, 15, 10),
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   gap: 5,
  //                   tabs: [
  //
  //                     GButton(
  //                       leading: Column(
  //                         children: [
  //
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 height:newValue==0?35:40 ,
  //                                 alignment: Alignment.center,
  //                                 width: newValue==0?35:40,
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular( newValue==0?100:10),
  //                                   color: Colors.white,
  //                                   boxShadow: [
  //                                     BoxShadow(
  //                                       blurStyle: BlurStyle.solid,
  //                                       color: cl7E7E7E.withOpacity(.6),
  //                                       spreadRadius: 0,
  //                                       blurRadius: 5,
  //                                       offset: const Offset(0, 1,), // changes position of shadow
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 child: Icon(Icons.military_tech,color: cl005A87, size:  newValue==0?20:25,),
  //                               ),
  //                               if (newValue==0) Consumer<LanguageProvider>(
  //                                   builder: (context,value2,child) {
  //                                     return Padding(
  //                                       padding: const EdgeInsets.only(left: 3.0,right: 10),
  //                                       child: Text(value2.individualLeaders,
  //                                         textAlign:TextAlign.center,
  //                                         style: const TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 12),),
  //                                     );
  //                                   }
  //                               ) else const SizedBox()
  //                             ],
  //                           ),
  //                           if (newValue!=0) Consumer<LanguageProvider>(
  //                               builder: (context,value2,child) {
  //                                 return Padding(
  //                                   padding: const EdgeInsets.only(top: 5.0),
  //                                   child: Text(value2.individualLeaders,
  //                                     textAlign:TextAlign.center,
  //                                     style: const TextStyle(color: cl005A87,fontWeight: FontWeight.bold,fontSize: 12),),
  //                                 );
  //                               }
  //                           ) else const SizedBox()
  //                         ],
  //                       ),
  //                       icon: Icons.military_tech,
  //                       iconColor: cl005A87,
  //                       iconSize: newValue==0?18:25,
  //                       // text: languageProvider.individualLeaders,
  //                       onPressed: () {
  //                         screenValue.value = 0;
  //                       },
  //                     ),
  //                     GButton(
  //
  //                       leading: Column(
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 height:newValue==1?35:40 ,
  //                                 alignment: Alignment.center,
  //                                 width: newValue==1?35:40,
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular( newValue==1?100:10),
  //                                   color: Colors.white,
  //                                   boxShadow: [
  //                                     BoxShadow(
  //                                       blurStyle: BlurStyle.solid,
  //                                       color: cl7E7E7E.withOpacity(.6),
  //                                       spreadRadius: 0,
  //                                       blurRadius: 5,
  //                                       offset: const Offset(
  //                                         0,
  //                                         1,
  //                                       ), // changes position of shadow
  //                                     ),
  //                                   ], ),
  //
  //                                 child: Icon(Icons.currency_rupee,color: cl005A87,size: newValue==1?20:25,),
  //                               ),
  //                               if (newValue==1) Consumer<LanguageProvider>(
  //                                   builder: (context,value,child) {
  //                                     return  Padding(
  //                                       padding: const EdgeInsets.only(left: 3.0,right: 10),
  //                                       child: Text(value.aggregatorAmount,
  //                                         textAlign:TextAlign.center,
  //                                         style: const TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 12),),
  //                                     );
  //                                   }
  //                               ) else const SizedBox()
  //                             ],
  //                           ),
  //                           if (newValue!=1) Consumer<LanguageProvider>(
  //                               builder: (context,value,child) {
  //                                 return  Padding(
  //                                   padding: const EdgeInsets.only(top: 5.0),
  //                                   child: Text(value.aggregatorAmount,
  //                                     textAlign:TextAlign.center,
  //                                     style: const TextStyle(color: cl005A87,fontWeight: FontWeight.bold,fontSize: 12),),
  //                                 );
  //                               }
  //                           ) else const SizedBox()
  //                         ],
  //                       ),
  //                       icon: Icons.currency_rupee,
  //                       iconColor: cl005A87,
  //                       iconSize: newValue==1?18:25,
  //                       // text: languageProvider.aggregatorAmount,
  //                       onPressed: () {
  //                         homeProvider.getTopEnrollers();
  //
  //                         screenValue.value = 1;
  //
  //                       },
  //                     ),
  //                     GButton(
  //
  //                       leading: Column(
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 height:newValue==2?35:40 ,
  //                                 alignment: Alignment.center,
  //                                 width: newValue==2?35:40,
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular( newValue==2?100:10),
  //                                   color: Colors.white,
  //                                   boxShadow: [
  //                                     BoxShadow(
  //                                       blurStyle: BlurStyle.solid,
  //                                       color: cl7E7E7E.withOpacity(.6),
  //                                       spreadRadius: 0,
  //                                       blurRadius: 5,
  //                                       offset: const Offset(0, 1,), // changes position of shadow
  //                                     ),
  //                                   ], ),
  //
  //                                 child: Icon(Icons.people_outline,color: cl005A87,size: newValue==2?20:25,),
  //                               ),
  //                               if (newValue==2) Consumer<LanguageProvider>(
  //                                   builder: (context,value,child) {
  //                                     return Padding(
  //                                       padding: const EdgeInsets.only(left: 3.0,right: 10),
  //                                       child: Text(value.aggregatorParticipant,
  //                                         textAlign:TextAlign.center,
  //                                         style: const TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 12),),
  //                                     );
  //                                   }
  //                               ) else const SizedBox()
  //                             ],
  //                           ),
  //                           if (newValue!=2) Consumer<LanguageProvider>(
  //                               builder: (context,value,child) {
  //                                 return Padding(
  //                                   padding: const EdgeInsets.only(top: 5.0),
  //                                   child: Text(value.aggregatorParticipant,
  //                                     textAlign:TextAlign.center,
  //                                     style: const TextStyle(color: cl005A87,fontWeight: FontWeight.bold,fontSize: 12),),
  //                                 );
  //                               }
  //                           ) else const SizedBox()
  //                         ],
  //                       ),
  //                       icon: Icons.ac_unit_rounded,
  //                       iconColor: cl005A87,
  //                       iconSize: newValue==2?18:25,
  //                       // text: languageProvider.aggregatorParticipant,
  //                       onPressed: () {
  //                         homeProvider.getTopEnrollersParticipantsBase();
  //                         screenValue.value = 2;
  //
  //                       },
  //                     ),
  //
  //                   ],
  //                 );
  //               }),
  //         ),
  //         body: ValueListenableBuilder(
  //             valueListenable: screenValue,
  //             builder: (context, int value, child) {
  //               return mainScreens[value];
  //             }),
  //       ),
  //     ),
  //   );
  // }

}
