import 'package:auto_size_text/auto_size_text.dart';
import 'package:beehive/Screens/reciept_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Views/panjayath_model.dart';
import '../Views/receipt_list_model.dart';
import '../Views/ward_model.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/home_provider.dart';
import 'home.dart';
import 'home_screen.dart';

class PaymentHistory extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  PaymentHistory({Key? key,required this.loginUsername
    ,required this.loginUserID,required this.subScriberType,required this.loginUserPhone,
    required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
    required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
    ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget body(BuildContext context) {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:30,right:20,top: 10),
            child: Row(
              children: [

                Expanded(
                    flex: 5,
                    child: Text(
                      'Details',
                      style: TextStyle(
                        color: myBlack.withOpacity(0.40),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.10,
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          'Amount',
                          style: TextStyle(
                            color: myBlack.withOpacity(0.40),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.10,
                          ),
                        ),
                      ],
                    )),

              ],
            ),
          ),



          Consumer<HomeProvider>(builder: (context, value, child) {
            return value.historyList.isNotEmpty
                ? SizedBox(
              // height: MediaQuery.of(context).size.height,
                  child:
                  // value.loader?
                  // const Padding(
                  //     padding: EdgeInsets.all(10.0),
                  //     child: CircularProgressIndicator(
                  //       color: Colors.blueAccent,
                  //     )
                  // ):

                  ListView.builder(
                    shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: value.historyList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = value.historyList[index];
                        return InkWell(
                          onTap: () {
                            if (item.status == "Success") {
                              donationProvider.getDonationDetailsForReceipt(item.id);
                              callNext(ReceiptPage(subScriberType: subScriberType,nameStatus: 'YES',
                                  loginUserID: loginUserID,loginUsername: loginUsername,loginUserPhone: loginUserPhone,
                                zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                            }
                          },
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
                            margin: const EdgeInsets.only(top: 8, left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Align(
                                    alignment:Alignment.centerRight,
                                    child:Container(
                                      alignment: Alignment.center,
                                      height:35,
                                      width:90,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(18.04),
                                          bottomLeft: Radius.circular(18.04),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment(-1.00, -0.00),
                                          end: Alignment(1, 0),
                                          colors: [cl3E4FA3, cl253068],
                                        ),
                                      ),
                                      child: const Text(
                                        'Receipt',
                                        style: TextStyle(
                                          color: myWhite,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          // height: 0.18,
                                          letterSpacing: -0.10,
                                        ),
                                      ),
                                    )
                                ),

                                 Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '  *${item.paymentCategory}',
                                    style: const TextStyle(
                                      color: cl3E4FA3,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      // height: 0.08,
                                    ),
                                  ),
                                ),

                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Column(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       children: [
                                //
                                //         SizedBox(
                                //             width:
                                //             MediaQuery.of(context).size.width/8,
                                //             child: Text("Name", style: pay_his_NDMU,)),
                                //         SizedBox(
                                //             width:
                                //             MediaQuery.of(context).size.width/7.6,
                                //             child: Text(
                                //               "District",
                                //               style: pay_his_NDMU,
                                //             )),
                                //         SizedBox(
                                //             width:
                                //             MediaQuery.of(context).size.width/5,
                                //             child: Text(
                                //               "Assembly",
                                //               style: pay_his_NDMU,
                                //             )),
                                //         SizedBox(
                                //             width:
                                //             MediaQuery.of(context).size.width/4.7,
                                //             child: Text(
                                //               "Panchayath",
                                //               style: pay_his_NDMU,
                                //             )),
                                //         SizedBox(
                                //             width:
                                //             MediaQuery.of(context).size.width/5,
                                //             child: Text(
                                //               "Unit",
                                //               style: pay_his_NDMU,
                                //             )),
                                //         // SizedBox(
                                //         //     width:
                                //         //     MediaQuery.of(context).size.width/10,
                                //         //     child: Text(
                                //         //       "Booth",
                                //         //       style: pay_his_NDMU,
                                //         //     )),
                                //         item.enroller!="NILL"? SizedBox(
                                //             width:
                                //             MediaQuery.of(context).size.width/4.6,
                                //             child: Text(
                                //               "Volunteer",
                                //               style: pay_his_NDMU,
                                //             )):SizedBox(),
                                //
                                //       ],
                                //     ),
                                //     Column(
                                //       children: [
                                //         SizedBox(
                                //             width:
                                //                 MediaQuery.of(context).size.width / 2,
                                //             child: Text(
                                //               ": "+item.name,
                                //               style: receiptName,
                                //             )),
                                //         SizedBox(
                                //             width:
                                //                 MediaQuery.of(context).size.width / 2,
                                //             child: Text(
                                //               ": "+item.district,
                                //               style: pay_his_NDMU2,
                                //             )),
                                //         SizedBox(
                                //             width:
                                //                 MediaQuery.of(context).size.width / 2,
                                //             child: Text(
                                //               ": "+item.assembly,
                                //               style: pay_his_NDMU2,
                                //             )),
                                //         SizedBox(
                                //             width:
                                //             MediaQuery.of(context).size.width / 2,
                                //             child: Text(
                                //               ": "+item.panchayath,
                                //               style: pay_his_NDMU2,
                                //             )),
                                //         // item.status=="Success"?Text('Hadiya Success',style: green16,):Text('Hadiya Failed',style: red16,),
                                //          SizedBox(
                                //                 width: MediaQuery.of(context).size.width / 2,
                                //                 child: Text(": "+'${item.wardName}',
                                //                   style: pay_his_NDMU2,)),
                                //
                                //         const SizedBox(height: 2,),
                                //         // SizedBox(
                                //         //     width:
                                //         //     MediaQuery.of(context).size.width / 2,
                                //         //     child: Text(
                                //         //       ": "+item.booth,
                                //         //       style: pay_his_NDMU2,
                                //         //     )),
                                //         item.enroller!="NILL"? SizedBox(
                                //             width:
                                //             MediaQuery.of(context).size.width / 2,
                                //             child: Text(
                                //               ": "+item.enroller,
                                //               style: pay_his_NDMU2,
                                //             )):SizedBox(),
                                //       ],
                                //     ),
                                //
                                //     item.status == "Success" ? Text.rich(
                                //
                                //         TextSpan(
                                //
                                //             children: <InlineSpan>[
                                //
                                //           const TextSpan(
                                //               text: '₹',
                                //               style: TextStyle(
                                //                   fontWeight: FontWeight.w600,
                                //                   fontSize: 18,
                                //                   color: myBlack)),
                                //           TextSpan(
                                //               text: item.amount,
                                //               style: const TextStyle(
                                //                   fontFamily: 'PoppinsMedium',
                                //                   fontWeight: FontWeight.w700,
                                //                   fontSize: 18,
                                //                   color: cl323A71))
                                //         ])) : const Text(
                                //       'Failed',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                                //
                                //     ),
                                //   ],
                                // ),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5,horizontal: 5 ),
                                  child: Row(
                                    children: [

                                      Expanded(
                                          flex: 3,
                                          child: Container(
                                            // color: Colors.red,
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width/4.5,
                                                      child: Text('Name',style: TextStyle(
                                                          color: myBlack.withOpacity(0.20),
                                                          fontSize: 12.5,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: "PoppinsMedium"
                                                      ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width/25,
                                                        child:  Text(':',style: TextStyle(
                                                        color:myBlack.withOpacity(0.40)
                                                    ),)
                                                    ),
                                                    Flexible(
                                                      fit:FlexFit.tight,
                                                      child: SizedBox(
                                                        child: Text(item.name,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style:
                                                            const TextStyle(
                                                            color: myBlack,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w700,
                                                            fontFamily: "PoppinsMedium"
                                                        ),),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 2,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width/4.5,
                                                      child: Text('District',style: TextStyle(
                                                          color: myBlack.withOpacity(0.20),
                                                          fontSize: 12.5,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: "PoppinsMedium"
                                                      ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width/25,
                                                        child:  Text(':',style: TextStyle(
                                                        color:myBlack.withOpacity(0.40)
                                                    ),)
                                                    ),
                                                    Flexible(
                                                      fit:FlexFit.tight,
                                                      child: Text(item.district,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: receiptNDMU2,),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 2,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width/4.5,
                                                      child: Text('Assembly',style: TextStyle(
                                                          color: myBlack.withOpacity(0.20),
                                                          fontSize: 12.5,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: "PoppinsMedium"
                                                      ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width/25,
                                                        child:  Text(':',style: TextStyle(
                                                            color:myBlack.withOpacity(0.40)
                                                        ),)
                                                    ),
                                                    Flexible(
                                                      fit:FlexFit.tight,
                                                      child: Text(item.assembly,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: receiptNDMU2,),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 2,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width/4.5,
                                                      child: Text('Panchayath',style: TextStyle(
                                                          color: myBlack.withOpacity(0.20),
                                                          fontSize: 12.5,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: "PoppinsMedium"
                                                      ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width/25,
                                                        child:  Text(':',style: TextStyle(
                                                            color:myBlack.withOpacity(0.40)
                                                        ),)
                                                    ),
                                                    Flexible(
                                                      fit:FlexFit.tight,
                                                      child: Text(item.panchayath,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: receiptNDMU2,),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 2,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width/4.5,
                                                      child: Text('Unit',style: TextStyle(
                                                          color: myBlack.withOpacity(0.20),
                                                          fontSize: 12.5,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: "PoppinsMedium"
                                                      ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width/25,
                                                        child:  Text(':',style: TextStyle(
                                                            color:myBlack.withOpacity(0.40)
                                                        ),)
                                                    ),
                                                    Flexible(
                                                      fit:FlexFit.tight,
                                                      child: Text(item.wardName,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: receiptNDMU2,),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 2,),
                                                // Row(
                                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                                //   children: [
                                                //     SizedBox(
                                                //       width: width/4.9,
                                                //       child: Text('Booth',style: receiptNDMU,
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //         width: width/25,
                                                //         child: const Text(':')
                                                //     ),
                                                //     SizedBox(
                                                //       width: width/2.7,
                                                //       child: Text(item.booth,
                                                //         maxLines: 2,
                                                //         overflow: TextOverflow.ellipsis,
                                                //         style: receiptNDMU2,),
                                                //     ),
                                                //   ],
                                                // ),
                                                item.enroller=="NILL"?const SizedBox():
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width/4.5,
                                                      child: Text('Volunteer',style: TextStyle(
                                                          color: myBlack.withOpacity(0.20),
                                                          fontSize: 12.5,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: "PoppinsMedium"
                                                      ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width/25,
                                                        child:  Text(':',style: TextStyle(
                                                            color:myBlack.withOpacity(0.40)
                                                        ),)
                                                    ),
                                                    Flexible(
                                                      fit:FlexFit.tight,
                                                      child: Text(item.enroller,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: receiptNDMU2,),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                            ),
                                          )),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                   Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText.rich(
                                            TextSpan(
                                                children: <InlineSpan>[
                                                   TextSpan(
                                                        text: '₹',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 18,
                                                            color: item.status == "Success"?myBlack:myRed)),
                                                    TextSpan(
                                                        text: item.amount,
                                                        style:  TextStyle(
                                                            fontFamily: 'PoppinsMedium',
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 18,
                                                            color: item.status == "Success"?cl3E4FA3:myRed))
                                                  ])),

                                        const SizedBox(height:10),

                                        item.status != "Success" ? const Text(
                                          'Failed',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),

                                        ):const SizedBox(),

                                        const SizedBox(height:10),

                                        Text(getDate(item.time),style: receipt_DT,),
                                      ],
                                    ),
                                    flex: 1,
                                  ),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    item.status == 'Success'
                                        ? Consumer<HomeProvider>(
                                        builder: (context, value, child) {
                                          return value.historyPinWard == 'ON'
                                              ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: InkWell(
                                              onTap: () {
                                                donationProvider.transactionID.text = item.id;
                                                showPinWardAlert(context, item);
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 130,
                                                decoration: ShapeDecoration(
                                                  color: myWhite,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(18),
                                                  ),
                                                  shadows: const [
                                                    BoxShadow(
                                                      color: Color(0x28000000),
                                                      blurRadius: 4,
                                                      offset: Offset(0, 2),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  item.wardName == 'GENERAL'
                                                      ? 'Pin Unit'
                                                      : 'Change Unit',
                                                   style: const TextStyle(
                                                  color: cl263169,
                                                  fontSize: 10,
                                                  fontFamily: 'MontserratMedium',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                ),
                                              ),
                                            ),
                                          )
                                              : const SizedBox();
                                        })
                                        : const SizedBox(),


                                    const SizedBox(width: 5,),
                                    item.status == 'Success'&&item.enroller=="NILL"?InkWell(
                                      onTap: (){
                                        homeProvider.addEntrollerPhoneCT.clear();
                                        beAnEnrollerAlert(context,item.amount,item.id);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 130,
                                        decoration: ShapeDecoration(
                                          color: myWhite,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18),
                                          ),
                                          shadows: const [
                                            BoxShadow(
                                              color: Color(0x28000000),
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                        alignment: Alignment.center,
                                        child: const Text('Add Volunteer',
                                          style: TextStyle(
                                            color: cl263169,
                                            fontSize: 10,
                                            fontFamily: 'MontserratMedium',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ):const SizedBox(),

                                  ],
                                ),

                                const SizedBox(height:10),

                              ],
                            ),
                          ),
                        );
                      }),
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 200,),
                    Image.asset(
                      "assets/aaaaaa.png",
                      scale: 3.3,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'No data found',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    const Text(!kIsWeb
                        ? "You Don't have History data "
                        : 'Only available in mobile app',
                    style: TextStyle(fontFamily: "PoppinsMedium",color: cl353535,fontSize: 14),)
                  ],
                );
          }),
        ],
      ),
    );
  }

  getDate(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));

// 12 Hour format:
    var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);
    return d12;
  }

  Widget mobile(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        // HomeProvider homeProvider =
        // Provider.of<HomeProvider>(context, listen: false);
        // homeProvider.streamSubscriptionCancel();
        return true;
      },
      //HomeScreenNew
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: myWhite,
              leading: Center(
                child: InkWell(
                  onTap: () {
                    callNextReplacement( HomeScreenNew(subScriberType: subScriberType,
                        loginUserID: loginUserID,loginUsername: loginUsername,loginUserPhone: loginUserPhone,
                      zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                      sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                      foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                  },
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: myBlack.withOpacity(0.05),
                    child: const Padding(
                      padding: EdgeInsets.only(left:5.0),
                      child: Icon(Icons.arrow_back_ios,color:myBlack,size: 22,),
                    ),
                  )
                ),
              ),
              title: const Text("My History",style: TextStyle(
                  color: myBlack,
                  fontSize: 15,
                  fontFamily: 'PoppinsRegular',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5
              ),
              ),
            ),

            body: body(context),
          ),
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
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration( image: DecorationImage(
          image: AssetImage("assets/KPCCWebBackground.jpg",),
          fit:BoxFit.fill
      )),
      child: Stack(
        children: [
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
            child: queryData.orientation == Orientation.portrait
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width,
                        child:SafeArea(
                          child: Scaffold(
                            //backgroundColor: Colors.yellow,
                            backgroundColor: cl_c8b3e6, //cl_c8b3e6
                            appBar: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                              toolbarHeight: height*0.13,
                              centerTitle: true,
                              title:Text('My History',style: wardAppbarTxt,),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 12.0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       // Image.asset("assets/History.png",scale: 3 ,),
                              //       // SizedBox(width: width*0.01,),
                              //
                              //     ],
                              //   ),
                              // ),
                              automaticallyImplyLeading: false,
                              leading:  InkWell(
                                onTap: (){
                                  callNextReplacement( HomeScreenNew(subScriberType: subScriberType,
                                      loginUserID: loginUserID,loginUsername: loginUsername,loginUserPhone: loginUserPhone,
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
                              // actions: [
                              //   Column(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Image.asset("assets/help2.png",color: myWhite,scale: 4,),
                              //       Text("help",style: TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 10))
                              //     ],
                              //   ),
                              //   SizedBox(width: 14,)
                              // ],

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

                            body: body(context),
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
                        child: SafeArea(
                          child: Scaffold(
                            //backgroundColor: Colors.yellow,
                            backgroundColor: cl_c8b3e6, //cl_c8b3e6
                            appBar: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                              toolbarHeight: height*0.13,
                              centerTitle: true,
                              title:Text('My History',style: wardAppbarTxt,),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 12.0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       // Image.asset("assets/History.png",scale: 3 ,),
                              //       // SizedBox(width: width*0.01,),
                              //
                              //     ],
                              //   ),
                              // ),
                              automaticallyImplyLeading: false,
                              leading:  InkWell(
                                onTap: (){
                                  callNextReplacement( HomeScreenNew(subScriberType: subScriberType,
                                      loginUserID: loginUserID,loginUsername: loginUsername,loginUserPhone: loginUserPhone,
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
                              // actions: [
                              //   Column(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Image.asset("assets/help2.png",color: myWhite,scale: 4,),
                              //       Text("help",style: TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 10))
                              //     ],
                              //   ),
                              //   SizedBox(width: 14,)
                              // ],

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

                            body: body(context),
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }

  showPinWardAlert(
    BuildContext context,
    PaymentDetails item,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Consumer<DonationProvider>(
                        builder: (context, value, child) {
                      return Text(
                        'Transaction ID ${value.phonePinWard == 'ON' ? '/Phone No' : ''}',
                        style: const TextStyle(fontSize: 14),
                      );
                    }),
                  ),
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.transactionID,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        fillColor: myGray2,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (name) => name != '' &&
                              (name!.toLowerCase() == item.id.toLowerCase() ||
                                  name.toLowerCase() ==
                                      newString(item.id.toLowerCase(), 4) ||
                                  (value.phonePinWard == 'ON' &&
                                      name.toLowerCase() ==
                                          item.phoneNumber.toLowerCase()))
                          ? null
                          : 'Please Enter Valid Transaction ID',
                    );
                  }),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Select Unit',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return Autocomplete<WardModel>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        // return (value.wards + value.newWards)
                        return (value.allWards)
                        // (value.wards+value.newWards).map((e) => PanjayathModel(e.district, e.panchayath)).toSet().toList())

                            .where((WardModel wardd) =>
                        wardd.wardName.toLowerCase().contains(
                            textEditingValue.text.toLowerCase()) ||
                            wardd.panchayath.toLowerCase().contains(
                                textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (WardModel option) => option.wardName,
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextFormField(
                          decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Select Unit  ',
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            hintStyle: blackPoppinsR12,
                            filled: true,
                            fillColor: myLightWhiteNewUI,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: myGray2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: myGray2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: myGray2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (name) => name == '' ||
                              !(value.wards + value.newWards).map((e) => e.wardName).contains(name)
                              ? 'Please Enter Valid Unit Name'
                              : null,
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      onSelected: (WardModel selection) {
                        value.selectPinWard(selection);
                        // value.onSelectWard(selection);

                      },
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<WardModel> onSelected,
                          Iterable<WardModel> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 200,
                              color: Colors.white,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final WardModel option =
                                  options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);

                                    },
                                    child: Container(
                                      height: 60,
                                      color: Colors.white,
                                      // width: MediaQuery.of(context).size.width / 1.5,
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(option.wardName,
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            Text(option.panchayath),
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
                    );
                  }),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () async {
                          final FormState? form = _formKey.currentState;
                          if (form!.validate()) {
                            finish(context);
                            DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                            donationProvider.addPinWard(context, item.time, item.id, item.amount, item);
                          }
                        },
                        child: Container(
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
                          width: 130,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            'Pin Unit',
                            style: whitePoppinsBoldM15,
                          ),
                        ),
                      ),

                      // TextButton(
                      //   style: ButtonStyle(
                      //     foregroundColor:
                      //     MaterialStateProperty.all<Color>(myWhite),
                      //     backgroundColor:
                      //     MaterialStateProperty.all<Color>(myGreen),
                      //     shape:
                      //     MaterialStateProperty.all<RoundedRectangleBorder>(
                      //       RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //         side: const BorderSide(
                      //           color: myGreen,
                      //           width: 2.0,
                      //         ),
                      //       ),
                      //     ),
                      //     padding: MaterialStateProperty.all(
                      //         const EdgeInsets.symmetric(
                      //             vertical: 15, horizontal: 30)),
                      //   ),
                      //   onPressed: () async {
                      //     final FormState? form = _formKey.currentState;
                      //     if (form!.validate()) {
                      //       finish(context);
                      //       DonationProvider donationProvider = Provider.of<DonationProvider>(context,
                      //           listen: false);
                      //       donationProvider.addPinWard(item.time,item.id,item.amount,item);
                      //
                      //     }
                      //   },
                      //   child: Text(
                      //     'Pin Ward',
                      //     style: white16,
                      //   ),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Future<AlertDialog?> beAnEnrollerAlert(BuildContext context,String amount,String PaymentId) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Center(
                child: Text("*"+"സേവ് ചെയ്ത് കഴിഞ്ഞാൽ Volunteer ഡീറ്റെയിൽസ് പിന്നീട് മാറ്റം വരുത്താൻ കഴിയുകയില്ല ",
                  style: TextStyle(color: myRed,fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ),
              backgroundColor: myWhite,
              contentPadding: const EdgeInsets.only(
                top: 10.0,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              content: Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return Container(
                        width: 400,
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
                        decoration: const BoxDecoration(
                            color: myWhite,
                            borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10))),
                        child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical:5),
                                      child: SizedBox(
                                        height: 68,
                                        child: TextFormField(
                                            controller: value.addEntrollerPhoneCT,
                                            maxLength: 10,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: "Volunteer ID",
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 17),
                                              enabledBorder: border2,
                                              focusedBorder: border2,
                                              border: border2,

                                            ),
                                            validator: (text) {
                                              if (text!.isEmpty) {
                                                return 'Volunteer Id cannot be blank';
                                              } else if (text.length != 10) {
                                                return 'Volunteer Id Must be 10 letter';
                                              } else {
                                                return null;
                                              }
                                            }
                                        ),
                                      ),
                                    ),
                                    Consumer<HomeProvider>(
                                        builder: (context,value3,child) {
                                          return InkWell(
                                            onTap: () async {
                                              final FormState? form = _formKey.currentState;
                                              if(form!.validate()) {
                                                HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                                                homeProvider.checkVoulenteerApproved(value3.addEntrollerPhoneCT.text.toString());
                                                await homeProvider.checkVoulenteerExist(value3.addEntrollerPhoneCT.text.toString());
                                                if(value3.voulenteerExist==false){

                                                  print("Sorry no Volunteer found");
                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text("Volunteer Not Found"),
                                                    duration: Duration(milliseconds: 3000),
                                                  ));

                                                }else{
                                                  if(value3.voulenteerApproved){
                                                    confirmationAlert(context, value3.voulenteerName, value3.voulenteerID.toString(),amount,PaymentId,value3.voulenteerPlace);
                                                  }else{
                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                      backgroundColor: Colors.red,
                                                      content: Center(child: Text("Admin Not Approved this Volunteer")),
                                                      duration: Duration(milliseconds: 3000),
                                                    ));
                                                  }

                                                }

                                              }








                                            },
                                            child: Container(
                                                height: 40,
                                                width: MediaQuery.of(context).size.width * 0.3,
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
                                                child: const Center(
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(
                                                      color: myWhite,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                )),
                                          );
                                        }
                                    ),
                                  ] ),
                            )
                        )
                    );
                  }
              )
          );
        }
    );
  }
  Future<AlertDialog?> confirmationAlert(BuildContext context,String name,String phone,String amount,String paymnetID,String place) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text("Confirmation",
              style: TextStyle(
                  color: Colors.black
              ),
            ),
          ),
          backgroundColor: myWhite,
          contentPadding: const EdgeInsets.only(
            top: 15.0,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: Consumer<HomeProvider>(
              builder: (context,value2,child) {
                return Container(
                  width: 400,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 120,
                                child: Text("Volunteer ID ",style: gray12white,)),
                            Text(": ",style: gray12white,),
                            SizedBox(
                                width:width/2.8,
                                child: Text(phone,style: gray16White,)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 120,
                                child: Text("Volunteer Name ",style: gray12white,)),
                            Text(": ",style: gray12white,),
                            SizedBox(
                                width:width/2.8,
                                child: Text(name,style: gray16White,)),
                          ],
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(top: 5),
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       SizedBox(
                      //           width: 120,
                      //           child: Text("Volunteer Place ",style: gray12white,)),
                      //       Text(": ",style: gray12white,),
                      //       SizedBox(
                      //           width:width/2.8,
                      //           child: Text(place,style: gray16White,)),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {


                              finish(context);
                            },
                            child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(35)),
                                    // color: Color(0xff050066),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
                                    )
                                ),
                                child: const Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ),
                          const SizedBox(width: 10,),
                          InkWell(
                            onTap: (){
                              HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                              homeProvider.addToEnrollList(name,phone, amount,paymnetID,place);
                              finish(context);
                              finish(context);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.blue,
                                content: Text("Added Successfully."),
                                duration: Duration(milliseconds: 3000),
                              ));
                              callNextReplacement( HomeScreenNew(subScriberType: subScriberType,
                                  loginUserID: loginUserID,loginUsername: loginUsername,loginUserPhone: loginUserPhone,
                                zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);


                            },
                            child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(35)),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
                                    )),
                                child: const Center(
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                      color: myWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25,)
                    ],
                  ),
                );
              }
          ),
        );
      },
    );
  }
  OutlineInputBorder border2= OutlineInputBorder(
      borderSide: const BorderSide(color: myGray2),
      borderRadius: BorderRadius.circular(10));
  String newString(String oldString, int n) {
    if (oldString.length >= n) {
      return oldString.substring(oldString.length - n);
    } else {
      return '';
      // return whatever you want
    }
  }

}
getDate(String millis) {
  var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));

// 12 Hour format:
  var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);
  return d12;
}
