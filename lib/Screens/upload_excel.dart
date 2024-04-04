import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Admin/issue_clearance_page.dart';
import '../Views/panjayath_model.dart';
import '../Views/ward_model.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import '../providers/home_provider_reciept.dart';
import '../providers/web_provider.dart';
import '../service/excel_to_json.dart';
import 'dist_report_list.dart';

class UploadExcel extends StatefulWidget {
  @override
  _UploadExcel createState() => _UploadExcel();
}

class _UploadExcel extends State<UploadExcel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    WebProvider webProvider = Provider.of<WebProvider>(
        context, listen: false);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[


                Text("Monitor Page",style: black18,),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child:const Text("Click here to go to Monitor Page"),
                    onPressed: () {
                      FirebaseFirestore db = FirebaseFirestore.instance;

                      Map<String,String> k = HashMap();
                      k["TEST"] = "yakoob";
                      db.collection("TEST").doc("jjj").update(k).then((value) => print("Success"));
                    },
                  ),
                ),
                const SizedBox(height: 20,),


                Text("Issue Clearance",style: black18,),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child:const Text("Click here to Clear the issue"),
                    onPressed: () {
                      callNext(const IssueClearance(), context);
                    },
                  ),
                ),
                const SizedBox(height: 20,),


                 Text("Excel Old Format",style: black18,),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child:const Text("Click here to Upload Excel"),
                    onPressed: () {
                      ExcelToJson().convert().then((onValue) {

                        var jsonResponse = json.decode(onValue.toString());
                        List <dynamic> map= jsonResponse as List;
                        webProvider.uploadToFirebase(map,context);
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                 Text("Excel New Format",style: black18),
                const SizedBox(height: 20,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text("Make sure your excel file has the column \"Corporate ID\" in which replace the values as \"AM/PM\" according to time also in Capital Letter.Don't change the Column Name"),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to Upload Excel(New Format)",),
                    onPressed: () {
                      ExcelToJson().convert().then((onValue) {

                        var jsonResponse = json.decode(onValue.toString());
                        List <dynamic> map= jsonResponse as List;
                        webProvider.uploadNewToFirebase(map,context);



                      });
                    },
                  ),
                ),

                const SizedBox(height: 20,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text("When uploading an Excel file make sure every row is filled and no blank space in each and every Column"),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to Fetch Excel FireStore",),
                    onPressed: () {
                      webProvider.dateRangePickerFlutter(context);
                      // webProvider.selectDateForDayTotal(context,'FireStore');

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to Fetch Excel Firebase With Failure",),
                    onPressed: () {
                      webProvider.selectDate(context,'firebase');
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to Download Excel",),
                    onPressed: () {
                      webProvider.createExcel(webProvider.paymentDetailsList);

                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text("Excel uploading Portal for Formatted Excel"),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to Upload Formatted Excel",),
                    onPressed: () {
                      ExcelToJson().convert().then((onValue) {

                        var jsonResponse = json.decode(onValue.toString());
                        List <dynamic> map= jsonResponse as List;
                        webProvider.uploadToFirebaseExcelFormatted(map,context);
                      });

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to Upload Formatted Excel With Total",),
                    onPressed: () {
                      ExcelToJson().convert().then((onValue) {

                        var jsonResponse = json.decode(onValue.toString());
                        List <dynamic> map= jsonResponse as List;
                        webProvider.uploadToFirebaseExcelFormattedTotal(map,context);
                      });

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("get Day total",),
                    onPressed: () {
                    webProvider.selectDateForDayTotal(context,'');

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to Make Receipt",),
                    onPressed: () {
                      DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                      donationProvider.fetchDatabaseWard();
                      donationProvider.fetchAllWards();
                      // webProvider.loopPayments();

                      webProvider.webWard.clear();
                      webProvider.wardModel =null;

                      showReceiptAlert(context);

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Shift Ward",),
                    onPressed: () {
                      DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                      HomeProvider homeProvider =
                      Provider.of<HomeProvider>(context, listen: false);
                      homeProvider.fetchDropdown('', '');
                      donationProvider.fetchAllWards();
                      // webProvider.loopPayments();pp

                      webProvider.webWard.clear();
                      webProvider.wardModel =null;
                      webProvider.clearShiftwardData();
                      shiftWardAlert(context);

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Shift Panchayath",),
                    onPressed: () {
                      DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                      HomeProvider homeProvider =
                      Provider.of<HomeProvider>(context, listen: false);
                      homeProvider.fetchDropdown('', '');
                      donationProvider.fetchAllWards();
                      // webProvider.loopPayments();

                      webProvider.webWard.clear();
                      webProvider.wardModel =null;
                      shiftPanchayathAlert(context);

                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to Upload New Ward Without Zero",),
                    onPressed: () {

                      ExcelToJson().convert().then((onValue) {

                        var jsonResponse = json.decode(onValue.toString());
                        List <dynamic> map= jsonResponse as List;
                        webProvider.uploadWardWithoutZero(map,context);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to Upload New Ward With ZERO",),
                    onPressed: () {

                      ExcelToJson().convert().then((onValue) {

                        var jsonResponse = json.decode(onValue.toString());
                        List <dynamic> map= jsonResponse as List;
                        webProvider.uploadWard(map,context);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to hide Ward",),
                    onPressed: () {

                      ExcelToJson().convert().then((onValue) {

                        var jsonResponse = json.decode(onValue.toString());
                        List <dynamic> map= jsonResponse as List;
                        webProvider.hideWard(map,context);
                      });
                    },
                  ),
                ),
                Consumer<WebProvider>(
                  builder: (context,value,child) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        child: const Text("Click here to change Name status",),
                        onPressed: () {
                          showNameStatusChangeAlert(context);
                        },
                      ),
                    );
                  }
                ),
                Consumer<WebProvider>(
                    builder: (context,value,child) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          child: const Text("Click here to change Name",),
                          onPressed: () {
                            showNameChangeAlert(context);
                          },
                        ),
                      );
                    }
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Dist Report",),
                    onPressed: () {

                      callNext(const ListViewBuilder(), context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Download CC AVENUE excel",),
                    onPressed: () {
                      webProvider.fetchEntriesExcelFireStore(context);
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: ElevatedButton(
                //     child: const Text("Click here to Zero WardTotalAmount 2 *** dont click ***",),
                //     onPressed: () {
                //       // set up the buttons
                //       Widget cancelButton = TextButton(
                //         child: const Text("Cancel"),
                //         onPressed:  () {
                //           finish(context);
                //         },
                //       );
                //       Widget continueButton = TextButton(
                //         child: const Text("Continue"),
                //         onPressed:  () {
                //           finish(context);
                //             webProvider.zeroPayments();
                //         },
                //       );
                //
                //       // set up the AlertDialog
                //       AlertDialog alert = AlertDialog(
                //         title: const Text("Alert"),
                //         content: const Text("Click here to Zero WardTotalAmount"),
                //         actions: [
                //           cancelButton,
                //           continueButton,
                //         ],
                //       );
                //
                //       // show the dialog
                //       showDialog(
                //         context: context,
                //         builder: (BuildContext context) {
                //           return alert;
                //         },
                //       );
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: ElevatedButton(
                //     child: const Text("Click here to loop time WardTotalAmount *** dont click ***",),
                //     onPressed: () {
                //       webProvider.selectDateForDayTotalForLoop(context);
                //     },
                //   ),
                // ),



              ],
            ),
          ),
        ),
      ),
    );
  }
  showReceiptAlert(
      BuildContext context,
      ) {
    WebProvider webProvider = Provider.of<WebProvider>(
        context, listen: false);
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
                      'Tr ID',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),

                  Consumer<WebProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.webTransactionID,
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

                    );
                  }),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Date',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Consumer<WebProvider>(builder: (context, value, child) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: value.dateController,
                            enabled: false,
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

                          ),
                        ),
                        InkWell(
                          onTap:(){
                           setState(() {
                             value.selectDateAndTime(context);
                           });
                    },
                          child: Container(width: 50,
                          height: 45,
                            decoration: BoxDecoration(
                                color: myGreen,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )
                      ],
                    );
                  }),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Amount',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Consumer<WebProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.webAmount,
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
                      validator: (name) => name == ''
                          ? 'Please Enter Valid Name'
                          : null,
                    );
                  }),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Name',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Consumer<WebProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.webName,
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

                    );
                  }),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Phone Number',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Consumer<WebProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.webPhone,
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
                        return value.allWards
                            .where((WardModel wardd) => wardd.wardName.toLowerCase()
                            .contains(textEditingValue.text.toLowerCase())
                            || wardd.panchayath.toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (WardModel option) => option.wardName,
                      fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted
                          ) {

                        return TextFormField(
                          decoration: InputDecoration(

                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Select Ward/Unit',
                            suffixIcon:const Icon(Icons.arrow_drop_down),
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

                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      onSelected: (WardModel selection) {
                        webProvider.selectWebWard(selection);
                      },
                      optionsViewBuilder: (
                          BuildContext context,
                          AutocompleteOnSelected<WardModel> onSelected,
                          Iterable<WardModel> options
                          ) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              height: 300,
                              color: Colors.white,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final WardModel option = options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child:  SizedBox(
                                      height: 50,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(option.wardName,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold)),
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


                            webProvider.makeReceipt();
                            finish(context);
                          }
                        },
                        child: Text(
                          'Make Receipt',
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
  shiftWardAlert(
      BuildContext context,
      ) {
    WebProvider webProvider = Provider.of<WebProvider>(
        context, listen: false);
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
                  Consumer<WebProvider>(
                    builder: (context,value4,child) {
                      return Text("Total Payments : "+value4.paymentCount);
                    }
                  ),
                  Consumer<HomeProvider>(builder: (context, value, child) {
                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return (value.districtList)
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

                        return TextFormField(
                          decoration: InputDecoration(

                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Select District',
                            suffixIcon:const Icon(Icons.arrow_drop_down),
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

                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      onSelected: (String selection) {
                        HomeProvider homeProvider =
                        Provider.of<HomeProvider>(context, listen: false);
                        homeProvider.fetchDropdown('District', selection);
                        webProvider.shiftDistrict=selection;
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
                              width: MediaQuery.of(context).size.width/1.5,
                              height: 200,
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
                                    child:  SizedBox(
                                      height: 50,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(option,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold)),

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
                  SizedBox(height: 10,),
                  Consumer<HomeProvider>(builder: (context, value, child) {
                    return Autocomplete<AssemblyModel>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return (value.assemblyList)
                            .where((AssemblyModel wardd) => wardd.assembly.toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (AssemblyModel option) => option.assembly,
                      fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted
                          ) {

                        return TextFormField(
                          decoration: InputDecoration(

                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Select Assembly',
                            suffixIcon:const Icon(Icons.arrow_drop_down),
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

                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      onSelected: (AssemblyModel selection) {
                        webProvider.shiftAssembly=selection.assembly;
                        HomeProvider homeProvider =
                        Provider.of<HomeProvider>(context, listen: false);

                        homeProvider.fetchDropdown('Assembly', selection);
                      },
                      optionsViewBuilder: (
                          BuildContext context,
                          AutocompleteOnSelected<AssemblyModel> onSelected,
                          Iterable<AssemblyModel> options
                          ) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              height: 200,
                              color: Colors.white,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final AssemblyModel option = options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child:  SizedBox(
                                      height: 50,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(option.assembly,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold)),

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

                  SizedBox(height: 10,),
                  Consumer<HomeProvider>(builder: (context, value, child) {
                    return Autocomplete<PanjayathModel>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return (value.panjayathList)
                            .where((PanjayathModel wardd) => wardd.panjayath.toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (PanjayathModel option) => option.panjayath,
                      fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted
                          ) {

                        return TextFormField(
                          decoration: InputDecoration(

                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Select Panchayath',
                            suffixIcon:const Icon(Icons.arrow_drop_down),
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

                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      onSelected: (PanjayathModel selection) {
                        webProvider.shiftPanchayathh=selection.panjayath;
                        HomeProvider homeProvider =
                        Provider.of<HomeProvider>(context, listen: false);
                        homeProvider.fetchDropdown('Panjayath', selection);
                      },
                      optionsViewBuilder: (
                          BuildContext context,
                          AutocompleteOnSelected<PanjayathModel> onSelected,
                          Iterable<PanjayathModel> options
                          ) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              height: 200,
                              color: Colors.white,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final PanjayathModel option = options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child:  SizedBox(
                                      height: 50,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(option.panjayath,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold)),

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
                  SizedBox(height: 10,),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'From',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),

                  Consumer<WebProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.shiftWardFrom,
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

                    );
                  }),
                  SizedBox(height: 10,),
                  Consumer<WebProvider>(
                      builder: (context,value3,child) {
                        return Align(
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



                                  webProvider.getPaymentCount(context,value3.shiftDistrict,value3.shiftAssembly,value3.shiftPanchayathh,value3.shiftWardFrom.text.toString());
                                  // finish(context);

                              },
                              child: Text(
                                'GET COUNT',
                                style: white16,
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                  SizedBox(height: 10,),





                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      ' To Ward/Unit',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return Autocomplete<WardModel>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return value.allWards
                            .where((WardModel wardd) => wardd.wardName.toLowerCase()
                            .contains(textEditingValue.text.toLowerCase())
                            || wardd.panchayath.toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (WardModel option) => option.wardName,
                      fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted
                          ) {

                        return TextFormField(
                          decoration: InputDecoration(

                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Select Ward/Unit',
                            suffixIcon:const Icon(Icons.arrow_drop_down),
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

                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      onSelected: (WardModel selection) {
                        webProvider.selectWebWard(selection);
                      },
                      optionsViewBuilder: (
                          BuildContext context,
                          AutocompleteOnSelected<WardModel> onSelected,
                          Iterable<WardModel> options
                          ) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              height: 200,
                              color: Colors.white,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final WardModel option = options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child:  SizedBox(
                                      height: 50,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(option.wardName,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold)),
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

                  Consumer<WebProvider>(
                    builder: (context,value3,child) {
                      return Align(
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


                                  webProvider.shiftWard(context,value3.shiftDistrict, value3.shiftAssembly,value3.shiftPanchayathh,value3.shiftWardFrom.text.toString());





                              }
                            },
                            child: Text(
                              'SHIFT WARD',
                              style: white16,
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  shiftPanchayathAlert(
      BuildContext context,
      ) {
    WebProvider webProvider = Provider.of<WebProvider>(
        context, listen: false);
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
                  Consumer<WebProvider>(
                      builder: (context,value4,child) {
                        return Text("Total Payments : "+value4.paymentCountPAnchayath);
                      }
                  ),
                  Consumer<HomeProvider>(builder: (context, value, child) {
                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return (value.districtList)
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

                        return TextFormField(
                          decoration: InputDecoration(

                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Select District',
                            suffixIcon:const Icon(Icons.arrow_drop_down),
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

                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      onSelected: (String selection) {
                        HomeProvider homeProvider =
                        Provider.of<HomeProvider>(context, listen: false);
                        homeProvider.fetchDropdown('District', selection);
                        webProvider.shiftDistrict=selection;
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
                              width: MediaQuery.of(context).size.width/1.5,
                              height: 200,
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
                                    child:  SizedBox(
                                      height: 50,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(option,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold)),

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
                  SizedBox(height: 10,),
                  Consumer<HomeProvider>(builder: (context, value, child) {
                    return Autocomplete<AssemblyModel>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return (value.assemblyList)
                            .where((AssemblyModel wardd) => wardd.assembly.toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (AssemblyModel option) => option.assembly,
                      fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted
                          ) {

                        return TextFormField(
                          decoration: InputDecoration(

                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Select Assembly',
                            suffixIcon:const Icon(Icons.arrow_drop_down),
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

                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      onSelected: (AssemblyModel selection) {
                        webProvider.shiftAssembly=selection.assembly;

                        // homeProvider.fetchDropdown('Assembly', selection);
                      },
                      optionsViewBuilder: (
                          BuildContext context,
                          AutocompleteOnSelected<AssemblyModel> onSelected,
                          Iterable<AssemblyModel> options
                          ) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              height: 200,
                              color: Colors.white,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final AssemblyModel option = options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child:  SizedBox(
                                      height: 50,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(option.assembly,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold)),

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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'From',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),

                  Consumer<WebProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.shiftWardFrom,
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

                    );
                  }),
                  SizedBox(height: 10,),
                  Consumer<WebProvider>(
                      builder: (context,value3,child) {
                        return Align(
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



                                webProvider.getPaymentCountPanchayath(context,value3.shiftDistrict,value3.shiftAssembly,value3.shiftWardFrom.text.toString());
                                // finish(context);

                              },
                              child: Text(
                                'GET COUNT',
                                style: white16,
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                  SizedBox(height: 10,),





                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      ' To Ward/Unit',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    return Autocomplete<WardModel>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return value.allWards
                            .where((WardModel wardd) => wardd.wardName.toLowerCase()
                            .contains(textEditingValue.text.toLowerCase())
                            || wardd.panchayath.toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (WardModel option) => option.wardName,
                      fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted
                          ) {

                        return TextFormField(
                          decoration: InputDecoration(

                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Select Ward/Unit',
                            suffixIcon:const Icon(Icons.arrow_drop_down),
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

                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      onSelected: (WardModel selection) {
                        webProvider.selectWebWard(selection);
                      },
                      optionsViewBuilder: (
                          BuildContext context,
                          AutocompleteOnSelected<WardModel> onSelected,
                          Iterable<WardModel> options
                          ) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              height: 200,
                              color: Colors.white,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final WardModel option = options.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child:  SizedBox(
                                      height: 50,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(option.wardName,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold)),
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

                  Consumer<WebProvider>(
                      builder: (context,value3,child) {
                        return Align(
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


                                  webProvider.shiftPanchayath(value3.shiftDistrict, value3.shiftAssembly,value3.shiftWardFrom.text.toString());

                                  finish(context);



                                }
                              },
                              child: Text(
                                'SHIFT PANCHAYATH',
                                style: white16,
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  showNameStatusChangeAlert(BuildContext context) {
    WebProvider webProvider = Provider.of<WebProvider>(
        context, listen: false);
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
                      'Tr ID',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),

                  Consumer<WebProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.transactionId,
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


                    );
                  }),

                  SizedBox(height: 5,),
                  Consumer<WebProvider>(
                    builder: (context,value,child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Name Status : "),
                          Text(value.nameStatus),
                        ],
                      );
                    }
                  ),

                  Consumer<WebProvider>(
                    builder: (context,value,child) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              TextButton(
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
                                          vertical: 15, horizontal: 10)),
                                ),
                                onPressed: () async {
                                  final FormState? form = _formKey.currentState;
                                  if (form!.validate()) {
                                    webProvider.getNameStatus(value.transactionId.text.toString());

                                  }
                                },
                                child: Text(
                                  'Get Name Status',
                                  style: white16,
                                ),
                              ),
                              SizedBox(height: 8,),
                              TextButton(
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
                                          vertical: 15, horizontal: 10)),
                                ),
                                onPressed: () async {
                                  final FormState? form = _formKey.currentState;
                                  if (form!.validate()) {
                                    webProvider.changeNameStatus(value.nameStatus,value.transactionId.text);
                                    finish(context);
                                  }
                                },
                                child: Text(
                                  'Change Name Status',
                                  style: white16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  showNameChangeAlert(BuildContext context) {
    WebProvider webProvider = Provider.of<WebProvider>(
        context, listen: false);
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
                      'Tr ID',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),

                  Consumer<WebProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.transactionId,
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


                    );
                  }),

                  SizedBox(height: 5,),
                  Consumer<WebProvider>(
                    builder: (context,value,child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Name  : "),
                          Text(value.nameChange),
                        ],
                      );
                    }
                  ),
                  SizedBox(height: 5,),
                  Consumer<WebProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.nameChangeCt,
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


                    );
                  }),

                  Consumer<WebProvider>(
                    builder: (context,value,child) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              TextButton(
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
                                          vertical: 15, horizontal: 10)),
                                ),
                                onPressed: () async {
                                  final FormState? form = _formKey.currentState;
                                  if (form!.validate()) {
                                    webProvider.getName(value.transactionId.text.toString());

                                  }
                                },
                                child: Text(
                                  'Get Name',
                                  style: white16,
                                ),
                              ),
                              SizedBox(height: 8,),
                              TextButton(
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
                                          vertical: 15, horizontal: 10)),
                                ),
                                onPressed: () async {
                                  final FormState? form = _formKey.currentState;
                                  if (form!.validate()) {
                                    webProvider.changeName(value.nameChangeCt.text.toString(),value.transactionId.text);
                                    finish(context);
                                  }
                                },
                                child: Text(
                                  'Change Name ',
                                  style: white16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}