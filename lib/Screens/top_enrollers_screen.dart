import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/home_provider.dart';
import 'home_screen.dart';

class TopEnrollersScreen extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
   TopEnrollersScreen({Key? key,required this.loginUsername,
     required this.loginUserID,required this.subScriberType,required this.loginUserPhone,  required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
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

  Widget mobile(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(84),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 5.0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
            flexibleSpace: Container(
              height: MediaQuery.of(context).size.height*0.12,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(17),
                    bottomRight: Radius.circular(17)
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 33,),
                    InkWell(
                      onTap: (){
                        callNextReplacement(HomeScreenNew(loginUserPhone: loginUserPhone,
                            subScriberType: subScriberType,
                            loginUserID: loginUserID,
                            loginUsername: loginUsername,
                          zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                          sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                          foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ),context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: cl323A71,
                        size: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Text('Top Volunteers',style: wardAppbarTxt,),
                    ),
                    // Row(
                    //   children: [
                    //     Container(
                    //         width: 25,
                    //         height: 25,
                    //         decoration: const BoxDecoration(
                    //             shape: BoxShape.circle,
                    //             gradient: LinearGradient(
                    //                 colors: [
                    //                   cl14B37D,
                    //                   cl1177BB
                    //                 ],
                    //                 begin: Alignment.bottomLeft,
                    //                 end: Alignment.topRight
                    //             )),
                    //         child: Image.asset("assets/helpline.png",scale: 2,color: Colors.white,)),
                    //     const SizedBox(width: 4,),
                    //     const Text("Support",
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.w400,
                    //         fontFamily: "PoppinsMedium",
                    //       ),),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Consumer<HomeProvider>(
                builder: (context,value,child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.topEnrollersModel.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var item = value.topEnrollersModel[index];
                        return
                        Padding(
                          padding: const EdgeInsets.only(left:20,right:20,top: 5,bottom: 5),
                          child: Stack(
                            children: [
                              Container(
                                // height: 104,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  // color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage('assets/homeAmount_bgrnd.png'),fit: BoxFit.fill,
                                  ),
                                  // borderRadius: BorderRadius.all(Radius.circular(15)),

                                ),

                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                          width:80,height:100,
                                          // color:myLightRedNewUI,
                                          child: Padding(
                                            padding:  const EdgeInsets.only(bottom: 14.5,left: 10.8),
                                            child: SizedBox(
                                              width: 60,
                                              child:
                                              Image.asset('assets/leaderBadge.png',),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top:25,
                                            left: 33,
                                            child: SizedBox(width: 25,
                                                child: Center(child: Text((index+1).toString(),style: const TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize:18),)))),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        // color: Colors.red,
                                        //  width: 20,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10,),
                                            SizedBox(width:115,
                                              child: Text(
                                                item.name.toString(),
                                                style:  TextStyle(
                                                    fontSize: width*0.035,
                                                    color: Colors.white,
                                                    fontFamily: 'PoppinsMedium',
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width:115,
                                              child: Text(
                                                item.place,
                                                style:  TextStyle(
                                                    fontSize: width*0.028,
                                                    color: Colors.white,
                                                    fontFamily: 'PoppinsMedium',
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:115,
                                              child: Text(
                                                'ID: '+item.phone.substring(0, item.phone.length - 4) + getStar(4),
                                                style:  TextStyle(
                                                    fontSize: width*0.028,
                                                    color: Colors.white,
                                                    fontFamily: 'PoppinsMedium',
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10,),

                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(),
                                    Container(
                                        alignment: Alignment.centerRight,
                                        width: width*.25,
                                        // color: Colors.orange,
                                        child: FittedBox(
                                          child: Row(
                                            children: [
                                              const Text("₹",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),),
                                              Text(getAmount(double.parse(item.totalAMount.toStringAsFixed(0))),
                                                style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Colors.white,fontFamily: "PoppinsMedium"),),
                                            ],
                                          ),
                                        )
                                    )

                                  ],
                                ),

                              ),
                            ],
                          ),
                        );
                      });
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
      child: Stack(
        children: [
          Center(
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
                        title: Text('Top Enrollers',style: wardAppbarTxt,),
                        automaticallyImplyLeading: false,
                        leading:  InkWell(
                          onTap: (){
                            callNextReplacement(HomeScreenNew(loginUserPhone: loginUserPhone,
                                subScriberType: subScriberType,
                                loginUserID: loginUserID,loginUsername: loginUsername,
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
                          Consumer<HomeProvider>(
                            builder: (context,value,child) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.topEnrollersModel.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    var item = value.topEnrollersModel[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: InkWell(
                                        onTap: (){

                                        },
                                        child: Container(
                                          height: 100,

                                          child: Card(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                            elevation:2,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // Container(
                                                //   height: 50,
                                                //   width: 20,
                                                //   // margin: const EdgeInsets.all(10),
                                                //   // padding: const EdgeInsets.all(5),
                                                //   decoration: BoxDecoration(
                                                //     color: myWhite,
                                                //     borderRadius: BorderRadius.circular(25),
                                                //   ),
                                                //   // child: Image.asset(
                                                //   //   'assets/dsitrict_logo.png',
                                                //   //   fit: BoxFit.contain,
                                                //   // ),
                                                // ),
                                                Container(
                                                  width:220,
                                                  decoration: const BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment.topLeft,
                                                          end: Alignment.bottomRight,
                                                          colors: [myDarkBlue,myLightBlue2]
                                                      ),

                                                    borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(40),
                                                      bottomRight: Radius.circular(40),
                                                    )

                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 10.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(

                                                          'Name : '+item.name,
                                                          style: gray16White,
                                                        ),
                                                        Text(

                                                            'Place: '+item.place,
                                                            style: gray12white,
                                                          ),

                                                          Text(

                                                            'ID: '+item.phone,
                                                            style: gray12white,
                                                          ),

                                                      ],
                                                    ),
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
                                                                item.totalAMount.toString(),
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
                                      ),
                                    );
                                  });
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
                        title: Text('Top Enrollers',style: wardAppbarTxt,),
                        automaticallyImplyLeading: false,
                        leading:  InkWell(
                          onTap: (){
                            callNextReplacement(HomeScreenNew(loginUserPhone: loginUserPhone,
                                subScriberType: subScriberType,loginUserID: loginUserID,loginUsername: loginUsername,
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
                          Consumer<HomeProvider>(
                              builder: (context,value,child) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.topEnrollersModel.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      var item = value.topEnrollersModel[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: InkWell(
                                          onTap: (){

                                          },
                                          child: Container(
                                            height: 100,

                                            child: Card(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              elevation:2,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // Container(
                                                  //   height: 50,
                                                  //   width: 20,
                                                  //   // margin: const EdgeInsets.all(10),
                                                  //   // padding: const EdgeInsets.all(5),
                                                  //   decoration: BoxDecoration(
                                                  //     color: myWhite,
                                                  //     borderRadius: BorderRadius.circular(25),
                                                  //   ),
                                                  //   // child: Image.asset(
                                                  //   //   'assets/dsitrict_logo.png',
                                                  //   //   fit: BoxFit.contain,
                                                  //   // ),
                                                  // ),
                                                  Container(
                                                    width:220,
                                                    decoration: const BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment.topLeft,
                                                            end: Alignment.bottomRight,
                                                            colors: [myDarkBlue,myLightBlue2]
                                                        ),

                                                        borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(40),
                                                          bottomRight: Radius.circular(40),
                                                        )

                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(

                                                            'Name : '+item.name,
                                                            style: gray16White,
                                                          ),
                                                          Text(

                                                            'Place: '+item.place,
                                                            style: gray12white,
                                                          ),

                                                          Text(

                                                            'ID: '+item.phone,
                                                            style: gray12white,
                                                          ),

                                                        ],
                                                      ),
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
                                                                  item.totalAMount.toString(),
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
                                        ),
                                      );
                                    });
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
        ],
      ),
    );
  }
}
String getStar(int length) {
  String star = '';
  for (int i = 0; i < length; i++) {
    star = star + '*';
  }
  return star;
}