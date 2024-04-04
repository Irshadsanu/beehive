import 'package:flutter/material.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import '../providers/web_provider.dart';
class ListViewBuilder extends StatefulWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      WebProvider webProvider = Provider.of<WebProvider>(context, listen: false);
      webProvider.fetchDistrictAnalyticsReport(context);
    });


  }
  @override
  Widget build(BuildContext context) {
    WebProvider webProvider = Provider.of<WebProvider>(context, listen: false);


    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<WebProvider>(
              builder: (context,value,child) {
              return IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  Widget cancelButton = TextButton(
                    child: const Text("Excel"),
                    onPressed:  () {
                      value.createExcelDistrictReport(value.distReportArray);

                      finish(context);
                    },
                  );
                  Widget continueButton = TextButton(
                    child: const Text("Image"),
                    onPressed:  () {
                      value.createImage(screenshotController);
                        finish(context);

                    },
                  );

                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title: const Text("Download"),
                    content: const Text("Select Download Option"),
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
              );
            }
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<WebProvider>(
          builder: (context,value,child) {
            return Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Save',
                        style: white16,
                      ),
                    ],
                  ),
                  onPressed: () {
                    // set up the buttons
                    Widget cancelButton = TextButton(
                      child: const Text("Cancel"),
                      onPressed:  () {
                        finish(context);
                      },
                    );
                    Widget continueButton = TextButton(
                      child: const Text("Continue"),
                      onPressed:  () {
                        webProvider.saveLastReport(context);

                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: const Text("Are you sure"),
                      content: const Text("Do you want to save this data as last progress"),
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
                  style: ElevatedButton.styleFrom(
                      primary: myGreenNewUI,
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      )),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      textStyle: whitePoppinsM18),
                ),
              ),
            );
          }
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Center(
            child: Screenshot(
              controller: screenshotController,
              child: Container(
                width: 960,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(height: 60,width: 40,decoration: BoxDecoration(
                          color: Colors.green,
                            border: Border.all(color: Colors.black)
                        ),child: const Text('')),

                        Container(height: 60,width: 200,decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(color: Colors.black)
                        ),child: const Center(child: Text('DISTRICT/KMCC/OTHERS'))),
                        Container(height: 60,width: 180,decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(color: Colors.black)
                        ),child: Column(

                          children: [
                            Expanded(child: Container(width: 180,decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(color: Colors.black)
                            ),child:  Center(child: Consumer<WebProvider>(
                              builder: (context,value,child) {
                                return Text(dateConverter(value.lastUpdated));
                              }
                            )))),
                            Expanded(child: Container(width: 180,decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(color: Colors.black)
                            ),child:  Center(child: Consumer<WebProvider>(
                                builder: (context,value,child)  {
                                return Text(timeConverter(value.lastUpdated));
                              }
                            )))),
                          ],
                        )),
                        Container(height: 60,width: 180,decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.black)
                        ),child: const Center(child: Text('PROGRESS'))),

                        Container(height: 60,width: 180,decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(color: Colors.black)
                        ),child: Column(

                          children: [
                            Expanded(child: Container(width: 180,decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(color: Colors.black)
                            ),child:  Center(child: Consumer<WebProvider>(
                                builder: (context,value,child){
                                return Text(dateConverter(value.fetchedTime));
                              }
                            )))),
                            Expanded(child: Container(width: 180,decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(color: Colors.black)
                            ),child:  Center(child: Consumer<WebProvider>(
                                builder: (context,value,child) {
                                return Text(timeConverter(value.fetchedTime));
                              }
                            )))),
                          ],
                        )),
                        Container(height: 60,width: 180,decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.black)
                        ),child: const Center(child: Text('PROGRESS'))),
                      ],
                    ),
                    Row(

                      children: [
                        Container(height: 30,width: 40,decoration: border,child: const Text('')),

                        Container(height: 30,width: 200,decoration: border,child: const Text('')),
                        Container(height: 30,width: 80,decoration: border,alignment:align,child: Text('COUNT')),
                        Container(height: 30,width: 100,decoration: border,alignment:align,child: Text('AMOUNT')),
                        Container(height: 30,width: 80,decoration: border,alignment:align,child: Text('COUNT')),
                        Container(height: 30,width: 100,decoration: border,alignment:align,child: Text('AMOUNT')),

                        Container(height: 30,width: 80,decoration: border,alignment:align,child: Text('COUNT')),
                        Container(height: 30,width: 100,decoration: border,alignment:align,child: Text('AMOUNT')),
                        Container(height: 30,width: 80,decoration: border,alignment:align,child: Text('COUNT')),
                        Container(height: 30,width: 100,decoration: border,alignment:align,child: Text('AMOUNT')),

                      ],
                    ),
                    Consumer<WebProvider>(
                        builder: (context,value,child) {
                          return ListView.builder(
                            shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: value.distReportArray.length,
                              itemBuilder: (BuildContext context,int index){
                                var item =value.distReportArray[index];
                                var lastItem=value.getLastItem(item.name);
                                if(item.name==''){
                                  return Row(

                                    children: [
                                      Container(height: 30,width: 40,alignment:Alignment.center,decoration: border,child: const Text('')),

                                      Container(height: 30,width: 200,alignment:Alignment.center,decoration: border,child: const Text('')),
                                      Container(height: 30,width: 80,alignment:Alignment.center,decoration: border,child: const Text('')),
                                      Container(height: 30,width: 100,alignment:Alignment.center,decoration: border,child: const Text('')),
                                      Container(height: 30,width: 80,alignment:Alignment.center,decoration: border,child:const Text('',style: TextStyle(color: Colors.red),)),
                                      Container(height: 30,width: 100,alignment:Alignment.center,decoration: border,child: const Text('',style: TextStyle(color: Colors.red),)),

                                      Container(height: 30,width: 80,alignment:Alignment.center,decoration: border,child: const Text('')),
                                      Container(height: 30,width: 100,alignment:Alignment.center,decoration: border,child: const Text('')),
                                      Container(height: 30,width: 80,alignment:Alignment.center,decoration: border,child: const Text('',style: TextStyle(color: Colors.red),)),
                                      Container(height: 30,width: 100,alignment:Alignment.center,decoration: border,child: const Text('',style: TextStyle(color: Colors.red),)),

                                    ],
                                  );

                                }else{
                                  return Row(

                                    children: [
                                      Container(height: 30,width: 40,alignment:align,decoration: border,child: Text((index+1).toString(),style: const TextStyle(fontWeight: FontWeight.bold),)),

                                      Container(height: 30,width: 200,alignment:alignLeft,decoration: border,child: Text(item.name)),
                                      Container(height: 30,width: 80,alignment:align,decoration: border,child: Text(lastItem.count.toString())),
                                      Container(height: 30,width: 100,alignment:align,decoration: border,child: Text(lastItem.amount.toStringAsFixed(2))),
                                      Container(height: 30,width: 80,alignment:align,decoration: border,child: Text(lastItem.progressCount.toString(),style: const TextStyle(color: Colors.red),)),
                                      Container(height: 30,width: 100,alignment:align,decoration: border,child: Text(lastItem.progressAmount.toStringAsFixed(2),style: const TextStyle(color: Colors.red),)),

                                      Container(height: 30,width: 80,alignment:align,decoration: border,child: Text(item.count.toString())),
                                      Container(height: 30,width: 100,alignment:align,decoration: border,child: Text(item.amount.toStringAsFixed(2))),
                                      Container(height: 30,width: 80,alignment:align,decoration: border,child: Text((item.count-lastItem.count).toStringAsFixed(2),style: const TextStyle(color: Colors.red),)),
                                      Container(height: 30,width: 100,alignment:align,decoration: border,child: Text((item.amount-lastItem.amount).toStringAsFixed(2),style: const TextStyle(color: Colors.red),)),

                                    ],
                                  );

                                }
                              }
                          );
                        }
                    ),
                    Consumer<WebProvider>(
                        builder: (context,value,child)  {
                        return Row(

                          children: [
                            Container(height: 30,width: 40,decoration: border,child: const Text('')),

                            Container(height: 30,width: 200,decoration: border,child: const Text('')),
                            Container(height: 30,width: 80,decoration: border,alignment:align,child:  Text(value.lastCountTotal.toString(),style: const TextStyle(fontWeight: FontWeight.bold))),
                            Container(height: 30,width: 100,decoration: border,alignment:align,child:  Text(value.lastAmountTotal.toStringAsFixed(2),style: const TextStyle(fontWeight: FontWeight.bold))),
                            Container(height: 30,width: 80,decoration: border,alignment:align,child:  Text(value.lastProCountTotal.toString(),style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold))),
                            Container(height: 30,width: 100,decoration: border,alignment:align,child:  Text(value.lastProAmountTotal.toStringAsFixed(2),style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold))),

                            Container(height: 30,width: 80,decoration: border,alignment:align,child:  Text(value.countTotal.toString(),style: const TextStyle(fontWeight: FontWeight.bold))),
                            Container(height: 30,width: 100,decoration: border,alignment:align,child:  Text(value.amountTotal.toStringAsFixed(2),style: const TextStyle(fontWeight: FontWeight.bold))),
                            Container(height: 30,width: 80,decoration: border,alignment:align,child:  Text(value.proCountTotal.toString(),style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold))),
                            Container(height: 30,width: 100,decoration: border,alignment:align,child:  Text(value.proAmountTotal.toStringAsFixed(2),style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold))),

                          ],
                        );
                      }
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  var border =BoxDecoration(
      border: Border.all(color: Colors.black),
          color: Colors.white
  );
  var align =Alignment.centerRight;
  var alignLeft =Alignment.centerLeft;

  String dateConverter(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }
  String timeConverter(DateTime date) {
    final DateFormat formatter = DateFormat('hh:mm a');
    final String formatted = formatter.format(date);
    return formatted;
  }
}


