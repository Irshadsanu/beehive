import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/my_colors.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../qmchModels/subScriberModel.dart';
class CashFreeUpi extends StatelessWidget {
  String paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice;
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  List<MonthBool> monthList;
   CashFreeUpi({Key? key
     ,required this.paymentCategory
     ,required this.equipmentCount
     ,required this.equipmentID
     ,required this.oneEquipmentPrice,required this.loginUsername,required this.loginUserID,
     required this.subScriberType,required this.loginUserPhone,
     required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,required this.monthList,
   }) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }
   Widget mobile(BuildContext context) {
     DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upi'),
        centerTitle: true,
        backgroundColor: myGreenNewUI,

      ),
      body: Form(
        key: _formKey,
        child: Column(
          children:  [
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 30,bottom: 0),
              child: Consumer<DonationProvider>(
                  builder: (context, value, child)  {
                  return TextFormField(
                    controller: value.upiIdEt,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Upi ID',
                      labelText: 'Upi ID'
                    ),
                    validator: (text){
                      if(text==null||text.isEmpty){
                        return 'Upi ID cant be empty';
                      }else{
                        return null;
                      }
                    },
                  );
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
              child: Consumer<DonationProvider>(
                  builder: (context, value, child) {
                    return TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(
                            myWhite),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            myGreenNewUI),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10.0),
                            side: const BorderSide(
                              color: myGreenNewUI,
                              width: 2.0,
                            ),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30)),
                      ),
                      onPressed: () {
                        final FormState? form = _formKey.currentState;
                        if (form!.validate()) {
                          donationProvider.seamlessUPIPayment(context,value.upiIdEt.text,paymentCategory,equipmentCount
                              ,equipmentID,oneEquipmentPrice,loginUsername,loginUserID,subScriberType,loginUserPhone, zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice, foodkitPrice, footkitCount,equipmentAmount, sponsorPatientAmonut, foodkitAmount,monthList);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child:Text(
                          'Pay Now',
                          style: white16,
                        ),
                      ),
                    );
                  }
              ),
            ),

          ],
        ),
      ),
    );
  }
   Widget web(BuildContext context) {
     MediaQueryData queryData;
     queryData = MediaQuery.of(context);
     var height = queryData.size.height;
     var width = queryData.size.width;
     DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
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
        Center(child: queryData.orientation==Orientation.portrait?  Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: width/3,),
            SizedBox(width: width,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Upi'),
                  centerTitle: true,
                  backgroundColor: myGreenNewUI,

                ),
                body: Form(
                  key: _formKey,
                  child: Column(
                    children:  [
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,top: 30,bottom: 0),
                        child: Consumer<DonationProvider>(
                            builder: (context, value, child)  {
                              return TextFormField(
                                controller: value.upiIdEt,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter Your Upi ID',
                                    labelText: 'Upi ID'
                                ),
                                validator: (text){
                                  if(text==null||text.isEmpty){
                                    return 'Upi ID cant be empty';
                                  }else{
                                    return null;
                                  }
                                },
                              );
                            }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
                        child: Consumer<DonationProvider>(
                            builder: (context, value, child) {
                              return TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(
                                      myWhite),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      myGreenNewUI),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                        color: myGreenNewUI,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 30)),
                                ),
                                onPressed: () {
                                  final FormState? form = _formKey.currentState;
                                  if (form!.validate()) {
                                    donationProvider.seamlessUPIPayment(context,value.upiIdEt.text,paymentCategory,equipmentCount,
                                        equipmentID,oneEquipmentPrice,loginUsername,loginUserID,subScriberType,loginUserPhone, zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice, foodkitPrice, footkitCount,equipmentAmount, sponsorPatientAmonut, foodkitAmount,monthList);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child:Text(
                                    'Pay Now',
                                    style: white16,
                                  ),
                                ),
                              );
                            }
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            // SizedBox(width: width/3,),
          ],
        ):
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: width/3,),
            SizedBox(width: width/3,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Upi'),
                  centerTitle: true,
                  backgroundColor: myGreenNewUI,

                ),
                body: Form(
                  key: _formKey,
                  child: Column(
                    children:  [
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,top: 30,bottom: 0),
                        child: Consumer<DonationProvider>(
                            builder: (context, value, child)  {
                              return TextFormField(
                                controller: value.upiIdEt,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter Your Upi ID',
                                    labelText: 'Upi ID'
                                ),
                                validator: (text){
                                  if(text==null||text.isEmpty){
                                    return 'Upi ID cant be empty';
                                  }else{
                                    return null;
                                  }
                                },
                              );
                            }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
                        child: Consumer<DonationProvider>(
                            builder: (context, value, child) {
                              return TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(
                                      myWhite),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      myGreenNewUI),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                        color: myGreenNewUI,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 30)),
                                ),
                                onPressed: () {
                                  final FormState? form = _formKey.currentState;
                                  if (form!.validate()) {
                                    donationProvider.seamlessUPIPayment(context,value.upiIdEt.text,paymentCategory,equipmentCount,
                                        equipmentID,oneEquipmentPrice,loginUsername,loginUserID,subScriberType,loginUserPhone,
                                      zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice, foodkitPrice, footkitCount,equipmentAmount, sponsorPatientAmonut, foodkitAmount,monthList);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child:Text(
                                    'Pay Now',
                                    style: white16,
                                  ),
                                ),
                              );
                            }
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            // SizedBox(width: width/3,),
          ],
        ),)
      ],
    );
  }
}
