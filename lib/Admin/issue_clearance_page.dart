import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/upload_excel.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/web_provider.dart';

class IssueClearance extends StatelessWidget {
  const IssueClearance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WebProvider webProvider =
    Provider.of<WebProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return Scaffold(
      body: Container(
        color: lightBlue,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        finish(context);
                        callNextReplacement( UploadExcel(), context);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: myWhite
                        ),
                        child: const Center(
                          child: Icon(Icons.arrow_back_ios,color: myGradient5,),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: width/3,
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),

                        ),
                        child: Consumer<WebProvider>(
                            builder: (context, value, child) {
                              return TextField(
                                controller: value.transactionIdController,
                                decoration: InputDecoration(
                                  fillColor: myWhite,
                                  filled: true,
                                  hintText: 'Transaction ID',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: primary),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(color: primary),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                ),
                                onChanged: (item) {
                                  // if (item.trim().length==13) {
                                  //   webProvider.getIdDetails(item.trim(),context);
                                  // }
                                  // webProvider.getIdDetails(item.trim(),context);
                                },
                              );
                            }),
                      ),
                    ),
                    Consumer<WebProvider>(
                      builder: (context,value,child) {
                        return InkWell(
                          onTap: () {
                            webProvider.getIdDetails(value.transactionIdController.text.trim(),context);
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: myWhite
                            ),
                            child: const Center(
                              child: Icon(Icons.search,color: myGradient5,),
                            ),

                          ),
                        );
                      }
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: width/1.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 60,),
                      SizedBox(width: width/6,),
                      SizedBox(
                        height: 80,
                        width: width/2.5,
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          elevation: 0.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),

                          ),
                          child: Consumer<WebProvider>(
                              builder: (context, value, child) {
                                return TextField(
                                  controller: value.utrController,
                                  decoration: InputDecoration(
                                    fillColor: myWhite,
                                    filled: true,
                                    hintText: 'Enter UTR',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: knmGolden2),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:  BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                  ),
                                  onChanged: (item) {
                                    if (item.trim().length==12) {
                                      // webProvider.getUtrDetails(item.trim(),context);
                                    }
                                  },
                                );
                              }),
                        ),
                      ),
                      Consumer<WebProvider>(
                          builder: (context,value,child) {
                            return InkWell(
                              onTap: () {
                                webProvider.getUtrDetails(value.utrController.text.trim(),context);
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: myWhite
                                ),
                                child: const Center(
                                  child: Icon(Icons.search,color: myGradient5,),
                                ),

                              ),
                            );
                          }
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: width/1.2,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: myWhite
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Consumer<WebProvider>(
                          builder: (context,value,child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("Transaction ID",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issueID,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                      width: width/6,
                                        child: Text("Name",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issueName,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("Phone Number",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issuePhoneNumber,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("District",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issueDistrict,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("Assembly",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issueAssembly,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("Panchayath",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issuePanchayath,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("Ward",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issueWard,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("WardNumber",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issueWardNumber,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("Amount",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issueAmount,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("App Version",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issueAppVersion,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("Device ID",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issueDeviceId,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("Print Status",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issuePrintStatus,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("Ref Number",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issueRefNo,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("Time",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issueTime,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("UPI ID",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issueUpiID,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("Is In Payment",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      "+value.issuePayment,style: blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("Response",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      ${value.entryExist}",style:  blackPoppinsBoldM20,)),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                value.entryExist == 'AVAILABLE'
                                    ?Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(
                                        width: width/6,
                                        child: Text("Response Status",style: blackPoppinsBoldM20,)),
                                    SizedBox(
                                        width: width/3,
                                        child: Text(":      ${value.entryStatus}",style: blackPoppinsBoldM20,)),
                                  ],
                                ):const SizedBox(),
                                value.entryExist == 'YES'?
                                const SizedBox(height: 15,)
                                    :const SizedBox(),



                              ],
                            );
                          }
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      width: width/1.2,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: myWhite
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Consumer<WebProvider>(
                          builder: (context,value,child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Checkbox(
                                //       checkColor: Colors.white,
                                //       activeColor: Colors.greenAccent,
                                //       value: value.isAddToTotal,
                                //       onChanged: (value) {
                                //         webProvider.radioButtonChanges(value!);
                                //       },
                                //     ),
                                //
                                //     const Text(
                                //       "Don't Add To Total",
                                //     )
                                //   ],
                                // ),
                                const SizedBox(height: 15,),
                                InkWell(
                                  onTap: (){
                                    // webProvider.getDateFormat(value.issueTime);
                                    if(value.transactionIdController.text!=''){
                                      // if(value.issuePayment=='NO') {
                                        webProvider.issueClearance(context,
                                            value.transactionIdController.text.trim(),
                                            value.issueDeviceId,value.issueTime,value.issueDistrict,
                                            value.issueAssembly,value.issueAmount);
                                      // }else{
                                      //   webProvider.issueClearanceAlert(context,"Data Exist",'Data already exist in Payment node');
                                      //
                                      //   // webProvider.issueClearance(context,
                                      //   //     value.transactionIdController.text.trim(),
                                      //   //     value.issueDeviceId,value.issueTime,value.issueDistrict,
                                      //   //     value.issuePanchayath,value.issueWardName,value.issueAmount);
                                      //
                                      // }
                                    }else{
                                      webProvider.issueClearanceAlert(context,"Enter ID",'Enter Transaction ID');
                                    }

                                  },
                                  child: Container(
                                    height: 50,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                      color: myGradient4,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child:  Center(
                                      child: Text(
                                        "Add To Payments",style: blackPoppinsBoldM20
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15,),
                              ],
                            );
                          }
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),

    );

  }
}
