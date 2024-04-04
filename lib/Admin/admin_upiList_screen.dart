import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/home_provider.dart';
import 'admin_home_screen.dart';

class AdminUpiListScreen extends StatelessWidget {
  String from; String loginUsername,loginUserID,subScriberType,loginUserPhone;
  AdminUpiListScreen({Key? key, required this.from,required this.loginUsername,
    required this.loginUserID,required this.subScriberType,required this.loginUserPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondary,
          leading:InkWell(
              onTap: (){
                callNext( AdminHomeScreen(loginUserPhone: loginUserPhone,
                    loginUserID: loginUserID,loginUsername: loginUsername,
                    subScriberType: subScriberType,foodkitPrice: '',foodkitAmount: '',
                equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
                sponsorCategory: ''), context);
              },
              child: const Icon(Icons.arrow_back_ios_new_sharp)),
          title: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "",
              style: TextStyle(fontSize: 22),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Center(
                  child: Text(
                from,
                style: const TextStyle(
                    color: myBlack, fontSize: 25, fontWeight: FontWeight.bold),
              )),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 28.0),
                    child: Text(
                      "UPI ID",
                      style: TextStyle(color: myBlack, fontSize: 17),
                    ),
                  )),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Consumer<HomeProvider>(
                  builder: (context, value, child) {
                return Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return (value.upiList)
                        .where((String item) => item
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                        .toList();
                  },
                  displayStringForOption: (String option) => option,
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      fieldTextEditingController.text = value.upiIdController.text;
                    });

                    return Container(
                      width: MediaQuery.of(context).size.width * 0.86,
                      child: TextFormField(
                        style: const TextStyle(
                          color: myBlack,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              color: myBlack,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 25,
                              color: Colors.black38,
                            ),
                            border: textformBorder,
                            enabledBorder: textformBorder,
                            focusedBorder: textformBorder,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            labelText: "SELECT",
                            errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: .5))),
                        validator: (text) => text == '' || !value.upiList.contains(text) ? "Select UpiId" : null,
                        onChanged: (txt) {},
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                      ),
                    );
                  },
                  onSelected: (String selection) {
                    value.upiIdController.text = selection;
                  },
                  optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<String> onSelected,
                      Iterable<String> options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.86,
                          height: MediaQuery.of(context).size.height * 0.3,
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
                                child: Container(
                                  color: Colors.white,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.86,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(option,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
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
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 28.0),
                    child: Text(
                      "MODE",
                      style: TextStyle(color: myBlack, fontSize: 17),
                    ),
                  )),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Consumer<HomeProvider>(
                  builder: (context, value, child) {
                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return (value.modeList)
                            .where((String item) => item
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (String option) => option,
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          fieldTextEditingController.text = value.modeController.text;
                        });

                        return Container(
                          width: MediaQuery.of(context).size.width * 0.86,
                          child: TextFormField(
                            style: const TextStyle(
                              color: myBlack,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color: myBlack,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                ),
                                suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 25,
                                  color: Colors.black38,
                                ),
                                border: textformBorder,
                                enabledBorder: textformBorder,
                                focusedBorder: textformBorder,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                labelText: "SELECT",
                                errorBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.red, width: .5))),
                            validator: (text) =>
                            text == '' || !value.modeList.contains(text)
                                ? "Select UpiId"
                                : null,
                            onChanged: (txt) {},
                            controller: fieldTextEditingController,
                            focusNode: fieldFocusNode,
                          ),
                        );
                      },
                      onSelected: (String selection) {
                        value.modeController.text = selection;
                      },
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<String> onSelected,
                          Iterable<String> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.86,
                              height: MediaQuery.of(context).size.height * 0.3,
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
                                    child: Container(
                                      color: Colors.white,
                                      height: 70,
                                      width: MediaQuery.of(context).size.width * 0.86,
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(option,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 2)
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
              SizedBox( height: MediaQuery.of(context).size.height*0.35,),
              InkWell(
                onTap: (){
                  homeProvider.updateUpiDetails(from);
                  homeProvider.clearUpi();
                  callNextReplacement(AdminHomeScreen(loginUserPhone: loginUserPhone,
                      loginUserID: loginUserID,loginUsername: loginUsername,subScriberType: subScriberType,
                      equipmentAmount: '',deseaseName: '',footkitCount: '',zakathAmount: '',sponsorPatientAmonut: '',sponsorItemOnePrice: '',sponsorCount: '',
                      sponsorCategory: '',foodkitAmount: '',foodkitPrice: ''), context);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height*0.06,
                  width: MediaQuery.of(context).size.width*0.4,
                  decoration: BoxDecoration(
                      color: secondary,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: const Center(
                      child: Text("SAVE",
                        style: TextStyle(
                            color: myWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder textformBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide(color: myGray, width: 1),
);
