import 'package:flutter/material.dart';
import '../../constants/text_style.dart';
import '../../providers/home_provider.dart';
import '../providers/web_provider.dart';
import 'package:provider/provider.dart';

import '../constants/text_style.dart';
class MandalamWiseReport extends StatefulWidget {
  const MandalamWiseReport({Key? key}) : super(key: key);

  @override
  State<MandalamWiseReport> createState() => _MandalamWiseReportState();
}

class _MandalamWiseReportState extends State<MandalamWiseReport> {
  @override
  Widget build(BuildContext context) {
    WebProvider webProvider = Provider.of<WebProvider>(context, listen: false);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              shadowColor: const Color(0xFFF1F8FA).withOpacity(0.5),
              margin: const EdgeInsets.all(10),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:10),
                child: Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return (value.districtList)
                            .where((String wardd) => wardd.toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                            .toList();
                      },
                      displayStringForOption: (String option) => option,
                      fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted
                          ) {

                        return TextField(
                          decoration:  InputDecoration(
                            hintStyle: blackPoppinsR12,
                            hintText:'Select District',
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      onSelected: (String selection) {
                        webProvider.onDistrictSelected(selection,context);
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
                              width: double.infinity,
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
                                    child:  Container(
                                      color: Colors.white,
                                      height: 50,
                                      width: double.infinity,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                  }
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }
}
