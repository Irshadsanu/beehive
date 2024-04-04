import 'package:beehive/Screens/reciept_page.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';

class ReceiptListMonitorScreen extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
   ReceiptListMonitorScreen({Key? key,required this.loginUsername,required this.loginUserID
     ,required this.subScriberType,required this.loginUserPhone,  required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    if(!kIsWeb){
      return mob(context);
    }else {
      return web(context);}
  }

   Widget mob (BuildContext context){
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return queryData.orientation==Orientation.portrait?
    Scaffold(
      appBar: AppBar(
        centerTitle:true ,
        title:Consumer<HomeProvider>(
          builder: (context,value,child) {
            return RichText(text: TextSpan(children: [

                TextSpan(text:  getAmount(value.totalCollection),
                  style:  const TextStyle(
                    fontFamily: 'LilitaOne-Regular',
                    // fontWeight: FontWeight.bold,
                    fontSize: 38,
                    color:myWhite,
                  ),),

              ]));

            }
        ) ,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [

            Column(

              children: [
                Consumer<HomeProvider>(
                    builder: (context,value,child) {
                      return RichText(text: TextSpan(children: [

                        TextSpan(text:  getAmount(value.totalCount),
                          style:  const TextStyle(
                            fontFamily: 'LilitaOne-Regular',
                            // fontWeight: FontWeight.bold,
                            fontSize: 38,
                            color:myBlack,
                          ),),

                      ]));

                    }
                ),

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
                            controller: value.searchEt,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              fillColor: myWhite,
                              filled: true,
                              hintText: 'Phone Number/Transaction ID',
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
                                  onTap: () {
                                    homeProvider.searchPayments(
                                        value.searchEt.text, context);
                                  },
                                  child: const Icon(
                                    Icons.search,
                                    color: gold_C3A570,
                                  )),
                            ),
                            onChanged: (item) {
                              if (item.isEmpty) {

                                homeProvider.currentLimit = 50;
                                homeProvider.fetchReceiptListForMonitorApp(50);

                              }
                            },
                          );
                        }),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom:5),
                  child: Row(
                    children: [
                      // from != "home"
                      //     ? SizedBox(
                      //         child: Text(
                      //           'S.No',
                      //           style: green14N,
                      //         ),
                      //         width: 40,
                      //       )
                      //     : const SizedBox(),
                      Expanded(
                          flex: 4,
                          child: Text(
                            'Details',
                            style: receipt_AmountDetailse,
                          )),
                      Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Text(
                                'Amount',
                                style: receipt_AmountDetailse,
                              ),
                            ],
                          )),
                      // Expanded(
                      //     flex: 1,
                      //     child: Text(
                      //       'Amount/Dhoti',
                      //       style: black14N,
                      //     )),
                    ],
                  ),
                ),
                Consumer<HomeProvider>(
                    builder: (context,value,child) {

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.paymentDetailsList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {

                            var item = value.paymentDetailsList[index];
                            // homeProvider.buzzer(item.status.toString());

                            return queryData.orientation == Orientation.landscape?
                            Padding(
                              padding:  EdgeInsets.only(top:5,left: 5,right: 5),
                              child: Container(

                                decoration: BoxDecoration(
                                    color: item.status == "Success"
                                        ? myWhite
                                        : myfailed,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 0.2,
                                    )

                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey,
                                  //     blurRadius:3, // soften the shadow
                                  //
                                  //   )
                                  // ],
                                ),
                                // color: const Color(0xffF2EADD),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(right:15.0,),
                                      child: Text(getDate(item.time),style:
                                      receipt_DT
                                        ,)
                                      ,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // from != "home"
                                          //     ? SizedBox(
                                          //         child: Text(
                                          //           (index + 1).toString(),
                                          //           style: black14,
                                          //         ),
                                          //         width: 40,
                                          //       )
                                          //     : const SizedBox(),

                                          Expanded(
                                              flex: 3,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('Name',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.name,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('District',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          // width: width/2.7,
                                                          child: Text(item.district,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('Assembly',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.assembly,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('Panchayath',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.panchayath,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('Ward',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.wardName,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('UpiId',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.upiId,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('App',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.paymentApp,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('Platform',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.paymentplatform,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,)




                                                ],
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                              )),
                                          Expanded(
                                            child: Text(
                                              //item.name,
                                              " ₹ ${item.amount.split(".").first}",
                                              style: black141,
                                            ),
                                            flex: 1,
                                          ),

                                        ],
                                      ),
                                    ),





                                  ],
                                ),
                              ),
                            )
                                :Padding(
                              padding: const EdgeInsets.symmetric(horizontal:7,vertical: 5),
                              child: Container(

                                decoration: BoxDecoration(
                                  color: item.status == "Success"
                                      ? myWhite
                                      : myfailed,
                                  borderRadius: BorderRadius.circular(30),

                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius:3, // soften the shadow

                                    )
                                  ],
                                ),
                                // color: const Color(0xffF2EADD),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:15.0,top:7),
                                      child: Text(getDate(item.time),style:
                                      receipt_DT
                                        ,)
                                      ,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // from != "home"
                                          //     ? SizedBox(
                                          //         child: Text(
                                          //           (index + 1).toString(),
                                          //           style: black14,
                                          //         ),
                                          //         width: 40,
                                          //       )
                                          //     : const SizedBox(),

                                          Expanded(
                                              flex: 3,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('Name',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.name,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('District',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.district,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('Assembly',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.assembly,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('Panchayath',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.panchayath,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('Ward',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.wardName,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('UpiId',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.upiId,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('App',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.paymentApp,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('Platform',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.paymentplatform,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),




                                                ],
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                              )),
                                          Expanded(
                                            child: Text(
                                              //item.name,
                                              " ₹ ${item.amount.split(".").first}",
                                              style: black141,
                                            ),
                                            flex: 1,
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(height:height*0.02,),


                                    Padding(
                                      padding: const EdgeInsets.only(bottom:10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          // value.receiptPinWard=='ON'
                                          //     ?
                                          // InkWell(
                                          //   onTap: () {
                                          //
                                          //   },
                                          //   child: Container(
                                          //       alignment: Alignment.center,
                                          //       width: width * .320,
                                          //       height: 30,
                                          //       decoration: const BoxDecoration(
                                          //         gradient: LinearGradient(
                                          //             begin: Alignment.topLeft,
                                          //             end: Alignment.bottomRight,
                                          //             colors: [myDarkBlue,myLightBlue3]
                                          //         ),
                                          //         borderRadius: BorderRadius.all(
                                          //           Radius.circular(25),
                                          //
                                          //         ),
                                          //       ),
                                          //       child: Text('Change Booth',
                                          //         style:receiptCG,
                                          //       )),
                                          // )
                                          //     : SizedBox(
                                          //   width: width * .385,
                                          // ),

                                          InkWell(

                                            onTap: () {
                                              DonationProvider
                                              donationProvider =
                                              Provider.of<DonationProvider>(context, listen: false);
                                              donationProvider.getSharedPrefName();
                                              if (item.paymentApp == 'Bank' && item.name == 'No Name') {
                                                // showReceiptAlert(context, item);
                                              } else {
                                                print("receipt click here");
                                                DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                                donationProvider.getDonationDetailsForReceipt(item.id);
                                                // donationProvider.fetchDonationDetails(item.id);
                                                // donationProvider.receiptSuccessStatus(item.id);

                                                callNext(ReceiptPage(loginUserPhone: loginUserPhone,
                                                    subScriberType: subScriberType,nameStatus: 'YES',
                                                    loginUserID: loginUserID,loginUsername: loginUsername,
                                                  zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                                  sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                                  foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ),context);
                                              }
                                            },

                                            child: Container(
                                                alignment: Alignment.center,
                                                width: width * .320,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(40),

                                                    gradient: const LinearGradient(
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                        colors: [myDarkBlue,myLightBlue3]
                                                    )
                                                ),
                                                child: Text('Receipt',style: receiptCG,)),
                                          ),


                                        ],
                                      ),
                                    ),



                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [


                                        InkWell(
                                          onTap: () {
                                            launch("tel://${item.phoneNumber}");
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              width: width * .385,
                                              height: 35,
                                              decoration:  BoxDecoration(
                                                  color: myDarkBlue,
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft: Radius
                                                          .circular(10))),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.call,color: myWhite,),
                                                  const SizedBox(width: 10,),
                                                  Text('Call',
                                                    style:knmTerms3,
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),

                                        InkWell(

                                          onTap: () {
                                            launch("whatsapp://send?phone=${"+91"+item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                                          },

                                          child: Container(
                                              alignment: Alignment.center,
                                              width: width * .385,
                                              height: 35,
                                              decoration: const BoxDecoration(
                                                  color:  myDarkBlue,
                                                  borderRadius:
                                                  BorderRadius.only(
                                                      bottomRight:
                                                      Radius.circular(
                                                          10))),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.phone,color: myWhite,),
                                                  const SizedBox(width: 10,),
                                                  Text('WhatsApp',
                                                    style:knmTerms3,
                                                  ),
                                                ],
                                              )
                                            // child: Text('WhatsApp',style: knmTerms3,)
                                          ),
                                        ),

                                      ],
                                    )


                                  ],
                                ),
                              ),
                            );
                          });
                    }
                ),
                Consumer<HomeProvider>(builder: (context, value, child) {
                  return value.currentLimit == value.paymentDetailsList.length || value.currentWardLimit == value.paymentDetailsList.length
                      ? TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              primary),
                          foregroundColor:
                          MaterialStateProperty.all<Color>(myWhite),
                          overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                          animationDuration:
                          const Duration(microseconds: 500)),
                      onPressed: () async {
                        PackageInfo packageInfo = await PackageInfo.fromPlatform();
                        String packageName = packageInfo.packageName;
                        if(packageName=='com.spine.knmMonitor'){

                          HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                          homeProvider.currentLimit=50;
                          homeProvider.fetchReceiptListForMonitorApp(50);
                          homeProvider.checkStarRating();

                        }else{
                          value.currentLimit = value.currentLimit + 20;
                          homeProvider
                              .fetchReceiptList(value.currentLimit);
                        }

                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(child: Text('Load More')),
                      ))
                      : SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Divider(
                          thickness: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10),
                          child: Text(
                            value.paymentDetailsList.isNotEmpty
                                ? 'No More Payments'
                                : 'No Payments',
                            style: black16,
                          ),
                        ),
                      ],
                    ),
                  );
                })
              ],
            ),
            // Consumer<HomeProvider>(
            //     builder: (context,value,child) {
            //       return Align(
            //         alignment:Alignment.topRight ,
            //         child: ConfettiWidget(
            //           gravity: .3,
            //           minBlastForce: 5, maxBlastForce: 1000,
            //           numberOfParticles: 500,
            //           confettiController: value.controllerCenter,
            //           blastDirectionality: BlastDirectionality.explosive,
            //           // don't specify a direction, blast randomly
            //           //blastDirection: BorderSide.strokeAlignOutside,
            //           shouldLoop:
            //           true, // start again as soon as the animation is finished
            //           colors: const [
            //             Colors.green,
            //             Colors.blue,
            //             Colors.pink,
            //             Colors.orange,
            //             Colors.purple,
            //             Colors.red,
            //             Colors.greenAccent,
            //             Colors.white,
            //             Colors.lightGreen,
            //             Colors.lightGreenAccent
            //           ], // manually specify the colors to be used
            //           createParticlePath: value.drawStar, // define a custom shape/path.
            //         ),
            //       );
            //     }
            // ),
          ],
        ),
      ),
    ):Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width:width,
          child: Scaffold(
            appBar: AppBar(
              centerTitle:true ,
              title:Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return RichText(text: TextSpan(children: [

                      TextSpan(text:  getAmount(value.totalCollection),
                        style:  const TextStyle(
                          fontFamily: 'LilitaOne-Regular',
                          // fontWeight: FontWeight.bold,
                          fontSize: 38,
                          color:myWhite,
                        ),),

                    ]));

                  }
              ) ,
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [

                  Column(

                    children: [
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return RichText(text: TextSpan(children: [

                              TextSpan(text:  getAmount(value.totalCount),
                                style:  const TextStyle(
                                  fontFamily: 'LilitaOne-Regular',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 38,
                                  color:myBlack,
                                ),),

                            ]));

                          }
                      ),

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
                                  controller: value.searchEt,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    fillColor: myWhite,
                                    filled: true,
                                    hintText: 'Phone Number/Transaction ID',
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
                                        onTap: () {
                                          homeProvider.searchPayments(
                                              value.searchEt.text, context);
                                        },
                                        child: const Icon(
                                          Icons.search,
                                          color: gold_C3A570,
                                        )),
                                  ),
                                  onChanged: (item) {
                                    if (item.isEmpty) {

                                      homeProvider.currentLimit = 50;
                                      homeProvider.fetchReceiptListForMonitorApp(50);

                                    }
                                  },
                                );
                              }),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom:5),
                        child: Row(
                          children: [
                            // from != "home"
                            //     ? SizedBox(
                            //         child: Text(
                            //           'S.No',
                            //           style: green14N,
                            //         ),
                            //         width: 40,
                            //       )
                            //     : const SizedBox(),
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Details',
                                  style: receipt_AmountDetailse,
                                )),
                            Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Text(
                                      'Amount',
                                      style: receipt_AmountDetailse,
                                    ),
                                  ],
                                )),
                            // Expanded(
                            //     flex: 1,
                            //     child: Text(
                            //       'Amount/Dhoti',
                            //       style: black14N,
                            //     )),
                          ],
                        ),
                      ),
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {

                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.paymentDetailsList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {

                                  var item = value.paymentDetailsList[index];
                                  // homeProvider.buzzer(item.status.toString());

                                  return queryData.orientation == Orientation.landscape?
                                  Padding(
                                    padding:  EdgeInsets.only(top:5,left: 5,right: 5),
                                    child: Container(

                                      decoration: BoxDecoration(
                                          color: item.status == "Success"
                                              ? myWhite
                                              : myfailed,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 0.2,
                                          )

                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Colors.grey,
                                        //     blurRadius:3, // soften the shadow
                                        //
                                        //   )
                                        // ],
                                      ),
                                      // color: const Color(0xffF2EADD),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(right:15.0,),
                                            child: Text(getDate(item.time),style:
                                            receipt_DT
                                              ,)
                                            ,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Row(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // from != "home"
                                                //     ? SizedBox(
                                                //         child: Text(
                                                //           (index + 1).toString(),
                                                //           style: black14,
                                                //         ),
                                                //         width: 40,
                                                //       )
                                                //     : const SizedBox(),

                                                Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Name',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.name,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('District',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                // width: width/2.7,
                                                                child: Text(item.district,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Assembly',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.assembly,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Panchayath',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.panchayath,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Ward',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.wardName,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('UpiId',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.upiId,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('App',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.paymentApp,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,)




                                                      ],
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                    )),
                                                Expanded(
                                                  child: Text(
                                                    //item.name,
                                                    " ₹ ${item.amount.split(".").first}",
                                                    style: black141,
                                                  ),
                                                  flex: 1,
                                                ),

                                              ],
                                            ),
                                          ),





                                        ],
                                      ),
                                    ),
                                  )
                                      :Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:7,vertical: 5),
                                    child: Container(

                                      decoration: BoxDecoration(
                                        color: item.status == "Success"
                                            ? myWhite
                                            : myfailed,
                                        borderRadius: BorderRadius.circular(30),

                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius:3, // soften the shadow

                                          )
                                        ],
                                      ),
                                      // color: const Color(0xffF2EADD),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:15.0,top:7),
                                            child: Text(getDate(item.time),style:
                                            receipt_DT
                                              ,)
                                            ,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Row(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // from != "home"
                                                //     ? SizedBox(
                                                //         child: Text(
                                                //           (index + 1).toString(),
                                                //           style: black14,
                                                //         ),
                                                //         width: 40,
                                                //       )
                                                //     : const SizedBox(),

                                                Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Name',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.name,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('District',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.district,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Assembly',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.assembly,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Panchayath',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.panchayath,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Ward',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.wardName,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('UpiId',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.upiId,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('App',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.paymentApp,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),




                                                      ],
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                    )),
                                                Expanded(
                                                  child: Text(
                                                    //item.name,
                                                    " ₹ ${item.amount.split(".").first}",
                                                    style: black141,
                                                  ),
                                                  flex: 1,
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height:height*0.02,),


                                          Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                // value.receiptPinWard=='ON'
                                                //     ?
                                                // InkWell(
                                                //   onTap: () {
                                                //
                                                //   },
                                                //   child: Container(
                                                //       alignment: Alignment.center,
                                                //       width: width * .320,
                                                //       height: 30,
                                                //       decoration: const BoxDecoration(
                                                //         gradient: LinearGradient(
                                                //             begin: Alignment.topLeft,
                                                //             end: Alignment.bottomRight,
                                                //             colors: [myDarkBlue,myLightBlue3]
                                                //         ),
                                                //         borderRadius: BorderRadius.all(
                                                //           Radius.circular(25),
                                                //
                                                //         ),
                                                //       ),
                                                //       child: Text('Change Booth',
                                                //         style:receiptCG,
                                                //       )),
                                                // )
                                                //     : SizedBox(
                                                //   width: width * .385,
                                                // ),

                                                InkWell(

                                                  onTap: () {
                                                    DonationProvider
                                                    donationProvider =
                                                    Provider.of<DonationProvider>(context, listen: false);
                                                    donationProvider.getSharedPrefName();
                                                    if (item.paymentApp == 'Bank' && item.name == 'No Name') {
                                                      // showReceiptAlert(context, item);
                                                    } else {
                                                      print("receipt click here");
                                                      DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                                      donationProvider.getDonationDetailsForReceipt(item.id);
                                                      // donationProvider.fetchDonationDetails(item.id);
                                                      // donationProvider.receiptSuccessStatus(item.id);

                                                      callNext(ReceiptPage(loginUserPhone: loginUserPhone,
                                                          subScriberType: subScriberType,nameStatus: 'YES',
                                                          loginUserID: loginUserID,loginUsername: loginUsername,
                                                        zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                                        sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                                        foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ),
                                                          context);
                                                    }
                                                  },

                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: width * .320,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(40),

                                                          gradient: const LinearGradient(
                                                              begin: Alignment.centerLeft,
                                                              end: Alignment.centerRight,
                                                              colors: [myDarkBlue,myLightBlue3]
                                                          )
                                                      ),
                                                      child: Text('Receipt',style: receiptCG,)),
                                                ),


                                              ],
                                            ),
                                          ),



                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [


                                              InkWell(
                                                onTap: () {
                                                  launch("tel://${item.phoneNumber}");
                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: width * .385,
                                                    height: 35,
                                                    decoration:  BoxDecoration(
                                                        color: myDarkBlue,
                                                        borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(10))),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(Icons.call,color: myWhite,),
                                                        const SizedBox(width: 10,),
                                                        Text('Call',
                                                          style:knmTerms3,
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ),

                                              InkWell(

                                                onTap: () {
                                                  launch("whatsapp://send?phone=${"+91"+item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                                                },

                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: width * .385,
                                                    height: 35,
                                                    decoration: const BoxDecoration(
                                                        color:  myDarkBlue,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                            Radius.circular(
                                                                10))),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(Icons.phone,color: myWhite,),
                                                        const SizedBox(width: 10,),
                                                        Text('WhatsApp',
                                                          style:knmTerms3,
                                                        ),
                                                      ],
                                                    )
                                                  // child: Text('WhatsApp',style: knmTerms3,)
                                                ),
                                              ),

                                            ],
                                          )


                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                      ),
                      Consumer<HomeProvider>(builder: (context, value, child) {
                        return value.currentLimit == value.paymentDetailsList.length || value.currentWardLimit == value.paymentDetailsList.length
                            ? TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    primary),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(myWhite),
                                overlayColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.red),
                                animationDuration:
                                const Duration(microseconds: 500)),
                            onPressed: () async {
                              PackageInfo packageInfo = await PackageInfo.fromPlatform();
                              String packageName = packageInfo.packageName;
                              if(packageName=='com.spine.knmMonitor'){

                                HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                                homeProvider.currentLimit=50;
                                homeProvider.fetchReceiptListForMonitorApp(50);
                                homeProvider.checkStarRating();

                              }else{
                                value.currentLimit = value.currentLimit + 20;
                                homeProvider
                                    .fetchReceiptList(value.currentLimit);
                              }

                            },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Center(child: Text('Load More')),
                            ))
                            : SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              const Divider(
                                thickness: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10),
                                child: Text(
                                  value.paymentDetailsList.isNotEmpty
                                      ? 'No More Payments'
                                      : 'No Payments',
                                  style: black16,
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                  // Consumer<HomeProvider>(
                  //     builder: (context,value,child) {
                  //       return Align(
                  //         alignment:Alignment.topRight ,
                  //         child: ConfettiWidget(
                  //           gravity: .3,
                  //           minBlastForce: 5, maxBlastForce: 1000,
                  //           numberOfParticles: 500,
                  //           confettiController: value.controllerCenter,
                  //           blastDirectionality: BlastDirectionality.explosive,
                  //           // don't specify a direction, blast randomly
                  //           //blastDirection: BorderSide.strokeAlignOutside,
                  //           shouldLoop:
                  //           true, // start again as soon as the animation is finished
                  //           colors: const [
                  //             Colors.green,
                  //             Colors.blue,
                  //             Colors.pink,
                  //             Colors.orange,
                  //             Colors.purple,
                  //             Colors.red,
                  //             Colors.greenAccent,
                  //             Colors.white,
                  //             Colors.lightGreen,
                  //             Colors.lightGreenAccent
                  //           ], // manually specify the colors to be used
                  //           createParticlePath: value.drawStar, // define a custom shape/path.
                  //         ),
                  //       );
                  //     }
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget web (BuildContext context){
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);

    return queryData.orientation==Orientation.portrait? Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width:width,
          child: Scaffold(
            appBar: AppBar(
              centerTitle:true ,
              title:Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return RichText(text: TextSpan(children: [

                      TextSpan(text:  getAmount(value.totalCollection),
                        style:  const TextStyle(
                          fontFamily: 'LilitaOne-Regular',
                          // fontWeight: FontWeight.bold,
                          fontSize: 38,
                          color:myWhite,
                        ),),

                    ]));

                  }
              ) ,
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [

                  Column(

                    children: [
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return RichText(text: TextSpan(children: [

                              TextSpan(text:  getAmount(value.totalCount),
                                style:  const TextStyle(
                                  fontFamily: 'LilitaOne-Regular',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 38,
                                  color:myBlack,
                                ),),

                            ]));

                          }
                      ),

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
                                  controller: value.searchEt,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    fillColor: myWhite,
                                    filled: true,
                                    hintText: 'Phone Number/Transaction ID',
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
                                        onTap: () {
                                          homeProvider.searchPayments(
                                              value.searchEt.text, context);
                                        },
                                        child: const Icon(
                                          Icons.search,
                                          color: gold_C3A570,
                                        )),
                                  ),
                                  onChanged: (item) {
                                    if (item.isEmpty) {

                                      homeProvider.currentLimit = 50;
                                      homeProvider.fetchReceiptListForMonitorApp(50);

                                    }
                                  },
                                );
                              }),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom:5),
                        child: Row(
                          children: [
                            // from != "home"
                            //     ? SizedBox(
                            //         child: Text(
                            //           'S.No',
                            //           style: green14N,
                            //         ),
                            //         width: 40,
                            //       )
                            //     : const SizedBox(),
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Details',
                                  style: receipt_AmountDetailse,
                                )),
                            Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Text(
                                      'Amount',
                                      style: receipt_AmountDetailse,
                                    ),
                                  ],
                                )),
                            // Expanded(
                            //     flex: 1,
                            //     child: Text(
                            //       'Amount/Dhoti',
                            //       style: black14N,
                            //     )),
                          ],
                        ),
                      ),
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {

                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.paymentDetailsList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {

                                  var item = value.paymentDetailsList[index];
                                  // homeProvider.buzzer(item.status.toString());

                                  return queryData.orientation == Orientation.landscape?
                                  Padding(
                                    padding:  EdgeInsets.only(top:5,left: 5,right: 5),
                                    child: Container(

                                      decoration: BoxDecoration(
                                          color: item.status == "Success"
                                              ? myWhite
                                              : myfailed,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 0.2,
                                          )

                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Colors.grey,
                                        //     blurRadius:3, // soften the shadow
                                        //
                                        //   )
                                        // ],
                                      ),
                                      // color: const Color(0xffF2EADD),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(right:15.0,),
                                            child: Text(getDate(item.time),style:
                                            receipt_DT
                                              ,)
                                            ,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Row(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // from != "home"
                                                //     ? SizedBox(
                                                //         child: Text(
                                                //           (index + 1).toString(),
                                                //           style: black14,
                                                //         ),
                                                //         width: 40,
                                                //       )
                                                //     : const SizedBox(),

                                                Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Name',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.name,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('District',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                // width: width/2.7,
                                                                child: Text(item.district,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Assembly',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.assembly,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Panchayath',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.panchayath,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Ward',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.wardName,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('UpiId',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.upiId,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('App',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.paymentApp,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('App',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.paymentApp,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,)




                                                      ],
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                    )),
                                                Expanded(
                                                  child: Text(
                                                    //item.name,
                                                    " ₹ ${item.amount.split(".").first}",
                                                    style: black141,
                                                  ),
                                                  flex: 1,
                                                ),

                                              ],
                                            ),
                                          ),





                                        ],
                                      ),
                                    ),
                                  )
                                      :Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:7,vertical: 5),
                                    child: Container(

                                      decoration: BoxDecoration(
                                        color: item.status == "Success"
                                            ? myWhite
                                            : myfailed,
                                        borderRadius: BorderRadius.circular(30),

                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius:3, // soften the shadow

                                          )
                                        ],
                                      ),
                                      // color: const Color(0xffF2EADD),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:15.0,top:7),
                                            child: Text(getDate(item.time),style:
                                            receipt_DT
                                              ,)
                                            ,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Row(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // from != "home"
                                                //     ? SizedBox(
                                                //         child: Text(
                                                //           (index + 1).toString(),
                                                //           style: black14,
                                                //         ),
                                                //         width: 40,
                                                //       )
                                                //     : const SizedBox(),

                                                Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Name',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.name,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('District',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.district,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Assembly',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.assembly,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Panchayath',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.panchayath,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Ward',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.wardName,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('UpiId',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.upiId,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('App',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.paymentApp,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),




                                                      ],
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                    )),
                                                Expanded(
                                                  child: Text(
                                                    //item.name,
                                                    " ₹ ${item.amount.split(".").first}",
                                                    style: black141,
                                                  ),
                                                  flex: 1,
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height:height*0.02,),


                                          Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                // value.receiptPinWard=='ON'
                                                //     ?
                                                // InkWell(
                                                //   onTap: () {
                                                //
                                                //   },
                                                //   child: Container(
                                                //       alignment: Alignment.center,
                                                //       width: width * .320,
                                                //       height: 30,
                                                //       decoration: const BoxDecoration(
                                                //         gradient: LinearGradient(
                                                //             begin: Alignment.topLeft,
                                                //             end: Alignment.bottomRight,
                                                //             colors: [myDarkBlue,myLightBlue3]
                                                //         ),
                                                //         borderRadius: BorderRadius.all(
                                                //           Radius.circular(25),
                                                //
                                                //         ),
                                                //       ),
                                                //       child: Text('Change Booth',
                                                //         style:receiptCG,
                                                //       )),
                                                // )
                                                //     : SizedBox(
                                                //   width: width * .385,
                                                // ),

                                                InkWell(

                                                  onTap: () {
                                                    DonationProvider
                                                    donationProvider =
                                                    Provider.of<DonationProvider>(context, listen: false);
                                                    donationProvider.getSharedPrefName();
                                                    if (item.paymentApp == 'Bank' && item.name == 'No Name') {
                                                      // showReceiptAlert(context, item);
                                                    } else {
                                                      print("receipt click here");
                                                      DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                                      donationProvider.getDonationDetailsForReceipt(item.id);
                                                      // donationProvider.fetchDonationDetails(item.id);
                                                      // donationProvider.receiptSuccessStatus(item.id);

                                                      callNext(ReceiptPage(loginUserPhone: loginUserPhone,
                                                          subScriberType: subScriberType,nameStatus: 'YES',
                                                          loginUserID: loginUserID,loginUsername: loginUsername,
                                                        zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                                        sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                                        foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ),
                                                          context);
                                                    }
                                                  },

                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: width * .320,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(40),

                                                          gradient: const LinearGradient(
                                                              begin: Alignment.centerLeft,
                                                              end: Alignment.centerRight,
                                                              colors: [myDarkBlue,myLightBlue3]
                                                          )
                                                      ),
                                                      child: Text('Receipt',style: receiptCG,)),
                                                ),


                                              ],
                                            ),
                                          ),



                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [


                                              InkWell(
                                                onTap: () {
                                                  launch("tel://${item.phoneNumber}");
                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: width * .385,
                                                    height: 35,
                                                    decoration:  BoxDecoration(
                                                        color: myDarkBlue,
                                                        borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(10))),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(Icons.call,color: myWhite,),
                                                        const SizedBox(width: 10,),
                                                        Text('Call',
                                                          style:knmTerms3,
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ),

                                              InkWell(

                                                onTap: () {
                                                  launch("whatsapp://send?phone=${"+91"+item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                                                },

                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: width * .385,
                                                    height: 35,
                                                    decoration: const BoxDecoration(
                                                        color:  myDarkBlue,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                            Radius.circular(
                                                                10))),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(Icons.phone,color: myWhite,),
                                                        const SizedBox(width: 10,),
                                                        Text('WhatsApp',
                                                          style:knmTerms3,
                                                        ),
                                                      ],
                                                    )
                                                  // child: Text('WhatsApp',style: knmTerms3,)
                                                ),
                                              ),

                                            ],
                                          )


                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                      ),
                      Consumer<HomeProvider>(builder: (context, value, child) {
                        return value.currentLimit == value.paymentDetailsList.length || value.currentWardLimit == value.paymentDetailsList.length
                            ? TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    primary),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(myWhite),
                                overlayColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.red),
                                animationDuration:
                                const Duration(microseconds: 500)),
                            onPressed: () async {
                              PackageInfo packageInfo = await PackageInfo.fromPlatform();
                              String packageName = packageInfo.packageName;
                              if(packageName=='com.spine.knmMonitor'){

                                HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                                homeProvider.currentLimit=50;
                                homeProvider.fetchReceiptListForMonitorApp(50);
                                homeProvider.checkStarRating();

                              }else{
                                value.currentLimit = value.currentLimit + 20;
                                homeProvider
                                    .fetchReceiptList(value.currentLimit);
                              }

                            },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Center(child: Text('Load More')),
                            ))
                            : SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              const Divider(
                                thickness: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10),
                                child: Text(
                                  value.paymentDetailsList.isNotEmpty
                                      ? 'No More Payments'
                                      : 'No Payments',
                                  style: black16,
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                  // Consumer<HomeProvider>(
                  //     builder: (context,value,child) {
                  //       return Align(
                  //         alignment:Alignment.topRight ,
                  //         child: ConfettiWidget(
                  //           gravity: .3,
                  //           minBlastForce: 5, maxBlastForce: 1000,
                  //           numberOfParticles: 500,
                  //           confettiController: value.controllerCenter,
                  //           blastDirectionality: BlastDirectionality.explosive,
                  //           // don't specify a direction, blast randomly
                  //           //blastDirection: BorderSide.strokeAlignOutside,
                  //           shouldLoop:
                  //           true, // start again as soon as the animation is finished
                  //           colors: const [
                  //             Colors.green,
                  //             Colors.blue,
                  //             Colors.pink,
                  //             Colors.orange,
                  //             Colors.purple,
                  //             Colors.red,
                  //             Colors.greenAccent,
                  //             Colors.white,
                  //             Colors.lightGreen,
                  //             Colors.lightGreenAccent
                  //           ], // manually specify the colors to be used
                  //           createParticlePath: value.drawStar, // define a custom shape/path.
                  //         ),
                  //       );
                  //     }
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    )
        :Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width:width,
            child: Scaffold(
              appBar: AppBar(
                centerTitle:true ,
                title:Consumer<HomeProvider>(
                    builder: (context,value,child) {
                      return RichText(text: TextSpan(children: [

                        TextSpan(text:  getAmount(value.totalCollection),
                          style:  const TextStyle(
                            fontFamily: 'LilitaOne-Regular',
                            // fontWeight: FontWeight.bold,
                            fontSize: 38,
                            color:myWhite,
                          ),),

                      ]));

                    }
                ) ,
              ),
              body: SingleChildScrollView(
                child: Stack(
                  children: [

                    Column(

                      children: [
                        Consumer<HomeProvider>(
                            builder: (context,value,child) {
                              return RichText(text: TextSpan(children: [

                                TextSpan(text:  getAmount(value.totalCount),
                                  style:  const TextStyle(
                                    fontFamily: 'LilitaOne-Regular',
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 38,
                                    color:myBlack,
                                  ),),

                              ]));

                            }
                        ),

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
                                    controller: value.searchEt,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      fillColor: myWhite,
                                      filled: true,
                                      hintText: 'Phone Number/Transaction ID',
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
                                          onTap: () {
                                            homeProvider.searchPayments(
                                                value.searchEt.text, context);
                                          },
                                          child: const Icon(
                                            Icons.search,
                                            color: gold_C3A570,
                                          )),
                                    ),
                                    onChanged: (item) {
                                      if (item.isEmpty) {

                                        homeProvider.currentLimit = 50;
                                        homeProvider.fetchReceiptListForMonitorApp(50);

                                      }
                                    },
                                  );
                                }),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom:5),
                          child: Row(
                            children: [
                              // from != "home"
                              //     ? SizedBox(
                              //         child: Text(
                              //           'S.No',
                              //           style: green14N,
                              //         ),
                              //         width: 40,
                              //       )
                              //     : const SizedBox(),
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Details',
                                    style: receipt_AmountDetailse,
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Text(
                                        'Amount',
                                        style: receipt_AmountDetailse,
                                      ),
                                    ],
                                  )),
                              // Expanded(
                              //     flex: 1,
                              //     child: Text(
                              //       'Amount/Dhoti',
                              //       style: black14N,
                              //     )),
                            ],
                          ),
                        ),
                        Consumer<HomeProvider>(
                            builder: (context,value,child) {

                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.paymentDetailsList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {

                                    var item = value.paymentDetailsList[index];
                                    // homeProvider.buzzer(item.status.toString());

                                    return queryData.orientation == Orientation.landscape?
                                    Padding(
                                      padding:  EdgeInsets.only(top:5,left: 5,right: 5),
                                      child: Container(

                                        decoration: BoxDecoration(
                                            color: item.status == "Success"
                                                ? myWhite
                                                : myfailed,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.blue,
                                              width: 0.2,
                                            )

                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.grey,
                                          //     blurRadius:3, // soften the shadow
                                          //
                                          //   )
                                          // ],
                                        ),
                                        // color: const Color(0xffF2EADD),

                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [

                                            Padding(
                                              padding: const EdgeInsets.only(right:15.0,),
                                              child: Text(getDate(item.time),style:
                                              receipt_DT
                                                ,)
                                              ,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Row(
                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // from != "home"
                                                  //     ? SizedBox(
                                                  //         child: Text(
                                                  //           (index + 1).toString(),
                                                  //           style: black14,
                                                  //         ),
                                                  //         width: 40,
                                                  //       )
                                                  //     : const SizedBox(),

                                                  Expanded(
                                                      flex: 3,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('Name',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.name,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('District',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  // width: width/2.7,
                                                                  child: Text(item.district,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('Assembly',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.assembly,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('Panchayath',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.panchayath,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('Ward',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.wardName,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('UpiId',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.upiId,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('App',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.paymentApp,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('Platform',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.paymentplatform,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 5,)




                                                        ],
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                      )),
                                                  Expanded(
                                                    child: Text(
                                                      //item.name,
                                                      " ₹ ${item.amount.split(".").first}",
                                                      style: black141,
                                                    ),
                                                    flex: 1,
                                                  ),

                                                ],
                                              ),
                                            ),





                                          ],
                                        ),
                                      ),
                                    )
                                        :Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:7,vertical: 5),
                                      child: Container(

                                        decoration: BoxDecoration(
                                          color: item.status == "Success"
                                              ? myWhite
                                              : myfailed,
                                          borderRadius: BorderRadius.circular(30),

                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius:3, // soften the shadow

                                            )
                                          ],
                                        ),
                                        // color: const Color(0xffF2EADD),

                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right:15.0,top:7),
                                              child: Text(getDate(item.time),style:
                                              receipt_DT
                                                ,)
                                              ,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
                                              child: Row(
                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // from != "home"
                                                  //     ? SizedBox(
                                                  //         child: Text(
                                                  //           (index + 1).toString(),
                                                  //           style: black14,
                                                  //         ),
                                                  //         width: 40,
                                                  //       )
                                                  //     : const SizedBox(),

                                                  Expanded(
                                                      flex: 3,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Name',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.name,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('District',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.district,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Assembly',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.assembly,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Panchayath',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.panchayath,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Ward',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.wardName,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('UpiId',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.upiId,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('App',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.paymentApp,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),




                                                        ],
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                      )),
                                                  Expanded(
                                                    child: Text(
                                                      //item.name,
                                                      " ₹ ${item.amount.split(".").first}",
                                                      style: black141,
                                                    ),
                                                    flex: 1,
                                                  ),

                                                ],
                                              ),
                                            ),
                                            SizedBox(height:height*0.02,),


                                            Padding(
                                              padding: const EdgeInsets.only(bottom:10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  // value.receiptPinWard=='ON'
                                                  //     ?
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //
                                                  //   },
                                                  //   child: Container(
                                                  //       alignment: Alignment.center,
                                                  //       width: width * .320,
                                                  //       height: 30,
                                                  //       decoration: const BoxDecoration(
                                                  //         gradient: LinearGradient(
                                                  //             begin: Alignment.topLeft,
                                                  //             end: Alignment.bottomRight,
                                                  //             colors: [myDarkBlue,myLightBlue3]
                                                  //         ),
                                                  //         borderRadius: BorderRadius.all(
                                                  //           Radius.circular(25),
                                                  //
                                                  //         ),
                                                  //       ),
                                                  //       child: Text('Change Booth',
                                                  //         style:receiptCG,
                                                  //       )),
                                                  // )
                                                  //     : SizedBox(
                                                  //   width: width * .385,
                                                  // ),

                                                  InkWell(

                                                    onTap: () {
                                                      DonationProvider
                                                      donationProvider =
                                                      Provider.of<DonationProvider>(context, listen: false);
                                                      donationProvider.getSharedPrefName();
                                                      if (item.paymentApp == 'Bank' && item.name == 'No Name') {
                                                        // showReceiptAlert(context, item);
                                                      } else {
                                                        print("receipt click here");
                                                        DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                                        donationProvider.getDonationDetailsForReceipt(item.id);
                                                        // donationProvider.fetchDonationDetails(item.id);
                                                        // donationProvider.receiptSuccessStatus(item.id);

                                                        callNext(ReceiptPage(loginUserPhone: loginUserPhone,
                                                            subScriberType: subScriberType,nameStatus: 'YES',
                                                            loginUserID: loginUserID,loginUsername: loginUsername,
                                                          zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                                          sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                                          foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ),
                                                            context);
                                                      }
                                                    },

                                                    child: Container(
                                                        alignment: Alignment.center,
                                                        width: width * .320,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(40),

                                                            gradient: const LinearGradient(
                                                                begin: Alignment.centerLeft,
                                                                end: Alignment.centerRight,
                                                                colors: [myDarkBlue,myLightBlue3]
                                                            )
                                                        ),
                                                        child: Text('Receipt',style: receiptCG,)),
                                                  ),


                                                ],
                                              ),
                                            ),



                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [


                                                InkWell(
                                                  onTap: () {
                                                    launch("tel://${item.phoneNumber}");
                                                  },
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: width * .385,
                                                      height: 35,
                                                      decoration:  BoxDecoration(
                                                          color: myDarkBlue,
                                                          borderRadius:
                                                          const BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(10))),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(Icons.call,color: myWhite,),
                                                          const SizedBox(width: 10,),
                                                          Text('Call',
                                                            style:knmTerms3,
                                                          ),
                                                        ],
                                                      )
                                                  ),
                                                ),

                                                InkWell(

                                                  onTap: () {
                                                    launch("whatsapp://send?phone=${"+91"+item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                                                  },

                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: width * .385,
                                                      height: 35,
                                                      decoration: const BoxDecoration(
                                                          color:  myDarkBlue,
                                                          borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                              Radius.circular(
                                                                  10))),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(Icons.phone,color: myWhite,),
                                                          const SizedBox(width: 10,),
                                                          Text('WhatsApp',
                                                            style:knmTerms3,
                                                          ),
                                                        ],
                                                      )
                                                    // child: Text('WhatsApp',style: knmTerms3,)
                                                  ),
                                                ),

                                              ],
                                            )


                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                        ),
                        Consumer<HomeProvider>(builder: (context, value, child) {
                          return value.currentLimit == value.paymentDetailsList.length || value.currentWardLimit == value.paymentDetailsList.length
                              ? TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      primary),
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(myWhite),
                                  overlayColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.red),
                                  animationDuration:
                                  const Duration(microseconds: 500)),
                              onPressed: () async {
                                PackageInfo packageInfo = await PackageInfo.fromPlatform();
                                String packageName = packageInfo.packageName;
                                if(packageName=='com.spine.knmMonitor'){

                                  HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                                  homeProvider.currentLimit=50;
                                  homeProvider.fetchReceiptListForMonitorApp(50);
                                  homeProvider.checkStarRating();

                                }else{
                                  value.currentLimit = value.currentLimit + 20;
                                  homeProvider
                                      .fetchReceiptList(value.currentLimit);
                                }

                              },
                              child: const SizedBox(
                                width: double.infinity,
                                child: Center(child: Text('Load More')),
                              ))
                              : SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                const Divider(
                                  thickness: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10),
                                  child: Text(
                                    value.paymentDetailsList.isNotEmpty
                                        ? 'No More Payments'
                                        : 'No Payments',
                                    style: black16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                    // Consumer<HomeProvider>(
                    //     builder: (context,value,child) {
                    //       return Align(
                    //         alignment:Alignment.topRight ,
                    //         child: ConfettiWidget(
                    //           gravity: .3,
                    //           minBlastForce: 5, maxBlastForce: 1000,
                    //           numberOfParticles: 500,
                    //           confettiController: value.controllerCenter,
                    //           blastDirectionality: BlastDirectionality.explosive,
                    //           // don't specify a direction, blast randomly
                    //           //blastDirection: BorderSide.strokeAlignOutside,
                    //           shouldLoop:
                    //           true, // start again as soon as the animation is finished
                    //           colors: const [
                    //             Colors.green,
                    //             Colors.blue,
                    //             Colors.pink,
                    //             Colors.orange,
                    //             Colors.purple,
                    //             Colors.red,
                    //             Colors.greenAccent,
                    //             Colors.white,
                    //             Colors.lightGreen,
                    //             Colors.lightGreenAccent
                    //           ], // manually specify the colors to be used
                    //           createParticlePath: value.drawStar, // define a custom shape/path.
                    //         ),
                    //       );
                    //     }
                    // ),
                  ],
                ),
              ),
            ),
          ),
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
}
String getAmount(double totalCollection) {
  final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
  String newText1 = formatter.format(totalCollection);
  String newText =
  formatter.format(totalCollection).substring(0, newText1.length - 3);
  return newText;
}