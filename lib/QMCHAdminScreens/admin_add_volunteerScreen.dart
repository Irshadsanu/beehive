import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';

class AdminAddVolunteerScreen extends StatelessWidget {
  String adminName,adminID,from,editID;
   AdminAddVolunteerScreen({Key? key,required this.adminName,required this.adminID,required this.from,required this.editID}) : super(key: key);
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    HomeProvider donationProvider = Provider.of<HomeProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    print(from);
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(onTap: (){
            finish(context);
          },
            child: Container(
              // width: 10,
              // height: 10,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.05000000074505806),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(37.40),
                ),
              ),
              child: InkWell(
                  onTap: () {

                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.black,
                    size: 18,
                  )),
            ),
          ),
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: width * .1),
            child:from=='edit'?
            const Text(
              "Edit Volunteer",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                // height: 0.08,
              ),
            )
                : Text(
              "Add Volunteer",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                // height: 0.08,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<HomeProvider>(
          builder: (context,value,child) {
            return InkWell(

              onTap: (){

                var form = formKey1.currentState;
                if (form!.validate()) {

                      value.addVoulenteers(from,editID,adminName,adminID);
                      finish(context);


                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                  },
              child: Container(
                width: width,
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
                ),
              ),
            );
          }),
      // backgroundColor: Colors.cyan.shade200,
      body: Form(key: formKey1,
        child: Column(

       mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
SizedBox(height: 80,),
            InkWell(onTap: () {
              donationProvider.showBottomSheet(context);
            }, child: Consumer<HomeProvider>(
                builder: (context, value, child) {
                  return value.fileImage != null
                      ? CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(value.fileImage!,),)
                      : value.voulenteerImage != ""
                      ? CircleAvatar(
                    radius: 60,
                    backgroundImage:NetworkImage(value.voulenteerImage!),
                  )
                      : Column(
                    children: [
                      Container(
                        width: 90,
                        height: 90,

                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 5.15,
                                offset: Offset(0, 2.58),
                                spreadRadius: 0,
                              )
                            ],
                            image: const DecorationImage(
                                image: AssetImage(
                                  "assets/upload_poto.png",),scale: 1.5)
                        ),),
                    ],
                  );
                })),
            SizedBox(height: 10,),
            Text(
              'Add Photo',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 50,),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width*0.85,height: 50,
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
                    child: Consumer<HomeProvider>(
                        builder: (context, value, child) {
                          return TextFormField(
                            controller: value.entrollerNameCT,
                            decoration: InputDecoration(
                              hintText: 'Enter Volunteer Name',
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
                                borderSide: BorderSide(color: myGray2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (txt) {
                              if (txt!.isEmpty) {
                                return 'Please Enter Subscriber Name';
                              } else {
                                return null;
                              }
                            },
                          );
                        }),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: width*0.85,height: 50,
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
                    child: Consumer<HomeProvider>(
                        builder: (context, value, child) {
                          return TextFormField(
                            maxLength: 10,
                            controller: value.entrollerPhoneCT,
                            enabled: from=="addNew"?true:false,
                            keyboardType: TextInputType.phone,
                            // maxLength: 10,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],

                            decoration: InputDecoration(

                              hintText: 'Enter Volunteer Phone',
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
                                borderSide: BorderSide(color: myGray2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (txt) {
                              if (txt!.isEmpty || txt!.length!=10) {
                                return 'Please Enter Phone';
                              } else {
                                return null;
                              }
                            },
                          );
                        }),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),



          ],
        ),
      ),

    );
  }
}
