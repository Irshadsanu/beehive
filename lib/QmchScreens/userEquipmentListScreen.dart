import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../QMCHAdminScreens/equipment_List.dart';
import '../Screens/donate_page.dart';
import '../Screens/no_paymet_gatway.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';

class UserEquipmentListScreen extends StatelessWidget {
  String paymentCategory; String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  UserEquipmentListScreen({Key? key, required this.paymentCategory,
    required this.loginUsername,required this.loginUserID,
    required this.subScriberType,required this.loginUserPhone,
    required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
    required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
    ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,})
      : super(key: key);

  List<String> names = ['Wheel Chair'];
  List<String> images = ["assets/wheelchair.png"];
  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
    FirebaseFirestore db = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: myWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: myWhite,
        centerTitle: true,
        leading: Center(
          child: InkWell(
            onTap: (){
              finish(context);
            },
            child: CircleAvatar(
              radius: 19,
              backgroundColor: myBlack.withOpacity(0.05),
              child: const Padding(
                padding: EdgeInsets.only(left:5.0),
                child: Icon(Icons.arrow_back_ios,color:myBlack,size: 22,),
              ),
            )
          ),
        ),
        title: const Text(
          "Equipment's",
          style: TextStyle(
              color: myBlack,
              fontSize: 15,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "PATIENT SUPPORTING EQUIPMENTS",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins',
                    color: cl253068),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<DonationProvider>(builder: (context, value, child) {
                return SizedBox(
                  width: width / 0.8,
                  // height: height * 0.8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing:10,
                                  mainAxisSpacing: 10,
                                  mainAxisExtent: 210),
                          itemCount: value.filterEquipmentsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = value.filterEquipmentsList[index];
                            return Container(
                              // height: 175,
                              decoration: ShapeDecoration(
                                color: clF5F5F5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7),
                                side: BorderSide(color: item.selectedCount>0?Colors.green:Colors.white)),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          height:70,
                                            width:width*.25,
                                            child: Image.network(item.photo,),
                                        ),

                                        SizedBox(
                                          height: 20,
                                          child: Center(
                                            child: Text(
                                              item.equipmentName,
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Lato',
                                                  color: cl_253068),
                                            ),
                                          ),
                                        ),
                                        // const SizedBox(height: 8),
                                        Text(item.collectedCount.toString() +
                                            '/' +
                                            item.requeredCount.toString()),
                                        // const SizedBox(height: 8),
                                        PercentageIndicator(
                                            percentage: (item.collectedCount/item.requeredCount)*100),
                                        Container(
                                          width: width / 3,
                                          height: 30,
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
                                                    donationProvider
                                                        .equipmentCountDecrease(
                                                      item.requeredCount,
                                                      index,
                                                      item.collectedCount,
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: cl_F5F5F5,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    height: 25,
                                                    child: const Icon(
                                                      CupertinoIcons.minus,
                                                      color: cl_253068,
                                                      size: 12,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  item.selectedCount.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    print(' Clickeddddd.............');
                                                    donationProvider
                                                        .equipmentCountIncrease(
                                                      item.requeredCount,
                                                      index,
                                                      item.collectedCount,
                                                        item.collectedCount+item.selectedCount
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: cl_F5F5F5,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    height: 25,
                                                    child: const Icon(
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
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 18,
                                    child: Container(
                                      padding:const EdgeInsets.symmetric(horizontal:10),
                                      // width: width / 7,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: cl_2D8E00, // Change color as needed
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: Text(
                                          "₹" + item.equipmentPrice,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'JaldiBold'),
                                        ), // Change the icon as needed
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Consumer<DonationProvider>(
                          builder: (context,value,child) {
                            print(value.equipmentCount.toString()+' '+value.filterEquipmentsList.length.toString()+' CCC VV ');
                            return
                              value.equipmentCount<=value.filterEquipmentsList.length &&value.filterEquipmentsList.length>0?
                            InkWell(
                              onTap: () {
                                donationProvider.fetchEquipment(
                                    false,
                                    value
                                        .filterEquipmentsList[
                                            value.filterEquipmentsList.length - 1].addedTime);
                              },
                              child: Container(
                                height: 40,
                                width: 250,
                                color: Colors.deepPurple,
                                child: const Center(
                                    child: Text(
                                  'Load More',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ):const SizedBox();
                          }
                        )
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: width,
                decoration: BoxDecoration(
                    color: cl_F5F5F5, borderRadius: BorderRadius.circular(7)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Price Details",
                        style: TextStyle(
                            color: cl_3F50A4,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'JaldiBold'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<DonationProvider>(
                        builder: (context,value,child) {
                          return Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.filterEquipmentsList.length,
                                  itemBuilder: (context, index) {
                                    var item = value.filterEquipmentsList[index];
                                    return item.selectedCount>0?
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:10.0),
                                      child: Container(
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(item.equipmentName),
                                          Text((item.selectedCount.toStringAsFixed(0)+'*'+double.parse(item.equipmentPrice).toStringAsFixed(0))),
                                        ],
                                      ),),
                                    ):const SizedBox();
                                  }),
                              Row(children: [
                                const Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      color: cl_3F50A4,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins'),
                                ),
                                const Spacer(),
                                Text(
                                  value.getTotalEquipmentAmount().toStringAsFixed(0),
                                  style: const TextStyle(
                                      color: cl_3F50A4,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins'),
                                )
                              ]),
                            ],
                          );
                        }
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<DonationProvider>(
                builder: (context,value,child) {
                  return Container(
                    // height: height / 8.7,
                    width: width,
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
                     value.getAmount(value.getTotalEquipmentAmount()),
                                style: const TextStyle(
                                    color: cl_3F50A4,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'JaldiBold'),
                              ),
                              const Text(
                                "Total Amount",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins'),
                              ),
                            ],
                          ),

                          Consumer<DonationProvider>(
                            builder: (context,value,child) {
                              return InkWell(
                                onTap: () {
                                  if(value.getTotalEquipmentAmount()>0){
                                    db.collection('EQUIPMENTS').doc(value.filterEquipmentsList.where((element) => element.selectedBool==true).first.id.toString()).get().then((value1){
                                      if(value1.exists){
                                        Map<dynamic,dynamic> map=value1.data() as Map;
                                        if(double.parse(map['EQUIPMENT_COUNT'].toString())>double.parse(map['EQUIPMENT_COLLECTED_COUNT'].toString())){
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
                                              value.kpccAmountController.text=value.getTotalEquipmentAmount().toStringAsFixed(0);
                                              donationProvider.onAmountChange('');
                                              donationProvider.clearGenderAndAgedata();
                                              donationProvider.selectedPanjayathChip = null;
                                              donationProvider.chipsetWardList.clear();
                                              donationProvider.selectedWard = null;
                                              '1';
                                              donationProvider.minimumbool = true;
                                              donationProvider.clearDonateScreen();
                                              callNext(
                                                  DonatePage(loginUserPhone: loginUserPhone,paymentCategory: paymentCategory,
                                                      equipmentCount: value.filterEquipmentsList.where((element) => element.selectedBool==true).first.selectedCount.toString(),
                                                      equipmentID: value.filterEquipmentsList.where((element) => element.selectedBool==true).first.id.toString(),
                                                      oneEquipmentPrice: value.filterEquipmentsList.where((element) => element.selectedBool==true).first.equipmentPrice.toString(),
                                                      loginUserID: loginUserID,loginUsername: loginUsername,subScriberType: subScriberType, zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                                    sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                                    foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount,monthList: [],
                                                  ),
                                                  context);
                                            } else {
                                              callNext( NoPaymentGateway(loginUserPhone: loginUserPhone,loginUserID: loginUserID,loginUsername:
                                              loginUsername,subScriberType: subScriberType, zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                                sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                                foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                                            }
                                          });

                                        }else{
                                          const snackBar = SnackBar(
                                            content: Center(child: Text('Equipment collected as needed',style: TextStyle(color: Colors.white),)),
                                            backgroundColor: Colors.green,
                                          );

                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                        }
                                      }
                                    });

                                  }else{
                                    const snackBar = SnackBar(
                                      content: Center(child: Text('Please select Equipment',style: TextStyle(color: Colors.white),)),
                                      backgroundColor: Colors.redAccent,
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                  }

                                },
                                child: Container(
                                  width: 140,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(34),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [cl_3F50A4, cl_253068],
                                    ),
                                  ),
                                  child: const Center(
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
                              );
                            }
                          )
                        ],
                      ),
                    ),
                  );
                }
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
