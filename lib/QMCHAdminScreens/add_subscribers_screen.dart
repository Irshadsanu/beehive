import 'package:beehive/QMCHAdminScreens/subScribersListScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';

class AddSubscribersScreen extends StatelessWidget {
  String adminName,adminID,from,id;
   AddSubscribersScreen({Key? key,required this.adminName,
     required this.adminID,required this.from,required this.id}) : super(key: key);
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
              onTap: (){
                finish(context);
              },
                child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black, size: 18,)),),
        ),
        title: Center(
          child: Padding(
          padding:  EdgeInsets.only(right: width*.1),
            child: Text(
            from,
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
      floatingActionButton: Consumer<DonationProvider>(
          builder: (context,value,child) {
            return InkWell(

                onTap: (){
                  var form = formKey1.currentState;
                  if (form!.validate()) {
                    // if(value.fileImage!=null || value.equipmentPhotoUrl != ""){
                      donationProvider.addSubcriber(from,id,adminName,adminID);
                      // finish(context);
                      callNextReplacement(SubScribersListScreen(adminID:adminID, adminName: adminName,), context);
                    }
                  // else{
                  //     const snackBar = SnackBar(
                  //       content: Center(child: Text('Upload Photo')),backgroundColor: Colors.black,
                  //     );
                  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //   }
                //  }

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

                Center(
                  child: Text(
                         'Save',
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
      body: Form(
        key:formKey1,
        child: SizedBox(
          height: height,
          width: width,
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*.06,),
              InkWell(onTap: (){
                donationProvider.showBottomSheet(context);
              },
                  child:
                  Consumer<DonationProvider>(builder: (context, value, child) {
                    // print(value.fileImage.toString() +"adsfasdf");
                    // print(value.equipmentPhotoUrl.toString() +"adsfasdf");
                    return value.fileImage != null
                        ?    Container(
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
                          image:  DecorationImage(
                              image: FileImage(value.fileImage!),fit: BoxFit.cover)))
                        : value.equipmentPhotoUrl != ""
                        ?    Container(
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
                      ),
                        child:Image.network(value.equipmentPhotoUrl!,fit: BoxFit.cover,),
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
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Opacity(
                                opacity: 0.22,
                                child: Text(
                                  'Add Photo',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,

                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                  })),
              const SizedBox(height: 18,),
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
                child: Consumer<DonationProvider>(builder: (context, value, child) {
                  return TextFormField(

                    controller: value.subscriberNameCT,
                    decoration: const InputDecoration(
                      hintText: 'Enter Name',
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10),
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                    ),
                    validator: (txt){
                      if(txt!.isEmpty){
                        return 'Please Enter Name';
                      }else{
                        return null;
                      }
                    },
                  );
                }),
              ),
              const SizedBox(height: 15,),
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
                child: Consumer<DonationProvider>(builder: (context, value, child) {
                  return TextFormField(
                    maxLength: 10,
                    controller: value.subscriberPhoneCT,

                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'Enter Phone Number',
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10),
                      fillColor: Colors.white,
                      filled: true,
                        border: InputBorder.none,
                    ),
                    validator: (txt){
                      if(txt!.isEmpty || txt!.length!=10){
                        return 'Please Enter Phone Number';
                      }else{
                        return null;
                      }
                    },
                  );
                }),
              ),
              const SizedBox(height: 15,),

              ///Subscriber Address
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
                    ),
                  ],
                ),
                child: Consumer<DonationProvider>(builder: (context, value, child) {
                  return TextFormField(
                    controller: value.subscriberAddressCT,
                    decoration: const InputDecoration(
                      hintText: 'Enter Address',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,

                    ),
                    validator: (txt){
                      if(txt!.isEmpty){
                        return 'Please Enter Address';
                      }else{
                        return null;
                      }
                    },
                  );
                }),
              ),

              // const SizedBox(height: 15,),
              //
              // Consumer<DonationProvider>(
              //     builder: (context,value,child) {
              //       return InkWell(onTap: (){
              //         var form = formKey1.currentState;
              //         if (form!.validate()) {
              //           if(value.fileImage!=null){
              //             donationProvider.addSubcriber(from,id,adminName,adminID);
              //             finish(context);
              //           }else{
              //             const snackBar = SnackBar(
              //               content: Center(child: Text('Upload Photo')),backgroundColor: Colors.black,
              //             );
              //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
              //           }
              //         }
              //       },
              //         child: Container(height: 80,width: 100,color: Colors.yellow.withOpacity(0.7),
              //           alignment: Alignment.center,
              //           child: ),
              //       );
              //     }
              // )
            ],
          ),
        ),
      ),
    );
  }
}
