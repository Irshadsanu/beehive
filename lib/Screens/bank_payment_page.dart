import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../constants/my_colors.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import 'package:provider/provider.dart';
class BankPaymentPage extends StatelessWidget {
  const BankPaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }

  }
  Widget body(BuildContext context) {
    DonationProvider donationProvider =Provider.of<DonationProvider>(context,listen: false);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text('Using UPI ID',style:black16,),
              ),
            ),
            const SizedBox(height: 3,),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 5,left: 15,bottom: 10,right: 15),
                child: Consumer<DonationProvider>(
                    builder: (context,value,child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: Row(
                            children: [
                              Text('UPI   :  ',style: blackPoppinsR12,),
                              Flexible(child: InkWell(
                                  onTap: (){
                                    donationProvider.copyToClipBoard(context,value.acUpiId);

                                  },
                                  child: Text(value.acUpiId,style: bluePoppinsR12,))),
                            ],
                          )),
                          InkWell(
                              onTap:(){
                                donationProvider.copyToClipBoard(context,value.acUpiId);
                              },
                              child: Column(
                                children: const [
                                  Icon(Icons.copy),
                                  Text("Copy",style:TextStyle(fontSize: 9))
                                ],
                              )),

                        ],
                      );
                    }
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20),
              child: Row(
                children:  [
                  const Expanded(child:  Divider(indent: 10,endIndent: 10,thickness: 2,)),
                  Text('Or',style:blackPoppinsR12,),
                  const Expanded(child:  Divider(indent: 10,endIndent: 10,thickness: 2,)),
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text('Using Account Details',style:black16,),
                  ),
                  const SizedBox(height: 3,),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    elevation: 3,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10,left: 15,bottom: 5,right: 15),
                          child: Consumer<DonationProvider>(
                              builder: (context,value,child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Text('Account Name    : ',style: blackPoppinsR12,),
                                          Flexible(child: InkWell(
                                              onTap: (){
                                                donationProvider.copyToClipBoard(context,value.acName);

                                              },
                                              child: Text(value.acName,style: bluePoppinsR12,))),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                        onTap:(){
                                          donationProvider.copyToClipBoard(context,value.acName);
                                        },
                                        child: Column(
                                          children: const [
                                            Icon(Icons.copy),
                                            Text("Copy",style:TextStyle(fontSize: 9))
                                          ],
                                        )),
                                  ],
                                );
                              }
                          ),
                        ),
                        const Divider(indent: 10,endIndent: 10,thickness: 2,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                          child: Consumer<DonationProvider>(
                              builder: (context,value,child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Row(
                                      children: [
                                        Text('Account Number : ',style: blackPoppinsR12,),
                                        InkWell(
                                          child: Text('${value.acNo}',style: bluePoppinsR12,),onTap: (){
                                          donationProvider.copyToClipBoard(context,value.acNo);

                                        },),
                                      ],
                                    ),
                                    InkWell(
                                        onTap:(){
                                          donationProvider.copyToClipBoard(context,value.acNo);
                                        },
                                        child: Column(
                                          children: const [
                                            Icon(Icons.copy),
                                            Text("Copy",style:TextStyle(fontSize: 9))
                                          ],
                                        )),

                                  ],
                                );
                              }
                          ),
                        ),
                        const Divider(indent: 10,endIndent: 10,thickness: 2,),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                          child: Consumer<DonationProvider>(
                              builder: (context,value,child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Row(
                                      children: [
                                        Text('IFSC                         : ',style: blackPoppinsR12,),
                                        InkWell(child: Text('${value.ifsc}',style: bluePoppinsR12,),onTap: (){
                                          donationProvider.copyToClipBoard(context,value.ifsc);

                                        },),
                                      ],
                                    ),
                                    InkWell(
                                        onTap:(){
                                          donationProvider.copyToClipBoard(context,value.ifsc);
                                        },
                                        child: Column(
                                          children: const [
                                            Icon(Icons.copy),
                                            Text("Copy",style:TextStyle(fontSize: 9))
                                          ],
                                        )),


                                  ],
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20),
                    child: Row(
                      children:  [
                        const Expanded(child:  Divider(indent: 10,endIndent: 10,thickness: 2,)),
                        Text('Or',style:blackPoppinsR12,),
                        const Expanded(child:  Divider(indent: 10,endIndent: 10,thickness: 2,)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text('Using Scan QR Code',style:black16,),
                  ),
                  const SizedBox(height: 3,),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    elevation: 3,
                    child: Column(
                      children: [
                        const SizedBox(height:10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Image.asset('assets/upiqrcode.jpeg',height:200,width: 200,)),
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width-50,
                            child: Image.asset("assets/upi_apps_icon.png"),
                          ),
                        ),

                        !kIsWeb?Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: (){
                              donationProvider.shareQr();
                            }, child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Share'),
                              Icon(Icons.share,size: 20),
                            ],
                          ),
                          ),
                        ):const SizedBox(),
                      ],
                    ),
                  ),


                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 20),
                  //   child: Row(
                  //     children:  [
                  //       const Expanded(child:  Divider(indent: 10,endIndent: 10,thickness: 2,)),
                  //       Text('Or',style:blackPoppinsR12,),
                  //       const Expanded(child:  Divider(indent: 10,endIndent: 10,thickness: 2,)),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 5,),



                ],
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/name.png",color: Colors.black,scale: 30,),
                    const SizedBox(width:8),
                    const Flexible(
                      child: Text(
                          ' Payment Receipt   24 മണിക്കൂറിന് ശേഷം ആപ്പിൽ നിന്നും download ചെയ്യാവുന്നതാണ്.',style:TextStyle(color: Colors.black,fontSize: 18)
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height:10)
          ],
        ),
      ),
    );
  }
  Widget mobile(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: myGreenNewUI,
      ),
      body: body(context),
    );
  }

  Widget web(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =Provider.of<DonationProvider>(context,listen: false);
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

          child:queryData.orientation==Orientation.portrait? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                width: width,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: myGreenNewUI,
                  ),
                  body: body(context),                ),
              ),
            ],
          ): Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width/3,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: myGreenNewUI,
                  ),
                  body: body(context),                ),
              ),
            ],
          ),
        ),
      ],
    );

  }
}
