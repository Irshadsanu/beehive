import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../Screens/donate_page.dart';
import '../Screens/no_paymet_gatway.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';

class SubscriptionPayments extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
   SubscriptionPayments({Key? key,required this.loginUsername,required this.loginUserID,
     required this.subScriberType,required this.loginUserPhone,
     required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);

    DateTime currentDate = DateTime.now();
    int currentYear = currentDate.year;
    String currentMonthInWords = DateFormat('MMMM').format(currentDate);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: myWhite,
        elevation: 0,
        leading: InkWell(
          onTap: (){
            finish(context);
          },
          child: CircleAvatar(
              radius: 22,
              backgroundColor: myWhite.withOpacity(0.5),
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 15,
                color: myBlack,
              )),
        ),
        centerTitle: true,
        title: const Text(
          "Subscription Payment",
          style: TextStyle(
            color: myBlack,
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12),
        child: Consumer<DonationProvider>(
          builder: (context,value,child) {
            return Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),

                Container(
                  alignment: Alignment.center,
                  height: 80,
                  width: width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/VolunRA.png"),fit: BoxFit.cover
                    )
                  ),
                  child: Text(
                    currentMonthInWords.toString()+' '+currentYear.toString(),
                    style: TextStyle(
                      color: myWhite,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 10,),

                Container(
                  // height: height*0.2,
                  width: width,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    shadows: [
                      const BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 5.15,
                        offset: Offset(0, 2.58),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,top: 5),
                            child: Container(height: 50,width: 60,color: Colors.white,
                              child: Image.asset(
                                  "assets/Volunteer RegistrationImg.png",scale: 3,),
                            ),
                          ),
                          const SizedBox(width: 15,),
                          Column(mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Subscription Payment',
                                style: TextStyle(
                                  color: Color(0xFF3E4FA3),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                               Text(
                                 currentMonthInWords+' '+currentYear.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 15,),
                          Consumer<DonationProvider>(
                            builder: (context,value,child) {
                              return
                                value.monthList.where((element) => element.payStatus=='PAID'&&element.monthName==currentMonthInWords).length>0?
                                Text('Paid',style: TextStyle(color: Colors.green),):
                                Text('Unpaid');
                              ;
                            }
                          )
                        ],
                      ),
                      const SizedBox(height: 5,),
                      const Text(
                        '1,000',
                        style: TextStyle(
                          color: Color(0xFF3E4FA3),
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.18,
                        ),
                      ),
                      const Divider(
                        color: Color(0xFF9F9F9F),
                        thickness: 1,
                      ),
                      const SizedBox(height: 15,),
                      Consumer<HomeProvider>(builder: (context, value, child) {
                        return ((kIsWeb ||
                            Platform.isAndroid ||
                            value.iosPaymentGateway == 'ON') &&
                            !Platform.isIOS)
                            ? Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 2),
                          child: Consumer<DonationProvider>(builder: (context, value1, child) {

                              return
                                value1.monthList.where((element) => element.payStatus=='NOTPAID').length>0?
                                InkWell(
                                onTap: () {
                                  donationProvider.clearSelections();
                                  donationProvider.checkPendingPayments(loginUserID);
                                  pendingAlert(context);

                                },
                                child:
                                ///
                                Container(
                                  height: 50,
                                  width: width * .760,
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
                                      colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
                                    ),
                                  ),
                                  child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset("assets/CoinGif.gif"),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "Contribute",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Poppins",
                                                color: myWhite,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      )),
                                ),
                              ):SizedBox();
                            }
                          ),
                        )
                            : const SizedBox();
                      })
                    ],
                  ),
                ),
                const SizedBox(height: 25,),
                 Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Consumer<DonationProvider>(
                    builder: (context,value,child) {
                      return
                        value.subscriberPaymentList.length>0?
                        Text(
                        'Latest Transaction',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ):SizedBox();
                    }
                  ),
                ),
                const SizedBox(height: 5,),
                Flexible(fit: FlexFit.tight,
                  child: Consumer<DonationProvider>(
                    builder: (context,value,child) {
                      return ListView.builder(
                        shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding: const EdgeInsets.all(10.0),
                          itemCount: value.subscriberPaymentList.length,
                          itemBuilder: (BuildContext context, int index) {
                          var item=value.subscriberPaymentList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Container(
                                height: 80,
                                width: width*0.8,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
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
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                      width: 52,
                                      height: 52,
                                      padding: const EdgeInsets.only(
                                        top: 13.05,
                                        left: 11.31,
                                        right: 10.44,
                                        bottom: 13.06,
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(78.33),
                                        ),
                                        shadows: [
                                          const BoxShadow(
                                            color: Color(0x0A000000),
                                            blurRadius: 4.49,
                                            offset: Offset(0, 2.24),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                          child: Image.asset("assets/qmchBg.png")),
                                    ),
                                    Flexible(fit: FlexFit.tight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                             Text(
                                              double.parse(item.amonut.toString()).toStringAsFixed(0) ,
                                              style: TextStyle(
                                                color: Color(0xFF3E4FA3),
                                                fontSize: 18,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                                letterSpacing: -0.18,
                                              ),
                                            ),
                                             Text(
                                              getDate(item.paymentDateMillis),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                                letterSpacing: -0.10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                     SizedBox(width: 75,
                                      child: Center(
                                        child: Text(
                                          item.monthName,
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.5),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                            letterSpacing: -0.10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  void pendingAlert(context){
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            scrollable: true,
            backgroundColor: myWhite,

            title: Center(
              child: Text('Payment Pending This Year', style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),),
            ),
             content: Container(height: height*0.7,
               width: width*0.8,
               child: SingleChildScrollView(
                 child: Column(
                   children: [
                     Container(
                       child: Consumer<DonationProvider>(
                       builder: (context,value,child) {
                       return ListView.builder(
                       physics: ScrollPhysics(),
                       shrinkWrap: true,
                         padding: const EdgeInsets.all(10.0),
                          itemCount: value.monthList.length,
                           itemBuilder: (BuildContext context, int index) {
                           var item=value.monthList[index];
                       return Padding(
                         padding: const EdgeInsets.only(bottom: 8.0),
                         child:   item.payStatus!='PAID'?
                         InkWell(onTap: (){
                           donationProvider.selectMonthofPay(index);
                         },
                           child: Container(height: 45,width: width*0.8,
                           decoration: ShapeDecoration(
                             color: Colors.white,
                             shape: RoundedRectangleBorder(
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
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               InkWell(onTap:(){
                                 donationProvider.selectMonthofPay(index);
                               },
                                 child: Padding(
                                   padding: const EdgeInsets.only(left: 15),
                                   child: Text(item.monthName, style: TextStyle(
                                     color: Colors.black,
                                     fontSize: 12,
                                     fontFamily: 'Poppins',
                                     fontWeight: FontWeight.w500,
                                     letterSpacing: 0.12,
                                   ),),
                                 ),
                               ),
                               // Spacer(),
                               InkWell(onTap: (){
                                 donationProvider.selectMonthofPay(index);
                               },
                                 child: SizedBox(height: 50,width: 50,
                                   child: Checkbox(activeColor: Colors.green,
                                     checkColor: Colors.white,
                                     value: item.selectionBool,
                                     shape: CircleBorder(),
                                     side:const BorderSide(color: Colors.green, width: 2),
                                     onChanged: (bool? value1) {
                                     if(!item.selectionBool){
                                       print('INCFN');
                                       value.selectMonthofPay(index);
                                     }
                                     },
                                   ),
                                 ),
                               ),

                             ],
                           ),),
                         )
                             :Container(
                           height: 40,
                           width: width*0.8,
                           decoration: ShapeDecoration(
                             color: Colors.grey.shade50,
                             shape: RoundedRectangleBorder(
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
                           ),
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 10),
                             child: Row(mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(item.monthName, style: TextStyle(
                                   color: Colors.black,
                                   fontSize: 12,
                                   fontFamily: 'Poppins',
                                   fontWeight: FontWeight.w500,
                                   letterSpacing: 0.12,
                                 ),),
                               Spacer(),
                                 Container(
                                   width: 50,
                                   decoration: BoxDecoration(
                                       color: Colors.green,
                                       borderRadius: BorderRadius.circular(12)
                                   ),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       SizedBox(width: 2,),
                                       Container(
                                         child: Text('Paid', style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 10,
                                           fontFamily: 'Poppins',
                                           fontWeight: FontWeight.w500,
                                           letterSpacing: 0.12,
                                         ),),
                                       ),
                                       SizedBox(width: 2,),
                                       Icon(Icons.check, color: Colors.white,size: 10),
                                       // SizedBox(width: 2,),

                                     ],
                                   ),
                                 )

                               ],
                             ),
                           ),),
                       );
                       });
            }
          ),
                     ),

                   ],
                 ),
               ),
             ),
            actions: [
              InkWell(
                onTap: () {
                  finish(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Container(
                      height: 40,width: 130,
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
                        const BorderRadius.all(Radius.circular(15)),
                        gradient: const LinearGradient(
                          begin: Alignment(-1.00, -0.00),
                          end: Alignment(1, 0),
                          colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
                        ),
                      ),
                      child: Center(child: Text('Cancel',style: TextStyle(color: Colors.white),)),
                    ),
                    SizedBox(height: 16),
                    Consumer<DonationProvider>(
                        builder: (context,value,child) {
                          return InkWell(onTap: (){
                            final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
                            value.kpccAmountController.text=value.monthlyPayAmount.toString();
                            if(value.monthlyPayAmount>0){
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
                                  donationProvider.onAmountChange('');
                                  donationProvider.clearGenderAndAgedata();
                                  donationProvider.selectedPanjayathChip = null;
                                  donationProvider.chipsetWardList.clear();
                                  donationProvider.selectedWard = null;
                                  '1';
                                  donationProvider.minimumbool = true;
                                  donationProvider.clearDonateScreen();
                                  callNext(DonatePage(loginUserPhone: loginUserPhone,subScriberType: subScriberType,oneEquipmentPrice: '',
                                    paymentCategory: 'MONTHLY_PAYMENT',equipmentCount: '',
                                    equipmentID: '',loginUserID: loginUserID,loginUsername: loginUsername,
                                    zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                    sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                    foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount,monthList: value.monthList, ), context);
                                } else {
                                  callNext( NoPaymentGateway(loginUserPhone: loginUserPhone,subScriberType: subScriberType,loginUserID: loginUserID,
                                    loginUsername: loginUsername, zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                    sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                    foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                                }
                              });
                            }else{
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(backgroundColor: Colors.red,
                                content: Center(child: Text("Please select one month",style: TextStyle(
                                    color: Colors.white
                                ),)),
                                duration: Duration(milliseconds: 3000),
                              ));
                            }

                          },
                            child: Container(
                              height: 40,width: 130,
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
                                const BorderRadius.all(Radius.circular(15)),
                                gradient: const LinearGradient(
                                  begin: Alignment(-1.00, -0.00),
                                  end: Alignment(1, 0),
                                  colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
                                ),
                              ),
                              child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/CoinGif.gif"),
                                  Text('Pay',style: TextStyle(color: Colors.white),),
                                ],
                              )),
                            ),
                          );
                        }
                    ),

                  ],),
                ),
              ),
              SizedBox(height: 15,)

            ],

          );
        });
  }

  getDate(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));

// 12 Hour format:
    var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);
    return d12;
  }

}
