import 'package:beehive/QmchScreens/userActivityDetailsScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';

class UserActivityHomeScreen extends StatefulWidget {
   UserActivityHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserActivityHomeScreen> createState() => _UserActivityHomeScreenState();
}

class _UserActivityHomeScreenState extends State<UserActivityHomeScreen> {
  List<String> images = [
    "assets/carouselBg1.png",
    "assets/carouselBg1.png",
    "assets/carouselBg1.png",
    "assets/carouselBg1.png",
  ];

   int activeIndex = 0;

  @override

  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: myWhite,
        elevation: 0,
        leading: Center(
          child: InkWell(
            onTap:(){
              finish(context);
            },
            child: CircleAvatar(
                radius: 19,
                backgroundColor: myBlack.withOpacity(0.05),
                child: const Padding(
                  padding: EdgeInsets.only(left:4.0,right: 6),
                  child: Icon(Icons.arrow_back_ios_new_outlined,size: 20,color: myBlack,),
                )),
          ),
        ),
        centerTitle: true,
        title: const Text("Activities",style: TextStyle(color:myBlack, fontFamily: 'Poppins',
          fontSize: 15,fontWeight: FontWeight.w600,),
        ),
      ),

      body: Column(
        children: [

          const SizedBox(height: 10,),

          Container(
            height: 200,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
            ),
            child: CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder:
                  (context, index, realIndex) {
                //final image=value.imgList[index];
                final image = images[index];
                return buildImage(image, context);
              },
              options: CarouselOptions(
                  clipBehavior:
                  Clip.antiAliasWithSaveLayer,
                  // autoPlayCurve: Curves.linear,
                  height: 200,
                  viewportFraction: 0.85,
                  aspectRatio: 2.0,
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

          ///
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Container(
          //     width:width,
          //     height: height*0.2,
          //
          //     child: CarouselSlider(
          //       options: CarouselOptions(height:150,
          //           autoPlay: true,viewportFraction: 0.5,
          //           autoPlayAnimationDuration: const Duration(milliseconds: 400),
          //           autoPlayCurve: Curves.fastOutSlowIn,
          //           enableInfiniteScroll: true
          //       ),
          //       items: [
          //         Container(
          //           width: 250,
          //           height: 150,
          //           decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/carouselBg1.png"))),
          //         ),
          //         Container(
          //           width: 250,
          //           height: 150,
          //           decoration: BoxDecoration( image: const DecorationImage(image: AssetImage("assets/carousel.png"),),borderRadius: BorderRadius.circular(5)),
          //         ),],
          //     ),
          //   ),
          // ),
          const SizedBox(height: 10,),
          const Text('Lorem ipsum dolor sit amet!',style: TextStyle(fontFamily: "JaldiBold",fontWeight: FontWeight.w400,
              fontSize: 14,color: cl_3F50A4),),
          const Text('consectetur adipiscing elit. Ut viverra sapien in est porta \n vel cursus urna rutrum.',style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w400,
              fontSize: 10,color: myBlack),),

          Expanded(
            child: Consumer<DonationProvider>(
              builder: (context,value,child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      // scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: value.filterNewsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item =value.filterNewsList[index];
                        return Padding(
                          padding:  const EdgeInsets.all(8.0),
                          child: InkWell(onTap: (){
                            callNext(UserActivityDetailsScreen(newsFeedModel: item,), context);
                          },
                            child: Container(
                              width: double.infinity,
                              child: ListTile(
                                leading: Container(width: width/6,height: height/5,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),
                                    image:item.image!=''? DecorationImage(
                                      image: NetworkImage(item.image),
                                      fit: BoxFit.fill,
                                    ) : const DecorationImage(
                                      image: AssetImage("assets/noImage.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),),
                                title: Text(item.title,style: const TextStyle(fontFamily: "JaldiBold",fontWeight: FontWeight.w400,
                                    fontSize: 14,color: cl_3F50A4),),
                                subtitle: Text(item.description,maxLines: 2,
                                  style: const TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w400,
                                    fontSize: 10,color: myBlack),),
                                trailing:Padding(
                                  padding:  const EdgeInsets.only(top: 43.0),
                                  child: Text(item.nowDifferece,style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500,
                                      fontSize: 8,color: myBlack.withOpacity(0.5)),),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                      Consumer<DonationProvider>(
                        builder: (context,value,child) {
                          return value.newsFeedCount > value.filterNewsList.length ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: (){
                                value.fetchAllNews(false,value.filterNewsList[value.filterNewsList.length-1].addedTime);
                              },
                              child: Container(
                                height: 35 ,
                                width:width*.5 ,
                                decoration:  BoxDecoration(
                                  gradient: const LinearGradient(
                                           begin:
                                           Alignment(-1.00, -0.00),
                                             end: Alignment(1, 0),
                                            colors: [
                                             Color(0xFF3E4FA3),
                                               Color(0xFF253068)
                                                      ]
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child:const Center(child:  Text("Load More",style: const TextStyle(fontFamily: "JaldiBold",fontWeight: FontWeight.w400,
                                    fontSize: 14,color: Colors.white),)),
                              ),
                            ),
                          ): const SizedBox();
                        }
                      )
                    ],
                  ),
                );
              }
            ),
          ),
        ],
      ),

    );
  }
}

buildImage(var image, context) {
  return Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(horizontal: 10),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(image),
        fit: BoxFit.fill,
      ),
      borderRadius: BorderRadius.circular(7),
    ),
  );
}