import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Screens/payment_history.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';

class VoulenteerTransactionsScreen extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
   VoulenteerTransactionsScreen({Key? key ,required this.loginUsername,required this.loginUserID,required this.subScriberType,required this.loginUserPhone}) : super(key: key);

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
              height: height*.3,
              width: width*.9,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
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
              child: Column(
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
                ],
              ),
            ),
          ),
          SizedBox(height: height*.015,),
          Consumer<HomeProvider>(
            builder: (context,value,child) {
              return SizedBox(
                // height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: value.voulenteerpaymentsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = value.voulenteerpaymentsList[index];
                      return InkWell(
                        onTap: () {
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
                                              // const SizedBox(height: 2,),
                                              // Row(
                                              //   crossAxisAlignment: CrossAxisAlignment.start,
                                              //   children: [
                                              //     SizedBox(
                                              //       width: width/4.5,
                                              //       child: Text('District',style: TextStyle(
                                              //           color: myBlack.withOpacity(0.20),
                                              //           fontSize: 12.5,
                                              //           fontWeight: FontWeight.w600,
                                              //           fontFamily: "PoppinsMedium"
                                              //       ),
                                              //       ),
                                              //     ),
                                              //     SizedBox(
                                              //         width: width/25,
                                              //         child:  Text(':',style: TextStyle(
                                              //             color:myBlack.withOpacity(0.40)
                                              //         ),)
                                              //     ),
                                              //     Flexible(
                                              //       fit:FlexFit.tight,
                                              //       child: Text(item.district,
                                              //         maxLines: 2,
                                              //         overflow: TextOverflow.ellipsis,
                                              //         style: receiptNDMU2,),
                                              //     ),
                                              //   ],
                                              // ),
                                              // const SizedBox(height: 2,),
                                              // Row(
                                              //   crossAxisAlignment: CrossAxisAlignment.start,
                                              //   children: [
                                              //     SizedBox(
                                              //       width: width/4.5,
                                              //       child: Text('Assembly',style: TextStyle(
                                              //           color: myBlack.withOpacity(0.20),
                                              //           fontSize: 12.5,
                                              //           fontWeight: FontWeight.w600,
                                              //           fontFamily: "PoppinsMedium"
                                              //       ),
                                              //       ),
                                              //     ),
                                              //     SizedBox(
                                              //         width: width/25,
                                              //         child:  Text(':',style: TextStyle(
                                              //             color:myBlack.withOpacity(0.40)
                                              //         ),)
                                              //     ),
                                              //     Flexible(
                                              //       fit:FlexFit.tight,
                                              //       child: Text(item.assembly,
                                              //         maxLines: 2,
                                              //         overflow: TextOverflow.ellipsis,
                                              //         style: receiptNDMU2,),
                                              //     ),
                                              //   ],
                                              // ),
                                              // const SizedBox(height: 2,),
                                              // Row(
                                              //   crossAxisAlignment: CrossAxisAlignment.start,
                                              //   children: [
                                              //     SizedBox(
                                              //       width: width/4.5,
                                              //       child: Text('Panchayath',style: TextStyle(
                                              //           color: myBlack.withOpacity(0.20),
                                              //           fontSize: 12.5,
                                              //           fontWeight: FontWeight.w600,
                                              //           fontFamily: "PoppinsMedium"
                                              //       ),
                                              //       ),
                                              //     ),
                                              //     SizedBox(
                                              //         width: width/25,
                                              //         child:  Text(':',style: TextStyle(
                                              //             color:myBlack.withOpacity(0.40)
                                              //         ),)
                                              //     ),
                                              //     Flexible(
                                              //       fit:FlexFit.tight,
                                              //       child: Text(item.panchayath,
                                              //         maxLines: 2,
                                              //         overflow: TextOverflow.ellipsis,
                                              //         style: receiptNDMU2,),
                                              //     ),
                                              //   ],
                                              // ),
                                              // const SizedBox(height: 2,),
                                              // Row(
                                              //   crossAxisAlignment: CrossAxisAlignment.start,
                                              //   children: [
                                              //     SizedBox(
                                              //       width: width/4.5,
                                              //       child: Text('Unit',style: TextStyle(
                                              //           color: myBlack.withOpacity(0.20),
                                              //           fontSize: 12.5,
                                              //           fontWeight: FontWeight.w600,
                                              //           fontFamily: "PoppinsMedium"
                                              //       ),
                                              //       ),
                                              //     ),
                                              //     SizedBox(
                                              //         width: width/25,
                                              //         child:  Text(':',style: TextStyle(
                                              //             color:myBlack.withOpacity(0.40)
                                              //         ),)
                                              //     ),
                                              //     Flexible(
                                              //       fit:FlexFit.tight,
                                              //       child: Text(item.wardName,
                                              //         maxLines: 2,
                                              //         overflow: TextOverflow.ellipsis,
                                              //         style: receiptNDMU2,),
                                              //     ),
                                              //   ],
                                              // ),
                                              // const SizedBox(height: 2,),
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

                                          Text(getDate(item.addedTimeMillis),style: receipt_DT,),
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



                            ],
                          ),
                        ),
                      );
                    }),
              );
            }
          )
        ],
      ),
    );
  }
}
