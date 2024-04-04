import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/donate_page.dart';
import '../Screens/no_paymet_gatway.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';

class PatientSposershipHomeScreen extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
   PatientSposershipHomeScreen({Key? key,required this.loginUsername,
     required this.loginUserID,required this.subScriberType,required this.loginUserPhone,
     required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,
   }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myWhite,
        elevation: 0,
        leading: InkWell(onTap: (){
          finish(context);
        },
          child: CircleAvatar(
              radius: 22,
              backgroundColor:myWhite.withOpacity(0.5),
              child: const Icon(Icons.arrow_back_ios_new_outlined,size: 15,color: myBlack,)),
        ),
        centerTitle: true,
        title: const Text("Patient Sponsorship",style: TextStyle(color:myBlack, fontFamily: 'Poppins',
          fontSize: 15,fontWeight: FontWeight.w600,),
        ),
      ),
      backgroundColor: Colors.white,
      body: SizedBox(width: width,height: height,
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*0.03,),
              Consumer<DonationProvider>(
                builder: (context,value,child) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.sponsershipDiseaseList.length,
                  itemBuilder: (context, index) {
                    var item=value.sponsershipDiseaseList[index];
                    print(index.toString()+' vjufoiv'+item.assetPath);
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0,left: 10,right: 10),
                        child: Container(
                          // height: height*0.3,
                          width: width*0.85,
                          decoration: ShapeDecoration(
                            // color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              side:   BorderSide(
                                color: item.selectionBool==true?myGreen:Colors.white,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(18.04),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 5.15,
                                offset: Offset(0, 2.58),
                                spreadRadius: 0,
                              )
                            ],
                          ),child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        color: Color(0xFF3E4FA3),
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Image.asset(item.assetPath,scale: index==1?1:2,),
                                    SizedBox(height: 10,),
                                    Container(
                                      width: width / 3,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                donationProvider.decrementDiseasePrice(index);
                                              },
                                              child: Container(
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    color: cl_F5F5F5,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(8)),
                                                height: 25,
                                                child: Icon(
                                                  CupertinoIcons.minus,
                                                  color: cl_253068,
                                                  size: 12,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              item.count.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize: 11),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                donationProvider.incrementDiseasePrice(index);
                                              },
                                              child: Container(
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    color: cl_F5F5F5,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(8)),
                                                height: 25,
                                                child: Icon(
                                                  CupertinoIcons.add,
                                                  color: cl_253068,
                                                  size: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10,)

                                  ],
                                ),
                              ),
                              Align(alignment: Alignment.topRight,
                                  child: Container(height: 30,width: 70,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2D8D00),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(18.04),
                                        bottomLeft:  Radius.circular(15),
                                        topLeft:  Radius.circular(15),
                                      )
                                    ),
                                    child: Center(child: Text(item.price.toString(),style: TextStyle(color: Colors.white),)),
                                   ))

                            ],
                          ),
                        ),
                      ),
                    );
                  });
                }
              ),

              SizedBox(height: height*0.03,),
              Container(
                // height: height*0.15,
              width: width*.85,
                decoration: ShapeDecoration(
                  color: Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      'Price Details',
                      style: TextStyle(
                        color: Color(0xFF3E4FA3),
                        fontSize: 14,
                        fontFamily: 'Jaldi',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                      SizedBox(height: 10,),
                      Consumer<DonationProvider>(
                        builder: (context,value,child) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.sponsershipDiseaseList.length,
                              itemBuilder: (context, index) {
                                var item=value.sponsershipDiseaseList[index];
                               return item.count>0?
                               Padding(
                                  padding: const EdgeInsets.only(bottom:5.0),
                                  child: Container(
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(item.name),
                                        Row(
                                          children: [
                                            Text(item.count.toString()+'*'),
                                            Text(item.price.toString()),
                                          ],
                                        ),
                                      ],
                                    ),),
                                ):SizedBox();
                              });
                        }
                      ),
                      SizedBox(height: 10,),
                      Row(children: [
                        Text(
                          "Total Amount",
                          style: TextStyle(
                              color: cl_3F50A4,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins'),
                        ),
                        Spacer(),
                        Consumer<DonationProvider>(
                          builder: (context,value,vhild) {
                            return Text(
                              value.getTotalSposership().toStringAsFixed(0),
                              style: TextStyle(
                                  color: cl_3F50A4,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins'),
                            );
                          }
                        )
                      ])
                  ],),
                ),
              ),
              SizedBox(height: height*0.03,),
              Consumer<DonationProvider>(
                  builder: (context,value,child) {
                    return Container(
                      // height: height / 8.7,
                      width: width*0.85,
                      decoration: BoxDecoration(
                          color: cl_F5F5F5, borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                          value.getAmount(value.getTotalSposership()),
                                  style: TextStyle(
                                      color: cl_3F50A4,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'JaldiBold'),
                                ),
                                Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins'),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                print(value.getTotalEquipmentAmount().toStringAsFixed(0)+' DUEDUEDUD');
                                if(value.getTotalSposership()>0){
                                  mRoot
                                      .child('0')
                                      .child('PaymentGateway36')
                                      .onValue
                                      .listen((event) {
                                    if (event.snapshot.value.toString() == 'ON') {
                                      DonationProvider donationProvider =
                                      Provider.of<DonationProvider>(context,
                                          listen: false);
                                      donationProvider.amountTC.text = "";
                                      donationProvider.nameTC.text = "";
                                      donationProvider.phoneTC.text = "";
                                      value.kpccAmountController.text=value.getTotalSposership().toStringAsFixed(0);
                                      donationProvider.onAmountChange('');
                                      donationProvider.clearGenderAndAgedata();
                                      donationProvider.selectedPanjayathChip = null;
                                      donationProvider.chipsetWardList.clear();
                                      donationProvider.selectedWard = null;
                                      '1';
                                      donationProvider.minimumbool = true;
                                      donationProvider.clearDonateScreen();
                                      callNext(
                                          DonatePage(loginUserPhone: loginUserPhone,paymentCategory: 'SPONSOR_PATIENT',
                                            equipmentCount: value.sponsershipDiseaseList.where((element) => element.selectionBool==true).first.count.toString(),
                                            equipmentID: value.sponsershipDiseaseList.where((element) => element.selectionBool==true).first.name.toString(),
                                            oneEquipmentPrice: value.sponsershipDiseaseList.where((element) => element.selectionBool==true).first.price.toString(),
                                              loginUserID: loginUserID,loginUsername: loginUsername,subScriberType: subScriberType,
                                            zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                            sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                            foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount,monthList: [],
                                          )
                                          ,
                                          context);
                                    } else {
                                      callNext( NoPaymentGateway(loginUserPhone: loginUserPhone,loginUserID: loginUserID,
                                          loginUsername: loginUsername,subScriberType: subScriberType,
                                        zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                        sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                        foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                                    }
                                  });
                                }else{
                                  const snackBar = SnackBar(
                                    content: Center(child: Text('Please select a Patient',style: TextStyle(color: Colors.white),)),
                                    backgroundColor: Colors.redAccent,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                }

                              },
                              child: Container(
                                width: width / 2.2,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(34),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [cl_3F50A4, cl_253068],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
