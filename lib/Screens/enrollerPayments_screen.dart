import 'package:beehive/Screens/top_enrollers_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/home_provider.dart';
import 'home_screen.dart';

class EnrollerPaymentsScreen extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
   EnrollerPaymentsScreen({Key? key,required this.loginUsername,required this.loginUserID
     ,required this.subScriberType,required this.loginUserPhone,
     required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  // callNextReplacement(
  // HomeScreenNew(loginUserID: loginUserID,
  // loginUsername: loginUsername,
  // subScriberType: subScriberType,loginUserPhone: loginUserPhone,),context);

  //Volunteer Payments

  Widget mobile(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: myWhite,
          leading: Center(
            child: InkWell(
              onTap: () {
                callNextReplacement(
                HomeScreenNew(loginUserID: loginUserID,
                loginUsername: loginUsername,
                subScriberType: subScriberType,loginUserPhone: loginUserPhone,
                          zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                          sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                          foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ),context);
              },
              child:  CircleAvatar(
                  radius: 20,
                  backgroundColor:myBlack.withOpacity(0.1),
                  child: const Icon(Icons.arrow_back_ios_new_outlined,size: 20,color: myBlack,)),
            ),
          ),

          title: const Text("Volunteer Payments",style: TextStyle(color:myBlack, fontFamily: 'Poppins',
            fontSize: 15,fontWeight: FontWeight.w600,),
          ),

          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
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
                child: Consumer<HomeProvider>(
                    builder: (context, value, child) {
                      return TextField(
                        controller: value.EnrollerPaymentSearchCt,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Search Volunteer ID",
                          hintStyle:  TextStyle(
                            color: cl898989.withOpacity(0.56),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          suffixIcon: InkWell(
                              onTap: () async {
                                homeProvider.aa();
                                if(value.EnrollerPaymentSearchCt.text==""){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              backgroundColor:Colors.red,
                                                content: Text("Please enter Volunteer ID")));

                                }else{

                                  await homeProvider.getEnrollerPayments(value.EnrollerPaymentSearchCt.text.toString());


                                }
                              },
                              child:  Icon(
                                Icons.search,
                                color: cl898989.withOpacity(0.56),
                              )),
                        ),
                        onChanged: (item) {

                        },
                        onSubmitted: (txt){


                        },
                      );
                    }),
              ),

              const SizedBox(height: 10,),

              Container(
                width: width,
                margin: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
                decoration: BoxDecoration(
                  image:const DecorationImage(
                    image:AssetImage("assets/VolunRA.png"),
                    fit: BoxFit.cover
                  ),
                  // border: Border.all(
                  //       color: cl1177BB,
                  //       width: 1),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(15.0)),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Consumer<HomeProvider>(
                      builder: (context,value,child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 8,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 130,
                                child: Text('Volunteer Name',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: myWhite,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.10,
                                    )
                                ),
                              ),
                              const Text(' : ',style: TextStyle(color: myWhite,)),
                              Flexible(
                                fit:FlexFit.tight,
                                child: Text(value.EnrollerPaymentName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: myWhite,
                                    fontSize: 13,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.12,),),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 130,
                                child: Text('No of Payments',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: myWhite,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.10,),
                                ),
                              ),
                              const Text(' : ',style: TextStyle(color: myWhite,)),
                              Flexible(
                                fit:FlexFit.tight,
                                child: Text(value.enrollerNoOfPayments,
                                  maxLines: 2,
                                  // textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: myWhite,
                                    fontSize: 13,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.12,),),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 130,
                                child: Text('Amount',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: myWhite,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.10,),
                                ),
                              ),
                              const Text(' : ',style: TextStyle(color: myWhite,)),
                              Flexible(
                                fit:FlexFit.tight,
                                child: Text(value.EnrollerPaymenttotal.toString(),
                                  maxLines: 1,
                                  // textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: myWhite,
                                    fontSize: 13,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.12,),),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8,)
                        ],
                      );
                    }
                  ),
                )
              ),

              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Details',
                    style: TextStyle(
                      color: myBlack.withOpacity(0.40),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.10,
                    ),
                  ),

                  Text(
                    'Amount',
                    style: TextStyle(
                      color:  myBlack.withOpacity(0.40),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.10,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 2,),

              Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return value.enrollerPaymentsList.isNotEmpty?
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.enrollerPaymentsList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var item = value.enrollerPaymentsList[index];
                          return InkWell(
                            onTap: (){

                            },
                            child:Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              child: Container(
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
                                child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //   height:35,
                                    //         width:90,
                                    // ),
                                    // Align(
                                    //     alignment:Alignment.centerRight,
                                    //     child:Container(
                                    //       alignment: Alignment.center,
                                    //       height:35,
                                    //       width:90,
                                    //       decoration: const BoxDecoration(
                                    //         borderRadius: BorderRadius.only(
                                    //           topRight: Radius.circular(18.04),
                                    //           bottomLeft: Radius.circular(18.04),
                                    //         ),
                                    //         gradient: LinearGradient(
                                    //           begin: Alignment(-1.00, -0.00),
                                    //           end: Alignment(1, 0),
                                    //           colors: [cl3E4FA3, cl253068],
                                    //         ),
                                    //       ),
                                    //       child: const Text(
                                    //         'Receipt',
                                    //         style: TextStyle(
                                    //           color: myWhite,
                                    //           fontSize: 12,
                                    //           fontFamily: 'Poppins',
                                    //           fontWeight: FontWeight.w500,
                                    //           // height: 0.18,
                                    //           letterSpacing: -0.10,
                                    //         ),
                                    //       ),
                                    //     )
                                    // ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,top: 15),
                                      child: Text(
                                        '  *General',
                                        style: TextStyle(
                                          color: cl3E4FA3,
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          // height: 0.08,
                                        ),
                                      ),
                                    ),


                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 13, horizontal: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              children: [

                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width / 4.9,
                                                      child:  Text(
                                                        "Name",
                                                        style: TextStyle(color: myBlack.withOpacity(0.20),
                                                            fontSize: 12.5,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: "PoppinsMedium"),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                        width: width / 25,
                                                        child:  Text(':',style: TextStyle(
                                                            color:myBlack.withOpacity(0.40)
                                                        ),)),

                                                    SizedBox(
                                                      width: width / 2.7,
                                                      child: Text(item.name,
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: myBlack,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w700,
                                                          fontFamily: "PoppinsMedium"
                                                      ),
                                                    ),
                                                    )

                                                  ],
                                                ),

                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width / 4.9,
                                                      child: Text(
                                                        "ID",
                                                        style: TextStyle(color: myBlack.withOpacity(0.20),
                                                            fontSize: 12.5,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: "PoppinsMedium"),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                        width: width / 25,
                                                        child:  Text(':',style: TextStyle(
                                                        color:myBlack.withOpacity(0.40)
                                                    ),)),

                                                    SizedBox(
                                                      width:
                                                      width / 2.7,
                                                      child: Text(
                                                        item.enrollerid.substring(0, item.enrollerid.length - 4) + getStar(4),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: gray12,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                ///district,panchayath,unit
                                                // Row(
                                                //   children: [
                                                //     SizedBox(
                                                //       width: width / 4.9,
                                                //       child: Text(
                                                //         "District",
                                                //         style: TextStyle(color: myBlack.withOpacity(0.20),
                                                //             fontSize: 12.5,
                                                //             fontWeight: FontWeight.w600,
                                                //             fontFamily: "PoppinsMedium"),
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //         width: width / 25,
                                                //         child:  Text(':',style: TextStyle(
                                                //             color:myBlack.withOpacity(0.40)
                                                //         ),)),
                                                //
                                                //     SizedBox(
                                                //       width: width / 2.7,
                                                //       child: Text(
                                                //         item.district,
                                                //         maxLines: 2,
                                                //         overflow: TextOverflow.ellipsis,
                                                //         style: gray12,
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                                //
                                                // Row(
                                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                                //   children: [
                                                //     SizedBox(
                                                //       width: width / 4.9,
                                                //       child: Text(
                                                //        "Panchayath",
                                                //         style: TextStyle(color: myBlack.withOpacity(0.20),
                                                //             fontSize: 12.5,
                                                //             fontWeight: FontWeight.w600,
                                                //             fontFamily: "PoppinsMedium"),
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //         width: width / 25,
                                                //         child:  Text(':',style: TextStyle(
                                                //             color:myBlack.withOpacity(0.40)
                                                //         ),)),
                                                //     SizedBox(
                                                //       width: width / 2.7,
                                                //       child: Text(
                                                //         item.panchayath,
                                                //         maxLines: 2,
                                                //         overflow: TextOverflow.ellipsis,
                                                //         style: gray12,
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                                //
                                                // Row(
                                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                                //   children: [
                                                //     SizedBox(
                                                //       width: width / 4.9,
                                                //       child: Text(
                                                //        "Unit",
                                                //         style: TextStyle(color: myBlack.withOpacity(0.20),
                                                //             fontSize: 12.5,
                                                //             fontWeight: FontWeight.w600,
                                                //             fontFamily: "PoppinsMedium"),
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //         width: width / 25,
                                                //         child: Text(':',style: TextStyle(
                                                //             color:myBlack.withOpacity(0.40)
                                                //         ),)),
                                                //     SizedBox(
                                                //       width: width / 2.7,
                                                //       child: Text(
                                                //         item.ward,
                                                //         maxLines: 2,
                                                //         overflow: TextOverflow.ellipsis,
                                                //         style: gray12,
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                FittedBox(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        '₹',
                                                        overflow: TextOverflow.fade,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18),
                                                      ),
                                                      SizedBox(
                                                        height: 25,
                                                        // width: 95,
                                                        //color: Colors.black,
                                                        child: Text(
                                                          item.amount.toString(),
                                                          overflow: TextOverflow.fade,
                                                          maxLines: 1, style: const TextStyle(
                                                            fontFamily: 'PoppinsMedium',
                                                            fontSize: 19,
                                                            fontWeight: FontWeight.w700,
                                                            color:cl3E4FA3
                                                        ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5),
                                                  child: Text(
                                                    item.time,
                                                    style:  const TextStyle(
                                                      color: cl7E7E7E,
                                                      fontSize: 9,
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w500,
                                                      height: 0,
                                                      letterSpacing: -0.09,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                              ///

                          );
                        }):Padding(
                          padding: const EdgeInsets.only(top:200),
                          child: SizedBox(
                            width: width/1.5,
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: value.enrollerNoPaymet,
                                      child: const Text("No payments found.",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "PoppinsMedium"),)),
                                  Visibility(
                                      visible: value.enrollerNoPaymet,
                                      child: const SizedBox(height:30,)),
                                  const Text("Volunteer id /Volunteer Phone Number ഉപയോഗിച്ച് Search ചെയ്യുക",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "PoppinsMedium"),),
                                ],
                              )),
                        );
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget web(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration( image: DecorationImage(
          image: AssetImage("assets/KPCCWebBackground.jpg",),
          fit:BoxFit.fill
      )),
      child: Center(
        child: queryData.orientation == Orientation.portrait
            ?Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(height*0.12),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    toolbarHeight: height*0.13,
                    centerTitle: true,
                    title: Text('Volunteer Payments',style: wardAppbarTxt,),
                    automaticallyImplyLeading: false,
                    leading:  InkWell(
                      onTap: (){
                        callNextReplacement(HomeScreenNew(loginUserID: loginUserID,
                            loginUsername: loginUsername,subScriberType: subScriberType,loginUserPhone: loginUserPhone,
                          zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                          sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                          foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ),context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [myDarkBlue,myLightBlue3]
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)
                        ),
                      ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          // elevation: 0.5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Consumer<HomeProvider>(
                              builder: (context, value, child) {
                                return TextField(
                                  controller: value.EnrollerPaymentSearchCt,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: myWhite,
                                    filled: true,
                                    hintText: 'Enter Volunteer ID/ Volunteer Phone Number',
                                    hintStyle: const TextStyle(fontSize: 12,fontFamily: "Heebo"),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: myWhite),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(color: myWhite),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    suffixIcon: InkWell(
                                        onTap: () async {
                                          homeProvider.aa();
                                          if(value.EnrollerPaymentSearchCt.text==""){
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        backgroundColor:Colors.red,
                                                          content: Text("Please enter Volunteer ID")));

                                          }else{

                                            await homeProvider.getEnrollerPayments(value.EnrollerPaymentSearchCt.text.toString());


                                          }


                                        },
                                        child: const Icon(
                                          Icons.search,
                                          color: gold_C3A570,
                                        )),
                                  ),
                                  onChanged: (item) {

                                  },
                                  onSubmitted: (txt){


                                  },
                                );
                              }),
                        ),
                      ),
                      Consumer<HomeProvider>(
                        builder: (context,value,child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RichText(
                                  text: TextSpan(
                               children: [
                                 const TextSpan(
                                   text:"No of Payments:",style: TextStyle(fontSize: 16,color: myBlack)
                                 ),
                                 TextSpan(
                                     text:value.enrollerNoOfPayments.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: myBlack)
                                 ),
                               ] ,
                              )),
                              RichText(
                                  text: TextSpan(
                               children: [
                                 const TextSpan(
                                   text:"Amount:",style: TextStyle(fontSize: 16,color: myBlack)
                                 ),
                                 TextSpan(
                                     text:value.EnrollerPaymenttotal.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: myBlack)
                                 ),
                               ] ,
                              )),



                            ],
                          );
                        }
                      ),
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return value.enrollerPaymentsList.isNotEmpty?ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.enrollerPaymentsList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  var item = value.enrollerPaymentsList[index];
                                  return InkWell(
                                    onTap: (){

                                    },
                                    child: Container(


                                      child: Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        elevation:2,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 20,
                                              // margin: const EdgeInsets.all(10),
                                              // padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: myWhite,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              // child: Image.asset(
                                              //   'assets/dsitrict_logo.png',
                                              //   fit: BoxFit.contain,
                                              // ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(height: 8,),
                                                  RichText(text: TextSpan(children: [
                                                    const TextSpan(text: 'Name        : ',style: TextStyle(color: Colors.black,fontFamily: 'Montserrat',)),
                                                    TextSpan(text:  item.name,
                                                      style: gray16,),

                                                  ])),
                                                  const SizedBox(height: 2,),RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'ID                  : ' ,style: gray12,),
                                                    TextSpan(text: item.enrollerid ,style: gray12,)

                                                  ])),const SizedBox(height: 2,),
                                                  RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'District              : ' ,style: gray12,),
                                                    TextSpan(text: item.district ,style: gray12,)

                                                  ])),const SizedBox(height: 2,),RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'Panchayath           : ' ,style: gray12,),
                                                    TextSpan(text: item.panchayath ,style: gray12,)

                                                  ])),const SizedBox(height: 2,),RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'Unit          : ' ,style: gray12,),
                                                    TextSpan(text: item.ward ,style: gray12,)

                                                  ])),
                                                  const SizedBox(height: 8,),


                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    height: 25,
                                                    width: 120,
                                                    // color: Colors.red,
                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          '₹',
                                                          overflow: TextOverflow.fade,
                                                          style: greenB18,
                                                        ),
                                                        SizedBox(
                                                          height: 25,
                                                          width: 95,
                                                          //color: Colors.black,
                                                          child: Text(
                                                            item.amount.toString(),
                                                            overflow: TextOverflow.fade,
                                                            maxLines: 1,
                                                            style: greenB18,
                                                          ),
                                                        ),
                                                      ],
                                                    )

                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }):const Padding(
                                  padding: EdgeInsets.only(top:200),
                                  child: Text("No data Found.."),
                                );
                          }
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        )
            :Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width/3,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(height*0.12),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    toolbarHeight: height*0.13,
                    centerTitle: true,
                    title: Text('Enroller Payments',style: wardAppbarTxt,),
                    automaticallyImplyLeading: false,
                    leading:  InkWell(
                      onTap: (){
                        callNextReplacement(HomeScreenNew(loginUserID: loginUserID,
                            loginUsername: loginUsername,subScriberType: subScriberType,loginUserPhone: loginUserPhone,
                          zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                          sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                          foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ),context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [myDarkBlue,myLightBlue3]
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)
                        ),
                      ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          // elevation: 0.5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Consumer<HomeProvider>(
                              builder: (context, value, child) {
                                return TextField(
                                  controller: value.EnrollerPaymentSearchCt,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: myWhite,
                                    filled: true,
                                    hintText:'Enter Enroller ID/ Enroller Phone Number',
                                    hintStyle: const TextStyle(fontSize: 12,fontFamily: "Heebo"),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: myWhite),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(color: myWhite),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    suffixIcon: InkWell(
                                        onTap: () async {
                                          homeProvider.aa();
                                          if(value.EnrollerPaymentSearchCt.text==""){
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                    backgroundColor:Colors.red,
                                                    content: Text("Please enter Enroller ID")));

                                          }else{

                                            await homeProvider.getEnrollerPayments(value.EnrollerPaymentSearchCt.text.toString());


                                          }


                                        },
                                        child: const Icon(
                                          Icons.search,
                                          color: gold_C3A570,
                                        )),
                                  ),
                                  onChanged: (item) {

                                  },
                                  onSubmitted: (txt){


                                  },
                                );
                              }),
                        ),
                      ),
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                            text:"No of Payments:",style: TextStyle(fontSize: 16,color: myBlack)
                                        ),
                                        TextSpan(
                                            text:value.enrollerNoOfPayments.toString(),
                                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: myBlack)
                                        ),
                                      ] ,
                                    )),
                                RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                            text:"Amount:",style: TextStyle(fontSize: 16,color: myBlack)
                                        ),
                                        TextSpan(
                                            text:value.EnrollerPaymenttotal.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: myBlack)
                                        ),
                                      ] ,
                                    )),



                              ],
                            );
                          }
                      ),
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return value.enrollerPaymentsList.isNotEmpty?ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.enrollerPaymentsList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  var item = value.enrollerPaymentsList[index];
                                  return InkWell(
                                    onTap: (){

                                    },
                                    child: Container(
                                      height: 130,

                                      child: Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        elevation:2,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 20,
                                              // margin: const EdgeInsets.all(10),
                                              // padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: myWhite,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              // child: Image.asset(
                                              //   'assets/dsitrict_logo.png',
                                              //   fit: BoxFit.contain,
                                              // ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(height: 8,),
                                                  RichText(
                                                      text: TextSpan(
                                                      children: [
                                                    const TextSpan(text: 'Name        : ',style: TextStyle(color: Colors.black,fontFamily: 'Montserrat',)),
                                                    TextSpan(text:  item.name,
                                                      style: gray16,),

                                                  ])),
                                                  const SizedBox(height: 2,),
                                                  RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'ID                  : ' ,style: gray12,),
                                                    TextSpan(text: item.enrollerid ,style: gray12,)

                                                  ])),const SizedBox(height: 2,),
                                                  RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'District              : ' ,style: gray12,),
                                                    TextSpan(text: item.district ,style: gray12,)

                                                  ])),const SizedBox(height: 2,),
                                                  RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'Assembly  : ' ,style: gray12,),
                                                    TextSpan(text: item.assembly ,style: gray12,)

                                                  ])),const SizedBox(height: 2,),RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'Panchayath           : ' ,style: gray12,),
                                                    TextSpan(text: item.panchayath ,style: gray12,)

                                                  ])),const SizedBox(height: 2,),RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'Unit          : ' ,style: gray12,),
                                                    TextSpan(text: item.ward ,style: gray12,)

                                                  ])),
                                                  const SizedBox(height: 8,),


                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    height: 25,
                                                    width: 120,
                                                    // color: Colors.red,
                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          '₹',
                                                          overflow: TextOverflow.fade,
                                                          maxLines: 1,
                                                          style: greenB18,
                                                        ),
                                                        SizedBox(
                                                          height: 25,
                                                          width: 95,
                                                          //color: Colors.black,
                                                          child: Text(
                                                            item.amount.toString(),
                                                            overflow: TextOverflow.fade,
                                                            maxLines: 1,
                                                            style: greenB18,
                                                          ),
                                                        ),
                                                      ],
                                                    )

                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }):const Padding(
                              padding: EdgeInsets.only(top:200),
                              child: Text("No data Found.."),
                            );
                          }
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
