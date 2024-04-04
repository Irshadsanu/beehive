import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../qmchModels/foodkitModel.dart';
import 'firebase_dynamic_link.dart';
import 'dart:io';

class UserActivityDetailsScreen extends StatelessWidget {
  NewsFeedModel newsFeedModel;
   UserActivityDetailsScreen({Key? key,required this.newsFeedModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return  Scaffold(
      floatingActionButton:  InkWell(onTap:() async {
        String generatedDeepLink=
        await FirebaseDynamicLinkService.createDynamicLink(true,newsFeedModel.id);

        var imageUrl = newsFeedModel.image;
        if(newsFeedModel!=''){
          imageUrl = newsFeedModel.image.toString();
        }else{
          imageUrl = 'https://firebasestorage.googleapis.com/v0/b/rayyou-c92a0.appspot.com/o/News.png?alt=media&token=d3eb0117-481d-44cf-8f4b-cdfd268611a3';
        }
        final uri = Uri.parse(imageUrl);
        final response = await http.get(uri);
        final bytes = response.bodyBytes;
        final temp = await getTemporaryDirectory();
        final path = '${temp.path}/image.jpg';
        File(path).writeAsBytesSync(bytes);
        print(generatedDeepLink+"      jddddddddd");
        await Share.shareFiles([path],text: '${newsFeedModel.title}:\n\nDownload QMCH APP to read more and be updated $generatedDeepLink',
            subject: 'Look what I made!');
      },
        child: CircleAvatar(
          radius: 34,
          backgroundColor: myBlack.withOpacity(0.1),
          child: Icon(Icons.share,size: 20,color: cl_3F50A4,),
        ),
      ),
      appBar: AppBar(
        backgroundColor: myWhite,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
              radius: 22,
              backgroundColor: myBlack.withOpacity(0.05),
              child: InkWell(
                onTap: (){
                  finish(context);
                },
                  child: const Icon(Icons.arrow_back_ios_new_outlined,size: 15,color: myBlack,))),
        ),
        centerTitle: true,
        title: const Text("Activity",style: TextStyle(color:myBlack, fontFamily: 'Poppins',
          fontSize: 15,fontWeight: FontWeight.w600,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.fromLTRB(18.0,20,18,20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(newsFeedModel.title,style: TextStyle(
                fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'Poppins',color: myBlack
              ),),
              SizedBox(height: 20,),
              newsFeedModel.image!=''?
              Container(
                width: width,
                height: height/3,
                decoration: BoxDecoration(
                  image:
                  DecorationImage(image: NetworkImage(newsFeedModel.image),fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10)
              ),
              ):Container(

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

                      Icon(Icons.photo,color: Colors.grey,),
                      SizedBox(height: 5,),
                      Text(
                        'Image Not Found',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(newsFeedModel.nowDifferece,style:TextStyle( fontSize: 10,fontWeight: FontWeight.w500,fontFamily: 'Poppins',color: myBlack.withOpacity(0.5)) ,),
              ),
              SizedBox(height: 10,),
              Text(newsFeedModel.description,
              style: TextStyle( fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'Poppins',color: myBlack),),
              // SizedBox(height: 10,),
              // Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, "
              //     "and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. ",
              //   style: TextStyle( fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'Poppins',color: myBlack),),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
