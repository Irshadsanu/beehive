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
import '../qmchModels/equipmentModel.dart';

class MultiplePaymentScreen extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
   MultiplePaymentScreen({Key? key,required this.loginUsername,required this.loginUserID
     ,required this.subScriberType,required this.loginUserPhone,  required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
      Consumer<DonationProvider>(
        builder: (context,value,child) {
          return InkWell(onTap: (){
            print(value.patientAmountCT.text+' CISMIJCSNIC');
            if( value.allTotal>0){
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
                  donationProvider.kpccAmountController.text = value.allTotal.toString();
                  donationProvider.onAmountChange('');
                  donationProvider.clearGenderAndAgedata();
                  donationProvider.selectedPanjayathChip = null;
                  donationProvider.chipsetWardList.clear();
                  donationProvider.selectedWard = null;
                  '1';
                  donationProvider.minimumbool = true;
                  donationProvider.clearDonateScreen();
                  callNext(DonatePage(
                    loginUserPhone: loginUserPhone,
                    subScriberType: subScriberType,
                    oneEquipmentPrice:value.equipmentSelectedIDCT.text!=''? value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.equipmentPrice:'0',
                      paymentCategory: 'MULTIPLE_PAYMENT',
                    equipmentCount:value.equipmentSelectedIDCT.text!=''? value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.selectedCount.toString():'0',
                      equipmentID: value.equipmentSelectedIDCT.text!=''? value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.id:'0',
                    loginUserID: loginUserID,
                    loginUsername: loginUsername,
                  zakathAmount: value.zakathTotal.toString(),
                    sponsorPatientAmonut: value.patientTotal.toString(),
                    sponsorItemOnePrice: value.patientSelectedCT.text!=''?value.sponsershipDiseaseList.where((element) => element.name==value.patientSelectedCT.text).first.price.toString():'0',
                  sponsorCount:value.patientSelectedNameCT.text!=''? value.sponsershipDiseaseList.where((element) => element.name==value.patientSelectedNameCT.text).first.count.toString():"0",
                    sponsorCategory:  value.patientSelectedCT.text!=''?value.sponsershipDiseaseList.where((element) => element.name==value.patientSelectedCT.text).first.name:'0',
                    footkitCount:value.footkitSponserList[0].count.toString(),
                    deseaseName: value.monthlyPayAmount.toString(),///Monthly pay total
                      foodkitPrice:value.footkitSponserList[0].price.toString() ,
                    equipmentAmount:value.equipmntTotal.toString() ,
                    foodkitAmount: value.footkitTotal.toString(),
                    monthList:value.monthList, ), context);
                } else {
                  callNext( NoPaymentGateway(
                    loginUserPhone: loginUserPhone,
                    subScriberType: subScriberType,
                    loginUserID: loginUserID,
                    loginUsername: loginUsername,
                    zakathAmount: value.zakathTotal.toString(),
                    sponsorPatientAmonut: value.patientTotal.toString(),
                    sponsorItemOnePrice: value.patientSelectedCT.text!=''?value.sponsershipDiseaseList.where((element) => element.name==value.patientSelectedCT.text).first.price.toString():'0',
                    sponsorCount: value.sponsershipDiseaseList.where((element) => element.name==value.patientSelectedNameCT.text).first.count.toString(),
                    sponsorCategory:  value.patientSelectedCT.text!=''?value.sponsershipDiseaseList.where((element) => element.name==value.patientSelectedCT.text).first.name:'0',
                    footkitCount: value.footkitSponserList[0].count.toString(),
                    deseaseName: deseaseName,
                    foodkitPrice:value.footkitSponserList[0].price.toString() ,
                    equipmentAmount:value.equipmntTotal.toString() ,
                    foodkitAmount: value.footkitTotal.toString(),), context);
                }
              });
            }else{
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(backgroundColor: Colors.red,
                content: Text("Please select one payment",style: TextStyle(color: Colors.white),),
                duration: Duration(milliseconds: 3000),
              ));
            }


          },
            child: Container(
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
                        "Pay Now",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "PoppinsMedium",
                            color: myWhite,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
            ),
          );
        }
      ),
      appBar: AppBar(
        backgroundColor: myWhite,
        elevation: 0,
        centerTitle: true,
        leading: Center(
          child: InkWell(onTap: (){
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
          "Multiple Payment",style: TextStyle(
            color: myBlack,
            fontSize: 15,
            fontFamily: 'PoppinsRegular',
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5
        ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 15.0),
             child: Column(
               children: [
                 const SizedBox(height:10),

                 ///Zakat
                 Container(
                   height: 150,
                   padding: const EdgeInsets.all(8),
                   decoration: ShapeDecoration(
                     color: myWhite,
                     shape: RoundedRectangleBorder(
                       side: const BorderSide(
                         width: 0.20,
                         strokeAlign: BorderSide.strokeAlignOutside,
                         color: clCACACA,
                       ),
                       borderRadius: BorderRadius.circular(18),
                     ),
                     shadows: const [
                       BoxShadow(
                         color: Color(0x0A000000),
                         blurRadius: 5.15,
                         offset: Offset(0, 2.58),
                         spreadRadius: 0,
                       )
                     ],
                   ),
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         width: 85,
                         height: 85 ,
                         padding: const EdgeInsets.all(5),
                         decoration: ShapeDecoration(
                           image: const DecorationImage(
                               image: AssetImage("assets/zakatImg.png"),scale: 3
                           ),
                           color: myWhite,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(13.27),
                           ),
                           shadows: const [
                             BoxShadow(
                               color: Color(0x19000000),
                               blurRadius: 17.12,
                               offset: Offset(0, 0),
                               spreadRadius: 0,
                             )
                           ],
                         ),
                       ),

                       const SizedBox(width: 10,),

                       Flexible(
                         fit:FlexFit.tight,
                         child: Column(
                           mainAxisAlignment:
                           MainAxisAlignment.start,
                           crossAxisAlignment:
                           CrossAxisAlignment.start,
                           children: [
                             const Text(
                               'Zakat',
                               style: TextStyle(
                                 color: cl3E4FA3,
                                 fontSize: 14,
                                 fontFamily: 'JaldiBold',
                                 fontWeight: FontWeight.w400,
                                 // height: 0.06,
                               ),
                             ),
                             const Text(
                               'Your Zakat transforms lives. Give hope, make an impact. Donate now.',
                               style: TextStyle(
                                 color: myBlack,
                                 fontSize: 11,
                                 fontFamily: 'Poppins',
                                 fontWeight: FontWeight.w400,
                                 // height: 0.11,
                               ),
                             ),

                             const SizedBox(height: 8,),

                             Consumer<DonationProvider>(
                                 builder: (context,value,child) {
                                   return TextFormField(

                                     cursorColor: cl253068,
                                     onChanged: (data){
                                       value.calculateMultiplePay('ZAKATH');
                                     },
                                     keyboardType: TextInputType.number,
                                     textAlign:  TextAlign.center ,
                                     controller: value.zakathAmountCT,
                                     style: const TextStyle(color:myBlack, fontSize: 17,fontFamily: 'Poppins',),
                                     decoration: InputDecoration(
                                       fillColor:  const Color(0xFFF5F5F5),
                                         filled: true,
                                         contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                         hintText: 'Amount',
                                         helperText: "",
                                         hintStyle: TextStyle(color: searchBartext,
                                           fontFamily: 'Poppins',
                                         ),

                                         focusedBorder:const OutlineInputBorder(
                                           borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                           borderSide: BorderSide(color: Colors.white),
                                         ),
                                         enabledBorder:const OutlineInputBorder(
                                           borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                           borderSide: BorderSide(color: Colors.white),
                                         ),
                                         errorBorder: const OutlineInputBorder(
                                           borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                           borderSide: BorderSide(color: Colors.white),
                                         ),
                                         border:const OutlineInputBorder(
                                           borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                           borderSide: BorderSide(color: Colors.white),
                                         )
                                     ),

                                     validator: (value) {
                                       if (value!.isEmpty) {
                                         return 'Enter Name';
                                       }

                                       return null;
                                     },
                                   );
                                 }
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),

                 const SizedBox(height: 10,),

                 ///Equipment
                 Container(
                   // height: 150,
                   padding: const EdgeInsets.all(8),
                   decoration: ShapeDecoration(
                     color: myWhite,
                     shape: RoundedRectangleBorder(
                       side: const BorderSide(
                         width: 0.20,
                         strokeAlign: BorderSide.strokeAlignOutside,
                         color: clCACACA,
                       ),
                       borderRadius: BorderRadius.circular(18),
                     ),
                     shadows: const [
                       BoxShadow(
                         color: Color(0x0A000000),
                         blurRadius: 5.15,
                         offset: Offset(0, 2.58),
                         spreadRadius: 0,
                       )
                     ],
                   ),
                   child: Column(
                     children: [
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             width: 85,
                             height: 85,
                             padding: const EdgeInsets.all(5),
                             decoration: ShapeDecoration(
                               image: const DecorationImage(
                                   image: AssetImage("assets/SponsorEquipmentImg.png"),scale: 3
                               ),
                               color: myWhite,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(13.27),
                               ),
                               shadows: const [
                                 BoxShadow(
                                   color: Color(0x19000000),
                                   blurRadius: 17.12,
                                   offset: Offset(0, 0),
                                   spreadRadius: 0,
                                 )
                               ],
                             ),
                           ),

                           const SizedBox(width: 10,),

                           Flexible(
                             fit:FlexFit.tight,
                             child: Column(
                               mainAxisAlignment:
                               MainAxisAlignment.start,
                               crossAxisAlignment:
                               CrossAxisAlignment.start,
                               children: const [
                                 Text(
                                   'Equipment',
                                   style: TextStyle(
                                     color: cl3E4FA3,
                                     fontSize: 14,
                                     fontFamily: 'JaldiBold',
                                     fontWeight: FontWeight.w400,
                                     // height: 0.06,
                                   ),
                                 ),
                                 Text(
                                   'consectetur adipiscing elit. Ut viverra sapien in est porta, vel cursus urna rutrum.',
                                   style: TextStyle(
                                     color: myBlack,
                                     fontSize: 11,
                                     fontFamily: 'Poppins',
                                     fontWeight: FontWeight.w400,
                                     // height: 0.11,
                                   ),
                                 ),

                                 // Consumer<DonationProvider>(
                                 //     builder: (context,value,child) {
                                 //       return SizedBox(
                                 //         height:70,
                                 //         child: TextFormField(
                                 //           cursorColor: cl253068,
                                 //           onChanged: (data){
                                 //             value.calculateMultiplePay('EQUIPMENT');
                                 //           },
                                 //           keyboardType: TextInputType.number,
                                 //           enabled: value.equipmentSelectedCT.text!=''?true:false,
                                 //           textAlign:  TextAlign.center ,
                                 //           controller: value.equipmentAmountCT,
                                 //           style:const TextStyle(color:myBlack, fontSize: 17,fontFamily: 'Poppins',),
                                 //           decoration: InputDecoration(
                                 //               contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                 //               hintText: 'Count',
                                 //               helperText: "",
                                 //               hintStyle: TextStyle(color: searchBartext,
                                 //                 fontFamily: 'Poppins',
                                 //               ),
                                 //               focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: cl253068),),
                                 //               enabledBorder: const UnderlineInputBorder(
                                 //                 borderSide: BorderSide(color:cl253068),
                                 //               ),
                                 //               errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: cl253068),),
                                 //               border: const UnderlineInputBorder(borderSide: BorderSide(color: cl253068),)
                                 //           ),
                                 //
                                 //           validator: (value) {
                                 //             if (value!.isEmpty) {
                                 //               return 'Enter Count';
                                 //             }
                                 //
                                 //             return null;
                                 //           },
                                 //         ),
                                 //       );
                                 //     }
                                 // ),
                               ],
                             ),
                           ),
                         ],
                       ),

                       const SizedBox(height: 10,),

                       //colum
                       Column(
                         children:[
                           Consumer<DonationProvider>(
                               builder: (context,value,child) {
                                 return SizedBox(
                                   height:40,
                                   width: double.infinity,
                                   child: Autocomplete<EquipmentModel>(
                                     optionsBuilder: (TextEditingValue textEditingValue) {
                                       return (value.filterEquipmentsList)
                                           .where((EquipmentModel wardd) => wardd.equipmentName.toLowerCase()
                                           .contains(textEditingValue.text.toLowerCase()))
                                           .toList();
                                     },
                                     displayStringForOption: (EquipmentModel option) => option.equipmentName,
                                     fieldViewBuilder: (
                                         BuildContext context,
                                         TextEditingController fieldTextEditingController,
                                         FocusNode fieldFocusNode,
                                         VoidCallback onFieldSubmitted
                                         ) {
                                       WidgetsBinding.instance.addPostFrameCallback((_) {
                                         fieldTextEditingController.text = value.equipmentSelectedCT.text;
                                       });
                                       print("gsggsahsuhw"+value.filterEquipmentsList.length.toString());
                                       return SizedBox(
                                         height: 43,
                                         child: TextFormField(
                                           onChanged: (value2){
                                             if(value2==''){
                                               value.equipmentSelectedCT.text='';
                                               value.equipmntTotal=0;
                                               value.clearEquipments();
                                             }
                                           },
                                           textAlign: TextAlign.center,
                                           style: const TextStyle(color:myBlack, fontSize: 14,fontFamily: 'Poppins',),
                                           decoration:  InputDecoration(
                                               contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                               hintText:'Select Equipment',
                                               hintStyle: TextStyle(color: searchBartext,fontSize: 16,fontWeight: FontWeight.normal,
                                                   fontFamily: 'Poppins'
                                               ),
                                               focusedBorder: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(9),
                                                 borderSide: const BorderSide(
                                                   color: clCACACADark,
                                                   width: 0.05,
                                                 ),
                                               ),
                                               enabledBorder:  OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(9),
                                                 borderSide: const BorderSide(
                                                   color: clCACACADark,
                                                   width: 0.05,
                                                 ),
                                               ),
                                               disabledBorder:  OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(9),
                                                 borderSide: const BorderSide(
                                                   color: clCACACADark,
                                                   width: 0.05,
                                                 ),
                                               ),
                                               suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined,color:myBlack)
                                           ),
                                           controller: fieldTextEditingController,
                                           focusNode: fieldFocusNode,
                                           // validator: (text) => value.assemblyList.map((e) => e.assembly.contains(text)) ? "Please Select Your Assembly" : null,
                                           validator: (value2) {
                                             if (value2!.trim().isEmpty || !value.filterEquipmentsList.map((item) => item.equipmentName.trim()).contains(value2.trim())) {
                                               return "Please Select Your State";
                                             } else {
                                               return null;
                                             }
                                           },
                                         ),
                                       );

                                     },
                                     onSelected: (EquipmentModel selection) {
                                       value.clearEquipments();
                                       value.equipmentSelectedCT.text=selection.equipmentName;
                                       value.setPickedID(selection.id);
                                       FocusManager.instance.primaryFocus?.unfocus();
                                     },
                                     optionsViewBuilder: (
                                         BuildContext context,
                                         AutocompleteOnSelected<EquipmentModel> onSelected,
                                         Iterable<EquipmentModel> options
                                         ) {
                                       return Align(
                                         alignment: Alignment.topCenter,
                                         child: Material(
                                           child: Container(
                                             width: width*0.6,
                                             height: 400,
                                             color: Colors.white,
                                             child: ListView.builder(
                                               padding: const EdgeInsets.all(10.0),
                                               itemCount: options.length,
                                               itemBuilder: (BuildContext context, int index) {
                                                 final EquipmentModel option = options.elementAt(index);

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
                                                           Text(option.equipmentName,
                                                               style: const TextStyle(
                                                                   color: Colors.black,
                                                                   fontWeight: FontWeight.bold)),
                                                           // Text(option.district,style: const TextStyle(
                                                           //   color: Colors.black,
                                                           //     fontSize: 12
                                                           // ),),
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
                                 );
                               }
                           ),

                           // Consumer<DonationProvider>(
                           //   builder: (context,value,child) {
                           //     return value.equipmentSelectedIDCT.text!=''?
                           //     Positioned(
                           //         bottom: 0,
                           //         child:(value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.collectedCount
                           //             /value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.requeredCount)*100>0?
                           //         PercentageIndicator(percentage: (value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.collectedCount
                           //             /value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.requeredCount)*100):SizedBox()
                           //     ):SizedBox();
                           //   }
                           // ),

                           ///
                           // Consumer<DonationProvider>(
                           //     builder: (context,value,child) {
                           //       return
                           //         Positioned(
                           //             bottom: 0,
                           //             child:
                           //             PercentageIndicatorMultiple(percentage:10/50*100)
                           //         );
                           //     }
                           // ),

                           const SizedBox(height: 5,),

                           Consumer<DonationProvider>(
                               builder: (context,value,child) {
                                 return value.equipmentSelectedIDCT.text!=''?
                                 Align(
                                   alignment:Alignment.centerRight,
                                   child: Text(value.filterEquipmentsList.where((element) =>
                                   element.id==value.equipmentSelectedIDCT.text).first.collectedCount.toString() +
                                       '/' +
                                       value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.requeredCount.toString(),
                                     style: const TextStyle(
                                       fontFamily: 'Poppins',
                                       color:myBlack,
                                       fontSize:10,
                                     ),
                                   ),
                                 ):const SizedBox();
                               }
                           ),

                           const SizedBox(height: 10,),

                           Row(
                               children:[
                                 Expanded(
                                   flex:1,
                                   child: Consumer<DonationProvider>(
                                       builder: (context,value,child) {
                                         return Center(child:value.equipmntTotal>0? Text(value.equipmntTotal.toString(),
                                           style: const TextStyle(
                                           color: myBlack,
                                           fontSize: 13.14,
                                           fontFamily: 'PoppinsRegular',
                                           fontWeight: FontWeight.w700,
                                         ),
                                         ):SizedBox());
                                       }
                                   ),
                                 ),

                                 const SizedBox(width:15),

                                 Expanded(
                                   flex:1,
                                   child: Consumer<DonationProvider>(
                                       builder: (context,value,child) {
                                         return Container(
                                           decoration: BoxDecoration(
                                               color: myWhite,
                                               borderRadius:
                                               BorderRadius.circular(10)),

                                           child: Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment
                                                   .spaceEvenly,

                                               children: [
                                                 value.equipmentSelectedIDCT.text!=''?
                                                 InkWell(
                                                   onTap: () {
                                                     donationProvider
                                                         .equipmentCountDecrease(
                                                       value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.requeredCount,
                                                       value.filterEquipmentsList.indexWhere((element) => element.id==value.equipmentSelectedIDCT.text),
                                                       value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.collectedCount,
                                                     );
                                                     value.calculateMultiplePay('EQUIPMENT');
                                                   },
                                                   child: Container(
                                                     width: 27,
                                                     height: 27,
                                                     decoration: BoxDecoration(
                                                         color: cl_F5F5F5,
                                                         borderRadius:
                                                         BorderRadius
                                                             .circular(8)),
                                                     child: const Icon(
                                                       CupertinoIcons.minus,
                                                       color: cl_253068,
                                                       size: 15,
                                                     ),
                                                   ),
                                                 ):const SizedBox(),
                                                 value.equipmentSelectedIDCT.text!=''?
                                                 Text(
                                                   value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.selectedCount.toString(),
                                                   style: const TextStyle(
                                                       color: myBlack,
                                                       fontFamily: 'Poppins',
                                                       fontWeight:
                                                       FontWeight.w600,
                                                       fontSize: 11
                                                   ),
                                                 ):const SizedBox(),



                                                 value.equipmentSelectedIDCT.text!=''?
                                                 InkWell(
                                                   onTap: () {
                                                     donationProvider
                                                         .equipmentCountIncrease(
                                                         value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.requeredCount,
                                                         value.filterEquipmentsList.indexWhere((element) => element.id==value.equipmentSelectedIDCT.text),
                                                         value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.collectedCount,
                                                         value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.collectedCount+value.filterEquipmentsList.where((element) => element.id==value.equipmentSelectedIDCT.text).first.selectedCount
                                                     );
                                                     value.calculateMultiplePay('EQUIPMENT');

                                                   },
                                                   child: Container(
                                                     width: 27,
                                                     height: 27,
                                                     decoration: BoxDecoration(
                                                         color: cl_F5F5F5,
                                                         borderRadius:
                                                         BorderRadius
                                                             .circular(8)),
                                                     child: const Icon(
                                                       CupertinoIcons.add,
                                                       color: cl_253068,
                                                       size: 15,
                                                     ),
                                                   ),
                                                 ):const SizedBox(),
                                               ],
                                             ),
                                           ),
                                         );
                                       }
                                   ),
                                 ),
                               ]
                           )
                         ]
                       )
                     ],
                   ),
                 ),

                 const SizedBox(height: 10,),
                 ///Patient

                 Container(
                   // height: 150,
                   padding: const EdgeInsets.all(8),
                   decoration: ShapeDecoration(
                     color: myWhite,
                     shape: RoundedRectangleBorder(
                       side: const BorderSide(
                         width: 0.20,
                         strokeAlign: BorderSide.strokeAlignOutside,
                         color: clCACACA,
                       ),
                       borderRadius: BorderRadius.circular(18),
                     ),
                     shadows: const [
                       BoxShadow(
                         color: Color(0x0A000000),
                         blurRadius: 5.15,
                         offset: Offset(0, 2.58),
                         spreadRadius: 0,
                       )
                     ],
                   ),
                   child: Column(
                     children: [
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             width: 85,
                             height: 85,
                             padding: const EdgeInsets.all(5),
                             decoration: ShapeDecoration(
                               image: const DecorationImage(
                                   image: AssetImage("assets/SponsoraPatientImg.png"),scale: 3
                               ),
                               color: myWhite,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(13.27),
                               ),
                               shadows: const [
                                 BoxShadow(
                                   color: Color(0x19000000),
                                   blurRadius: 17.12,
                                   offset: Offset(0, 0),
                                   spreadRadius: 0,
                                 )
                               ],
                             ),
                           ),

                           const SizedBox(width: 10,),

                           Flexible(
                             fit:FlexFit.tight,
                             child: Column(
                               mainAxisAlignment:
                               MainAxisAlignment.start,
                               crossAxisAlignment:
                               CrossAxisAlignment.start,
                               children: const [
                                 Text(
                                   'Patient',
                                   style: TextStyle(
                                     color: cl3E4FA3,
                                     fontSize: 14,
                                     fontFamily: 'JaldiBold',
                                     fontWeight: FontWeight.w400,
                                     // height: 0.06,
                                   ),
                                 ),

                                 Text(
                                   'consectetur adipiscing elit. Ut viverra sapien in est porta, vel cursus urna rutrum.',
                                   style: TextStyle(
                                     color: myBlack,
                                     fontSize: 11,
                                     fontFamily: 'Poppins',
                                     fontWeight: FontWeight.w400,
                                     // height: 0.11,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),

                       const SizedBox(height: 10,),

                       Column(
                           children:[
                             Consumer<DonationProvider>(
                                 builder: (context,value,child) {
                                   return SizedBox(
                                     height:45,
                                     width: double.infinity,
                                     child: Autocomplete<SponsershipDiseaseModel>(
                                       optionsBuilder: (TextEditingValue textEditingValue) {
                                         return (value.sponsershipDiseaseList)
                                             .where((SponsershipDiseaseModel wardd) => wardd.name.toLowerCase()
                                             .contains(textEditingValue.text.toLowerCase()))
                                             .toList();
                                       },
                                       displayStringForOption: (SponsershipDiseaseModel option) => option.name,
                                       fieldViewBuilder: (
                                           BuildContext context,
                                           TextEditingController fieldTextEditingController,
                                           FocusNode fieldFocusNode,
                                           VoidCallback onFieldSubmitted
                                           ) {
                                         WidgetsBinding.instance.addPostFrameCallback((_) {
                                           fieldTextEditingController.text = value.patientSelectedCT.text;
                                         });
                                         print("gsggsahsuhw"+value.sponsershipDiseaseList.length.toString());
                                         return SizedBox(
                                           height: 43,
                                           child: TextFormField(
                                             onChanged: (value2){
                                               value.sponserMultipaymenrClear();
                                               value.patientSelectedCT.text='';
                                             },
                                             textAlign: TextAlign.center,
                                             cursorColor: cl253068,
                                             decoration:  InputDecoration(
                                                 contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                 hintText:'Select Type',
                                                 hintStyle: TextStyle(color: searchBartext,fontSize: 14,fontWeight: FontWeight.normal,
                                                     fontFamily: 'Poppins'
                                                 ),
                                                 focusedBorder: OutlineInputBorder(
                                                   borderRadius: BorderRadius.circular(9),
                                                   borderSide: const BorderSide(
                                                     color: clCACACADark,
                                                     width: 0.05,
                                                   ),
                                                 ),
                                                 enabledBorder:  OutlineInputBorder(
                                                   borderRadius: BorderRadius.circular(9),
                                                   borderSide: const BorderSide(
                                                     color: clCACACADark,
                                                     width: 0.05,
                                                   ),
                                                 ),
                                                 disabledBorder:  OutlineInputBorder(
                                                   borderRadius: BorderRadius.circular(9),
                                                   borderSide: const BorderSide(
                                                     color: clCACACADark,
                                                     width: 0.05,
                                                   ),
                                                 ),
                                                 suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined,color:myBlack)
                                             ),
                                             controller: fieldTextEditingController,
                                             focusNode: fieldFocusNode,
                                             style: const TextStyle(color:myBlack, fontSize: 14,fontFamily: 'Poppins',),
                                             // validator: (text) => value.assemblyList.map((e) => e.assembly.contains(text)) ? "Please Select Your Assembly" : null,
                                             validator: (value2) {
                                               if (value2!.trim().isEmpty || !value.sponsershipDiseaseList.map((item) => item.name.trim()).contains(value2.trim())) {
                                                 return "Please Select Your State";
                                               } else {
                                                 return null;
                                               }
                                             },
                                           ),
                                         );

                                       },
                                       onSelected: (SponsershipDiseaseModel selection) {
                                         value.sponserMultipaymenrClear();
                                         value.patientSelectedCT.text=selection.name;
                                         value.setPatientType(selection.name);
                                         FocusManager.instance.primaryFocus?.unfocus();
                                       },
                                       optionsViewBuilder: (
                                           BuildContext context,
                                           AutocompleteOnSelected<SponsershipDiseaseModel> onSelected,
                                           Iterable<SponsershipDiseaseModel> options
                                           ) {
                                         return Align(
                                           alignment: Alignment.topCenter,
                                           child: Material(
                                             child: Container(
                                               width: width*0.6,
                                               height: 400,
                                               color: Colors.white,
                                               child: ListView.builder(
                                                 padding: const EdgeInsets.all(10.0),
                                                 itemCount: options.length,
                                                 itemBuilder: (BuildContext context, int index) {
                                                   final SponsershipDiseaseModel option = options.elementAt(index);

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
                                                             Text(option.name,
                                                                 style: const TextStyle(
                                                                     color: Colors.black,
                                                                     fontWeight: FontWeight.bold)),
                                                             // Text(option.district,style: const TextStyle(
                                                             //   color: Colors.black,
                                                             //     fontSize: 12
                                                             // ),),
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
                                   );
                                 }
                             ),

                             const SizedBox(height: 15,),

                             Row(
                                 children:[
                                   Expanded(
                                     flex:1,
                                     child: Center(
                                       child: Consumer<DonationProvider>(
                                           builder: (context,value,child) {
                                             return value.patientTotal>0?
                                             Text(value.patientTotal.toString(),style: const TextStyle(
                                               color: myBlack,
                                               fontSize: 13.14,
                                               fontFamily: 'PoppinsRegular',
                                               fontWeight: FontWeight.w700,
                                             ),
                                             ):SizedBox();
                                           }
                                       ),
                                     ),
                                   ),

                                   const SizedBox(width: 15,),

                                   Expanded(
                             flex:1,
                                     child: Consumer<DonationProvider>(
                                         builder: (context,value,child) {
                                           return
                                             value.patientSelectedNameCT.text!=''?
                                             Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment
                                                   .spaceEvenly,
                                               children: [
                                                 InkWell(
                                                   onTap: () {
                                                     donationProvider.decrementDiseasePrice(value.sponsershipDiseaseList.indexWhere((element) => element.name==value.patientSelectedNameCT.text));
                                                     value.calculateMultiplePay('PATIENT');
                                                   },
                                                   child: Container(
                                                     width: 27,
                                                     height: 27,
                                                     decoration: BoxDecoration(
                                                         color: cl_F5F5F5,
                                                         borderRadius:
                                                         BorderRadius
                                                             .circular(8)),
                                                     child: const Icon(
                                                       CupertinoIcons.minus,
                                                       color: cl_253068,
                                                       size: 15,
                                                     ),
                                                   ),
                                                 ),

                                                 value.patientSelectedNameCT.text!=''?
                                                 Text(
                                                   value.sponsershipDiseaseList.where((element) => element.name==value.patientSelectedNameCT.text).first.count.toString(),
                                                   style: const TextStyle(
                                                       color: myBlack,
                                                       fontFamily: 'Poppins',
                                                       fontWeight:
                                                       FontWeight.w600,
                                                       fontSize: 11
                                                   ),
                                                 ):const SizedBox(),

                                                 InkWell(
                                                   onTap: () {
                                                     donationProvider.incrementDiseasePrice(value.sponsershipDiseaseList.indexWhere((element) => element.name==value.patientSelectedNameCT.text));
                                                     value.calculateMultiplePay('PATIENT');

                                                   },
                                                   child: Container(
                                                     width: 27,
                                                     height: 27,
                                                     decoration: BoxDecoration(
                                                         color: cl_F5F5F5,
                                                         borderRadius:
                                                         BorderRadius
                                                             .circular(8)),
                                                     child: const Icon(
                                                       CupertinoIcons.add,
                                                       color: cl_253068,
                                                       size: 15,
                                                     ),
                                                   ),
                                                 ),
                                               ],
                                             ):const SizedBox();
                                         }
                                     ),
                                   ),


                                 ]
                             )


                             // Consumer<DonationProvider>(
                             //     builder: (context,value,child) {
                             //       return SizedBox(
                             //         height:70,
                             //         child: TextFormField(
                             //           cursorColor: cl253068,
                             //           onChanged: (data){
                             //             value.calculateMultiplePay('PATIENT');
                             //           },
                             //           keyboardType: TextInputType.number,
                             //           enabled: value.patientSelectedCT.text!=''?true:false,
                             //           textAlign:  TextAlign.center ,
                             //           controller: value.patientAmountCT,
                             //           style:const TextStyle(color:myBlack, fontSize: 17,fontFamily: 'Poppins',),
                             //           decoration: InputDecoration(
                             //               contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                             //               hintText: 'Count',
                             //               helperText: "",
                             //               hintStyle: TextStyle(color: searchBartext,
                             //                 fontFamily: 'Poppins',
                             //               ),
                             //               focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: cl253068),),
                             //               enabledBorder: const UnderlineInputBorder(
                             //                 borderSide: BorderSide(color:cl253068),
                             //               ),
                             //               errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: cl253068),),
                             //               border: const UnderlineInputBorder(borderSide: BorderSide(color: cl253068),)
                             //           ),
                             //
                             //           validator: (value) {
                             //             if (value!.isEmpty) {
                             //               return 'Enter Name';
                             //             }
                             //
                             //             return null;
                             //           },
                             //         ),
                             //       );
                             //     }
                             // ),
                           ]
                       )
                     ],
                   ),
                 ),

                 const SizedBox(height: 10,),

                 ///Food kit

                 Container(
                   // height: 150,
                   padding: const EdgeInsets.all(8),
                   decoration: ShapeDecoration(
                     color: myWhite,
                     shape: RoundedRectangleBorder(
                       side: const BorderSide(
                         width: 0.20,
                         strokeAlign: BorderSide.strokeAlignOutside,
                         color: clCACACA,
                       ),
                       borderRadius: BorderRadius.circular(18),
                     ),
                     shadows: const [
                       BoxShadow(
                         color: Color(0x0A000000),
                         blurRadius: 5.15,
                         offset: Offset(0, 2.58),
                         spreadRadius: 0,
                       )
                     ],
                   ),

                   child: Column(
                     children: [
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             width: 85,
                             height: 85,
                             padding: const EdgeInsets.all(5),
                             decoration: ShapeDecoration(
                               image: const DecorationImage(
                                   image: AssetImage("assets/contributionImg.png"),scale: 3
                               ),
                               color: myWhite,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(13.27),
                               ),
                               shadows: const [
                                 BoxShadow(
                                   color: Color(0x19000000),
                                   blurRadius: 17.12,
                                   offset: Offset(0, 0),
                                   spreadRadius: 0,
                                 )
                               ],
                             ),
                           ),

                           const SizedBox(width: 10,),

                           Flexible(
                             fit:FlexFit.tight,
                             child: Column(
                               mainAxisAlignment:
                               MainAxisAlignment.start,
                               crossAxisAlignment:
                               CrossAxisAlignment.start,
                               children: const [
                                 Text(
                                   'Food kit',
                                   style: TextStyle(
                                     color: cl3E4FA3,
                                     fontSize: 14,
                                     fontFamily: 'JaldiBold',
                                     fontWeight: FontWeight.w400,
                                     // height: 0.06,
                                   ),
                                 ),
                                 Text(
                                   'consectetur adipiscing elit. Ut viverra sapien in est porta, vel cursus urna rutrum.',
                                   style: TextStyle(
                                     color: myBlack,
                                     fontSize: 11,
                                     fontFamily: 'Poppins',
                                     fontWeight: FontWeight.w400,
                                     // height: 0.11,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),

                       const SizedBox(height: 10,),

                       Row(
                         children:[

                           Expanded(
                             flex:1,
                             child: Center(
                               child: Consumer<DonationProvider>(
                                   builder: (context,value,child) {
                                     return value.footkitTotal>0?Text(value.footkitTotal.toString(),style: const TextStyle(
                                     color: myBlack,
                                     fontSize: 13.14,
                                     fontFamily: 'PoppinsRegular',
                                     fontWeight: FontWeight.w700,
                                     ),):SizedBox();
                                   }
                               ),
                             ),
                           ),

                           const SizedBox(height: 15,),

                           Expanded(
                             flex:1,
                             child: Consumer<DonationProvider>(
                                 builder: (context,value,child) {
                                   return Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment
                                           .spaceEvenly,
                                       children:[
                                         InkWell(
                                           onTap: (){
                                             donationProvider.decrementFoodkit();
                                             value.calculateMultiplePay('FOODKIT');
                                           },
                                           child: Container(
                                             width: 27,
                                             height: 27,
                                             decoration: BoxDecoration(
                                                 color: cl_F5F5F5,
                                                 borderRadius:
                                                 BorderRadius
                                                     .circular(8)),
                                             child: const Icon(
                                               CupertinoIcons.minus,
                                               color: cl_253068,
                                               size: 15,
                                             ),
                                           ),
                                         ),


                                         Text(
                                           value.footkitSponserList[0].count.toString(),
                                           style: const TextStyle(
                                               color: myBlack,
                                               fontFamily: 'Poppins',
                                               fontWeight:
                                               FontWeight.w600,
                                               fontSize: 11
                                           ),
                                         ),


                                         InkWell(
                                           onTap: (){
                                             donationProvider.incrementFoodKit();
                                             value.calculateMultiplePay('FOODKIT');
                                           },
                                           child: Container(
                                             width: 27,
                                             height: 27,
                                             decoration: BoxDecoration(
                                                 color: cl_F5F5F5,
                                                 borderRadius:
                                                 BorderRadius
                                                     .circular(8)),
                                             child: const Icon(Icons.add,color: cl253068, size: 15,),
                                           ),
                                         ),

                                       ]
                                   );
                                 }
                             ),
                           ),

                           ///textField Count
                           // SizedBox(height: 10,),
                           // Consumer<DonationProvider>(
                           //     builder: (context,value,child) {
                           //       return TextFormField(
                           //         cursorColor: cl253068,
                           //         onChanged: (data){
                           //           value.calculateMultiplePay('FOODKIT');
                           //         },
                           //         keyboardType: TextInputType.number,
                           //         textAlign:  TextAlign.center ,
                           //         controller: value.foodkitAmountCT,
                           //         style: const TextStyle(color:myBlack, fontSize: 17,fontFamily: 'Poppins',),
                           //         decoration: InputDecoration(
                           //             contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                           //             hintText: 'Count',
                           //             helperText: "",
                           //             hintStyle: TextStyle(color: searchBartext,
                           //               fontFamily: 'Poppins',
                           //             ),
                           //
                           //             focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: cl253068),),
                           //             enabledBorder: const UnderlineInputBorder(
                           //               borderSide: BorderSide(color:cl253068),
                           //             ),
                           //             errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: cl253068),),
                           //             border: const UnderlineInputBorder(borderSide: BorderSide(color: cl253068),)
                           //         ),
                           //
                           //         validator: (value) {
                           //           if (value!.isEmpty) {
                           //             return 'Enter Name';
                           //           }
                           //
                           //           return null;
                           //         },
                           //       );
                           //     }
                           // ),
                         ]
                       )
                     ],
                   ),
                 ),

                 const SizedBox(height: 10,),

                 ///Members Payment

                 subScriberType=='SUBSCRIBER' ?
                 Container(
                   // height: 150,
                   padding: const EdgeInsets.all(8),
                   decoration: ShapeDecoration(
                     color: myWhite,
                     shape: RoundedRectangleBorder(
                       side: const BorderSide(
                         width: 0.20,
                         strokeAlign: BorderSide.strokeAlignOutside,
                         color: clCACACA,
                       ),
                       borderRadius: BorderRadius.circular(18),
                     ),
                     shadows: const [
                       BoxShadow(
                         color: Color(0x0A000000),
                         blurRadius: 5.15,
                         offset: Offset(0, 2.58),
                         spreadRadius: 0,
                       )
                     ],
                   ),
                   child: Column(
                     children: [
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             width: 85,
                             height: 85,
                             padding: const EdgeInsets.all(5),
                             decoration: ShapeDecoration(
                               image: const DecorationImage(
                                   image: AssetImage("assets/SubscriptionPayment.png"),scale: 3
                               ),
                               color: myWhite,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(13.27),
                               ),
                               shadows: const [
                                 BoxShadow(
                                   color: Color(0x19000000),
                                   blurRadius: 17.12,
                                   offset: Offset(0, 0),
                                   spreadRadius: 0,
                                 )
                               ],
                             ),
                           ),

                           const SizedBox(width: 10,),


                           Flexible(
                             fit:FlexFit.tight,
                             child: Column(
                               mainAxisAlignment:
                               MainAxisAlignment.start,
                               crossAxisAlignment:
                               CrossAxisAlignment.start,
                               children: const [
                                 Text(
                                   'Members Payment',
                                   style: TextStyle(
                                     color: cl3E4FA3,
                                     fontSize: 14,
                                     fontFamily: 'JaldiBold',
                                     fontWeight: FontWeight.w400,
                                     // height: 0.06,
                                   ),
                                 ),
                                 Text(
                                   'consectetur adipiscing elit. Ut viverra sapien in est porta, vel cursus urna rutrum.',
                                   style: TextStyle(
                                     color: myBlack,
                                     fontSize: 11,
                                     fontFamily: 'Poppins',
                                     fontWeight: FontWeight.w400,
                                     // height: 0.11,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),

                       const SizedBox(height:10),

                       Column(
                         children: [

                           Consumer<DonationProvider>(
                               builder: (context,value,child) {
                                 return Container(
                                   height: 40,
                                   // color: Colors.red,
                                   child: ListView.builder(
                                       physics: const ScrollPhysics(),
                                       shrinkWrap: true,
                                       padding: const EdgeInsets.symmetric(horizontal:10),
                                       itemCount: value.monthList.length,
                                       scrollDirection: Axis.horizontal,
                                       itemBuilder: (BuildContext context, int index) {
                                         var item = value.monthList[index];
                                         return Center(
                                           child: Padding(
                                             padding: const EdgeInsets.only(right: 15.0),
                                             child:item.payStatus=='PAID'?
                                             Container(
                                               width: 100,
                                               height: 30,
                                               decoration: ShapeDecoration(
                                                 color: clF5F5F5,
                                                 shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(43),
                                                 ),
                                                 shadows: const [
                                                   BoxShadow(
                                                     color: Color(0x3F000000),
                                                     blurRadius: 2,
                                                     offset: Offset(0, 1),
                                                     spreadRadius: 0,
                                                   )
                                                 ],
                                               ),
                                               child: Center(child: Text(item.monthName,style: TextStyle(
                                                 color: myBlack.withOpacity(0.30)
                                               ),)),
                                             ):
                                             InkWell(onTap: (){
                                               donationProvider.selectMonthofPay(index);
                                             },
                                               child: Container(
                                                 width: 100,
                                                 height: 30,
                                                 decoration: ShapeDecoration(
                                                   color:item.payStatus=='NOTPAID'&&item.selectionBool?
                                                   cl253068 :  myWhite,//(0xFFF5F5F5)
                                                   shape: RoundedRectangleBorder(
                                                     borderRadius: BorderRadius.circular(43),
                                                   ),
                                                   shadows: const [
                                                     BoxShadow(
                                                       color: Color(0x3F000000),
                                                       blurRadius: 2,
                                                       offset: Offset(0, 1),
                                                       spreadRadius: 0,
                                                     )
                                                   ],
                                                 ),
                                                 child: Center(child: Text(item.monthName,
                                                 style: TextStyle(
                                                   color:item.payStatus=='NOTPAID'&&item.selectionBool?myWhite:myBlack
                                                 ),
                                                 )),
                                               ),
                                             ),
                                           ),
                                         );
                                       }),
                                 );
                               }
                           ),

                           const SizedBox(height: 8,),

                           ///calender
                           // Consumer<DonationProvider>(
                           //     builder: (context,value,child) {
                           //       return Row(
                           //         children: [
                           //           Expanded(
                           //             flex:1,
                           //             child: InkWell(
                           //                 onTap: (){
                           //                   donationProvider.selectDate(context,'Date1');
                           //                 },
                           //                 child: Container(
                           //                   height: 30,
                           //                   child: FittedBox(
                           //                     child: Row(
                           //                       mainAxisAlignment: MainAxisAlignment.end,
                           //                       children: [
                           //                         Text(value.date1.text,style: const TextStyle(
                           //                           color: myBlack,
                           //                           fontSize: 8,
                           //                           fontFamily: 'Poppins',
                           //                           fontWeight: FontWeight.w400,
                           //                         ),
                           //                         ),
                           //                         const SizedBox(width: 5,),
                           //                         const Icon(Icons.calendar_month,color:cl3E4FA3,size: 20,)
                           //                       ],
                           //                     ),
                           //                   ),)),
                           //           ),
                           //
                           //           Text(
                           //             '  To  ',
                           //             style: TextStyle(
                           //               color: myBlack.withOpacity(0.50),
                           //               fontSize: 12,
                           //               fontFamily: 'Poppins',
                           //               fontWeight: FontWeight.w400,
                           //               height: 0,
                           //             ),
                           //           ),
                           //
                           //           Expanded(
                           //             flex:1,
                           //             child: InkWell(onTap: (){
                           //               donationProvider.selectDate(context,'Date2');
                           //             },
                           //                 child: SizedBox(
                           //                   height: 30,
                           //                   child: FittedBox(
                           //                     child: Row(
                           //                       mainAxisAlignment:MainAxisAlignment.end,
                           //                       children: [
                           //                         Text(value.date2.text.toString(),style: const TextStyle(
                           //                           color: myBlack,
                           //                           fontSize: 8,
                           //                           fontFamily: 'Poppins',
                           //                           fontWeight: FontWeight.w400,
                           //                         ),),
                           //                         const SizedBox(width: 5,),
                           //                         const Icon(Icons.calendar_month,color:cl3E4FA3,size: 20,)
                           //                       ],
                           //                     ),
                           //                   ),)),
                           //           ),
                           //
                           //         ],
                           //       );
                           //     }
                           // ),


                           Row(
                               children:[
                                 ///textfield amount
                                 // Flexible(
                                 //   fit:FlexFit.tight,
                                 //   child: Consumer<DonationProvider>(
                                 //       builder: (context,value,child) {
                                 //         return TextFormField(
                                 //           cursorColor: cl253068,
                                 //           // onChanged: (data){
                                 //           //
                                 //           // },
                                 //           readOnly: true,
                                 //           // keyboardType: TextInputType.number,
                                 //           textAlign:  TextAlign.center ,
                                 //           controller: value.membersPaymentAmountCT,
                                 //           style: const TextStyle(color:myBlack, fontSize: 17,fontFamily: 'Poppins',),
                                 //           decoration: InputDecoration(
                                 //               contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                 //               hintText: 'Amount',
                                 //               helperText: "",
                                 //               hintStyle: TextStyle(color: searchBartext,
                                 //                 fontFamily: 'Poppins',
                                 //               ),
                                 //
                                 //               focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: cl253068),),
                                 //               enabledBorder: const UnderlineInputBorder(
                                 //                 borderSide: BorderSide(color:cl253068),
                                 //               ),
                                 //               errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: cl253068),),
                                 //               border: const UnderlineInputBorder(borderSide: BorderSide(color: cl253068),)
                                 //           ),
                                 //
                                 //           validator: (value) {
                                 //             // if (value!.isEmpty) {
                                 //             //   return 'Enter Name';
                                 //             // }
                                 //             //
                                 //             // return null;
                                 //           },
                                 //         );
                                 //       }
                                 //   ),
                                 // ),

                                 Expanded(
                                   flex:1,
                                   child: Center(
                                     child: Consumer<DonationProvider>(
                                         builder: (context,value,child) {
                                           return value.monthlyPayAmount>0?
                                           Text(value.monthlyPayAmount.toString(),
                                           style:const TextStyle(
                                             color: myBlack,
                                             fontSize: 13.14,
                                             fontFamily: 'PoppinsRegular',
                                             fontWeight: FontWeight.w700,
                                           ),
                                           ):SizedBox();
                                         }
                                     ),
                                   ),
                                 ),

                                 const SizedBox(width:15),

                                 Expanded(
                                     flex:1,
                                   child: Consumer<DonationProvider>(
                                     builder: (context,value,child) {
                                       return Container(
                                         alignment: Alignment.center,
                                         padding: const EdgeInsets.symmetric(horizontal: 20),
                                         height:30,
                                         child:  Consumer<DonationProvider>(
                                           builder: (context,value,child) {
                                             return Text(
                                              value.monthlyPayAmount>0?
                                              value.monthList.where((element) => element.payStatus=='NOTPAID'&&element.selectionBool).length.toStringAsFixed(0)+" Months":"0 Months",
                                               textAlign: TextAlign.center,
                                               style: const TextStyle(
                                                 color: myBlack,
                                                 fontSize: 13,
                                                 fontFamily: 'Poppins',
                                                 fontWeight: FontWeight.w500,
                                               ),
                                             );
                                           }
                                         ),
                                       );
                                     }
                                   ),
                                 ),
                               ]
                           ),
                         ],
                       )
                     ],
                   ),
                 ):const SizedBox(),

                 const SizedBox(height: 10,),
               ],
             ),
           ),


          Consumer<DonationProvider>(
              builder: (context,value,child) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal:10),
                  // height: 500,
                  width: width,
                  color: clF1F1F1,
                 child: Column(
                   children: [
                     const SizedBox(height:5),

                     const Text(
                     'Price Details',
                       style: TextStyle(
                         color: myBlack,
                         fontSize: 14,
                         fontFamily: 'JaldiBold',
                         fontWeight: FontWeight.w400,
                       ),
                     ),

                     const SizedBox(height:5),

                    value.zakathTotal>0?
                    Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           const Text('ZAKATH',style: TextStyle(
                             color: myBlack,
                             fontSize: 12,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w500,
                           ),
                           ),
                           Text(value.zakathTotal.toString(),style: const TextStyle(
                             color: myBlack,
                             fontSize: 12,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w500,
                           ),)
                         ],),
                        const SizedBox(height: 10,),
                      ],
                    ):const SizedBox(),

                     value.monthlyPayAmount>0?
                    Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           const Text('MONTHLY PAYMENT',style: TextStyle(
                             color: myBlack,
                             fontSize: 12,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w500,
                           ),
                           ),
                           Text(value.monthlyPayAmount.toString(),style: const TextStyle(
                             color: myBlack,
                             fontSize: 12,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w500,
                           ),)
                         ],),
                        const SizedBox(height: 10,),
                      ],
                    ):const SizedBox(),

                     // const SizedBox(height: 10,),

                     value.equipmntTotal>0?
                     Column(
                       children: [
                         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                           const Text('Equipment',style: TextStyle(
                             color: myBlack,
                             fontSize: 12,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w500,
                           ),),
                           Text(value.equipmntTotal.toString(),style: const TextStyle(
                             color: myBlack,
                             fontSize: 12,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w500,
                           ),)
                         ],),
                         const SizedBox(height: 10,),
                       ],
                     ):const SizedBox(),

                     value.patientTotal>0?
                     Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                           const Text('Patient',style: TextStyle(
                             color: myBlack,
                             fontSize: 12,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w500,
                           ),),
                           Text(value.patientTotal.toString(),style: const TextStyle(
                             color: myBlack,
                             fontSize: 12,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w500,
                           ),)
                         ],),
                         const SizedBox(height: 10,),
                       ],
                     ):const SizedBox(),

                     value.footkitTotal>0?
                     Column(
                       children: [
                         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                           const Text('FoodKit',style: TextStyle(
                             color: myBlack,
                             fontSize: 12,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w500,
                           ),),
                           Text(value.footkitTotal.toString(),style: const TextStyle(
                             color: myBlack,
                             fontSize: 12,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w500,
                           ),)
                         ],),
                         const SizedBox(height: 10,),
                       ],
                     ):const SizedBox(),

                     value.subscriptionTotal>0?
                     Column(
                       children: [
                         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                           const Text('Subscription payment',style: TextStyle(
                             color: myBlack,
                             fontSize: 12,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w500,
                           ),),
                           Text(value.subscriptionTotal.toString(),style: const TextStyle(
                             color: myBlack,
                             fontSize: 12,
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w500,
                           ),)
                         ],),
                         const SizedBox(height: 10,),
                       ],
                     ):const SizedBox(),



                     value.allTotal>0?
                     Column(
                       children: [
                         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                           const Text('TOTAL', style: TextStyle(
                             color: myBlack,
                             fontSize: 15,
                             fontFamily: 'JaldiBold',
                             fontWeight: FontWeight.w400,
                           ),
                           ),
                           Text(value.allTotal.toString(),style: const TextStyle(
                             color: myBlack,
                             fontSize: 15,
                             fontFamily: 'JaldiBold',
                             fontWeight: FontWeight.w400,
                           ),)
                         ],),
                         const SizedBox(height: 10,),
                       ],
                     ):const SizedBox(),
                      const SizedBox(height: 10,)

                   ],
                 ),
                );
              }
            ),

            const SizedBox(height:70),

          ],
        ),
      ),
    );
  }

    }

class PercentageIndicatorMultiple extends StatelessWidget {
  final double percentage;

  PercentageIndicatorMultiple({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:12),
      child: Container(
        // width: 150,
        height: 10,
        decoration: BoxDecoration(
          border: Border.all(color: c_Grey.shade200),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    myWhite,
                    myWhite,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            if (percentage < 100)
              FractionallySizedBox(
                widthFactor: percentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        cl253068,// Color(0xFF74799d)
                        myWhite,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            if (percentage == 100)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: cl253068, // Progressed color (red)
                ),
              ),
          ],
        ),
      ),
    );
  }
}
