import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:provider/provider.dart';
import '../../constants/my_colors.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import '../../qmchModels/subScriberModel.dart';
class CashFreeCard extends StatelessWidget {
  String paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice;
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  List<MonthBool> monthList;
   CashFreeCard({Key? key
     ,required this.paymentCategory
     ,required this.equipmentCount
     ,required this.equipmentID
     ,required this.oneEquipmentPrice,required this.loginUsername,
     required this.loginUserID,required this.subScriberType,required this.loginUserPhone,
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
     MediaQueryData queryData;
     queryData = MediaQuery.of(context);
     var height = queryData.size.height;
     var width = queryData.size.width;
     DonationProvider donationProvider =
     Provider.of<DonationProvider>(context, listen: false);
     HomeProvider homeProvider = Provider.of<HomeProvider>(
         context, listen: false);
     return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text('Card'),
        centerTitle: true,
        backgroundColor: myGreenNewUI,
      ),
      body:Column(
        children: [
          Consumer<DonationProvider>(
              builder: (context, value, child) {
              return CreditCardForm(
                cardHolderName: value.cardHolderName,
                cardNumber: value.cardNumber,
                cvvCode: value.cvvCode,
                expiryDate: value.expiryDate,
                formKey: _formKey, // Required
                onCreditCardModelChange: (CreditCardModel data) {
                  donationProvider.onCardInputChange(data);
                }, // Required
                themeColor: Colors.red,
                cardNumberDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number',
                  hintText: 'XXXX XXXX XXXX XXXX',
                ),
                expiryDateDecoration: const InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  labelText: 'Expired Date',
                  hintText: 'XX/XX',
                ),
                cvvCodeDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CVV',
                  hintText: 'XXX',
                ),
                cardHolderDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Card Holder',
                ),
              );
            }
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
                      donationProvider.seamlessCardPayment(context,paymentCategory,
                          equipmentCount,equipmentID,oneEquipmentPrice,
                          loginUsername,loginUserID,subScriberType,loginUserPhone, zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice, foodkitPrice, footkitCount,equipmentAmount, sponsorPatientAmonut, foodkitAmount,monthList);
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
    );
  }
   Widget web(BuildContext context) {
     MediaQueryData queryData;
     queryData = MediaQuery.of(context);
     var height = queryData.size.height;
     var width = queryData.size.width;
     DonationProvider donationProvider =
     Provider.of<DonationProvider>(context, listen: false);
     HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
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
           // SizedBox(width: width/3,),
           SizedBox(width:width,
             child: Scaffold(
               appBar: AppBar(
                 leading: BackButton(),
                 title: const Text('Card'),
                 centerTitle: true,
                 backgroundColor: myGreenNewUI,
               ),
               body:Column(
                 children: [
                   Consumer<DonationProvider>(
                       builder: (context, value, child) {
                         return CreditCardForm(
                           cardHolderName: value.cardHolderName,
                           cardNumber: value.cardNumber,
                           cvvCode: value.cvvCode,
                           expiryDate: value.expiryDate,
                           formKey: _formKey, // Required
                           onCreditCardModelChange: (CreditCardModel data) {
                             donationProvider.onCardInputChange(data);
                           }, // Required
                           themeColor: Colors.red,
                           cardNumberDecoration: const InputDecoration(
                             border: OutlineInputBorder(),
                             labelText: 'Number',
                             hintText: 'XXXX XXXX XXXX XXXX',
                           ),
                           expiryDateDecoration: const InputDecoration(
                             border: OutlineInputBorder(
                             ),
                             labelText: 'Expired Date',
                             hintText: 'XX/XX',
                           ),
                           cvvCodeDecoration: const InputDecoration(
                             border: OutlineInputBorder(),
                             labelText: 'CVV',
                             hintText: 'XXX',
                           ),
                           cardHolderDecoration: const InputDecoration(
                             border: OutlineInputBorder(),
                             labelText: 'Card Holder',
                           ),
                         );
                       }
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
                                 donationProvider.seamlessCardPayment(context,paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice,
                                     loginUsername,loginUserID,subScriberType,loginUserPhone,
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
           // SizedBox(width: width/3,),
         ],
       ):
       Row(
         mainAxisSize: MainAxisSize.min,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           // SizedBox(width: width/3,),
           SizedBox(width:width/3,
             child: Scaffold(
               appBar: AppBar(
                 leading: BackButton(),
                 title: const Text('Card'),
                 centerTitle: true,
                 backgroundColor: myGreenNewUI,
               ),
               body:Column(
                 children: [
                   Consumer<DonationProvider>(
                       builder: (context, value, child) {
                         return CreditCardForm(
                           cardHolderName: value.cardHolderName,
                           cardNumber: value.cardNumber,
                           cvvCode: value.cvvCode,
                           expiryDate: value.expiryDate,
                           formKey: _formKey, // Required
                           onCreditCardModelChange: (CreditCardModel data) {
                             donationProvider.onCardInputChange(data);
                           }, // Required
                           themeColor: Colors.red,
                           cardNumberDecoration: const InputDecoration(
                             border: OutlineInputBorder(),
                             labelText: 'Number',
                             hintText: 'XXXX XXXX XXXX XXXX',
                           ),
                           expiryDateDecoration: const InputDecoration(
                             border: OutlineInputBorder(
                             ),
                             labelText: 'Expired Date',
                             hintText: 'XX/XX',
                           ),
                           cvvCodeDecoration: const InputDecoration(
                             border: OutlineInputBorder(),
                             labelText: 'CVV',
                             hintText: 'XXX',
                           ),
                           cardHolderDecoration: const InputDecoration(
                             border: OutlineInputBorder(),
                             labelText: 'Card Holder',
                           ),
                         );
                       }
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
                                 donationProvider.seamlessCardPayment(context,paymentCategory,equipmentCount,
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
           // SizedBox(width: width/3,),
         ],
       ),)
     ],);
  }
}
