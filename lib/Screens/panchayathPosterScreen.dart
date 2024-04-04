import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'home.dart';
import 'home_screen.dart';

class PanchayathPosterPageScreen extends StatelessWidget {

  String district;
  String assembly;
  String panchayath,loginUserPhone;
  String loginUsername,loginUserID,subScriberType;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  PanchayathPosterPageScreen({Key? key, required this.district, required this.assembly, required this.panchayath,required this.loginUserPhone
    ,required this.loginUsername,required this.loginUserID,required this.subScriberType,
    required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
    required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
    ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);
  ScreenshotController screenshotController = ScreenshotController();


  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider =Provider.of<HomeProvider>(context,listen: false);
    // homeProvider.checkInternet(context);


    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }
  Widget body (BuildContext context){
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Consumer<DonationProvider>(
                builder: (context,value,child) {
                  return Screenshot(
                    controller: screenshotController,
                    child: Stack(
                      children: [

                        SizedBox(
                          height: 420,
                          width: 340,
                          child:

                           Image.asset("assets/panchayath.jpg",fit: BoxFit.fill,alignment: Alignment.bottomCenter,)

                        ),
                        Positioned(
                            top: district=="FAMILY CONTRIBUTION"?220:205,
                           right: 30,

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [


                                Container(
                                    alignment: Alignment.center,
                                    width: 340,
                                    child: Text(panchayath,style:  TextStyle(fontSize:panchayath.length>20?10:18,fontWeight: FontWeight.bold, fontFamily: 'Montserrat',color: Colors.white),)
                                ),
                                const SizedBox(height: 3,),
                                SizedBox(
                                    width: 340,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        assembly=="FAMILY CONTRIBUTION"?SizedBox(): SizedBox(
                                            width: width * .55,
                                            child: Center(child: Text(assembly,style:  TextStyle(fontSize:assembly.length>20? 11:10,fontWeight: FontWeight.w600, fontFamily: 'Montserrat',color: Colors.white),))),

                                      ],
                                    )),
                                SizedBox(
                                    width: 340,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        district=="FAMILY CONTRIBUTION"?SizedBox(): Text(district,style:  TextStyle(fontSize: district.length>20?10:11,fontWeight: FontWeight.w600, fontFamily: 'Montserrat',color: Colors.white),),

                                      ],
                                    ))
                              ],
                            ))


                      ],
                    ),
                  );
                }
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: Padding(
                //         padding: const EdgeInsets.only(right: 10),
                //         child: TextButton(
                //           style: ButtonStyle(
                //             foregroundColor: MaterialStateProperty.all<Color>(myWhite),
                //             backgroundColor: MaterialStateProperty.all<Color>(primary),
                //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //               RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(30),
                //                 side: const BorderSide(
                //                   color: secondary,
                //                   width: 2.0,
                //                 ),
                //               ),
                //             ),
                //             padding: MaterialStateProperty.all(
                //                 const EdgeInsets.symmetric(
                //                     vertical: 15, horizontal: 30)),
                //           ),
                //           onPressed: () {
                //             showBottomSheetStaff(context);
                //           },
                //           child: Text(
                //             'Upload Photo',
                //             style: white16,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height:10),
                InkWell(
                  onTap: (){
                    donationProvider.shareImageForPoster(screenshotController);
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 22,vertical: 15),
                    decoration:  BoxDecoration(
                      boxShadow:  [
                        const BoxShadow(
                          color:cl323A71,
                        ),
                        BoxShadow(
                          color: cl000000.withOpacity(0.25),
                          spreadRadius: -5.0,
                          blurRadius: 20.0,
                        ),

                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(35)),
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [cl323A71, cl1177BB]),

                    ),
                    child: const Center(
                        child: Text(
                          "Share to Whatsapp",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "PoppinsMedium",
                              color: myWhite, fontWeight: FontWeight.w500),
                        )),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
  Widget mobile(BuildContext context) {


    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(84),
          child: AppBar(
            backgroundColor: Colors.white,
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
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 33,),
                    InkWell(
                      onTap: (){

                        finish(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: cl323A71,
                        size: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Text(
                        "Panchayath Quota Poster",
                        style: wardAppbarTxt,
                      ),
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
        body: body(context),
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
    return Stack(children: [
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
      Center(child: queryData.orientation==Orientation.portrait?  Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width:width,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: MediaQuery.of(context).size.height*0.13,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [myDarkBlue,myLightBlue]
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)
                    ),
                  ),
                ),
                title: SizedBox(width: MediaQuery.of(context).size.width*0.7,
                  child: Center(
                    child: Text(
                        "Receipt",
                        style: wardAppbarTxt
                    ),
                  ),
                ),
                leading: InkWell(
                  onTap: () {
                    callNextReplacement( HomeScreenNew(subScriberType: subScriberType,
                        loginUserID: loginUserID,loginUsername: loginUsername,loginUserPhone: loginUserPhone,
                      zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                      sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                      foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                  },
                  child: const  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              body: body(context),
            ),
          ),
        ],
      ):
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width:width/3,
            child: Scaffold(
              appBar: AppBar(
                flexibleSpace: Container(
                  // height: 100,
                  decoration: const BoxDecoration(
                    color: myGreen,
                  ),
                ),
                title: const Padding(
                  padding: EdgeInsets.only(left: 70),
                  child: Text(
                    "Reciept",
                  ),
                ),
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, color: myWhite)),
              ),
              body: body(context),
            ),
          ),
        ],
      ),)
    ],);
  }
  void showBottomSheetStaff(BuildContext context) {
    DonationProvider donationProvider =Provider.of<DonationProvider>(context,listen: false);

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
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(
                    Icons.camera_enhance_sharp,
                    color: myGreen,
                  ),
                  title: const Text('Camera',),
                  onTap: () => {donationProvider.getImageFromCamera(context), Navigator.pop(context)}),
              ListTile(
                  leading: const Icon(Icons.photo, color: myGreen),
                  title: const Text('Gallery',),
                  onTap: () => {donationProvider.getImageFromGallery(context),Navigator.pop(context)}),
            ],
          );
        });
    // ImageSource
  }
  noPhotoAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      backgroundColor: Colors.white,
      actions: [
        SizedBox(
          width: 400,
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sorry",
                style: black16,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Please Upload Photo First",
                      style: black16,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          finish(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(35),
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [myDarkBlue,myLightBlue]
                            ),
                          ),
                          child:  Text(
                            "OK",
                            style: white16,
                          ),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}


