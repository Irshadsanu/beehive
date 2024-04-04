import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';

class AdminAddEqupmentsScreen extends StatelessWidget {
  String adminName, adminID,editID,from;
  AdminAddEqupmentsScreen(
      {Key? key, required this.adminName, required this.adminID,required this.editID,required this.from})
      : super(key: key);
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<DonationProvider>(
          builder: (context,value,child) {
            return InkWell(
              onTap: (){
                // donationProvider.clearSubcriptionScreen();
                // callNext(AddSubscribersScreen(adminID: adminID,adminName: adminName,from: "Add Subscriber",id: ""), context);
                var form = formKey1.currentState;
                if (form!.validate()) {
                  if(from==''){
                    if (value.fileImage != null) {
                      donationProvider.addEquipment(
                          from, '', adminName, adminID);
                      finish(context);
                    } else {
                      const snackBar = SnackBar(
                        content: Center(child: Text('Upload Photo')),
                        backgroundColor: Colors.black,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                  else{
                    print('jelplasdl');
                    donationProvider.addEquipment(
                        from, editID, adminName, adminID);
                    finish(context);

                  }

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
                child: Row( mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,

                      ),
                    )
                  ],
                ),),
            );
          }),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
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
                  finish(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                  size: 18,
                )),
          ),
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: width * .1),
            child: Text(
              "Add Equipment",
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
      body: SingleChildScrollView(
        child: Form(
          key: formKey1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                InkWell(onTap: () {
                  donationProvider.showBottomSheet(context);
                }, child:
                    Consumer<DonationProvider>(builder: (context, value, child) {
                  return value.fileImage != null
                      ? Container(
                          height: height * .2,
                          width: width ,
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
                          image: DecorationImage(
                              image: FileImage(value.fileImage!))


                              // color: Colors.red,
                              ))
                      : value.equipmentPhotoUrl != ""
                          ? Container(
                              height: height * .2,
                              width: width,
                              // decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(15),
                              //     image: DecorationImage(
                              //         image: NetworkImage(
                              //             value.useruploadedPhotoUrl!)))
                              child: Image.network(value.equipmentPhotoUrl!))
                          :               Container(
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
                SizedBox(height: 14,),
                Container(
                  width: width,
                  height: 50,
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
                  child: Consumer<DonationProvider>(
                      builder: (context, value, child) {
                    return TextFormField(
                      controller: value.equipmentNameCT,
                      decoration: InputDecoration(
                        hintText: 'Equipment Name',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        focusedBorder: InputBorder.none,
                        enabledBorder:  InputBorder.none,
                        errorBorder:  InputBorder.none,
                      ),
                      validator: (txt) {
                        if (txt!.isEmpty) {
                          return 'Please Enter Equipment Name';
                        } else {
                          return null;
                        }
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
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
                  width: width,
                  height: 50,
                  child: Consumer<DonationProvider>(
                      builder: (context, value, child) {
                    return TextFormField(
                      controller: value.equipmentPriceCT,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Equipment Price',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),

                        focusedBorder:  InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
                      validator: (txt) {
                        if (txt!.isEmpty) {
                          return 'Please Enter Price';
                        } else {
                          return null;
                        }
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
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
                  width: width,
                  height: 50,
                  child: Consumer<DonationProvider>(
                      builder: (context, value, child) {
                    return TextFormField(
                      controller: value.equipmentCountCT,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Equipment Count',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),

                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder:  InputBorder.none,
                      ),
                      validator: (txt) {
                        if (txt!.isEmpty) {
                          return 'Please Enter Count';
                        } else {
                          return null;
                        }
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: width,
                  height: 50,
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
                  child: Consumer<DonationProvider>(
                      builder: (context, value, child) {
                        return TextFormField(
                          controller: value.equipmentDiscriptionCT,
                          decoration: InputDecoration(
                            hintText: ' Equipment Discription',
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: myGray2),
                              borderRadius: BorderRadius.circular(18.04),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: myGray2),
                              borderRadius: BorderRadius.circular(18.04),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: myGray2),
                              borderRadius: BorderRadius.circular(18.04),
                            ),
                          ),
                          validator: (txt) {
                            if (txt!.isEmpty) {
                              return 'Please Enter Equipment Discription';
                            } else {
                              return null;
                            }
                          },
                        );
                      }),
                ),

                // Consumer<DonationProvider>(builder: (context, value, child) {
                //   return InkWell(
                //     onTap: () {
                //       var form = formKey1.currentState;
                //       if (form!.validate()) {
                //         if (value.fileImage != null) {
                //           donationProvider.addEquipment(
                //               'AddNew', '', adminName, adminID);
                //           finish(context);
                //         } else {
                //           const snackBar = SnackBar(
                //             content: Center(child: Text('Upload Photo')),
                //             backgroundColor: Colors.black,
                //           );
                //
                //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //         }
                //       }
                //     },
                //     child: Container(
                //       height: 80,
                //       width: 100,
                //       color: Colors.yellow.withOpacity(0.7),
                //       alignment: Alignment.center,
                //       child: Text('save'),
                //     ),
                //   );
                // })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
