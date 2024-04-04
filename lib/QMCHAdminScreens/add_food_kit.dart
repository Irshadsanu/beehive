import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';

class AdminAddFoodKitScreen extends StatelessWidget {
  String adminName,adminID,from,editID;
  AdminAddFoodKitScreen({Key? key,required this.adminName,required this.adminID,required this.from,required this.editID}) : super(key: key);
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(backgroundColor: Colors.blue.withOpacity(0.4),
      appBar: AppBar(
        leading: InkWell(onTap: (){
          finish(context);
        },
            child: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
      ),
      body: SizedBox(width: width,height: height,
        child: Form(key: formKey1,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<DonationProvider>(
                  builder: (context,value,child) {
                    return
                      value.fileImage!=null?
                      InkWell(
                        onTap: (){
                          value.showBottomSheet(context);
                        },
                        child: Column(
                          children: [
                            SizedBox(height: height*0.03,),
                            Container(height: 300,width: width*0.7,
                              decoration: BoxDecoration(

                                  image: DecorationImage(
                                      image: FileImage(value.fileImage!)
                                  )
                              ),),
                          ],
                        ),
                      ):
                          value.fetchimage==''?
                    InkWell(
                        onTap: (){
                          value.showBottomSheet(context);
                        },
                        child: Icon(Icons.person,size: 100,)
                      ):
                    Image.network(value.fetchimage);

                  }
              ),

              SizedBox(width: width*0.5,height: 50,
                child: Consumer<DonationProvider>(builder: (context, value, child) {
                  return TextFormField(
                    controller: value.foodKitNameCT,
                    decoration: InputDecoration(
                      hintText: 'Enter Food Name',
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
                        borderSide:  BorderSide(color: myGray2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (txt){
                      if(txt!.isEmpty){
                        return 'Please Enter Food Name';
                      }else{
                        return null;
                      }
                    },
                  );
                }),
              ),
              SizedBox(height: 15,),
              SizedBox(width: width*0.5,height: 50,
                child: Consumer<DonationProvider>(builder: (context, value, child) {
                  return TextFormField(

                    controller: value.foodKitPriceCT,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Food Price',
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10),
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide:  BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (txt){
                      if(txt!.isEmpty){
                        return 'Please Enter Price';
                      }else{
                        return null;
                      }
                    },
                  );
                }),
              ),
              SizedBox(height: 15,),
              SizedBox(width: width*0.5,height: 50,
                child: Consumer<DonationProvider>(builder: (context, value, child) {
                  return TextFormField(

                    controller: value.foodKitDiscriptionCT,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Enter Food Description',
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10),
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide:  BorderSide(color: Colors.black),
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

              Consumer<DonationProvider>(
                  builder: (context,value,child) {
                    return InkWell(onTap: (){
                      var form = formKey1.currentState;
                      if (form!.validate()) {
                        if(value.fileImage!=null&&value.fetchimage!=null){
                          donationProvider.addFoodKit(from,editID,adminName,adminID, value.fileImage);
                          finish(context);
                        }else{
                          const snackBar = SnackBar(
                            content: Center(child: Text('Upload Photo')),
                            backgroundColor: Colors.black,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                      child: Container(height: 80,width: 100,color: Colors.yellow.withOpacity(0.7),
                        alignment: Alignment.center,
                        child: Text('save'),),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}