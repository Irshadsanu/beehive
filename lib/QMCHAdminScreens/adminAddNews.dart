import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';

class AdminAddNewsScreen extends StatelessWidget {
  String adminName,adminID,from,editID;
  AdminAddNewsScreen({Key? key,required this.adminName,required this.adminID,required this.from,required this.editID}) : super(key: key);
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(        backgroundColor: myWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

floatingActionButton:                 Consumer<DonationProvider>(
    builder: (context,value,child) {
      return InkWell(onTap: () {
        print(from);
        var form = formKey1.currentState;
        if (form!.validate()) {
          // if (from == 'new') {
            // || (value.newsImage != '' &&
            // value.newsImage.toString() != 'null')
            // if (value.fileImage != null) {
              print('hellw');

              donationProvider.addNewsFeed(
                  from, editID, adminName, adminID);
              finish(context);
            }
        // else {
        //       const snackBar = SnackBar(
        //         content: Center(child: Text('Upload Photo')),
        //         backgroundColor: Colors.black,
        //       );
        //
        //       ScaffoldMessenger.of(context).showSnackBar(
        //           snackBar);
        //     }
        //   }

          // else {
          //   donationProvider.addNewsFeed(
          //       from, editID, adminName, adminID);
          //   finish(context);
          // }

        },

        child: Container(   width: width,
          height: 46,
          margin: const EdgeInsets.only(

            left: 20,
            right: 20,

          ),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.00, -0.00),
              end: Alignment(1, 0),
              colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(34),
            ),
          ),
          child:

          // Center(
          //   child: Text(
          //     from=="Add Subscriber"
          //         ? 'Save'
          //         :"Edit",
          //     style: const TextStyle(
          //       color: Colors.white,
          //       fontSize: 12,
          //       fontFamily: 'Poppins',
          //       fontWeight: FontWeight.w600,
          //
          //     ),
          //   ),
          // ),
          Center(
            child: Text(
              "Save",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,

              ),
            ),
          ),),
      );
    }
)
      ,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: myWhite,
        leading: InkWell(
          onTap: (){
            finish(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.only(right: 5),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.05000000074505806),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(37.40),
                ),
              ),
              child: const Icon(Icons.arrow_back_ios_new_outlined,color: myBlack, size: 18,),),
          ),
        ),
        title: const Text(
          'Add Activity',
          style: TextStyle(
            color: myBlack,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            // height: 0.08,
          ),
        ),
      ),

      body: SizedBox(width: width,height: height,
        child: Form(key: formKey1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(onTap: () {
                  donationProvider.showBottomSheet(context);
                }, child: Consumer<DonationProvider>(
                    builder: (context, value, child) {
                      return value.fileImage != null
                          ? Container(
                          width: width,
                          height: 181.68,
                          decoration: ShapeDecoration(
                            color: myWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x28000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                     child: Image.file(value.fileImage!))
                          : value.newsImage != ""
                          ? Container(
                          width: width,
                          height: 181.68,
                          decoration: ShapeDecoration(
                            color: myWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x28000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Image.network(value.newsImage!,fit: BoxFit.fill,))
                          : Container(

                          width: width,
                          height: 181.68,
                          decoration: ShapeDecoration(
                            color: myWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x28000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Icon(Icons.add_photo_alternate_outlined,color: Colors.grey,),
                              Text(
                                'Add Photo',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                      );
                    })),
                SizedBox(height: 20,),

                Container( width: width*0.85,height: 50,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.04),
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
                  child: Consumer<DonationProvider>(builder: (context, value, child) {
                    return TextFormField(
                      controller: value.newsTitleCT,
                      decoration: InputDecoration(
                        hintText: 'Enter News Title',
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10),

                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide:  BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (txt){
                        if(txt!.isEmpty){
                          return 'Please Enter Title';
                        }else{
                          return null;
                        }
                      },
                    );
                  }),
                ),

                SizedBox(height: 15,),
                Container(width: width*0.85,height: 50,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.04),
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
                  child: Consumer<DonationProvider>(builder: (context, value, child) {
                    return TextFormField(

                      controller: value.newsDiscriptionCT,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter News Description',
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10),

                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide:  BorderSide(color: myGray2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (txt){
                        if(txt!.isEmpty){
                          return 'Please Enter Description';
                        }else{
                          return null;
                        }
                      },
                    );
                  }),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}