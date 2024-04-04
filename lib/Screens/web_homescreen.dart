import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/alerts.dart';
import '../constants/my_colors.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import 'district_report.dart';
import 'donate_page.dart';
class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({Key? key}) : super(key: key);

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  final List<int> amount = [500, 1000, 5000, 10000, 25000, 50000];

  final List<String> amountInWords = [
    "Five Hundred",
    "Thousand",
    "Five Thousand",
    "Ten Thousand",
    "Twenty Five Thousand",
    "Fifty Thousand",
  ];

  List<String> images = [
    "assets/mathetharothvam.png",
    "assets/nirbhayam.png",
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);

    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return
      Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: width,
                      // height: 250,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [primary, primary])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                           Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'KPCC 138',
                              style: heeboWhite19,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: SizedBox(
                              height: 110,
                              // color: Colors.blueGrey,
                              width: 300,
                              child: Stack(
                                children: [
                                  Image.asset("assets/Layer 12.png"),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 37.0,
                                      top: 52,
                                    ),
                                    child: SizedBox(
                                      height: 30,
                                      //width:  width*.70,
                                      // color: Colors.yellow,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                3, 3, 14, 3),
                                            child: Image.asset(
                                              "assets/RsIcon.png",
                                              color: myWhite,
                                              height: height * .040,
                                            ),
                                          ),
                                          Consumer<HomeProvider>(
                                              builder: (context, value, child) {
                                                return Text(
                                                  getAmount(value.totalCollection),
                                                  style: heeboWhite25,
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                   Positioned(
                                      right: 10,
                                      bottom: 2,
                                      child: Text(
                                        'Total amount',
                                        style: heeboWhite13,
                                      ))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                        ],
                      )),
                  Column(

                    children: [
                      const SizedBox(
                        height: 45,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          ElevatedButton(
                            onPressed: (){
                              alertSupport(context);
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.transparent,
                            ),

                            child:
                            Row(
                              children: [
                                const Text(
                                  "Help Line",
                                  style: TextStyle(
                                      color: myBlack,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Heebo"
                                  ),
                                ),
                                const SizedBox(width: 8,),

                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 0.5,
                                          color: Colors.grey,
                                          spreadRadius: 0.5)
                                    ],
                                  ),
                                  child: const CircleAvatar(
                                    // alertSupport(context);
                                    backgroundColor: myWhite,
                                    radius: 18.0,
                                    child: Icon(Icons.call, color: knmCallIcon),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "My Contribution",
                      style: b_myContributiontx,
                    ),
                  ),
                  amount.isEmpty
                      ? const SizedBox()
                      : GridView.builder(
                      padding: const EdgeInsets.all(10),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 7,
                        crossAxisSpacing: 7,
                        childAspectRatio: 2,
                        crossAxisCount: 2,
                      ),
                      itemCount: amount.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            decoration: BoxDecoration(
                                color: myWhite,
                                borderRadius: index == 0
                                    ? const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                )
                                    : index == 1
                                    ? const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                )
                                    : index == amount.length - 1
                                    ? const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight:
                                  Radius.circular(20),
                                  bottomLeft:
                                  Radius.circular(5),
                                )
                                    : index == amount.length - 2
                                    ? const BorderRadius.only(
                                  topLeft:
                                  Radius.circular(5),
                                  topRight:
                                  Radius.circular(5),
                                  bottomRight:
                                  Radius.circular(5),
                                  bottomLeft:
                                  Radius.circular(20),
                                )
                                    : const BorderRadius.all(
                                    Radius.circular(5))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "₹${amount[index]}",
                                    style:  TextStyle(
                                        color: gold_b7950e,
                                        fontSize: queryData.orientation == Orientation.portrait? width*.030:width*.013,
                                    ),
                                  ),
                                  Text(
                                    amountInWords[index],
                                    style:  TextStyle(
                                      fontSize:queryData.orientation == Orientation.portrait? width*.030:width*.013,
                                        color: gold_b7950e,
                                        fontFamily: "Heebo"
                                    ),
                                  )
                                ]));
                      }),
                  InkWell(
                      onTap: () {
                        alertTermsAndConditions(context);
                      },
                      child: TpcContainer(width, "Terms and Conditions",
                          "assets/Layer24copy.png")),
                  InkWell(
                      onTap: () {
                        alertTerm(context);
                      },
                      child: TpcContainer(
                          width, "Privacy Policy", "assets/Layer22copy.png")),
                  InkWell(
                      onTap: () {
                        alertContact(context);
                      },
                      child: TpcContainer(
                          width, "Contact Us", "assets/Layer23copy.png")),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
              Positioned(
                  right: 50,
                  left: 50,
                // right: 50,
                  top: 230,
                  child: SizedBox(
                    //height: 90,
                    width: width/3.4,
                    // color:Colors.yellow,
                    child: Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: images.length,
                          itemBuilder: (context, index, realIndex) {
                            //final image=value.imgList[index];
                            final image = images[index];
                            return buildImage(image,context);
                          },
                          options: CarouselOptions(
                              height: 100,
                              viewportFraction: 1,
                              autoPlay: true,
                              //enableInfiniteScroll: false,
                              pageSnapping: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              enlargeCenterPage: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              }),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        buidIndiaCator(images.length,context),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
  }

  Widget TpcContainer(double width, String Ctext, String ImgTxt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: width,
        decoration: const BoxDecoration(
          color: knmGradient5,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: knmGradient2,
                child: Image.asset(
                  ImgTxt,
                  height: 18,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Text(
                Ctext,
                style: tpcAmountTxt
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildImage(var image,context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(image, fit: BoxFit.fill),
      ),
    );
  }

  buidIndiaCator(int count, BuildContext context) {
    int imgCount = count;
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imgCount,
        effect: const JumpingDotEffect(
            dotWidth: 7,
            dotHeight: 7,
            activeDotColor: Color(0xffb7950e),
            dotColor: Color(0xffaba17c)),
      ),
    );
  }
}
