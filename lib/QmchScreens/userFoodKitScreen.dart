import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Screens/donate_page.dart';
import '../Screens/no_paymet_gatway.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';

class UserFoodKitScreen extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
   UserFoodKitScreen({Key? key,required this.loginUsername,
     required this.loginUserID,required this.subScriberType,required this.loginUserPhone,
     required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: myWhite,
        centerTitle: true,
        leading: Center(
          child: InkWell(
            onTap:(){
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
        title: const Text("Food Kit",style: TextStyle(
            color: myBlack,
            fontSize: 15,
            fontFamily: 'PoppinsRegular',
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5
        ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: width*.90,
          child: ListView(
            children: [
              const SizedBox(height: 20,),

              Container(
                alignment: Alignment.topRight,
                height: 445,
                width: width,
                decoration: ShapeDecoration(
                  color: clE8EFF5,
                    image:const DecorationImage(
                        image:AssetImage("assets/foodKitImg.png"),
                      fit: BoxFit.cover
                    ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.04),
                  ),
                  shadows: [
                    const BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 5.15,
                      offset: Offset(0, 2.58),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child:Container(
                  alignment: Alignment.center,
                  width: 80,
                  height: 30,
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  margin: const EdgeInsets.only(right: 10,top: 10),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: cl2D8D00,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29),
                    ),
                  ),
                  child:    const FittedBox(
                    child: Text(
                      '₹ 500',
                      style: TextStyle(
                        color: myWhite,
                        fontSize: 15,
                        fontFamily: 'JaldiBold',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                )
              ),

              const SizedBox(height: 20,),

              Consumer<DonationProvider>(
                builder: (context,value,child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      InkWell(
                        onTap: (){
                          donationProvider.decrementFoodkit();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 35,
                          height: 35,
                          decoration: ShapeDecoration(
                            color: myWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38),
                            ),
                            shadows: [
                              const BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child:const Icon(Icons.remove,color: cl253068,),
                        ),
                      ),

                      const SizedBox(width: 15,),

                       Text(
                        value.footkitSponserList[0].count.toString(),
                        style: TextStyle(
                          color: cl182B18,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),

                      const SizedBox(width: 15,),

                      InkWell(
                        onTap: (){
                          donationProvider.incrementFoodKit();

                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: ShapeDecoration(
                            color: myWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38),
                            ),
                            shadows: [
                              const BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: const Icon(Icons.add,color: cl253068,),
                        ),
                      ),

                    ]
                  );
                }
              ),

              const SizedBox(height: 20,),


              Container(
                width: width,
                padding: const EdgeInsets.all(20),
                // height: 130,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Price Details',
                      style: TextStyle(
                        color: cl3E4FA3,
                        fontSize: 14,
                        fontFamily: 'JaldiBold',
                        fontWeight: FontWeight.w400,
                        height: 0.06,
                      ),
                    ),

                    const SizedBox(height: 10,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Consumer<DonationProvider>(
                              builder: (context,value,child) {
                                return  Text("Food Kit "+value.footkitSponserList[0].count.toString(),
                                  style: TextStyle(
                                    color: myBlack,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }
                            ),
                          ),
                        ),

                        const SizedBox(width: 10,),

                        Expanded(
                          flex:1,
                          child: Consumer<DonationProvider>(
                            builder: (context,value,child) {
                              return Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child:  Text.rich(
                                    value.footkitSponserList[0].count>0? TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "₹ ",
                                        style: TextStyle(
                                          color: myBlack,
                                          fontSize: 12,
                                          // fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          // height: 0.11,
                                        ),
                                      ),
                                       TextSpan(
                                          text:value.footkitSponserList[0].count.toString()+'*'+value.footkitSponserList[0].price.toString() ,style: TextStyle(
                                        color: myBlack,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        // height: 0.11,
                                      ),
                                      )
                                    ]
                                  ):TextSpan(
                                        children: [
                                          TextSpan(
                                            text: " ",
                                            style: TextStyle(
                                              color: myBlack,
                                              fontSize: 12,
                                              // fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              // height: 0.11,
                                            ),
                                          ),
                                          TextSpan(
                                            text:'',style: TextStyle(
                                            color: myBlack,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            // height: 0.11,
                                          ),
                                          )
                                        ]
                                    )
                                )

                              );
                            }
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text("Total Amount",
                              style: TextStyle(
                                color: cl3F50A4,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 0.08,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10,),

                        Expanded(
                          flex:1,
                          child: Consumer<DonationProvider>(
                            builder: (context,value,child) {
                              return Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child:  Text.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "₹ ",
                                              style: TextStyle(
                                                color: cl3F50A4,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextSpan(
                                              text: value.getAmount(value.getTotalfoodAmount()) ,style: TextStyle(
                                              color: cl3F50A4,
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 0.08,
                                            ),
                                            ),
                                          ]
                                      )
                                  )
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20,),

              Container(
                width: width,
                padding: const EdgeInsets.all(20),
                // height: 130,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: clF5F5F5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                ),
               child: Row(
                 children: [
                   Expanded(
                       flex:1,
                       child: Consumer<DonationProvider>(
                         builder: (context,value,child) {
                           return Container(
                             padding: const EdgeInsets.symmetric(vertical: 5),
                             child: Column(
                               children: [
                                  FittedBox(
                                   child: Text.rich(
                                       TextSpan(
                                           children: [
                                             TextSpan(
                                               text: "₹ ",
                                               style: TextStyle(
                                                 color: cl3F50A4,
                                                 fontSize: 20.48,
                                                 fontWeight: FontWeight.w400,
                                               ),
                                             ),
                                             TextSpan(
                                               text: value.getAmount(value.getTotalfoodAmount()) ,style:TextStyle(
                                               color: cl3E4FA3,
                                               fontSize: 20.48,
                                               fontFamily: 'JaldiBold',
                                               fontWeight: FontWeight.w400,
                                               height: 0,
                                             ),
                                             ),
                                           ]
                                       )
                                   ),
                                 ),

                                 const Text(
                                   'Total Amount',
                                   style: TextStyle(
                                     color: myBlack,
                                     fontSize: 12,
                                     fontFamily: 'Poppins',
                                     fontWeight: FontWeight.w500,
                                   ),
                                 ),
                               ],
                             ),
                   );
                         }
                       )),

                   const SizedBox(width:10),

                   Expanded(
                       flex:1,
                       child:
                       Consumer<DonationProvider>(
                         builder: (context,value,child) {
                           return InkWell(onTap: (){
                             if(value.getTotalfoodAmount()>0){
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
                                   value.kpccAmountController.text=value.getTotalfoodAmount().toStringAsFixed(0);
                                   donationProvider.onAmountChange('');
                                   donationProvider.clearGenderAndAgedata();
                                   donationProvider.selectedPanjayathChip = null;
                                   donationProvider.chipsetWardList.clear();
                                   donationProvider.selectedWard = null;
                                   '1';
                                   donationProvider.minimumbool = true;
                                   donationProvider.clearDonateScreen();
                                   callNext(
                                       DonatePage(loginUserPhone: loginUserPhone,paymentCategory: 'FOODKIT',
                                         equipmentCount: value.footkitSponserList[0].count.toString(),
                                         equipmentID: '',
                                         oneEquipmentPrice: value.footkitSponserList[0].price.toString(),
                                           loginUserID: loginUserID,loginUsername: loginUsername,subScriberType: subScriberType,
                                         zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                         sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                         foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount,monthList: [],
                                       ),
                                       context);
                                 } else {
                                   callNext( NoPaymentGateway(loginUserPhone: loginUserPhone,
                                       loginUserID: loginUserID,loginUsername: loginUsername,
                                       subScriberType: subScriberType, zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                     sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                     foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                                 }
                               });
                             }else{
                               const snackBar = SnackBar(
                                 content: Center(child: Text('Please select Food kit Count',style: TextStyle(color: Colors.white),)),
                                 backgroundColor: Colors.redAccent,
                               );

                               ScaffoldMessenger.of(context).showSnackBar(snackBar);
                             }

                           },
                             child: Container(
                               padding: const EdgeInsets.symmetric(vertical: 5),
                               child: Container(
                                 height: 50,
                                 decoration: BoxDecoration(
                                   boxShadow: [
                                     const BoxShadow(
                                       color: cl1883B2,
                                     ),
                                     BoxShadow(
                                       color: cl000000.withOpacity(0.25),
                                       spreadRadius: -5.0,
                                       // blurStyle: BlurStyle.inner,
                                       blurRadius: 20.0,
                                     ),
                                   ],
                                   borderRadius:
                                   const BorderRadius.all(Radius.circular(35)),
                                   gradient: const LinearGradient(
                                     begin: Alignment(-1.00, -0.00),
                                     end: Alignment(1, 0),
                                     colors: [cl3E4FA3, cl253068],
                                   ),
                                 ),
                                 child: const Center(
                                     child: Text(
                                       "Continue",
                                       style: TextStyle(
                                           fontSize: 18,
                                           fontFamily: "PoppinsMedium",
                                           color: myWhite,
                                           fontWeight: FontWeight.w500),
                                     )),
                               ),
                             ),
                           );
                         }
                       )
                   ),
                 ],
               ),
              ),

              const SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
