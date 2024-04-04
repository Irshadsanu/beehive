import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../Screens/district_report.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/home_provider.dart';
import 'admin_upiList_screen.dart';


class AdminHomeScreen extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
   AdminHomeScreen({Key? key,required this.loginUsername,
     required this.loginUserID,required this.subScriberType,required this.loginUserPhone,
     required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondary,
          title:const Padding(
            padding:  EdgeInsets.only(left: 20.0),
            child: Text("Select App",style: TextStyle(fontSize: 22),),
          ),
          automaticallyImplyLeading: false,
        ),
        
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.08,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          homeProvider.getUpiIdListAdmin();
                          homeProvider.getModeListAdmin();
                          homeProvider.fetchUpiDetails("BHIM");

                          callNext(AdminUpiListScreen(loginUserPhone: loginUserPhone,loginUserID: loginUserID,loginUsername: loginUsername,from: "BHIM",subScriberType: subScriberType), context);
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(border: Border.all(color: myGray)),
                         child: Image.asset("assets/bhim.png",),
                        ),
                      ),
                     const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text("BHIM",style: TextStyle(color: myBlack,fontSize: 17),),
                      )
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.25,),
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          homeProvider.getUpiIdListAdmin();
                          homeProvider.getModeListAdmin();
                          homeProvider.fetchUpiDetails("BHIM2000");
                          callNext(AdminUpiListScreen(loginUserPhone: loginUserPhone,loginUserID: loginUserID,loginUsername: loginUsername,from:"BHIM2000",subScriberType: subScriberType), context);
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(border: Border.all(color: myGray)),
                          child: Image.asset("assets/bhim.png",),
                        ),
                      ),
                     const Padding(
                        padding:  EdgeInsets.only(top: 8.0),
                        child:  Text("BHIM2000",style: TextStyle(color: myBlack,fontSize: 17)),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.08,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          homeProvider.getUpiIdListAdmin();
                          homeProvider.getModeListAdmin();
                          homeProvider.fetchUpiDetails("GPay");

                          callNext(AdminUpiListScreen(loginUserPhone: loginUserPhone,loginUserID: loginUserID,loginUsername: loginUsername,from:"GPay",subScriberType: subScriberType), context);
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(border: Border.all(color: myGray)),
                          child: Image.asset("assets/gpay.png",),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text("GPay",style: TextStyle(color: myBlack,fontSize: 17),),
                      )
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.25,),
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          homeProvider.getUpiIdListAdmin();
                          homeProvider.getModeListAdmin();
                          homeProvider.fetchUpiDetails("GPay2000");

                          callNext(AdminUpiListScreen(loginUserPhone: loginUserPhone,loginUserID: loginUserID,loginUsername: loginUsername,from:"GPay2000",subScriberType: subScriberType), context);
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(border: Border.all(color: myGray)),
                          child: Image.asset("assets/gpay.png",),
                        ),
                      ),
                      const Padding(
                        padding:  EdgeInsets.only(top: 8.0),
                        child:  Text("GPay2000",style: TextStyle(color: myBlack,fontSize: 17)),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.08,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          homeProvider.getUpiIdListAdmin();
                          homeProvider.getModeListAdmin();
                          homeProvider.fetchUpiDetails("Paytm");

                          callNext(AdminUpiListScreen(loginUserPhone: loginUserPhone,loginUserID: loginUserID,loginUsername: loginUsername,from:"Paytm",subScriberType: subScriberType), context);
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(border: Border.all(color: myGray2)),
                          child: Image.asset("assets/paytm.png",),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text("Paytm",style: TextStyle(color: myBlack,fontSize: 17),),
                      )
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.25,),
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          homeProvider.getUpiIdListAdmin();
                          homeProvider.getModeListAdmin();
                          homeProvider.fetchUpiDetails("Paytm2000");

                          callNext(AdminUpiListScreen(loginUserPhone: loginUserPhone,loginUserID: loginUserID,loginUsername: loginUsername,from:"Paytm2000",subScriberType: subScriberType), context);
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(border: Border.all(color: myGray2)),
                          child: Image.asset("assets/paytm.png",),
                        ),
                      ),
                      const Padding(
                        padding:  EdgeInsets.only(top: 8.0),
                        child:  Text("Paytm2000",style: TextStyle(color: myBlack,fontSize: 17)),
                      ),

                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return InkWell(
                      onTap: (){
                        homeProvider.addDistrictOtherAmount();
                        homeProvider.fetchDistrictWiseReport();
                        callNext( DistrictReport(loginUserPhone: loginUserPhone,from: 'ADMIN',
                            loginUserID: loginUserID,
                            loginUsername: loginUsername,
                            subScriberType: subScriberType,
                          foodkitAmount: foodkitAmount,
                          deseaseName: deseaseName,
                          equipmentAmount:equipmentAmount ,
                          foodkitPrice: foodkitPrice,
                          footkitCount: footkitCount,
                          sponsorCategory: sponsorCategory,
                          sponsorCount: sponsorCount,
                          sponsorItemOnePrice: sponsorItemOnePrice,
                          sponsorPatientAmonut: sponsorPatientAmonut,
                          zakathAmount: zakathAmount,
                        ), context);

                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.06,
                        width: MediaQuery.of(context).size.width*0.9,
                        decoration: BoxDecoration(
                            color: secondary,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Center(
                            child: Text("Click here to District Report",
                              style: TextStyle(
                                  color: myWhite,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),)),
                      ),
                    );
                  }
              ),
              SizedBox(height: 20,),



              Consumer<HomeProvider>(
                builder: (context,value,child) {
                  return SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      // shadowColor: myGray,
                      margin: const EdgeInsets.all(10),
                      // color: textfieldBg,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10),
                        child: Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return (value.adminViewDistrictList)
                                .where((String wardd) => wardd.toLowerCase()
                                .contains(textEditingValue.text.toLowerCase())).toList();
                          },
                          displayStringForOption: (String option) => option,
                          fieldViewBuilder: (
                              BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted
                              ) {

                            return TextField(

                              textAlign: TextAlign.center,
                              decoration:  InputDecoration(
                                fillColor: Colors.white,
                                hintStyle: grayB12,
                                hintText:'Select District',
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: primary),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: primary),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: primary),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: primary),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                              ),
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            );
                          },
                          onSelected: (String selection) {
                            value.adminDistrictNameCT.text=selection;
                            homeProvider.clearAdminDistricttotal();
                          },
                          optionsViewBuilder: (
                              BuildContext context,
                              AutocompleteOnSelected<String> onSelected,
                              Iterable<String> options
                              ) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  width: width-30,
                                  height: 300,
                                  color: Colors.white,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(10.0),
                                    itemCount: options.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final String option = options.elementAt(index);

                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child:  Container(
                                          color: Colors.white,
                                          height: 50,
                                          width: width-30,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(option,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 10)
                                              ]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                      ),
                    ),
                  );
                }
              ),
              Consumer<HomeProvider>(
                builder: (context,value,child) {
                  return InkWell(
                    onTap: (){
                      homeProvider.adminViewDistrictTotal(value.adminDistrictNameCT.text.toString());
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.06,
                      width: MediaQuery.of(context).size.width*0.4,
                      decoration: BoxDecoration(
                          color: secondary,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: const Center(
                          child: Text("Ok",
                            style: TextStyle(
                                color: myWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),)),
                    ),
                  );
                }
              ),
              SizedBox(height: 35,),
              Column(
                children: [
                  Consumer<HomeProvider>(
                      builder: (context,value,child) {
                        return value.totalAmount!=0.0?
                        Text('₹ '+value.totalAmount.toString(),style: TextStyle(color: Colors.green, fontFamily: 'Montserrat',fontWeight: FontWeight.bold,fontSize: 32),):SizedBox();
                      }
                  ),
                  SizedBox(height: 25,),

                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height *0.3,),
            ],
          ),
        )
      ),
    );
  }
}
