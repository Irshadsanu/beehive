import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../QMCHAdminScreens/add_subscribers_screen.dart';
import '../Screens/payment_history.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';
import '../qmchModels/subScriberModel.dart';

class SubscriberDetails extends StatelessWidget {
  SubScriberModel subScriberModel;
  String adminId,adminName;
   SubscriberDetails({Key? key,required this.subScriberModel,required this.adminId,required this.adminName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            // width: 10,
            // height: 10,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0.05000000074505806),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(37.40),
              ),
            ),
            child: InkWell(
                onTap: (){
                  finish(context);
                },
                child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black, size: 18,)),),
        ),
        title: Center(
          child: Padding(
            padding:  EdgeInsets.only(right: width*.1),
            child: Text(
              'Subscriber',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                // height: 0.08,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: height*.015,),
          Align(alignment: Alignment.center,
            child: Container(
              // height: height*.34,
              width: width*.9,
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
              child: Column(
                children: [
                  SizedBox(
                    height: height*.14,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: height*.07,
                              decoration:const BoxDecoration(
                                image:  DecorationImage(
                                  image: AssetImage("assets/profile_subscriber.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              height: height*.07,
                              decoration:const BoxDecoration(
                                  // color: Colors.yellow
                              ),
                            ),
                          ],
                        ),
              Center(
                child: Container(

                  width: height*.108,
                  height: height*.108,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.77, color: Colors.white),
                      borderRadius: BorderRadius.circular(57.70),
                    ),
                  ),
                  child: Container(
                    width: height*.105,
                    height: height*.105,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                     color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.77, color: Colors.white),
                        borderRadius: BorderRadius.circular(57.70),
                      ),
                    ),
                    child: Image.network(subScriberModel.photo,fit: BoxFit.cover),
              ),
                ),
              ),
                      ],
                    ),
                    
                  ),
Padding(
  padding:  EdgeInsets.only(left: width*.05,top: height*.005,right:width*.05, ),
  child:   Column( mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.centerLeft,

                child: Text(
                  'Name*',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.30000001192092896),
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    // height: 0.16,
                    letterSpacing: 0.10,
                  ),
                ),

              ),
               SizedBox(width: width*0.7,
                 child: Text(
                   subScriberModel.subScriberName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.12,
                  ),
              ),
               ),
            ],
          ),
          InkWell(
            onTap:() {
              donationProvider.fetchSubScribersEditOne(subScriberModel
                  .id);
              // donationProvider.clearSubcriptionScreen();
              callNext(AddSubscribersScreen(
                  adminID: adminId, adminName: adminName, from: "Edit", id: subScriberModel.id), context);
            },
              child: Container(
              width: height*.035,
              height: height*.035,
              padding: const EdgeInsets.all(5),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.07000000029802322),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Icon(Icons.edit,size: 15,),
            ),
          ),
        ],
      ),
      SizedBox(height: height*.01,),
      Text(
        'Mobile Number*',
        style: TextStyle(
          color: Colors.black.withOpacity(0.30000001192092896),
          fontSize: 11,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          // height: 0.16,
          letterSpacing: 0.10,
        ),
      ),
      Text(
        subScriberModel.subScriberPhoneNumber,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          letterSpacing: 0.12,
        ),
      ),
      SizedBox(height: height*.01,),
      Text(
        'Address*',
        style: TextStyle(
          color: Colors.black.withOpacity(0.30000001192092896),
          fontSize: 11,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          letterSpacing: 0.10,
        ),
      ),
       Text(
         subScriberModel.subScriberAddress,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          letterSpacing: 0.12,
        ),
      ),
      SizedBox(height: height*.03,),
    ],
  ),
),
                ],
              ),
            ),
          ),
          SizedBox(height: height*.018,),
          Consumer<DonationProvider>(
            builder: (context,value,child) {
              return value.subscriberPaymentList.length>0
              ?SizedBox(
                width: width*.9,
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Latest Transaction',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // Text(
                    //   'view all',
                    //   style: TextStyle(
                    //     color: Color(0xFF253068),
                    //     fontSize: 10,
                    //     fontFamily: 'Poppins',
                    //     fontWeight: FontWeight.w400,
                    //     decoration: TextDecoration.underline,
                    //     // height: 0.18,
                    //   ),
                    // ),
                  ],
                ),
              ):SizedBox();
            }
          ),
          SizedBox(height: height*.015,),

          Flexible(fit:FlexFit.tight,
            child: Consumer<DonationProvider>(
                builder: (context,value,child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10.0),
                      itemCount: value.subscriberPaymentList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item=value.subscriberPaymentList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Container(
                            height: 80,
                            width: width*0.8,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.04),
                              ),
                              shadows: [
                                const BoxShadow(
                                  color: Color(0x0A000000),
                                  blurRadius: 5.15,
                                  offset: Offset(0, 2.58),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                      width: 52,
                                      height: 52,
                                      padding: const EdgeInsets.only(
                                        top: 13.05,
                                        left: 11.31,
                                        right: 10.44,
                                        bottom: 13.06,
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(78.33),
                                        ),
                                        shadows: [
                                          const BoxShadow(
                                            color: Color(0x0A000000),
                                            blurRadius: 4.49,
                                            offset: Offset(0, 2.24),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: Image.asset("assets/qmchBg.png")),
                                ),
                                Flexible(fit: FlexFit.tight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          double.parse(item.amonut.toString()).toStringAsFixed(0) ,
                                          style: TextStyle(
                                            color: Color(0xFF3E4FA3),
                                            fontSize: 18,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                            letterSpacing: -0.18,
                                          ),
                                        ),
                                        Text(
                                          getDate(item.paymentDateMillis),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                            letterSpacing: -0.10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 75,
                                  child: Center(
                                    child: Text(
                                      item.monthName,
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: -0.10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
            ),
          ),
        ],
      ),
    );
  }
}
