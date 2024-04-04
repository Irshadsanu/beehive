import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import '../Views/ward_model.dart';
import '../constants/shake_effect.dart';
import 'package:provider/provider.dart';
import '../Views/panjayath_model.dart';
import '../constants/custmom_chip.dart';
import '../qmchModels/subScriberModel.dart';
import '../service/currency_formater.dart';
import 'bank_payment_page.dart';
import 'cashfree/payment_gateway.dart';
import 'home.dart';
import 'home_screen.dart';
import 'new_payment_gateway_Screen.dart';
import 'no_paymet_gatway.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class DonatePage extends StatelessWidget {
  String paymentCategory,equipmentID,equipmentCount,oneEquipmentPrice;
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  List<MonthBool> monthList;
  DonatePage({Key? key
    ,required this.paymentCategory
    ,required this.equipmentID
    ,required this.equipmentCount
    ,required this.oneEquipmentPrice
    ,required this.loginUsername,required this.loginUserID,required this.subScriberType,required this.loginUserPhone,
    required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
    required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
  ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,required this.monthList,

  }) : super(key: key);


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  final ShakeXController _shakeXController=ShakeXController();
  final ShakeXController _shakeXControlleramount=ShakeXController();



  @override
  Widget build(BuildContext context) {



    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    // homeProvider.checkInternet(context);
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }
  Widget body(BuildContext context){
    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    if(kIsWeb&&queryData.orientation != Orientation.portrait){
      width=width/3;
    }
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);

    final List<int> amount = [
      138,
      200,
      500,
      1000,
      2000,
      5000,
    ];


    return SafeArea(
        child: Scaffold(
          appBar:  AppBar(
            elevation: 0,
            backgroundColor: myWhite,
            centerTitle: true,
            leading:Center(
              child: InkWell(
                onTap:(){
                  callNextReplacement( HomeScreenNew(loginUserPhone: loginUserPhone,
                      loginUserID: loginUserID,loginUsername: loginUsername,subScriberType: subScriberType,
                    zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                    sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                    foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                },
                child:CircleAvatar(
                  radius: 19,
                  backgroundColor: myBlack.withOpacity(0.05),
                  child: const Padding(
                    padding: EdgeInsets.only(left:5.0),
                    child: Icon(Icons.arrow_back_ios,color:myBlack,size: 22,),
                  ),
                )
              ),
            ),
            title: const Text(
              'Donations',
              style: TextStyle(
                color: myBlack,
                fontSize: 15,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5
                // height: 0.08,
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height:20),

                  SizedBox(
                    width: 80,
                    height: 70,
                    child:Image.asset("assets/qmchBg.png")
                  ),

                  const Text(
                    'QUAID-E-MILLATH',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: myBlack,
                      fontSize: 12,
                      fontFamily: 'JaldiBold',
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const Text(
                    'CENTRE FOR HUMANITY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: myBlack,
                      fontSize: 12,
                      fontFamily: 'JaldiBold',
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),


                  ///how to pay,amount enter textField
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 15,),

                        InkWell(
                          onTap:(){},
                          child: Container(
                            width: 125,
                            height: 34,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: myWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              shadows: [
                                const BoxShadow(
                                  color: Color(0x26000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                SizedBox(
                                    width: 24.47,
                                    height: 19.03,
                                  child:Image.asset("assets/youtube.png")
                                ),
                                const Text(
                                  ' How to Pay?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: myBlack,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    // height: 0.10,
                                  ),
                                ),
                              ]
                            )
                          ),
                        ),

                        Consumer<DonationProvider>(
                            builder: (context,value,child) {
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  const SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 26,),
                                      Row(
                                        children: [
                                          IntrinsicWidth(
                                            child: TextFormField(
                                            enabled:  paymentCategory!='FOODKIT'&&
                                                  paymentCategory!='SPONSOR_PATIENT'&&
                                                  paymentCategory!='EQUIPMENT'&&
                                                paymentCategory!='MULTIPLE_PAYMENT'&&
                                                paymentCategory!='MONTHLY_PAYMENT'?true:false,
                                              autofocus: true,
                                              style: GoogleFonts.akshar(
                                                  textStyle: const TextStyle(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "CarterOneRegular",
                                                    color:myBlack,
                                                  )  ),
                                              controller: value.kpccAmountController,
                                              showCursor: true,
                                              textInputAction: TextInputAction.next,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly,
                                                LengthLimitingTextInputFormatter(9)
                                              ],
                                              textAlign: TextAlign.center,
                                              decoration:   InputDecoration(
                                                prefixIcon: Padding(
                                                  padding: const EdgeInsets.only(bottom: 4.0),
                                                  child: Image.asset("assets/indian_rupee.png",scale:3.2)
                                                ),
                                                hintText: 'Amount',
                                                hintStyle: TextStyle(
                                                    fontFamily: 'CarterOneRegular',
                                                    fontSize: 25,
                                                    color:Colors.grey.shade500
                                                ),
                                                border: InputBorder.none,
                                                contentPadding:  const EdgeInsets.symmetric( horizontal: 10.0),
                                              ),

                                              onChanged:(text){


                                                // donationProvider.minimumAmountTrueOrFalse(text.toString());

                                                // if(double.parse(text.toString()==""?"0.0":text.toString())<138){
                                                //
                                                //
                                                //   donationProvider.setTextColor(poppinsalertred);
                                                //   print("ewfew");
                                                //
                                                //   _shakeXControlleramount.shake();
                                                //   if(!kIsWeb){
                                                //     Vibrate.vibrate();
                                                //   }
                                                //
                                                // }else{
                                                //   donationProvider.setTextColor(poppinsalertwhite);
                                                // }


                                              },
                                               onEditingComplete:(){


                                               },


                                              // validator: (person) => person == ''|| int.parse(person!)==0
                                              //     ? 'Please Enter Amount'
                                              //     : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8,),
                                       Text(
                                      paymentCategory!=''?paymentCategory:  'Contribute',
                                        style: TextStyle(
                                          color: cl3E4FA3,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          height: 0.11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10,),

                                ],
                              );
                            }
                        ),
                      ],
                    ),
                  ),

                  ///Name,hide Name,Mobile Number,Select Municipal..,
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 23.0,right: 23),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          loginUserPhone!=''?
                          Align(alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0,bottom: 12),
                              child: Consumer<DonationProvider>(
                                builder: (context,value,child) {
                                  return Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(onTap: (){
                                        donationProvider.setControllerData(loginUsername,loginUserPhone);
                                      },
                                          child: Text(
                                            'Fill With Existing Details',
                                            style: TextStyle(
                                              color: Colors.black.withOpacity(0.30),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                      SizedBox(width: 10,),
                                    value.dataSelected?
                                    InkWell(onTap: (){
                                      donationProvider.setControllerData(loginUsername,loginUserPhone);
                                    },
                                      child: Container(
                                          width: 17,
                                          height: 17,
                                          decoration: ShapeDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment(-1.00, -0.00),
                                              end: Alignment(1, 0),
                                              colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(34),
                                            ),
                                          ),
                                          child: Icon(Icons.done,color: Colors.white,size: 10,),
                                        ),
                                    ):
                                    InkWell(onTap: (){
                                      donationProvider.setControllerData(loginUsername,loginUserPhone);
                                    },
                                      child: Container(
                                          width: 17,
                                          height: 17,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(width: 0.70, color: Color(0xFF253068)),
                                              borderRadius: BorderRadius.circular(34),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              ),
                            ),
                          ):SizedBox(),
                          //Name
                          Consumer<DonationProvider>(
                              builder: (context, value, child) {
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  decoration: ShapeDecoration(
                                    color: myWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.04),
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
                                  child: TextFormField(
                                    onTap: (){
                                      if(value.kpccAmountController.text.isNotEmpty) {
                                        value.kpccAmountController.text = num.parse(value.kpccAmountController.text).toInt().toString();
                                      }

                                    },
                                    textInputAction: TextInputAction.next,
                                    controller: value.nameTC,
                                    style: const TextStyle(color: myBlack,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 1,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                        hintStyle: TextStyle(
                                          color: myBlack.withOpacity(0.20),
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(0.3),
                                        // fillColor: Colors.green,
                                        border:  InputBorder.none,
                                        enabledBorder:InputBorder.none,
                                        focusedBorder:InputBorder.none
                                    ),
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return "Please Enter a Name";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                );
                              }),

                          //hide Name
                          Consumer<DonationProvider>(
                            builder: (context,value1,child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Consumer<DonationProvider>(
                                      builder: (context,value,child) {
                                        return Checkbox(
                                          activeColor: cl323A71,
                                          shape: const CircleBorder(),
                                          checkColor: Colors.white,
                                          value: value.shownameBool,
                                          side:const BorderSide(color: cl3E4FA3, width: 2),
                                          onChanged: (bool? value) {
                                            donationProvider.showNameStatus();
                                          },
                                        );
                                      }
                                  ),
                                  Text('Hide Name',style: blackPoppinsBlackR12,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("(Participate without revealing your name)",style: hideNameStyle,),
                                  ),

                                ],
                              );
                            }
                          ),


                          //Mobile Number textField
                          Consumer<DonationProvider>(
                              builder: (context, value, child) {
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  decoration: ShapeDecoration(
                                    color: myWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.04),
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
                                  child: TextFormField(
                                    onTap: (){
                                      if(value.kpccAmountController.text.isNotEmpty) {
                                        value.kpccAmountController.text = num.parse(value.kpccAmountController.text).toInt().toString();
                                      }
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10)],
                                    controller: value.phoneTC,
                                    style: const TextStyle(color: myBlack,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 1,),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: "Mobile Number",
                                        hintStyle: TextStyle(
                                          color: myBlack.withOpacity(0.20),
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(0.3),
                                        // fillColor: Colors.green,
                                        border:  InputBorder.none,
                                        enabledBorder:InputBorder.none,
                                        focusedBorder:InputBorder.none
                                    ),
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return "Please Enter Mobile Number";
                                      } else if (!RegExp(
                                          r'^[0-9]+$')
                                          .hasMatch(value)|| value.length!=10) {
                                        return "Enter Correct Mobile Number";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                );
                              }),

                          const SizedBox(height:15),

                          // SizedBox(height:15,),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 12.0,bottom: 8),
                          //   child: Text("Select Organisation",
                          //     style: donateText,),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 10),
                          //   child: Consumer<DonationProvider>(
                          //       builder: (context,value,child) {
                          //         return Container(
                          //           // height: height*0.07,
                          //           // width: width*0.8,
                          //           child: Autocomplete<String>(
                          //             optionsBuilder: (TextEditingValue textEditingValue) {
                          //
                          //               return (value.organisationList).toList();
                          //             },
                          //             displayStringForOption: (String option) => option,
                          //             fieldViewBuilder: (
                          //                 BuildContext context,
                          //                 TextEditingController fieldTextEditingController,
                          //                 FocusNode fieldFocusNode,
                          //                 VoidCallback onFieldSubmitted
                          //                 ) {
                          //
                          //               return TextFormField(
                          //
                          //                 scrollPadding: const EdgeInsets.only(bottom: 500),
                          //                 decoration:  InputDecoration(
                          //                   contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          //
                          //                   // labelText:'Select Assembly/organization',
                          //                   // labelStyle: whitePoppins,
                          //                   filled: true,
                          //                   fillColor: Colors.white.withOpacity(0.4),
                          //                   border: borderKnm,
                          //                   enabledBorder: borderKnm,
                          //                   focusedBorder: borderKnm,
                          //                 ),
                          //                 controller: fieldTextEditingController,
                          //                 focusNode: fieldFocusNode,
                          //                 style: const TextStyle(fontWeight: FontWeight.bold,color: myBlack,fontSize: 18),
                          //                 // validator: (text) => value.assemblyList.map((e) => e.assembly.contains(text)) ? "Please Select Your Assembly" : null,
                          //                 validator: (value2) {
                          //                   if (value2!.trim().isEmpty) {
                          //                     return "Please Select Your Organisation";
                          //                   } else {
                          //                     return null;
                          //                   }
                          //                 },
                          //               );
                          //
                          //             },
                          //             onSelected: (String selection) {
                          //               value.organisationTC.text = selection;
                          //             },
                          //             optionsViewBuilder: (
                          //                 BuildContext context,
                          //                 AutocompleteOnSelected<String> onSelected,
                          //                 Iterable<String> options
                          //                 ) {
                          //               return Align(
                          //                 alignment: Alignment.topLeft,
                          //                 child: Material(
                          //                   child: Container(
                          //                     width: width-30,
                          //                     height: 300,
                          //                     color: Colors.white,
                          //                     child: ListView.builder(
                          //                       padding: const EdgeInsets.all(10.0),
                          //                       itemCount: options.length,
                          //                       itemBuilder: (BuildContext context, int index) {
                          //                         final String option = options.elementAt(index);
                          //
                          //                         return GestureDetector(
                          //                           onTap: () {
                          //                             onSelected(option);
                          //                           },
                          //                           child:  Container(
                          //                             color: Colors.white,
                          //                             height: 50,
                          //                             width: width-30,
                          //                             child: Column(
                          //                                 crossAxisAlignment:
                          //                                 CrossAxisAlignment.start,
                          //                                 children: [
                          //
                          //                                   Text(option,style: const TextStyle(
                          //                                       fontSize: 12
                          //                                   ),),
                          //                                   const SizedBox(height: 10)
                          //                                 ]),
                          //                           ),
                          //                         );
                          //                       },
                          //                     ),
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //           ),
                          //         );
                          //       }
                          //   ),
                          // ),

                          //Select Municipality/Panchayath
                          Consumer<DonationProvider>(
                              builder: (context,value,child) {
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  decoration: ShapeDecoration(
                                    color: myWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.04),
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
                                  child: Autocomplete<PanjayathModel>(
                                    optionsBuilder: (TextEditingValue textEditingValue) {

                                      return (value.panjayathList)

                                          .where((PanjayathModel wardd) => wardd.panjayath.toLowerCase()
                                          .contains(textEditingValue.text.toLowerCase()))
                                          .toList();
                                    },
                                    displayStringForOption: (PanjayathModel option) => option.panjayath,
                                    fieldViewBuilder: (
                                        BuildContext context,
                                        TextEditingController fieldTextEditingController,
                                        FocusNode fieldFocusNode,
                                        VoidCallback onFieldSubmitted
                                        ) {

                                      return TextFormField(

                                        scrollPadding: const EdgeInsets.only(bottom: 500),
                                        decoration:  InputDecoration(
                                          // labelText:'Select Assembly/organization',
                                          // labelStyle: whitePoppins,
                                            hintText: "Select Assembly/organization",
                                            hintStyle: TextStyle(
                                              color: myBlack.withOpacity(0.20),
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                            filled: true,
                                            fillColor: Colors.white.withOpacity(0.3),
                                            // fillColor: Colors.green,
                                            border:  InputBorder.none,
                                            enabledBorder:InputBorder.none,
                                            focusedBorder:InputBorder.none
                                        ),
                                        controller: fieldTextEditingController,
                                        focusNode: fieldFocusNode,
                                        style: const TextStyle(color: myBlack,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          height: 1,),
                                        // validator: (text) => value.assemblyList.map((e) => e.assembly.contains(text)) ? "Please Select Your Assembly" : null,

                                      ///ameen commented
                                        // validator: (value2) {
                                        //   if (value2!.trim().isEmpty || !value.panjayathList.map((item) => item.panjayath).contains(value2)) {
                                        //     return "Please Select Your panchayath";
                                        //   } else {
                                        //     return null;
                                        //   }
                                        // },
                                      );

                                    },
                                    onSelected: (PanjayathModel selection) {
                                      print(selection.assembly.toString()+"wwwwiefjmf");


                                      // donationProvider.onSelectAssembly(selection);


                                      donationProvider.fetchUnitChipset(selection,context);

                                    },
                                    optionsViewBuilder: (
                                        BuildContext context,
                                        AutocompleteOnSelected<PanjayathModel> onSelected,
                                        Iterable<PanjayathModel> options
                                        ) {
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          child: Container(
                                            width: width-30,
                                            height: 400,
                                            color: Colors.white,
                                            child: ListView.builder(
                                              padding: const EdgeInsets.all(10.0),
                                              itemCount: options.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                final PanjayathModel option = options.elementAt(index);

                                                return GestureDetector(
                                                  onTap: () {
                                                    onSelected(option);
                                                  },
                                                  child:  Container(
                                                    color: Colors.white,
                                                    height: 50,
                                                    width: width-30,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(option.panjayath,
                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight.bold)),
                                                          Text(option.district,style: const TextStyle(
                                                              fontSize: 12
                                                          ),),
                                                          const SizedBox(height: 10)
                                                        ]),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                          ),

                          const SizedBox(height: 5,),

                          // Align(alignment: Alignment.centerLeft,
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(left: 33.0),
                          //       child: Text('Select Unit',style: blackPoppinsBlackR14,),
                          //     )),

                          Consumer<DonationProvider>(
                              builder: (context,value,child) {
                                return value.chipsetWardList.isEmpty
                                    ?  Padding(
                                  padding: const EdgeInsets.fromLTRB(0,10,10,20),
                                  child:Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:  [
                                      const SizedBox(height:10),
                                      Row(
                                       // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.arrow_right,size: 25,color: Colors.black),
                                          SizedBox(
                                            width: width*.7,
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 3),
                                              child: Text('പഞ്ചായത്ത്‌ സെലക്ട് ചെയ്യുക.',style: TextStyle(color: Colors.black,fontSize: 14)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height:10),
                                      Row(
                                        //mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.arrow_right,size: 25,color: Colors.black),
                                          SizedBox(
                                            width: width*.7,
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 3.0),
                                              child: Text('ശേഷം താഴെ വരുന്ന ലിസ്റ്റിൽ നിന്നും Unit തിരഞ്ഞെടുക്കുക.',style: TextStyle(color: Colors.black,fontSize: 14)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height:10),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.arrow_right,size: 25,color: Colors.black),
                                          SizedBox(
                                            width: width*.7,
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 3.0),
                                              child: Text('ശേഷം  Pay Now ബട്ടൺ ക്ലിക്ക് ചെയ്യുക.',style: TextStyle(color: Colors.black,fontSize: 14)),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),

                                )
                                    :const SizedBox();
                              }
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///select unit
                  Padding(
                    padding: const EdgeInsets.only(left:20),
                    child: Consumer<DonationProvider>(
                        builder: (context,value,child){
                          return value.chipsetWardList.isNotEmpty
                              ?
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0,left: 10,right: 2),
                            child: ShakeX(
                              controller: _shakeXController,
                              text: 'Select Unit',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color:cl1E2C68
                              ),

                              child: Column(

                                children: [
                                  const SizedBox(height: 20,),

                                  ChipList(
                                    style:  const TextStyle(
                                        fontSize:10,fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                    ),
                                    listOfChipNames:value.chipsetWardList,
                                    listOfChipIndicesCurrentlySeclected: const [0],
                                    currentSelected: value.selectedWard,

                                    shouldWrap: true,
                                    supportsMultiSelect: false,
                                    runSpacing:7,
                                    spacing:8,
                                    callback: (item){
                                      print(item!.wardName.toString()+"fjrfior");
                                      donationProvider.onSelectWard(item);
                                    },
                                  ),
                                  const SizedBox(height: 40,)
                                ],
                              ),
                            ),
                          )
                              :const SizedBox();

                        }
                    ),
                  ),
                  const SizedBox(height: 90,),
                ],
              ),
            ),
          ),
        ));

  }

  Widget mobile (BuildContext context){
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return WillPopScope(
      onWillPop: ()async{
        return true;
      },
          //callNextReplacement(const HomeScreen(), context),
      child: Container(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          floatingActionButton: Consumer<DonationProvider>(
              builder: (context,value,child) {
                return Consumer<HomeProvider>(
                  builder: (context,value2,child) {
                    return InkWell(
                      onTap: () async {
                        print("esfef"+value.kpccAmountController.text);
                        HomeProvider homeProvider =
                        Provider.of<HomeProvider>(context, listen: false);

                      DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                      if(value.kpccAmountController.text.isNotEmpty) {

                        value.kpccAmountController.text = num.parse(value.kpccAmountController.text).toInt().toString();
                      }
                        PackageInfo packageInfo = await PackageInfo.fromPlatform();
                        String packageName = packageInfo.packageName;

                        final FormState? form = _formKey.currentState;


                          // if(value.selectedWard!=null){
                            if(form!.validate()){
                              if(value.kpccAmountController.text!=''){
                                if(kIsWeb){

                                }else{

                                  mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
                                    if(event.snapshot.value.toString()=='ON'){
                                      DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                      donationProvider.transactionID.text = DateTime.now().microsecondsSinceEpoch.toString()+generateRandomString(2);
                                      print("atteemptclickheh");
                                      donationProvider.attempt(donationProvider.transactionID.text,homeProvider.appVersion.toString(),paymentCategory,equipmentCount,equipmentID,
                                          oneEquipmentPrice,loginUsername,loginUserID,subScriberType,loginUserPhone,zakathAmount, deseaseName, sponsorCategory, sponsorCount, sponsorItemOnePrice, foodkitPrice, footkitCount, equipmentAmount,sponsorPatientAmonut,foodkitAmount,monthList);
                                      if(Platform.isIOS){
                                        callNext(NewPaymentGatewayScreen(id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=qa%20${donationProvider.transactionID.text}&am=${donationProvider.kpccAmountController.text.toString()}&cu=INR",
                                            paymentCategory: paymentCategory,
                                          equipmentCount: equipmentCount,
                                          equipmentID: equipmentID,
                                          oneEquipmentPrice: oneEquipmentPrice,
                                          loginUserID: loginUserID,
                                          loginUsername: loginUsername,
                                          subScriberType: subScriberType,loginUserPhone: loginUserPhone,
                                          zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                          sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                          foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, monthList: monthList), context);

                                      }else if(Platform.isAndroid){

                                        if(value2.lockMindGateOption=="ON"&&value2.intentPaymentOption=="OFF"){
                                          callNext(NewPaymentGatewayScreen(id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=qa%20${donationProvider.transactionID.text}&am=${donationProvider.kpccAmountController.text.toString()}&cu=INR",
                                              paymentCategory: paymentCategory,
                                            equipmentID: equipmentID,
                                            equipmentCount: equipmentCount,
                                            oneEquipmentPrice: oneEquipmentPrice,
                                            loginUserID: loginUserID,loginUsername: loginUsername,
                                            subScriberType: subScriberType,loginUserPhone: loginUserPhone,
                                            zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                            sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                            foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount,monthList: monthList, ), context);

                                        }else{

                                          callNext(PaymentGateway(subScriberType: subScriberType,paymentCategory: paymentCategory,monthList: monthList,
                                              equipmentID: equipmentID,
                                              equipmentCount: equipmentCount,
                                              oneEquipmentPrice: oneEquipmentPrice,loginUserID: loginUserID,loginUsername: loginUsername,
                                              loginUserPhone: loginUserPhone,zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                            sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                            foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);

                                        }


                                      }

                                    }else{
                                      callNext( NoPaymentGateway(loginUserPhone: loginUserPhone,
                                          loginUserID: loginUserID,loginUsername: loginUsername,
                                          subScriberType: subScriberType, zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                        sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                        foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                                    }
                                  });
                                }


                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor:Colors.red,
                                        content: Text("Please Enter Amount")));
                              }
                            }

                          // }else{
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //           backgroundColor:Colors.red,
                          //           content: Text("Please Select Unit")));
                          //
                          // }
                          },
                      child: Container(
                        height: 50,
                        width: width * .82,
                        decoration:  BoxDecoration(
                          boxShadow:  [
                            const BoxShadow(
                              color:cl323A71,
                            ),
                            BoxShadow(
                              color: cl000000.withOpacity(0.25),
                              spreadRadius: -5.0,
                              // blurStyle: BlurStyle.inner,
                              blurRadius: 20.0,
                            ),

                          ],
                            borderRadius: const BorderRadius.all(Radius.circular(35)),
                          gradient: const LinearGradient(
                            begin: Alignment(-1.00, -0.00),
                            end: Alignment(1, 0),
                            colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
                          ),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                           Image.asset("assets/CoinGif.gif"),
                            const GradientText(
                              'Pay Now',
                              style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontFamily: "PoppinsMedium"),
                              gradient: LinearGradient(colors: [
                                Colors.white,
                                Colors.white,
                              ]),
                            ),
                        // SizedBox(width: MediaQuery.of(context).size.width*0.1,
                        //     child: Image.asset("assets/Contribute Arrow.png",)),


                            // Icon(Icons.arrow_forward_ios,color: knmGolden,)

                          ],
                        ),
                      ),
                    );
                  }
                );
              }
          ),

          body: Consumer<DonationProvider>(
            builder: (context,value,child) {
              return GestureDetector(
                  onTap: () {
                    // if(value.dhotiCounterController.text.isEmpty) {
                    //   value.dhotiCounterController.text = '1';
                    //   value.dhothiAmount=600;
                    // }
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: body(context)
              );
            }
          ),
        ),
      ),
    );
  }
  Widget web (BuildContext context){
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return WillPopScope(
      onWillPop: ()async{
        return true;
        //callNextReplacement(const HomeScreen(), context),
      },

        child: Stack(children:[
          // Row(
          //   children: [
          //     Container(
          //       height: height,
          //       width: width,
          //       decoration: const BoxDecoration(
          //           image: DecorationImage(
          //               image: AssetImage('assets/KnmWebBackground1.jpg'),fit: BoxFit.cover
          //           )
          //       ),
          //       child: Row(
          //         children: [
          //           SizedBox(
          //               height: height,
          //               width: width / 3,
          //               child: Image.asset("assets/Group 2.png",scale: 4,)),
          //           SizedBox(
          //             height: height,
          //             width: width / 3,
          //           ),
          //           SizedBox(
          //               height: height,
          //               width: width / 3,
          //               child: Image.asset("assets/Group 3.png",scale: 6,)),
          //         ],
          //       ),
          //     ),
          //
          //
          //   ],
          // ),
          Center(
              child:queryData.orientation==Orientation.portrait
              ? Row(
               mainAxisSize: MainAxisSize.min,
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
              // SizedBox(width: width/3,),
               SizedBox(
                 width: width,
                child: Scaffold(
                  // backgroundColor: Colors.white,
                  resizeToAvoidBottomInset: true,
                  floatingActionButton: Consumer<DonationProvider>(
                      builder: (context,value,child) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child:
                          InkWell(
                            onTap: () {
                              // print("esfef");
                              // HomeProvider homeProvider =
                              // Provider.of<HomeProvider>(context, listen: false);
                              //
                              // DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                              // if(value.kpccAmountController.text.isNotEmpty) {
                              //
                              //   value.kpccAmountController.text = num.parse(value.kpccAmountController.text).toInt().toString();
                              // }
                              //
                              //
                              //
                              // final FormState? form = _formKey.currentState;
                              // if(form!.validate()){
                              //   if(double.parse(value.kpccAmountController.text.toString())>=138){
                              //     if(value.selectedWard==null){
                              //       _shakeXController.shake();
                              //       if(!kIsWeb){
                              //         Vibrate.vibrate();
                              //       }
                              //     } else {
                              //       callNext(PaymentGateway(), context);
                              //
                              //       if(kIsWeb){
                              //
                              //       }else{
                              //         mRoot.child('0').child('PaymentGateway34').onValue.listen((event) {
                              //           if(event.snapshot.value.toString()=='ON'){
                              //             DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                              //             donationProvider.transactionID.text = DateTime.now().microsecondsSinceEpoch.toString();
                              //             print("atteemptclickheh");
                              //             donationProvider.attempt(donationProvider.transactionID.text,homeProvider.appVersion.toString());
                              //             callNext(PaymentGateway(), context);
                              //           }else{
                              //             callNext(const NoPaymentGateway(), context);
                              //           }
                              //         });
                              //       }
                              //     }
                              //
                              //   }else{
                              //     ScaffoldMessenger.of(context).showSnackBar(
                              //         const SnackBar(
                              //             backgroundColor:Colors.red,
                              //             content: Text("Minimum amount is 138")));
                              //   }
                              //m
                              // }else{
                              //   if(!kIsWeb){
                              //     Vibrate.vibrate();
                              //   }
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       const SnackBar(content: Text("Please Enter Amount",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)));
                              //
                              // }
                              // }

                              // callNext(PaymentGateway(), context);
                              // if(value.selectedPanjayathChip!=null){


                              // }else{
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       const SnackBar(content: Text("please select panchayath!!!")));
                              // }


                            },
                            child: Container(
                              height: 50,
                              width: width * .750,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                                  // gradient: LinearGradient(
                                  //     begin: Alignment.centerLeft,
                                  //     end: Alignment.centerRight,
                                  //     colors: [myLightBlue, myDarkBlue])
                            ),
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                  const Icon(
                                    Icons.add_circle,
                                    color: myWhite,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5,),
                                  // value.displayAmount!=""
                                  //     ? Text(
                                  //   'Dhothi Amount ₹ '+value.displayAmount +' Now',
                                  //   style: white16,
                                  // ):
                                  const GradientText(
                                    'Pay Now',
                                    style: TextStyle(fontSize:22,fontWeight:FontWeight.bold ),
                                    gradient: LinearGradient(colors: [
                                      Colors.white,
                                      Colors.white,
                                    ]),
                                  ),
                                  // SizedBox(width: MediaQuery.of(context).size.width*0.1,
                                  //     child: Image.asset("assets/Contribute Arrow.png",)),


                                  // Icon(Icons.arrow_forward_ios,color: knmGolden,)

                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  ),

                  body: Consumer<DonationProvider>(
                      builder: (context,value,child) {
                        return GestureDetector(
                            onTap: () {
                              // if(value.dhotiCounterController.text.isEmpty) {
                              //   value.dhotiCounterController.text = '1';
                              //   value.dhothiAmount=600;
                              // }
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: body(context)
                        );
                      }
                  ),
                ),
              ),
              // SizedBox(width: width/3,),
            ],
          )

              : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                SizedBox(
                  width: width/3,
                  child: Scaffold(
                    // backgroundColor: Colors.white,
                    resizeToAvoidBottomInset: true,
                    floatingActionButton: Consumer<DonationProvider>(
                        builder: (context,value,child) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child:
                            InkWell(
                              onTap: () {
                                // print("esfef");
                                // HomeProvider homeProvider =
                                // Provider.of<HomeProvider>(context, listen: false);
                                //
                                // DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                // if(value.kpccAmountController.text.isNotEmpty) {
                                //
                                //   value.kpccAmountController.text = num.parse(value.kpccAmountController.text).toInt().toString();
                                // }
                                //
                                //
                                //
                                // final FormState? form = _formKey.currentState;
                                // if(form!.validate()){
                                //   if(double.parse(value.kpccAmountController.text.toString())>=138){
                                //     if(value.selectedWard==null){
                                //       _shakeXController.shake();
                                //       if(!kIsWeb){
                                //         Vibrate.vibrate();
                                //       }
                                //     } else {
                                //       callNext(PaymentGateway(), context);
                                //
                                //       if(kIsWeb){
                                //
                                //       }else{
                                //         mRoot.child('0').child('PaymentGateway34').onValue.listen((event) {
                                //           if(event.snapshot.value.toString()=='ON'){
                                //             DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                //             donationProvider.transactionID.text = DateTime.now().microsecondsSinceEpoch.toString();
                                //             print("atteemptclickheh");
                                //             donationProvider.attempt(donationProvider.transactionID.text,homeProvider.appVersion.toString());
                                //             callNext(PaymentGateway(), context);
                                //           }else{
                                //             callNext(const NoPaymentGateway(), context);
                                //           }
                                //         });
                                //       }
                                //     }
                                //
                                //   }else{
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(
                                //             backgroundColor:Colors.red,
                                //             content: Text("Minimum amount is 138")));
                                //   }
                                //
                                // }else{
                                //   if(!kIsWeb){
                                //     Vibrate.vibrate();
                                //   }
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       const SnackBar(content: Text("Please Enter Amount",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)));
                                //
                                // }
                                // }

                                // callNext(PaymentGateway(), context);
                                // if(value.selectedPanjayathChip!=null){


                                // }else{
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       const SnackBar(content: Text("please select panchayath!!!")));
                                // }


                              },
                              child: Container(
                                height: 50,
                                width: width * .750,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(35)),
                                    // gradient: LinearGradient(
                                    //     begin: Alignment.centerLeft,
                                    //     end: Alignment.centerRight,
                                    //     colors: [myLightBlue, myDarkBlue])
                                ),
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  const [
                                    Icon(
                                      Icons.add_circle,
                                      color: myWhite,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5,),
                                    // value.displayAmount!=""
                                    //     ? Text(
                                    //   'Dhothi Amount ₹ '+value.displayAmount +' Now',
                                    //   style: white16,
                                    // ):
                                    GradientText(
                                      'Pay Now',
                                      style: TextStyle(fontSize:22,fontWeight:FontWeight.bold ),
                                      gradient: LinearGradient(colors: [
                                        Colors.white,
                                        Colors.white,
                                      ]),
                                    ),
                                    // SizedBox(width: MediaQuery.of(context).size.width*0.1,
                                    //     child: Image.asset("assets/Contribute Arrow.png",)),


                                    // Icon(Icons.arrow_forward_ios,color: knmGolden,)

                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    ),

                    body: Consumer<DonationProvider>(
                        builder: (context,value,child) {
                          return GestureDetector(
                              onTap: () {
                                // if(value.dhotiCounterController.text.isEmpty) {
                                //   value.dhotiCounterController.text = '1';
                                //   value.dhothiAmount=600;
                                // }
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                              child: body(context)
                          );
                        }
                    ),
                  ),
              ),
              // SizedBox(width: width/3,),
            ],
          )),

        ]),
      );

  }
  TextStyle textsty=const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white);
  TextStyle textsty2=const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black);

  void showPaymentDialog(BuildContext context) {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    Widget setupAlertDialoadContainer() {
      return SizedBox(
        height: 100.0, // Change as per your requirement
        width: 100.0, // Change as per your requirement
        child: Consumer<DonationProvider>(
            builder: (context,value,child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: value.paymentOptions.length,
                itemBuilder: (BuildContext context, int index) {
                  return  InkWell(
                    onTap: () async {
                      finish(context);
                      if(value.paymentOptions[index].id=="1"){
                        donationProvider.funPaytm(context,paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice,loginUsername,loginUserID,subScriberType,loginUserPhone,
                          zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice, foodkitPrice, footkitCount,equipmentAmount, sponsorPatientAmonut, foodkitAmount,[]);

                      }
                      if(value.paymentOptions[index].id=="2"){
                        // donationProvider.cashFree();
                        // showBottomSheet(context);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: myWhite,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Image.asset(
                                value.paymentOptions[index].asset,
                                scale: 8,
                              )),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
        ),
      );
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: setupAlertDialoadContainer(),
          );
        });
  }
  // void showBottomSheet(BuildContext context) {
  //   DonationProvider donationProvider =
  //   Provider.of<DonationProvider>(context, listen: false);
  //   var size = MediaQuery.of(context).size;
  //   var height = size.height;
  //   var width = size.width;
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     barrierColor: myBlack.withOpacity(0.2),
  //     elevation: 10,
  //     useRootNavigator: true,
  //     backgroundColor: Colors.transparent,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(20.0),
  //           topRight: Radius.circular(20.0),
  //         )),
  //     builder: (_) {
  //       return DraggableScrollableSheet(
  //         maxChildSize: 0.8,
  //         expand: false,
  //         builder: (_, controller) {
  //
  //           return Column(
  //             children: [
  //
  //               Expanded(
  //                 child: Container(
  //                   padding: const EdgeInsets.only(top: 20),
  //                   decoration: const BoxDecoration(
  //                       color: myWhite,
  //
  //                       borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(20.0),
  //                         topRight: Radius.circular(20.0),
  //                       )
  //                   ),
  //                   child: Consumer<DonationProvider>(
  //                       builder: (context,value,child) {
  //                         return GridView.builder(
  //                           shrinkWrap: true,
  //                             gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
  //                                 maxCrossAxisExtent: width/4,
  //                                 childAspectRatio: 2 / 2,
  //                                 crossAxisSpacing: 20,
  //                                 mainAxisSpacing: 20),
  //                             itemCount: value.apps!.length,
  //                             itemBuilder: (BuildContext ctx, index) {
  //                               return InkWell(
  //
  //                                 onTap: Platform.isAndroid ? () async => await donationProvider.onTap(value.apps![index],context) : null,
  //                                 child: Container(
  //                                   alignment: Alignment.center,
  //                                   child: Column(
  //                                     children: [
  //                                       value.apps![index].iconImage(48),
  //                                       Text(value.apps![index].upiApplication.appName),
  //                                     ],
  //                                   ),
  //                                   decoration: BoxDecoration(
  //                                       color: Colors.white,
  //                                       borderRadius: BorderRadius.circular(15)),
  //                                 ),
  //                               );
  //                             });
  //                       }
  //                   ),
  //                 ),
  //               ),
  //
  //             ],
  //           );
  //
  //         },
  //       );
  //     },
  //   );
  // }
  final OutlineInputBorder border=OutlineInputBorder(
    borderSide: const BorderSide(
        color:Color(0xFFF4FCFE) , width: 1.0),
    borderRadius: BorderRadius.circular(8),
  );

  final OutlineInputBorder borderKnm=OutlineInputBorder(
    borderSide: const BorderSide(
        color:clD4D4D4 , width: 1.0),
    borderRadius: BorderRadius.circular(50),
  );

  void showBottomSheet(BuildContext context) {
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
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
          return Consumer<DonationProvider>(
              builder: (context,value,child) {
                return SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: value.paymentGateWays.length,
                    itemBuilder: (_, index) {
                      var item=value.paymentGateWays[index];
                      return InkWell(
                        onTap: (){
                          if(item=='Cashfree'){
                            callNextReplacement(PaymentGateway(subScriberType: subScriberType,paymentCategory: paymentCategory
                                ,equipmentID: equipmentID,equipmentCount: equipmentCount,
                              oneEquipmentPrice: oneEquipmentPrice,loginUserID: loginUserID,
                                loginUsername: loginUsername,loginUserPhone: loginUserPhone,monthList: monthList,
                              zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                              sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                              foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                          }
                          // else if(item=='PayU'){
                          //   finish(context);
                          //   showLoaderDialog(context);
                          //   String amount=donationProvider.amountTC.text;
                          //   String name=donationProvider.nameTC.text!=""?donationProvider.nameTC.text:"User";
                          //   String phone=donationProvider.phoneTC.text!=""?donationProvider.phoneTC.text:"9048004320";
                          //   donationProvider.payUPaymentGateWay(context, amount, name, phone);
                          // }
                        },
                        child: SizedBox(
                          height: 50,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(item),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
          );
        });
    // ImageSource
  }

}


class FirstDisabledFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
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

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;


  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
