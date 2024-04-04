import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Views/payment_details_old.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Views/ward_model.dart';
import '../../providers/home_provider_reciept.dart';
import '../reciept_page.dart';

class ReceiptListPageOld extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  ReceiptListPageOld({Key? key,required this.loginUsername,required this.loginUserID
    ,required this.subScriberType,required this.loginUserPhone,
    required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
    required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
    ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    HomeProviderReceiptApp homeProvider =
        Provider.of<HomeProviderReceiptApp>(context, listen: false);
    // homeProvider.checkInternet(context);
    Future.delayed(Duration.zero, () async {
      SharedPreferences userPreference = await SharedPreferences.getInstance();
      if (userPreference.getString("AlertShowed") == null) {
        aboutReceiptAlert(context);
      }
      userPreference.setString("AlertShowed", "AlertShowed");
    });
    if (!kIsWeb) {
      return mobile(context);
    } else {
      // return web(context);
      return mobile(context);
    }
  }

  Widget body(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    HomeProviderReceiptApp homeProvider = Provider.of<HomeProviderReceiptApp>(context, listen: false);
    print("asdfjaposfjiaposfi${homeProvider.filteredPaymentDetailsList.length}");
    var height = queryData.size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Card(
              elevation: 3,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Center(child: Consumer<HomeProviderReceiptApp>(
                  builder: (context, value, child) {
                return Text(
                  'Selected Date : ${value.selectedDate}',
                  style: green14N,
                );
              })),
            ),
          ),
          SizedBox(
            height: 70,
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              elevation: 3,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: TextField(
                //    ...,other fields
                decoration: InputDecoration(
                  fillColor: myWhite,
                  filled: true,
                  hintText: 'Search Name/Phone Number',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: myWhite),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: myWhite),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: myBlack,
                  ),
                ),
                onChanged: (item) {
                  if (item.isNotEmpty) {
                    homeProvider.filterReceiptList(item);
                  } else {
                    homeProvider.filteredPaymentDetailsList =
                        homeProvider.paymentDetailsList;
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: height - 220,
            width: double.infinity,
            child: Card(
              elevation: 20,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                'Name',
                                style: green14N,
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                'Details',
                                style: green14N,
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                'Amount',
                                style: green14N,
                              )),
                        ],
                      ),
                    ),
                    Consumer<HomeProviderReceiptApp>(
                        builder: (context, value, child) {
                      return
                          value.filteredPaymentDetailsList.length>=value.listLength ?
                      ListView.builder(
                          itemCount: value.listLength,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            var item = value.filteredPaymentDetailsList[index];
                            print("working recipt functionnnn${value.filteredPaymentDetailsList.length}");
                            return Container(
                              color: item.status == 'Success'
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.name,
                                            style: black14,
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                Text(
                                                  item.id,
                                                  style: black14,
                                                ),
                                                Text(
                                                  '${item.ward},${item.panchayath}\n${item.district}',
                                                  style: black14,
                                                ),
                                                Text(
                                                  getDate(item.time.toString()),
                                                  style: green14N,
                                                ),
                                                Text(
                                                  'Ph: ${item.phoneNumber}',
                                                  style: black16,
                                                ),
                                                Text(
                                                  "Upi id : ${item.paymentUpi}",
                                                  style: black14,
                                                ),
                                                Text(
                                                  "App : ${item.paymentApp}",
                                                  style: black14,
                                                )
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              '₹ ${item.amount}',
                                              style: black14,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Widget cancelButton = TextButton(
                                                child: const Text("Cancel"),
                                                onPressed:  () {
                                                  finish(context);
                                                },
                                              );
                                              Widget continueButton = TextButton(
                                                child: const Text("Continue"),
                                                onPressed:  () {
                                                  finish(context);
                                                  homeProvider.changeStatus(item);
                                                },
                                              );

                                              // set up the AlertDialog
                                              AlertDialog alert = AlertDialog(
                                                title: const Text("Change status"),
                                                content: const Text("Are you sure do you want to change status"),
                                                actions: [
                                                  cancelButton,
                                                  continueButton,
                                                ],
                                              );

                                              // show the dialog
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: 70,
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Change Status',
                                                style: whitePoppinsR12,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(
                                            width: 5,
                                          ),

                                          item.status == 'Success'
                                              ? Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          DonationProvider
                                                              donationProvider =
                                                              Provider.of<
                                                                      DonationProvider>(
                                                                  context,
                                                                  listen: false);
                                                          donationProvider
                                                              .getSharedPrefName();

                                                          if (item.paymentApp ==
                                                                  'Bank' &&
                                                              item.name ==
                                                                  'No Name') {
                                                            showReceiptAlert(
                                                                context, item);
                                                          } else {
                                                            DonationProvider
                                                                donationProvider =
                                                                Provider.of<
                                                                        DonationProvider>(
                                                                    context,
                                                                    listen: false);
                                                            donationProvider.getDonationDetailsForReceipt(item.id);
                                                            callNext(ReceiptPage(loginUserPhone: loginUserPhone,
                                                              loginUserID: loginUserID,
                                                              subScriberType: subScriberType,
                                                              loginUsername: loginUsername,
                                                              nameStatus: 'YES',zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                                              sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                                              foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ),
                                                                context);
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 70,
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            'Get Receipt',
                                                            style: whitePoppinsR12,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      item.paymentApp == "Bank" &&
                                                              item.wardname ==
                                                                  "General"
                                                          ? ElevatedButton(
                                                              onPressed: () {
                                                                showPinWardAlert(
                                                                    context, item);
                                                              },
                                                              child: Container(
                                                                width: 70,
                                                                alignment:
                                                                    Alignment.center,
                                                                child: Text(
                                                                  'Pin Ward',
                                                                  style:
                                                                      whitePoppinsR12,
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton.icon(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        myGreenNewUI),
                                                foregroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        myWhite),
                                                shape: MaterialStateProperty
                                                    .resolveWith<OutlinedBorder>((_) {
                                                  return RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(30));
                                                }),
                                              ),
                                              onPressed: () {
                                                if (getPhone(item.phoneNumber)) {
                                                  launch("tel://${item.phoneNumber}");
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Phone Number Not Available"),
                                                  ));
                                                }
                                              },
                                              icon: const Icon(Icons.call),
                                              label: const Text("Call")),
                                          const SizedBox(width: 5,),
                                          ElevatedButton.icon(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        myGreenNewUI),
                                                foregroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        myWhite),
                                                shape: MaterialStateProperty
                                                    .resolveWith<OutlinedBorder>((_) {
                                                  return RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(30));
                                                }),
                                              ),
                                              onPressed: () {
                                                if (getPhone(item.phoneNumber)) {
                                                  print(item.phoneNumber.replaceAll("+91", '').replaceAll(" ", ''));
                                                  launch("whatsapp://send?phone=${"+91"+item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Phone Number Not Available"),
                                                  ));
                                                }
                                              },
                                              icon: const Icon(Icons.call),
                                              label: const Text("WhatsApp")),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10)
                                ],
                              ),
                            );
                          })
                          :const SizedBox();
                    }),


                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(myGreenNewUI),
                            foregroundColor: MaterialStateProperty.all<Color>(myWhite),
                            overlayColor: MaterialStateColor.resolveWith((states) => Colors.red),
                            animationDuration: const Duration(microseconds:500)
                        ),
                        onPressed: (){
                          if(homeProvider.listLength+20<=homeProvider.filteredPaymentDetailsList.length){
                            homeProvider.increaseLimit(homeProvider.listLength+20);

                          }else{
                            homeProvider.increaseLimit(homeProvider.filteredPaymentDetailsList.length);

                          }
                        }, child: const SizedBox(width: double.infinity,child: Center(child: Text('Load More')),))


                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget tvBody(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    HomeProviderReceiptApp homeProvider =
    Provider.of<HomeProviderReceiptApp>(context, listen: false);
    var height = queryData.size.height;
    return Column(
      children: [
        SizedBox(
          height: height/15,
          child: Card(
            elevation: 3,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Center(child: Consumer<HomeProviderReceiptApp>(
                builder: (context, value, child) {
                  return Text(
                    'Selected Date : ${value.selectedDate}',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: height/50,
                        color:primary
                    ),
                  );
                })),
          ),
        ),
        SizedBox(
          height: height/20,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            elevation: 3,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: TextField(
              //    ...,other fields
              decoration: InputDecoration(
                fillColor: myWhite,
                filled: true,
                hintText: 'Search Name/Phone Number',
                hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: height/40,
                ),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: myWhite),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: myWhite),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                suffixIcon:  Icon(
                  Icons.search,size: height/25,
                  color: myBlack,
                ),
              ),
              onChanged: (item) {
                if (item.isNotEmpty) {
                  homeProvider.filterReceiptList(item);
                } else {
                  homeProvider.filteredPaymentDetailsList =
                      homeProvider.paymentDetailsList;
                }
              },
            ),
          ),
        ),
        SizedBox(
          height: height/1.3296399,
          width: double.infinity,
          child: Card(
            elevation: 20,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',

                                  fontSize: height/45,
                                  color:primary
                              ),
                            )),
                        Expanded(
                            flex: 8,
                            child: Text(
                              'Details',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',

                                  fontSize: height/45,
                                  color:primary
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Amount',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: height/45,
                                  color:primary
                              ),
                            )),
                        const Expanded(
                            flex: 5,
                            child: SizedBox()
                        ),
                      ],
                    ),
                  ),
                  Consumer<HomeProviderReceiptApp>(
                      builder: (context, value, child) {
                        return value.filteredPaymentDetailsList.length>=value.listLength
                            ?ListView.builder(
                            itemCount: value.listLength,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              var item = value.filteredPaymentDetailsList[index];
                              return Container(
                                color: item.status == 'Success'
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.red.withOpacity(0.1),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.name,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: height/55,
                                                  color:myBlack2
                                              ),
                                            ),
                                            flex: 4,
                                          ),
                                          Expanded(
                                              flex: 8,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    item.id,
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: height/55,
                                                        color:myBlack2
                                                    ),
                                                  ),
                                                  Text(
                                                    '${item.ward},${item.panchayath}\n${item.district}',
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: height/55,
                                                        color:myBlack2
                                                    ),
                                                  ),
                                                  Text(
                                                    getDate(item.time.toString()),
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: height/55,
                                                        color:primary
                                                    ),
                                                  ),
                                                  Text(
                                                    'Ph: ${item.phoneNumber}',
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: height/50,
                                                        color:myBlack2
                                                    ),
                                                  ),
                                                  Text(
                                                    "Upi id : ${item.paymentUpi}",
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: height/55,
                                                        color:myBlack2
                                                    ),
                                                  ),
                                                  Text(
                                                    "App : ${item.paymentApp}",
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: height/55,
                                                        color:myBlack2
                                                    ),
                                                  )
                                                ],
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                '₹ ${item.amount}',
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: height/55,
                                                    color:myBlack2
                                                ),
                                              )),
                                          Expanded(
                                              flex: 5,
                                              child:  Column(
                                                children: [

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Widget cancelButton = TextButton(
                                                            child: const Text("Cancel"),
                                                            onPressed:  () {
                                                              finish(context);
                                                            },
                                                          );
                                                          Widget continueButton = TextButton(
                                                            child: const Text("Continue"),
                                                            onPressed:  () {
                                                              finish(context);
                                                              homeProvider.changeStatus(item);
                                                            },
                                                          );

                                                          // set up the AlertDialog
                                                          AlertDialog alert = AlertDialog(
                                                            title: const Text("Change status"),
                                                            content: const Text("Are you sure do you want to change status"),
                                                            actions: [
                                                              cancelButton,
                                                              continueButton,
                                                            ],
                                                          );

                                                          // show the dialog
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return alert;
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                                              color: appBarReceipt
                                                          ),
                                                          width: height/7,
                                                          height: height/20,
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            'Change Status',
                                                            style: TextStyle(
                                                                fontFamily: 'PoppinsRegular',
                                                                fontSize: height/65,
                                                                color:myWhite
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      const SizedBox(
                                                        width: 5,
                                                      ),

                                                      item.status == 'Success'
                                                          ? Align(
                                                        alignment: Alignment.centerRight,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                DonationProvider
                                                                donationProvider =
                                                                Provider.of<
                                                                    DonationProvider>(
                                                                    context,
                                                                    listen: false);
                                                                donationProvider
                                                                    .getSharedPrefName();

                                                                if (item.paymentApp ==
                                                                    'Bank' &&
                                                                    item.name ==
                                                                        'No Name') {
                                                                  showReceiptAlert(
                                                                      context, item);
                                                                } else {
                                                                  DonationProvider
                                                                  donationProvider =
                                                                  Provider.of<
                                                                      DonationProvider>(
                                                                      context,
                                                                      listen: false);
                                                                  donationProvider.getDonationDetailsForReceipt(item.id);
                                                                  callNext(ReceiptPage(loginUserPhone: loginUserPhone,loginUserID: loginUserID,
                                                                    loginUsername: loginUsername,nameStatus: 'YES',subScriberType: subScriberType,
                                                                    zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                                                    sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                                                    foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ),
                                                                      context);
                                                                }
                                                              },
                                                              child: Container(
                                                                decoration: const BoxDecoration(
                                                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                    color: appBarReceipt
                                                                ),
                                                                width: height/7,
                                                                height: height/20,
                                                                alignment: Alignment.center,
                                                                child: Text(
                                                                  'Get Receipt',
                                                                  style: TextStyle(
                                                                      fontFamily: 'PoppinsRegular',
                                                                      fontSize: height/65,
                                                                      color:myWhite
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            item.paymentApp == "Bank" &&
                                                                item.wardname ==
                                                                    "General"
                                                                ? InkWell(
                                                              onTap: () {
                                                                showPinWardAlert(
                                                                    context, item);
                                                              },
                                                              child: Container(
                                                                decoration: const BoxDecoration(
                                                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                    color: appBarReceipt
                                                                ),
                                                                width: height/7,
                                                                height: height/20,
                                                                alignment:
                                                                Alignment.center,
                                                                child: Text(
                                                                  'Pin Ward',
                                                                  style:
                                                                  TextStyle(
                                                                      fontFamily: 'PoppinsRegular',
                                                                      fontSize: height/65,
                                                                      color:myWhite
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                                : const SizedBox(),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            if (getPhone(item.phoneNumber)) {
                                                              launch("tel://${item.phoneNumber}");
                                                            } else {
                                                              ScaffoldMessenger.of(context)
                                                                  .showSnackBar(const SnackBar(
                                                                content: Text(
                                                                    "Phone Number Not Available"),
                                                              ));
                                                            }
                                                          },
                                                          child: Container(
                                                            decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                color: myGreenNewUI
                                                            ),
                                                            width: height/7,
                                                            height: height/20,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                Icon(Icons.call,color:myWhite,size: height/35),
                                                                Text("Call",style: TextStyle(
                                                                    fontFamily: 'PoppinsRegular',
                                                                    fontSize: height/65,
                                                                    color:myWhite
                                                                ),)
                                                              ],
                                                            ),
                                                          ),
                                                      ),
                                                      const SizedBox(width: 5,),
                                                      InkWell(

                                                          onTap: () {
                                                            if (getPhone(item.phoneNumber)) {
                                                              print(item.phoneNumber.replaceAll("+91", '').replaceAll(" ", ''));
                                                              launch("whatsapp://send?phone=${"+91"+item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                                                            } else {
                                                              ScaffoldMessenger.of(context)
                                                                  .showSnackBar(const SnackBar(
                                                                content: Text(
                                                                    "Phone Number Not Available"),
                                                              ));
                                                            }
                                                          },
                                                         child: Container(
                                                           decoration: const BoxDecoration(
                                                               borderRadius: BorderRadius.all(Radius.circular(15)),
                                                               color: myGreenNewUI
                                                           ),
                                                           width: height/7,
                                                           height: height/20,
                                                           child: Row(
                                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                             children: [
                                                               Icon(Icons.call,color:myWhite,size: height/35),
                                                               Text("WhatsApp",style: TextStyle(
                                                                   fontFamily: 'PoppinsRegular',
                                                                   fontSize: height/65,
                                                                   color:myWhite
                                                               ),)
                                                             ],
                                                           ),
                                                         ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: myWhite,
                                    )

                                  ],
                                ),
                              );
                            }):const SizedBox();
                      }),
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(myGreenNewUI),
                          foregroundColor: MaterialStateProperty.all<Color>(myWhite),
                          overlayColor: MaterialStateColor.resolveWith((states) => Colors.red),
                          animationDuration: const Duration(microseconds:500)
                      ),
                      onPressed: (){
                        if(homeProvider.listLength+20<=homeProvider.filteredPaymentDetailsList.length){
                          homeProvider.increaseLimit(homeProvider.listLength+20);

                        }else{
                          homeProvider.increaseLimit(homeProvider.filteredPaymentDetailsList.length);

                        }
                      }, child: const SizedBox(width: double.infinity,child: Center(child: Text('Load More')),))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget webBody(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    HomeProviderReceiptApp homeProvider =
    Provider.of<HomeProviderReceiptApp>(context, listen: false);
    var height = queryData.size.height;
    return Column(
      children: [
        SizedBox(
          height: height/15,
          child: Card(
            elevation: 3,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Center(child: Consumer<HomeProviderReceiptApp>(
                builder: (context, value, child) {
                  return Text(
                    'Selected Date : ${value.selectedDate}',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: height/50,
                        color:primary
                    ),
                  );
                })),
          ),
        ),
        SizedBox(
          height: height/20,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            elevation: 3,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: TextField(
              //    ...,other fields
              decoration: InputDecoration(
                fillColor: myWhite,
                filled: true,
                hintText: 'Search Name/Phone Number',
                hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: height/40,
                ),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: myWhite),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: myWhite),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                suffixIcon:  Icon(
                  Icons.search,size: height/25,
                  color: myBlack,
                ),
              ),
              onChanged: (item) {
                if (item.isNotEmpty) {
                  homeProvider.filterReceiptList(item);
                } else {
                  homeProvider.filteredPaymentDetailsList =
                      homeProvider.paymentDetailsList;
                }
              },
            ),
          ),
        ),
        SizedBox(
          height: height/1.2,
          width: double.infinity,
          child: Card(
            elevation: 20,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',

                                  fontSize: height/45,
                                  color:primary
                              ),
                            )),
                        Expanded(
                            flex: 8,
                            child: Text(
                              'Details',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',

                                  fontSize: height/45,
                                  color:primary
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Amount',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: height/45,
                                  color:primary
                              ),
                            )),
                        const Expanded(
                            flex: 5,
                            child: SizedBox()
                        ),
                      ],
                    ),
                  ),
                  Consumer<HomeProviderReceiptApp>(
                      builder: (context, value, child) {
                        return value.filteredPaymentDetailsList.length>=value.listLength
                            ?ListView.builder(
                            itemCount: value.listLength,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              var item = value.filteredPaymentDetailsList[index];
                              return Container(
                                color: item.status == 'Success'
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.red.withOpacity(0.1),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical:10, horizontal: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.name,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: height/55,
                                                  color:myBlack2
                                              ),
                                            ),
                                            flex: 4,
                                          ),
                                          Expanded(
                                              flex: 8,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    item.id,
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: height/55,
                                                        color:myBlack2
                                                    ),
                                                  ),
                                                  Text(
                                                    '${item.ward},${item.panchayath}\n${item.district}',
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: height/55,
                                                        color:myBlack2
                                                    ),
                                                  ),
                                                  Text(
                                                    getDate(item.time.toString()),
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: height/55,
                                                        color:primary
                                                    ),
                                                  ),
                                                  Text(
                                                    'Ph: ${item.phoneNumber}',
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: height/50,
                                                        color:myBlack2
                                                    ),
                                                  ),
                                                  Text(
                                                    "Upi id : ${item.paymentUpi}",
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: height/55,
                                                        color:myBlack2
                                                    ),
                                                  ),
                                                  Text(
                                                    "App : ${item.paymentApp}",
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontSize: height/55,
                                                        color:myBlack2
                                                    ),
                                                  )
                                                ],
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                '₹ ${item.amount}',
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: height/55,
                                                    color:myBlack2
                                                ),
                                              )),
                                          Expanded(
                                            flex: 5,
                                            child:  Column(
                                              children: [

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Widget cancelButton = TextButton(
                                                          child: const Text("Cancel"),
                                                          onPressed:  () {
                                                            finish(context);
                                                          },
                                                        );
                                                        Widget continueButton = TextButton(
                                                          child: const Text("Continue"),
                                                          onPressed:  () {
                                                            finish(context);
                                                            homeProvider.changeStatus(item);
                                                          },
                                                        );

                                                        // set up the AlertDialog
                                                        AlertDialog alert = AlertDialog(
                                                          title: const Text("Change status"),
                                                          content: const Text("Are you sure do you want to change status"),
                                                          actions: [
                                                            cancelButton,
                                                            continueButton,
                                                          ],
                                                        );

                                                        // show the dialog
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return alert;
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                            color: appBarReceipt
                                                        ),
                                                        width: height/7,
                                                        height: height/20,
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          'Change Status',
                                                          style: TextStyle(
                                                              fontFamily: 'PoppinsRegular',
                                                              fontSize: height/65,
                                                              color:myWhite
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    const SizedBox(
                                                      width: 5,
                                                    ),

                                                    item.status == 'Success'
                                                        ? Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              DonationProvider
                                                              donationProvider =
                                                              Provider.of<
                                                                  DonationProvider>(
                                                                  context,
                                                                  listen: false);
                                                              donationProvider
                                                                  .getSharedPrefName();

                                                              if (item.paymentApp ==
                                                                  'Bank' &&
                                                                  item.name ==
                                                                      'No Name') {
                                                                showReceiptAlert(
                                                                    context, item);
                                                              } else {
                                                                DonationProvider
                                                                donationProvider =
                                                                Provider.of<
                                                                    DonationProvider>(
                                                                    context,
                                                                    listen: false);
                                                                donationProvider.getDonationDetailsForReceipt(item.id);
                                                                callNext(ReceiptPage(loginUserPhone: loginUserPhone,loginUserID: loginUserID,
                                                                  loginUsername: loginUsername,nameStatus: 'YES',subScriberType: subScriberType,
                                                                  zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                                                                  sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                                                                  foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ),
                                                                    context);
                                                              }
                                                            },
                                                            child: Container(
                                                              decoration: const BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                  color: appBarReceipt
                                                              ),
                                                              width: height/7,
                                                              height: height/20,
                                                              alignment: Alignment.center,
                                                              child: Text(
                                                                'Get Receipt',
                                                                style: TextStyle(
                                                                    fontFamily: 'PoppinsRegular',
                                                                    fontSize: height/65,
                                                                    color:myWhite
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          item.paymentApp == "Bank" &&
                                                              item.wardname ==
                                                                  "General"
                                                              ? InkWell(
                                                            onTap: () {
                                                              showPinWardAlert(
                                                                  context, item);
                                                            },
                                                            child: Container(
                                                              decoration: const BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                  color: appBarReceipt
                                                              ),
                                                              width: height/7,
                                                              height: height/20,
                                                              alignment:
                                                              Alignment.center,
                                                              child: Text(
                                                                'Pin Ward',
                                                                style:
                                                                TextStyle(
                                                                    fontFamily: 'PoppinsRegular',
                                                                    fontSize: height/65,
                                                                    color:myWhite
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                              : const SizedBox(),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                                const SizedBox(height: 5,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        if (getPhone(item.phoneNumber)) {
                                                          launch("tel://${item.phoneNumber}");
                                                        } else {
                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(const SnackBar(
                                                            content: Text(
                                                                "Phone Number Not Available"),
                                                          ));
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                                            color: myGreenNewUI
                                                        ),
                                                        width: height/7,
                                                        height: height/20,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Icon(Icons.call,color:myWhite,size: height/35),
                                                            Text("Call",style: TextStyle(
                                                                fontFamily: 'PoppinsRegular',
                                                                fontSize: height/65,
                                                                color:myWhite
                                                            ),)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5,),
                                                    InkWell(

                                                      onTap: () {
                                                        if (getPhone(item.phoneNumber)) {
                                                          print(item.phoneNumber.replaceAll("+91", '').replaceAll(" ", ''));
                                                          launch("whatsapp://send?phone=${"+91"+item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                                                        } else {
                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(const SnackBar(
                                                            content: Text(
                                                                "Phone Number Not Available"),
                                                          ));
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                                            color: myGreenNewUI
                                                        ),
                                                        width: height/7,
                                                        height: height/20,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Icon(Icons.call,color:myWhite,size: height/35),
                                                            Text("WhatsApp",style: TextStyle(
                                                                fontFamily: 'PoppinsRegular',
                                                                fontSize: height/65,
                                                                color:myWhite
                                                            ),)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: myWhite,
                                    )

                                  ],
                                ),
                              );
                            }):const SizedBox();
                      }),
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(myGreenNewUI),
                          foregroundColor: MaterialStateProperty.all<Color>(myWhite),
                          overlayColor: MaterialStateColor.resolveWith((states) => Colors.red),
                          animationDuration: const Duration(microseconds:500)
                      ),
                      onPressed: (){
                        if(homeProvider.listLength+20<=homeProvider.filteredPaymentDetailsList.length){
                          homeProvider.increaseLimit(homeProvider.listLength+20);

                        }else{
                          homeProvider.increaseLimit(homeProvider.filteredPaymentDetailsList.length);

                        }
                      }, child: const SizedBox(width: double.infinity,child: Center(child: Text('Load More')),))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget mobile(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    HomeProviderReceiptApp homeProvider =
    Provider.of<HomeProviderReceiptApp>(context, listen: false);
    var height = queryData.size.height;
    var width = queryData.size.width;

    if (queryData.orientation == Orientation.portrait) {
      return Scaffold(

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: myGradient3,
        // centerTitle: true,
        title: Text(
          'Receipt',
          style: white16,
        ),
        actions: [
          TextButton.icon(
              onPressed: () {
                print("portraittttttttttttttttt");
                homeProvider.selectDate(context);
              },
              icon: const Icon(
                Icons.calendar_today,
                color: myWhite,
              ),
              label: const Text(
                'Select Date',
                style: TextStyle(color: myWhite),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<HomeProviderReceiptApp>(
                builder: (context,value,child) {
                  return Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.greenAccent,
                    value: value.isBuzzer,
                    onChanged: (value) {
                      homeProvider.radioButtonChanges(value!);
                    },
                  );
                }
              ),

              const Text(
                "Buzzer",
              ),
              const SizedBox(width: 10,)
            ],
          ),
        ],
      ),
      body: body(context),
    );
    } else {
      return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(
          backgroundColor: myGradient3,
          // centerTitle: true,
          title: const Text(
            'Receipt',
            style: TextStyle(color: myWhite,fontSize: 15),
          ),
          actions: [
            TextButton.icon(
                onPressed: () {
                  homeProvider.selectDate(context);
                },
                icon:  const Icon(
                  Icons.calendar_today,size: 15,
                  color: myWhite,
                ),
                label: const Text(
                  'Select Date',
                  style: TextStyle(color: myWhite,fontSize: 15),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<HomeProviderReceiptApp>(
                    builder: (context,value,child) {
                      return Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.greenAccent,
                        value: value.isBuzzer,
                        onChanged: (value) {
                          homeProvider.radioButtonChanges(value!);
                        },
                      );
                    }
                ),

                const Text(
                  "Buzzer",
                )
              ],
            ),
          ],
        ),
      ),
      body: (!kIsWeb)?tvBody(context):webBody(context)
    );
    }
  }

  Widget web(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    HomeProviderReceiptApp homeProvider =
        Provider.of<HomeProviderReceiptApp>(context, listen: false);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return Stack(
      children: [
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
        Center(
            child: queryData.orientation == Orientation.portrait
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width,
                        child: Scaffold(
                          resizeToAvoidBottomInset: false,
                          appBar: AppBar(
                            backgroundColor: myGreen,
                            centerTitle: true,
                            title: Text(
                              'Receipt',
                              style: white16,
                            ),
                            actions: [
                              IconButton(
                                  onPressed: () {
                                    homeProvider.selectDate(context);
                                  },
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    color: myWhite,
                                  ))
                            ],
                          ),
                          body: body(context),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Scaffold(
                          resizeToAvoidBottomInset: false,
                          appBar: AppBar(
                            backgroundColor: myGreen,
                            centerTitle: true,
                            title: Text(
                              'Receipt',
                              style: white16,
                            ),
                            actions: [
                              IconButton(
                                  onPressed: () {
                                    homeProvider.selectDate(context);
                                  },
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    color: myWhite,
                                  ))
                            ],
                          ),
                          body: body(context),
                        ),
                      ),
                    ],
                  ))
      ],
    );
  }

  showReceiptAlert(
    BuildContext context,
    PaymentDetailsOld item,
  ) {
    HomeProviderReceiptApp homeProvider =
        Provider.of<HomeProviderReceiptApp>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Name',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.name,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        fillColor: myGray2,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (name) =>
                          name == '' ? 'Please Enter Valid Name' : null,
                    );
                  }),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Transaction ID(last 4 digit)/ Phone Number',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.transactionID,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        fillColor: myGray2,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (name) => name == '' ||
                              name!.toLowerCase() != item.id.toLowerCase() &&
                                  name.toLowerCase() !=
                                      item.upiId.toLowerCase() &&
                                  name.toLowerCase() !=
                                      item.refNo.toLowerCase() &&
                                  name.toLowerCase() !=
                                      item.phoneNumber.toLowerCase() &&
                                  name.toLowerCase() !=
                                      newString(item.id.toLowerCase(), 4)
                          ? 'Please Enter Valid Transaction ID'
                          : null,
                    );
                  }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(myWhite),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(myGreen),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                color: myGreen,
                                width: 2.0,
                              ),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30)),
                        ),
                        onPressed: () async {
                          final FormState? form = _formKey.currentState;
                          if (form!.validate()) {
                            finish(context);
                            DonationProvider donationProvider =
                                Provider.of<DonationProvider>(context,
                                    listen: false);
                            donationProvider.getDonationDetailsForReceipt(item.id);
                            SharedPreferences userPreference =
                                await SharedPreferences.getInstance();
                            userPreference.setString(
                                "ReceiptName", donationProvider.name.text);
                            userPreference.setString("ReceiptID",
                                donationProvider.transactionID.text);
                            callNext(ReceiptPage(loginUserPhone: loginUserPhone,
                                loginUserID: loginUserID,loginUsername: loginUsername,nameStatus: 'YES',
                                subScriberType: subScriberType,zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                              sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                              foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                          }
                        },
                        child: Text(
                          'Get Receipt',
                          style: white16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showPinWardAlert(
    BuildContext context,
    PaymentDetailsOld item,
  ) {
    HomeProviderReceiptApp homeProvider =
        Provider.of<HomeProviderReceiptApp>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Transaction ID(Last 4 digit)',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.transactionID,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        fillColor: myGray2,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (name) => name == '' ||
                              name!.toLowerCase() != item.id.toLowerCase() &&
                                  name.toLowerCase() !=
                                      newString(item.id.toLowerCase(), 4)
                          ? 'Please Enter Valid Transaction ID'
                          : null,
                    );
                  }),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Ward/Unit',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return Autocomplete<WardModel>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return (value.wards+value.newWards)
                            .where((WardModel wardd) =>
                                wardd.wardName.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase()) ||
                                wardd.panchayath.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (WardModel option) =>
                          option.wardName,
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextFormField(
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Select Ward/Unit',
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            hintStyle: blackPoppinsR12,
                            filled: true,
                            fillColor: myLightWhiteNewUI,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: myGray2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: myGray2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: myGray2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (name) => name == '' ||
                                  !(value.wards+value.newWards)
                                      .map((e) => e.wardName)
                                      .contains(name)
                              ? 'Please Enter Valid Ward/Unit Name'
                              : null,
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      onSelected: (WardModel selection) {
                        print('Selected: ${selection.wardName}');
                        value.selectPinWard(selection);
                      },
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<WardModel> onSelected,
                          Iterable<WardModel> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 200,
                              color: Colors.white,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final WardModel option =
                                      options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: Container(
                                      height: 50,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(option.wardName,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(option.panchayath),
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
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  getDate(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));

// 12 Hour format:
    var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);
    return d12;
  }

  String getName(PaymentDetailsOld item) {
    String trId = '';
    if (item.name == 'No Name') {
      trId = item.id.substring(0, item.id.length - 4) + getStar(4);
    } else {
      trId = item.id;
    }
    return trId;
  }

  String getStar(int length) {
    String star = '';
    for (int i = 0; i < length; i++) {
      star = star + '*';
    }
    return star;
  }

  aboutReceiptAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      backgroundColor: Colors.white,
      actions: [
        SizedBox(
          width: 400,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  "How to print Receipt",
                  style: black16,
                ),
                const SizedBox(height: 10,),
                const Align(
                  alignment: Alignment.center,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'KPCC 138 ന് സംഭാവന നൽകിയവർക്ക് "Get Receipt" Option ഉപയോഗിച്ഛ് അവരുടെ റെസിപ്പ്റ് പ്രിന്റ് ചെയ്യാൻ സാധിക്കുന്നതാണ്.',
                      // style: black16,
                    ),
                  ),
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
                              color: myGreen,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Text(
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

  String newString(String oldString, int n) {
    if (oldString.length >= n) {
      return oldString.substring(oldString.length - n);
    } else {
      return '';
      // return whatever you want
    }
  }

  bool getPhone(String donorNumber) {
    try {
      int ph = 0;
      ph = int.parse(donorNumber.trim().replaceAll("+", "").replaceAll(" ", ''));

      return true;
    } catch (e) {
      return false;
    }
  }
}
