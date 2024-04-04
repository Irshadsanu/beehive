import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import '../providers/web_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import 'home.dart';
import 'home_screen.dart';
import 'make_status_page.dart';

class ReceiptPage extends StatelessWidget {
  String nameStatus;

  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  ReceiptPage({Key? key,required this.nameStatus,
    required this.loginUsername,required this.loginUserID,required this.subScriberType,required this.loginUserPhone,  required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
    required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
    ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);

  ScreenshotController screenshotController = ScreenshotController();

  final LinearGradient _gradient = const LinearGradient(colors: <Color>[
    Colors.yellow,
    Colors.redAccent,
  ]);
  final List<int> amount = [
    10,
    20,
    50,
    100,
    200,
    500,

  ];

  @override
  Widget build(BuildContext context) {
    print(subScriberType+'asadasdasd');
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    Future.delayed(const Duration(seconds:4), () async {
      // if (donationProvider.monthlyAmountAlert) {
      //   receiptPageAlert(context);
      //
      // }

    });

    // homeProvider.checkInternet(context);

    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget body(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);

    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            // margin: const EdgeInsets.only(right: 15,left: 15,top: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Consumer<DonationProvider>(builder: (context, value, child) {
              return Screenshot(
                controller: screenshotController,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 480,
                            width: width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                image: AssetImage("assets/Receipt.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0,top: 5),
                              child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                        "  Date : ${DateFormat('dd/MM/yyyy, hh:mm a').format(value.donationTime)}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            fontFamily: "PoppinsMedium",
                                            color: Colors.black54)),
                                  ])),
                            ),
                          ),
                          Positioned(
                            top:97.5,
                            left:100,
                            child:nameStatus=="NO"?const Text(
                              "അനുഭാവി",
                              style: TextStyle(
                                color: myBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ): Container(
                              width: 240,
                              // color: Colors.red,
                              child: Text(
                               value.donorName.toString()+",",
                                style: const TextStyle(
                                  color: myBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 285,
                            left: 60,
                            child: Center(
                              child: Text(
                                "₹"+value.donorAmount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:30,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),

          Card(
            margin:
                const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 5),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Consumer<DonationProvider>(
                      builder: (context, value, child) {
                    return Text(
                      'Paid through ' + value.donorApp,
                      style: black16,
                    );
                  })),
                ],
              ),
            ),
          ),

          //    const SizedBox(height: 4,),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 10),
                child: Center(
                    child: Text(
                  'Details',
                  style: black16,
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        height: 22,
                        width: 22,
                        decoration: const BoxDecoration(
                            color:  Color(0xFF253068),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Image.asset(
                          'assets/Tik.png',
                          scale: 5,
                          color: myWhite,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Consumer<DonationProvider>(
                          builder: (context, value, child) {
                        return Text(
                          homeProvider.historyList
                                  .map((item) => item.id)
                                  .contains(value.donorID)
                              ? value.donorID
                              : value.donorID.substring(0, value.donorID.length - 4) + getStar(4),
                          style: black16,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: const Icon(
                        Icons.person,
                        color: myWhite,
                        size: 15,
                      ),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color:  const Color(0xFF253068),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Consumer<DonationProvider>(
                          builder: (context, value, child) {
                        return SizedBox(
                            width: (width) / 1.45,
                            child:nameStatus=="YES"? Text(
                              value.donorName,
                              style: black16,
                            ):Text(
                              "അനുഭാവി",
                              style: black16,
                            ));
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: const Icon(
                        Icons.call,
                        color: myWhite,
                        size: 15,
                      ),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color:  const Color(0xFF253068),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Consumer<DonationProvider>(
                          builder: (context, value, child) {
                        //getStar(5)+value.donorNumber.substring(value.donorNumber.length-5,value.donorNumber.length)
                        return Text(
                          getPhone(value.donorNumber),
                          style: black16,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: const Icon(
                        Icons.location_pin,
                        color: myWhite,
                        size: 15,
                      ),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color:  const Color(0xFF253068),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Consumer<DonationProvider>(
                          builder: (context, value, child) {
                        return SizedBox(
                            width: (width) / 1.45,
                            child: Text(
                              value.donorPlace,
                              style: black16,
                            ));
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20, bottom: 10),
                child: Consumer<DonationProvider>(
                    builder: (context, value, child) {
                  return value.donorReceiptPrinted == "Printed"
                      ? Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              child: const Icon(
                                Icons.print,
                                color: myWhite,
                                size: 15,
                              ),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: cl1177BB,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Receipt Printed",
                                  style: black16,
                                )),
                          ],
                        )
                      : const SizedBox();
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        height: 22,
                        width: 22,
                        decoration: const BoxDecoration(
                            color:  Color(0xFF253068),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Image.asset(
                          'assets/payment.png',
                          scale: 45,
                          color: myWhite,
                        )),
                    // Image.asset('assets/payment.png',scale: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Consumer<DonationProvider>(
                          builder: (context, value, child) {
                        return Text(
                          value.donorApp,
                          style: black16,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),

          // TextButton(
          //   style: ButtonStyle(
          //     foregroundColor: MaterialStateProperty.all<Color>(myWhite),
          //     backgroundColor: MaterialStateProperty.all<Color>(primary),
          //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //       RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30.0),
          //         side: const BorderSide(
          //           color: secondary,
          //           width: 2.0,
          //         ),
          //       ),
          //     ),
          //     padding: MaterialStateProperty.all(
          //         const EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
          //
          //   ),
          //   onPressed: () {
          //     donationProvider.whatsappStatus=null;
          //     callNext( MakeStatusPage(), context);
          //   },
          //   child:  Text(' Make Whatsapp Status',style: white16,),
          // ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget webBody(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);

    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            // margin: const EdgeInsets.only(right: 15,left: 15,top: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Consumer<DonationProvider>(builder: (context, value, child) {
              return Screenshot(
                controller: screenshotController,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 480,
                            width: width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                image: AssetImage("assets/Receipt.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),

                          ),
                          Positioned(
                            top: 5,
                            right: 8,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: SizedBox(
                                child: Center(
                                  child: Text(
                                    'Date : ${getDate(value.donationTime.millisecondsSinceEpoch.toString())}',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top:100,
                            left:120,
                            child: Text(
                              value.donorName.toString(),
                              style: const TextStyle(
                                color: myBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 285,
                            left: 100,
                            child: Center(
                              child: Text(
                                "₹"+value.donorAmount.toString(),
                                style: const TextStyle(
                                  color: myWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize:24,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                        ],
                      ),


                    ],
                  ),
                ),
              );
            }),
          ),
          Card(
            margin:
                const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 5),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Consumer<DonationProvider>(
                      builder: (context, value, child) {
                    return Text(
                      'Paid through ' + value.donorApp,
                      style: black16,
                    );
                  })),
                ],
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 10),
                child: Center(
                    child: Text(
                  'Details',
                  style: black16,
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        height: 22,
                        width: 22,
                        decoration: const BoxDecoration(
                            color: cl1177BB,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Image.asset(
                          'assets/Tik.png',
                          scale: 5,
                          color: myWhite,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Consumer<DonationProvider>(
                          builder: (context, value, child) {
                        return Text(
                          homeProvider.historyList
                                  .map((item) => item.id)
                                  .contains(value.donorID)
                              ? value.donorID
                              : value.donorID
                                      .substring(0, value.donorID.length - 4) +
                                  getStar(4),
                          style: black16,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: const Icon(
                        Icons.person,
                        color: myWhite,
                        size: 15,
                      ),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: cl1177BB,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Consumer<DonationProvider>(
                          builder: (context, value, child) {
                        return SizedBox(
                            width: (width / 3) / 1.2,
                            child: Text(
                              value.donorName,
                              style: black16,
                            ));
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: const Icon(
                        Icons.call,
                        color: myWhite,
                        size: 15,
                      ),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: cl1177BB,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Consumer<DonationProvider>(
                          builder: (context, value, child) {
                        //getStar(5)+value.donorNumber.substring(value.donorNumber.length-5,value.donorNumber.length)
                        return Text(
                          getPhone(value.donorNumber),
                          style: black16,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: const Icon(
                        Icons.location_pin,
                        color: myWhite,
                        size: 15,
                      ),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: cl1177BB,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Consumer<DonationProvider>(
                          builder: (context, value, child) {
                        return SizedBox(
                            width: (width / 3) / 1.2,
                            child: Text(
                              value.donorPlace,
                              style: black16,
                            ));
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20, bottom: 10),
                child: Consumer<DonationProvider>(
                    builder: (context, value, child) {
                  return value.donorReceiptPrinted == "Printed"
                      ? Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              child: const Icon(
                                Icons.print,
                                color: myWhite,
                                size: 15,
                              ),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: cl1177BB,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Receipt Printed",
                                  style: black16,
                                )),
                          ],
                        )
                      : const SizedBox();
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        height: 22,
                        width: 22,
                        decoration: const BoxDecoration(
                            color: cl1177BB,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Image.asset(
                          'assets/payment.png',
                          scale: 45,
                          color: myWhite,
                        )),
                    // Image.asset('assets/payment.png',scale: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Consumer<DonationProvider>(
                          builder: (context, value, child) {
                        return Text(
                          value.donorApp,
                          style: black16,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),

          // TextButton(
          //   style: ButtonStyle(
          //     foregroundColor: MaterialStateProperty.all<Color>(myWhite),
          //     backgroundColor: MaterialStateProperty.all<Color>(primary),
          //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //       RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10.0),
          //         side: const BorderSide(
          //           color: primary,
          //           width: 2.0,
          //         ),
          //       ),
          //     ),
          //     padding: MaterialStateProperty.all(
          //         const EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
          //   ),
          //   onPressed: () {
          //     donationProvider.whatsappStatus = null;
          //     callNext(MakeStatusPage(), context);
          //   },
          //   child: Text(
          //     ' Make Whatsapp Status',
          //     style: white16,
          //   ),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
        ],
      ),
    );
  }

  Widget mobile(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async{

           return

             callNextReplacement(HomeScreenNew(loginUserPhone: loginUserPhone,
               subScriberType: subScriberType,loginUserID: loginUserID,
               loginUsername: loginUsername,zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
             sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
             foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);

           },
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(65),
              child: AppBar(
                elevation: 0,
                backgroundColor: myWhite,
                flexibleSpace: Container(
                  height: MediaQuery.of(context).size.height*0.12,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17)),
                  ),
                ),
                // shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
                leading: IconButton(
                  onPressed: () {
                    subScriberType=='ADMIN'?
                    finish(context)
                    :callNextReplacement( HomeScreenNew(loginUserPhone: loginUserPhone,
                        subScriberType: subScriberType,
                        loginUserID: loginUserID,loginUsername: loginUsername,zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                      sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                      foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                  },
                  icon: CircleAvatar(
                    radius: 19,
                    backgroundColor: myBlack.withOpacity(0.05),
                    child: const Padding(
                      padding: EdgeInsets.only(left:5.0),
                      child: Icon(Icons.arrow_back_ios,color:myBlack,size: 22,),
                    ),
                  )
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5,),
                    const Text(
                      'Successful',
                      style: TextStyle(
                        color: myBlack,
                        fontSize: 15,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w700,
                    ),
                    ),
                    Consumer<DonationProvider>(builder: (context, value, child) {
                      return Text(
                        DateFormat('dd/MM/yyyy, hh:mm a').format(value.donationTime),
                        style: white12,
                      );
                    }),
                  ],
                ),
                actions: [
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return IconButton(
                      onPressed: () {
                        if (!kIsWeb) {

                            donationProvider.createImage(
                                'Print', value.donorName, screenshotController);

                        }
                      },
                      icon: const Icon(Icons.print,color: Color(0xFF253068)),
                    );
                  }),
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return IconButton(
                      onPressed: () {
                        if (!kIsWeb) {

                            donationProvider.createImage(
                                'Send', value.donorName, screenshotController);

                        }else {
                          WebProvider webProvider =
                              Provider.of<WebProvider>(context, listen: false);
                          webProvider.createImage(screenshotController);
                        }
                      },
                      icon: const Icon(Icons.share,color: Color(0xFF253068),
                      ),
                    );
                  })
                ],
              ),
            ),
            floatingActionButton:
                Consumer<HomeProvider>(builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0,),
                    child: InkWell(
                      onTap: () {
                        HomeProvider homeProvider =
                              Provider.of<HomeProvider>(context, listen: false);
                        homeProvider.fileImage=null;
                        donationProvider.whatsappStatus = null;

                        callNext(MakeStatusPage(loginUserPhone: loginUserPhone,
                            subScriberType: subScriberType,from: "",
                            loginUserID: loginUserID,loginUsername: loginUsername,zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                          sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                          foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);                      },
                      child: Container(
                        height: 50,
                        width: 160,
                        decoration: const BoxDecoration(

                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF3E4FA3), Color(0xFF253068)
                              ]),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Center(
                                child: Text(
                              "Make My Status",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                  color: myWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0,),
                    child: InkWell(
                      onTap: () {
                        HomeProvider homeProvider =
                        Provider.of<HomeProvider>(context, listen: false);
                        homeProvider.fileImage=null;
                        donationProvider.whatsappStatus = null;
                        callNext(MakeStatusPage(loginUserPhone: loginUserPhone,
                            subScriberType: subScriberType,from: "family",
                            loginUserID: loginUserID,
                            loginUsername: loginUsername,
                          zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                          sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                          foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);                    },
                      child: Container(
                        height: 50,
                        width: 160,
                        decoration: const BoxDecoration(

                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF3E4FA3), Color(0xFF253068)
                              ]),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Center(
                                child: Text(
                                  "Make Family Status",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                      color: myWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration( image: DecorationImage(
            image: AssetImage("assets/webApp.jpg",),
            fit:BoxFit.fill
        )),
        child: Center(
          child: queryData.orientation == Orientation.portrait
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width,
                      child: Scaffold(
                        appBar: PreferredSize(
                          preferredSize: const Size.fromHeight(84),
                          child: AppBar(
                            flexibleSpace: Container(
                              height: MediaQuery.of(context).size.height*0.12,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(17),
                                    bottomRight: Radius.circular(17)),
                              ),
                            ),
                            shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
                            backgroundColor: Colors.transparent,
                            elevation: 5,
                            // leading: IconButton(
                            //   onPressed: () {
                            //     callNextReplacement(const HomeScreenNew(loginUserPhone: loginUserPhone,subScriberType: subScriberType,loginUserID: loginUserID,loginUsername: loginUsername), context);
                            //   },
                            //   icon: const Padding(
                            //     padding: EdgeInsets.only(top: 8.0),
                            //     child: Icon(Icons.arrow_back_ios,color: cl323A71,),
                            //   ),
                            // ),
                            centerTitle: true,
                            title: Column(
                              children: [
                                const SizedBox(height: 18,),
                                Text(
                                  'Successful',
                                  style: white17,
                                ),
                                Consumer<DonationProvider>(builder: (context, value, child) {
                                  return Text(
                                    DateFormat('dd/MM/yyyy, hh:mm a').format(value.donationTime),
                                    style: white12,
                                  );
                                }),
                              ],
                            ),
                            actions: [
                              Consumer<DonationProvider>(builder: (context, value, child) {
                                return IconButton(
                                  onPressed: () {
                                    if (!kIsWeb) {

                                      donationProvider.createImage(
                                          'Print', value.donorName, screenshotController);

                                    }
                                  },
                                  icon: const Icon(Icons.print,color: cl323A71,),
                                );
                              }),
                              Consumer<DonationProvider>(builder: (context, value, child) {
                                return IconButton(
                                  onPressed: () {
                                    if (!kIsWeb) {

                                      donationProvider.createImage(
                                          'Send', value.donorName, screenshotController);

                                    }else {
                                      WebProvider webProvider =
                                      Provider.of<WebProvider>(context, listen: false);
                                      webProvider.createImage(screenshotController);
                                    }
                                  },
                                  icon: const Icon(Icons.download,color: cl323A71,),
                                );
                              })
                            ],
                          ),
                        ),

                        body: body(context),
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
                      child: Scaffold(
                        appBar: PreferredSize(
                          preferredSize: const Size.fromHeight(84),
                          child: AppBar(
                            flexibleSpace: Container(
                              height: MediaQuery.of(context).size.height*0.12,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(17),
                                    bottomRight: Radius.circular(17)),
                              ),
                            ),
                            shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
                            backgroundColor: Colors.transparent,
                            elevation: 5,
                            // leading: IconButton(
                            //   onPressed: () {
                            //     callNextReplacement(const HomeScreenNew(loginUserPhone: loginUserPhone,loginUserID: loginUserID,loginUsername: loginUsername), context);
                            //   },
                            //   icon: const Padding(
                            //     padding: EdgeInsets.only(top: 8.0),
                            //     child: Icon(Icons.arrow_back_ios,color: cl323A71,),
                            //   ),
                            // ),
                            centerTitle: true,
                            title: Column(
                              children: [
                                const SizedBox(height: 18,),
                                Text(
                                  'Successful',
                                  style: white17,
                                ),
                                Consumer<DonationProvider>(builder: (context, value, child) {
                                  return Text(
                                    DateFormat('dd/MM/yyyy, hh:mm a').format(value.donationTime),
                                    style: white12,
                                  );
                                }),
                              ],
                            ),
                            actions: [
                              Consumer<DonationProvider>(builder: (context, value, child) {
                                return IconButton(
                                  onPressed: () {
                                    if (!kIsWeb) {

                                      donationProvider.createImage(
                                          'Print', value.donorName, screenshotController);

                                    }
                                  },
                                  icon: const Icon(Icons.print,color: cl323A71,),
                                );
                              }),
                              Consumer<DonationProvider>(builder: (context, value, child) {
                                return IconButton(
                                  onPressed: () {
                                    if (!kIsWeb) {

                                      donationProvider.createImage(
                                          'Send', value.donorName, screenshotController);

                                    }else {
                                      WebProvider webProvider =
                                      Provider.of<WebProvider>(context, listen: false);
                                      webProvider.createImage(screenshotController);
                                    }
                                  },
                                  icon: const Icon(Icons.download,color: cl323A71,),
                                );
                              })
                            ],
                          ),
                        ),

                        body: webBody(context),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  getDate(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));

// 12 Hour format:
    var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);
    return d12;
  }

  String getStar(int length) {
    String star = '';
    for (int i = 0; i < length; i++) {
      star = star + '*';
    }
    return star;
  }

  String getPhone(String donorNumber) {
    try {
      int ph = 0;
      ph = int.parse(donorNumber.replaceAll("+", ""));

      return getStar(donorNumber.length - 5) +
          donorNumber
              .toString()
              .substring(donorNumber.length - 5, donorNumber.length);
    } catch (e) {
      return donorNumber;
    }
  }


  OutlineInputBorder border2 = OutlineInputBorder(
      borderSide: BorderSide(color: textfieldTxt.withOpacity(0.7)),
      borderRadius: BorderRadius.circular(10));
}
