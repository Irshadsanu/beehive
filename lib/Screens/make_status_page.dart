import 'package:auto_size_text/auto_size_text.dart';
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

class MakeStatusPage extends StatelessWidget {
  String from;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  MakeStatusPage({Key? key,required this.from,required this.loginUsername
    ,required this.loginUserID,required this.subScriberType,required this.loginUserPhone,
    required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
    required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
    ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,
  }) : super(key: key);
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    print(subScriberType+'asdpkaodskpo');
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
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Consumer<HomeProvider>(
                builder: (context,value,child) {
                  print(value.fileImage.toString()+' IVNFV');
                  return Container(
                    width:width,
                    margin:  EdgeInsets.symmetric(horizontal: width/23),
                    child: Screenshot(
                      controller: screenshotController,
                      child: Stack(
                        children: [
                          from==""? Padding(
                            padding:  EdgeInsets.only(top: height/9,left: 10),
                            child: Container(
                                height:170,
                                width:425,
                                decoration:
                              const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,

                                  // borderRadius: BorderRadius.circular(10),
                                  // borderRadius: BorderRadius.circular(7),

                                  // color: Colors.red
                                ),
                              child:value.fileImage!=null? Image.file(value.fileImage!,fit: BoxFit.cover,):SizedBox()
                            ),
                          ):SizedBox(),
                          Container(
                            // color: Colors.red,
                            height: height/2.05,
                            width: MediaQuery.of(context).size.width,
                            child: from==""?
                            Image.asset("assets/NjanumPankaliyai.png",fit: BoxFit.fill,alignment: Alignment.bottomCenter,)
                                : Image.asset("assets/familyStatus.png",fit: BoxFit.fill,alignment: Alignment.bottomCenter,),
                          ),


                          // from=="family"?Positioned(
                          //     top: 222,
                          //     left: 154,
                          //     child: Container(
                          //         width: 196,
                          //         decoration: const BoxDecoration(
                          //             color:Colors.white,
                          //             borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
                          //         ),
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(left: 8.0,bottom: 2),
                          //           child: Text(value.familyNameTC.text,
                          //             style: const TextStyle(color: Colors.black,fontFamily: "PoppinsMedium",fontWeight: FontWeight.w400,fontSize: 13),),
                          //         ))):const  SizedBox(),
                          // from==""? Positioned(
                          //   top: 220,
                          //   left: 125,
                          //   child: Center(
                          //     child:  SizedBox(
                          //       width: 450 / 4.2,
                          //       height: 20,
                          //       child: AutoSizeText.rich(
                          //           TextSpan(
                          //               children: <InlineSpan>[
                          //                 const TextSpan(
                          //                   text: '₹ ',
                          //                   style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w400),),
                          //                 TextSpan(
                          //                   text: value.donorAmount,
                          //                   style: const TextStyle(
                          //                     fontFamily: "PoppinsMedium",
                          //                       color: Colors.white,
                          //                       fontWeight: FontWeight.w600,
                          //                       fontSize: 17),)
                          //               ])
                          //       ),
                          //   ),
                          // ),
                          // ):SizedBox()
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          from=="family"?
          Consumer<DonationProvider>(builder: (context, value1, child) {
            return InkWell(
              onTap: () {
                value1.familyNameTC.clear();
                addFamilyNameAlert(context, value1.donorID);
              },
              child: Card(
                margin: const EdgeInsets.only(
                    right: 15, left: 15, top: 10, bottom: 5),
                elevation: 0,
                color: Colors.grey.shade300,
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
                            return Text("Family Name",
                              style: black16,
                            );

                          })),
                    ],
                  ),
                ),
              ),
            );
          })
              :SizedBox(),

          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF253068)),
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF253068)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),

                              ),
                            ),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30)),
                          ),
                          onPressed: () {
                            print('NIFUTG');
                            HomeProvider homeProvider =
                            Provider.of<HomeProvider>(context, listen: false);
                            homeProvider.showBottomSheet(context);

                            // showBottomSheetStaff(context);
                          },
                          child: Text(
                            'Upload Photo',
                            style: white16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height:10),
                Consumer<HomeProvider>(
                  builder: (context,value,chiild) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF253068)),
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF253068)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),

                                  ),
                                ),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 30)),
                              ),
                              onPressed: () {
                                if(value.fileImage!=null){

                                  donationProvider.shareImageStatus(screenshotController);
                                }else{
                                  noPhotoAlert(context);
                                }
                              },
                              child: Text(
                                'Share to Whatsapp',
                                style: white16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          elevation: 0,
          backgroundColor: myWhite,
          centerTitle: true,
          title: Text(
            "Receipt",
            style: TextStyle(
                color: myBlack,
                fontSize: 15,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5
              // height: 0.08,
            ),
          ),
          leading: Center(
            child: InkWell(
                onTap: () {
                  subScriberType=='ADMIN'?
                  finish(context)
                      :
                  callNextReplacement(
                      HomeScreenNew(subScriberType: subScriberType,
                        loginUserID: loginUserID,loginUsername: loginUsername,loginUserPhone: loginUserPhone,
                        zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                        sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                        foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context
                  );
                },
                child: CircleAvatar(
                  radius: 19,
                  backgroundColor: myBlack.withOpacity(0.05),
                  child: const Padding(
                    padding: EdgeInsets.only(left:5.0),
                    child: Icon(Icons.arrow_back_ios,color:myBlack,size: 22,),
                  ),
                )),
          ),
        ),
      ),
      body: body(context),
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
      Row(
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/KnmWebBackground1.jpg'),fit: BoxFit.cover
                )
            ),
            child: Row(
              children: [
                SizedBox(
                    height: height,
                    width: width / 3,
                    child: Image.asset("assets/Group 2.png",scale: 4,)),
                SizedBox(
                  height: height,
                  width: width / 3,
                ),
                SizedBox(
                    height: height,
                    width: width / 3,
                    child: Image.asset("assets/Group 3.png",scale: 6,)),
              ],
            ),
          ),


        ],
      ),
      Center(child: queryData.orientation==Orientation.portrait?  Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width:width,
            child: Scaffold(
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [primary, primary])),
                ),
                title: const Padding(
                  padding: EdgeInsets.only(left: 70),
                  child: Text(
                    "Receipt",
                  ),
                ),
                leading: InkWell(
                    onTap: () {
                      callNextReplacement(  HomeScreenNew(subScriberType: subScriberType,
                        loginUsername: loginUsername, loginUserID: loginUserID,loginUserPhone: loginUserPhone,
                        zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                        sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                        foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                    },
                    child: const Icon(Icons.arrow_back, color: myWhite)),
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
                    "Receipt",
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
    print('VIUJIUJVE');
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
                          decoration: const BoxDecoration(
                            color: Color(0xFF253068),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
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
  final OutlineInputBorder borderAddress = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
    borderRadius: BorderRadius.circular(50),
  );

  Future<AlertDialog?> addFamilyNameAlert(BuildContext context, String donorID) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
              height: 250,
              child: AlertDialog(
                  title:  const Text("Add Family Name"),
                  backgroundColor: Colors.white,
                  contentPadding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  content: Consumer<HomeProvider>(builder: (context, value, child) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Consumer<DonationProvider>(
                              builder: (context, value2, child) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        prefix: const SizedBox(
                                          width: 15,
                                        ),
                                        hintText: "Enter Family Name",
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabledBorder: borderAddress,
                                        disabledBorder: borderAddress,
                                        focusedBorder: borderAddress,
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                            )),
                                        focusedErrorBorder: borderAddress),
                                    controller: value2.familyNameTC,
                                    style: const TextStyle(
                                        fontFamily: 'BarlowCondensed',
                                        fontWeight: FontWeight.bold),
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return "Enter family Name";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                );
                              }),
                          Container(
                              padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(10))),
                              child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                                Consumer<DonationProvider>(
                                    builder: (context, value3, child) {
                                      return InkWell(
                                        onTap: () {
                                          final FormState? form = _formKey.currentState;
                                          if (form!.validate()) {
                                            value3.updateFamilyName(donorID);
                                            finish(context);
                                          }
                                        },
                                        child: Container(
                                            height: 50,
                                            width:
                                            MediaQuery.of(context).size.width * 0.7,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(35)),
                                                gradient: LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [cl323A71, cl1177BB])),
                                            child: const Center(
                                                child:  Text(
                                                  "OK",
                                                  style: TextStyle(
                                                    color: myWhite,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ))),
                                      );
                                    }),
                              ])),
                        ],
                      ),
                    );
                  })
              )

          );
        });
  }



}


