import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../Views/panjayath_model.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import '../providers/main_provider.dart';
import 'home_screen.dart';

class BeAnEnroller extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  BeAnEnroller({Key? key,required this.loginUsername,required this.loginUserID
    ,required this.subScriberType,required this.loginUserPhone,  required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
    required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
    ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);

    String whoIsAVolunteerText =
        "ഖാഇദെ മില്ലത്ത് ക്യാമ്പയിനിനെ പിന്തുണക്കാനും ഫണ്ട് സ്വരൂപിക്കാനും പരിശ്രമിക്കുന്ന വ്യക്തികളാണ് വോളണ്ടീയർമാർ."
        "ആപ്പില്‍,വോളണ്ടീയർമാർക്ക് രജിസ്റ്റര്‍ ചെയ്യാന്‍ അവരുടെ മൊബൈൽ നമ്പർ മാത്രം ഉപയോഗിച്ചാല്‍ മതി ."
        "വോളണ്ടീയർമാർക്ക് ഫണ്ട് സ്വരൂപണത്തില്‍ മറ്റ് വോളണ്ടീയർമാരുമായി മത്സരിക്കാന്‍ സാധിക്കും ."
        "'My History' പേജിലെ 'Add Volunteer' എന്ന ഓപ്ഷനിലൂടെ സംഭാവന ചെയ്യുന്നയാള്‍ക്ക് വോളണ്ടിയറെ Add ചെയ്യാവുന്നതാണ്.ഇതുവഴി വോളണ്ടിയര്‍മാര്‍ സ്വരൂപിച്ച സംഭാവനകള്‍ ട്രാക്ക് ചെയ്യാനും ക്യാമ്പയിനിന്റെ പുരോഗതി നിരീക്ഷിക്കാനും സാധിക്കും ."
        "ക്യാമ്പയിനില്‍ പങ്കെടുക്കാന്‍ വോളണ്ടിയര്‍ ആകേണ്ടതില്ല .";

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Volunteer Registration',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: InkWell(
            onTap: () {
              finish(context);
              // callNextReplacement(const HomeScreenNew(), context);
            },
            child: const Center(
              child: CircleAvatar(
                  backgroundColor: Color(0xfff2f2f2),
                  child: Center(
                      child: Icon(Icons.arrow_back_ios,
                          color: Color(0xFF414CA0)))),
            ),
          ),
        ),

        body: Consumer<HomeProvider>(builder: (context, value5, child) {
          return SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: SizedBox(
                    width: width,
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),

                                Consumer<HomeProvider>(
                                    builder: (context,value3,l) {
                                      return InkWell(onTap: (){

                                      },
                                        child: const Text(
                                          'Register',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF414CA0),
                                            fontSize: 19.91,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      );
                                    }
                                ),

                                const Text(
                                  'As a volunteer',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF6A6A6A),
                                    fontSize: 11.46,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    // height: 0.10,
                                  ),
                                ),

                                const SizedBox(
                                  height: 65,
                                ),

                                Consumer<HomeProvider>(
                                  builder: (context,val,child) {
                                    return InkWell(
                                      onTap: () {
                                        homeProvider.showBottomSheet(context);
                                      },
                                      child: Consumer<HomeProvider>(
                                          builder: (context, val, child) {
                                            return val.fileImage != null
                                                ? CircleAvatar(
                                              radius: 60,
                                              backgroundImage:
                                              FileImage(val.fileImage!),
                                            )
                                                : Container(
                                              padding:
                                              const EdgeInsets.only(top: 20),
                                              width: 105,
                                              height: 105,
                                              child: Image.asset(
                                                'assets/addenroller.png',
                                                scale: 3,
                                              ),
                                              decoration: const ShapeDecoration(
                                                color: Colors.white,
                                                shape: OvalBorder(),
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 6,
                                                    offset: Offset(0, 0),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                    );
                                  }
                                ),

                                SizedBox(height:10),

                                //Add Image Text
                                Text(
                                  'Add Image',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11.46,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(
                                  height: 30,
                                ),

                                //Name controller
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: TextFormField(
                                    controller: value5.entrollerNameCT,
                                    style: const TextStyle(
                                      color: myBlack,
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: myWhite,
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(28),
                                        ),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black12),
                                      ),
                                      // hintText: "Name",
                                      labelText: "Name",
                                      labelStyle: TextStyle(
                                        color: cl898989,
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        // height: 0.94,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(28),
                                        ),
                                        borderSide: BorderSide(
                                            width: 0.50, color: Colors.black12),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(28),
                                        ),
                                        borderSide: BorderSide(
                                            width: 0.50, color: Colors.black12),
                                      ),

                                      // border:  InputBorder.none,
                                      // hintText: "Name",
                                      // hintStyle:const TextStyle(
                                      //   color: cl898989,
                                      //   fontSize: 13,
                                      //   fontFamily: 'Poppins',
                                      //   fontWeight: FontWeight.w600,
                                      // ),
                                      // enabledBorder:borderKnm,
                                      // focusedBorder:borderKnm
                                    ),
                                    validator: (text) => text!.trim().isEmpty
                                        ? "Name cannot be blank"
                                        : null,
                                  ),
                                ),

                                const SizedBox(height: 10,),

                                //Mobile Number controller
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: TextFormField(
                                      controller: value5.entrollerPhoneCT,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10)
                                      ],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 14),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:myWhite,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                        border:  OutlineInputBorder(
                                          borderRadius:BorderRadius.all(Radius.circular(28),),
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.black12),
                                        ),
                                        // hintText: "Name",
                                        labelText: "Mobile Number",
                                        labelStyle:TextStyle(
                                          color: cl898989,
                                          fontSize: 13,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          // height: 0.94,
                                        ),
                                        focusedBorder:OutlineInputBorder(
                                          borderRadius:BorderRadius.all(Radius.circular(28),),
                                          borderSide: BorderSide(
                                              width: 0.50, color:Colors.black12),
                                        ),
                                        enabledBorder:OutlineInputBorder(
                                          borderRadius:BorderRadius.all(Radius.circular(28),),
                                          borderSide: BorderSide(
                                              width: 0.50, color:Colors.black12),
                                        ),
                                        // enabledBorder:borderKnm,
                                        // focusedBorder:borderKnm
                                      ),
                                      validator: (text) {
                                        if (text!.isEmpty) {
                                          return "Phone Number cannot be blank";
                                        } else if (text.length != 10) {
                                          return "Phone Number Must be 10 letter";
                                        } else {
                                          return null;
                                        }
                                      }),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                // Padding(
                                //   padding: const EdgeInsets.symmetric(vertical: 10),
                                //   child: SizedBox(
                                //     height: 68,
                                //     child: TextFormField(
                                //         controller: value5.entrollerPlaceCT,
                                //         keyboardType: TextInputType.text,
                                //         decoration: InputDecoration(
                                //           // labelText: "Place",
                                //           contentPadding: const EdgeInsets.symmetric(
                                //               horizontal: 17),
                                //           enabledBorder: border2,
                                //           focusedBorder: border2,
                                //           border: border2,
                                //         ),
                                //         validator: (text) {
                                //           if (text!.isEmpty) {
                                //             return 'Enter your Place';
                                //           } else {
                                //             return null;
                                //           }
                                //         }),
                                //   ),
                                // ),
                                //Panchayath / Unit
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Consumer<DonationProvider>(
                                      builder: (context, value, child) {
                                        return Autocomplete<PanjayathModel>(
                                          optionsBuilder:
                                              (TextEditingValue textEditingValue) {
                                            return (value.panjayathList)
                                                .where((PanjayathModel wardd) =>
                                                wardd.panjayath
                                                    .toLowerCase()
                                                    .contains(textEditingValue
                                                    .text
                                                    .toLowerCase()))
                                                .toList();
                                          },
                                          displayStringForOption:
                                              (PanjayathModel option) =>
                                          option.panjayath,
                                          fieldViewBuilder: (BuildContext context,
                                              TextEditingController
                                              fieldTextEditingController,
                                              FocusNode fieldFocusNode,
                                              VoidCallback onFieldSubmitted) {
                                            return TextFormField(
                                              scrollPadding: const EdgeInsets.only(bottom: 500),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor:myWhite,
                                                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                                border:  OutlineInputBorder(
                                                  borderRadius:BorderRadius.all(Radius.circular(28),),
                                                  borderSide: BorderSide(
                                                      width: 1, color: Colors.black12),
                                                ),
                                                // hintText: "Name",
                                                labelText: "Panchayath",
                                                labelStyle:TextStyle(
                                                  color: cl898989,
                                                  fontSize: 13,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  // height: 0.94,
                                                ),
                                                focusedBorder:OutlineInputBorder(
                                                  borderRadius:BorderRadius.all(Radius.circular(28),),
                                                  borderSide: BorderSide(
                                                      width: 0.50, color:Colors.black12),
                                                ),
                                                enabledBorder:OutlineInputBorder(
                                                  borderRadius:BorderRadius.all(Radius.circular(28),),
                                                  borderSide: BorderSide(
                                                      width: 0.50, color:Colors.black12),
                                                ),
                                                // enabledBorder:borderKnm,
                                                // focusedBorder:borderKnm
                                              ),
                                              controller: fieldTextEditingController,
                                              focusNode: fieldFocusNode,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: myBlack,
                                                  fontSize: 13),
                                              validator: (value2) {
                                                if (value2!.trim().isEmpty ||
                                                    !value.panjayathList
                                                        .map((item) =>
                                                    item.panjayath)
                                                        .contains(value2)) {
                                                  return "Please Select Your panchayath";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (text) {
                                                homeProvider
                                                    .enrollerDistrictCT.text = "";
                                                homeProvider
                                                    .enrollerAssemblyCT.text = "";
                                                homeProvider
                                                    .enrollerPanchayathCT.text = "";
                                              },
                                            );
                                          },
                                          onSelected: (PanjayathModel selection) {
                                            print(selection.assembly.toString() +
                                                "wwwwiefjmf");
                                            homeProvider
                                                .onSelectVolunteerPanchayath(
                                                selection);
                                            // donationProvider.onSelectAssembly(selection);
                                          },
                                          optionsViewBuilder: (BuildContext context,
                                              AutocompleteOnSelected<PanjayathModel>
                                              onSelected,
                                              Iterable<PanjayathModel> options) {
                                            return Align(
                                              alignment: Alignment.topLeft,
                                              child: Material(
                                                child: Container(
                                                  width: width - 30,
                                                  height: 400,
                                                  color: Colors.white,
                                                  child: ListView.builder(
                                                    padding:
                                                    const EdgeInsets.all(10.0),
                                                    itemCount: options.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                        int index) {
                                                      final PanjayathModel option =
                                                      options.elementAt(index);
                                                      return GestureDetector(
                                                        onTap: () {
                                                          onSelected(option);
                                                        },
                                                        child: Container(
                                                          color: Colors.white,
                                                          height: 50,
                                                          width: width - 30,
                                                          child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                    option
                                                                        .panjayath,
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                                Text(
                                                                  option.district,
                                                                  style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                      12),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10)
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
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 30),
                                  child: Consumer<HomeProvider>(
                                      builder: (context, value3, child) {
                                        return InkWell(
                                          onTap: () async {

                                            final FormState? form = _formKey.currentState;
                                            if (form!.validate()) {
                                              // if (value3.fileImage != null) {
                                              HomeProvider homeProvider =
                                              Provider.of<HomeProvider>(
                                                  context,
                                                  listen: false);
                                              await homeProvider
                                                  .enrollerExistCheck(value3
                                                  .entrollerPhoneCT.text
                                                  .toString());
                                              print("asdfgwose" +
                                                  value3.checkEnrollerExist
                                                      .toString());

                                              if (value3.checkEnrollerExist) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      "Volunteer Already Exist"),
                                                  duration: Duration(
                                                      milliseconds: 3000),
                                                ));
                                              } else {

                                                // volunteerRegAlert(
                                                //     context,
                                                //     value3.entrollerNameCT.text
                                                //         .toString(),
                                                //     value3.entrollerPhoneCT.text
                                                //         .toString(),
                                                //     value3
                                                //         .enrollerPanchayathCT.text
                                                //         .toString());


                                                ///ameen commented
                                                confirmationAlert(
                                                    context,
                                                    value3.entrollerNameCT.text
                                                        .toString(),
                                                    value3.entrollerPhoneCT.text
                                                        .toString(),
                                                    value3
                                                        .enrollerPanchayathCT.text
                                                        .toString());

                                              }
                                              // }else{
                                              //   print('  IVNIRVNRV');
                                              //   ScaffoldMessenger.of(context)
                                              //       .showSnackBar(const SnackBar(
                                              //     backgroundColor: Colors.red,
                                              //     content:
                                              //     Center(child: Text("Please Upload Photo")),
                                              //     duration:
                                              //     Duration(milliseconds: 3000),
                                              //   ));
                                              // }

                                            }
                                          },
                                          child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  .80,
                                              decoration: const BoxDecoration(
                                                // image: DecorationImage(
                                                //   image: AssetImage(
                                                //     "assets/vaqassets/contribute.png",
                                                //   ),
                                                //   fit: BoxFit.fill,
                                                // ),
                                                gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color(0xFF262C5C),
                                                    Color(0xFF424CA0)
                                                  ],
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: cl1883B2,
                                                  ),
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: .1,
                                                    offset: Offset(1, 2),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(19)),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Register as Volunteer",
                                                  style: TextStyle(
                                                    color: myWhite,
                                                    fontSize: 15,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  )));
        }));
  }

  Future<AlertDialog?> confirmationAlert(
      BuildContext context, String name, String phone, String place) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<HomeProvider>(builder: (context, value6, child) {
          return AlertDialog(
            title: const Center(
              child: Text(
                "Confirmation",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            backgroundColor: myWhite,
            contentPadding: const EdgeInsets.only(
              top: 15.0,
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            content: Consumer<HomeProvider>(builder: (context, value2, child) {
              return SizedBox(
                // width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8),
                      child: Text(
                        "*" +
                            "Volunteer details cannot be changed once they are saved",
                        style: TextStyle(
                            color: myRed,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 120,
                              child: Text(
                                "Volunteer ID ",
                                style: gray12white,
                              )),
                          Text(
                            ": ",
                            style: gray12white,
                          ),
                          SizedBox(
                              width: width / 2.8,
                              child: Text(
                                phone,
                                style: gray16White,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 120,
                              child: Text(
                                "Volunteer Name ",
                                style: gray12white,
                              )),
                          Text(
                            ": ",
                            style: gray12white,
                          ),
                          SizedBox(
                              width: width / 2.8,
                              child: Text(
                                name,
                                style: gray16White,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 120,
                              child: Text(
                                "Volunteer Place ",
                                style: gray12white,
                              )),
                          Text(
                            ": ",
                            style: gray12white,
                          ),
                          SizedBox(
                              width: width / 2.8,
                              child: Text(
                                place,
                                style: gray16White,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                                  // color: Color(0xff050066),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [Colors.black, Colors.green])),
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
                        const SizedBox(
                          width: 10,
                        ),
                        Consumer<HomeProvider>(
                            builder: (context,value3,child) {
                              return InkWell(
                                onTap: () {
                                  HomeProvider homeProvider =
                                  Provider.of<HomeProvider>(context,
                                      listen: false);
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  homeProvider.addEnrollers(context);
                                  callNextReplacement(HomeScreenNew(loginUserPhone: loginUserPhone,
                                      loginUserID: loginUserID,loginUsername: loginUsername,
                                      subScriberType: subScriberType, zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                    sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                    foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                                  volunteerRegAlert(
                                      context,
                                      value3.entrollerNameCT.text
                                          .toString(),
                                      value3.entrollerPhoneCT.text
                                          .toString(),
                                      value3
                                          .enrollerPanchayathCT.text
                                          .toString());
                                },
                                child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    decoration: const BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(35)),
                                        // color: Color(0xff050066),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [Colors.black, Colors.green])),
                                    child: const Center(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                              );
                            }
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            }),
          );
        });
      },
    );
  }

  OutlineInputBorder border2 = OutlineInputBorder(
      borderSide: BorderSide(color: textfieldTxt.withOpacity(0.1)),
      borderRadius: BorderRadius.circular(30));
}

final OutlineInputBorder borderKnm = OutlineInputBorder(
  borderSide: const BorderSide(color: clD4D4D4, width: 1.0),
  borderRadius: BorderRadius.circular(50),
);

volunteerRegAlert(BuildContext context,String name,String phone,String place) {
  AlertDialog alert = AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(21))),
    backgroundColor: Colors.transparent,
    actions: [
      Consumer<HomeProvider>(
          builder: (context,value,child) {
            return
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(21),),
                  color: Colors.white,
                  image: DecorationImage(
                      image:AssetImage("assets/vaqassets/BGshapes.png"),
                      fit:BoxFit.cover
                  ),


                ),
                width: 450,
                // height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    const SizedBox(
                      height: 15,
                    ),

                    Consumer<HomeProvider>(
                        builder: (context,val,child) {
                          return val.fileImage != null
                              ? CircleAvatar(
                            radius: 60,
                            backgroundImage:
                            FileImage(val.fileImage!),
                          ): Container(
                            padding:
                            const EdgeInsets.only(top: 10),
                            width: 80,
                            height: 80,
                            child: Image.asset(
                              'assets/addenroller.png',
                              scale: 3,
                            ),
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: OvalBorder(),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          );
                        }
                    ),

                    const SizedBox(
                      height: 15,
                    ),



                    Image.asset('assets/vaqassets/nanumvolunteeraayi.png',scale: 2,),

                    const SizedBox(
                      height: 40,
                    ),


                    Container(
                      // height: 100,
                      decoration: ShapeDecoration(
                        color: Color(0x35E9ECFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),


                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      " Name            : ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: myBlack,
                                      )),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                        Text(place ,style:  TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color: Colors.black),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                // alignment: WrapAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(" Volunteer ID  : ", style: TextStyle(
                                    fontSize: 16,
                                    color: myBlack,
                                  )),
                                  // RichText(
                                  //     text: TextSpan(
                                  //       children: [
                                  //         const TextSpan(
                                  //             text: "Volunteer ID  : ",
                                  //             style: TextStyle(
                                  //               fontSize: 16,
                                  //               color: myBlack,
                                  //             )),
                                  //         TextSpan(
                                  //           text: phone,
                                  //           style: const TextStyle(
                                  //               fontWeight: FontWeight.w600,
                                  //               fontFamily: "Poppins",
                                  //               fontSize: 14,
                                  //               color: Colors.black),
                                  //           recognizer: new TapGestureRecognizer()
                                  //             ..onTap = () {
                                  //               Clipboard.setData(
                                  //                   new ClipboardData(text: "id"))
                                  //                   .then((_) {
                                  //                 ScaffoldMessenger.of(context)
                                  //                     .showSnackBar(const SnackBar(
                                  //                   backgroundColor: myWhite,
                                  //                   content: Text(
                                  //                     "Copied ID !",
                                  //                     style: TextStyle(color: myBlack),
                                  //                   ),
                                  //                 ));
                                  //               });
                                  //             },
                                  //         ),
                                  //       ],
                                  //     )),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Row(
                                      // crossAxisAlignment: WrapCrossAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:[
                                          InkWell(
                                            onTap:(){
                                              Clipboard.setData(
                                                  new ClipboardData(text: "id"))
                                                  .then((_) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                  backgroundColor: myWhite,
                                                  content: Text(
                                                    "Copied ID !",
                                                    style: TextStyle(color: myBlack),
                                                  ),
                                                ));
                                              });
                                            },
                                            child: Text(phone,style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              // fontFamily: "Poppins",
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                            ),
                                          ),

                                          // SizedBox(width:5),

                                          InkWell(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(text: "aaaaaaaaaaaaaaaaaaaaaa"))
                                                  .then((_) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                  backgroundColor: myWhite,
                                                  content: Text(
                                                    "Copied ID !",
                                                    style: TextStyle(color: myBlack),
                                                  ),
                                                ));
                                              });
                                            },
                                            child: Container(
                                              width: 47,
                                              height: 30,
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                              decoration: ShapeDecoration(
                                                color: Color(0xFFEEEFFF),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(37),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 1),
                                                    child: Text(
                                                      'Copy',
                                                      style: TextStyle(
                                                        color: Color(0xFF3F4898),
                                                        fontSize: 10,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // const Icon(
                                            //   Icons.content_copy,
                                            //   color: myBlack,
                                            //   size: 25,
                                            // ),
                                          ),
                                        ]
                                    ),
                                  )

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          // flex: 1,
                            child: InkWell(
                              onTap: () {
                                finish(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                height: 40,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment(-1.00, 0.00),
                                    end: Alignment(1, 0),
                                    colors: [Color(0xFF212461), Color(0xFF006C9E)],
                                  ),

                                  // color: cl2C4680,
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Text(
                                  "OK",
                                  style: white16,
                                ),
                              ),
                            )),
                      ],
                    ),


                  ],
                ),
              );
          }
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
