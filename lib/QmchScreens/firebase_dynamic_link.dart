import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class FirebaseDynamicLinkService{

  final FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<String>createDynamicLink(bool short,String Id) async {
    String linkMessage;
    bool _isCreatingLink = false;
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    print("GGGGGGGGG");
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://qmch.page.link',
      link: Uri.parse('https://www.qmch.com/media?id=$Id"&si="https://firebasestorage.googleapis.com/v0/b/renaitv.appspot.com/o/1671273006736?alt=media&token=a4c29cb0-8dbc-42e6-b3d9-90d514d4c722'),
      androidParameters: const AndroidParameters(
        packageName: "com.spine.qmch",
        minimumVersion: 1,
      ),
    );

    Uri url;

    if (short) {
      final ShortDynamicLink shortLink =
      await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }
    linkMessage=url.toString();
    return linkMessage;


  }


  static Future<void>initDynamicLink(BuildContext context,String youTubeLink,String title,String description,String thumbnile,String id,String fromDate,String toDate) async {
    print('isNews showing'+id);
    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData dynamicLinkData) {
      final Uri deepLink=dynamicLinkData.link;
      var isNews=deepLink.pathSegments.contains("news");
      if (isNews){
        print('isNews showing');

        id=deepLink.queryParameters["id"].toString() ;
      }

      if(deepLink!=null){

        print('isNews deepLink');

        try {
          print("hegvdhhhuuhhyhhhhhhhhhhhh"+fromDate);
          print("fbvhfgvvvvvvvvvvfhgggggg"+toDate);
          // Navigator.push(context, MaterialPageRoute(builder: (context) =>
          //     Description(youTubeLink: youTubeLink, title: title, description: description, thumbnile: thumbnile, id: id,contentType:'',todate: toDate,fromdate: fromDate,)));
        }catch(e){
          print(e.toString()+"jjjjjjjjjjjjjjjjjj");
        }
      }
      else{
        return null;
      }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });


    //    final PendingDynamicLinkData data = FirebaseDynamicLinks.instance.getInitialLink() as PendingDynamicLinkData;
    //    final Uri deepLink = data.link;
    //
    //    var isNews = deepLink.pathSegments.contains("news");
    //    if(isNews){
    //       itemList.id = deepLink.queryParameters["id"].toString();
    //
    //       if(deepLink!= null){
    //         try{
    //           print("hegvdhhhuuhhyhhhhhhhhhhhh");
    //           Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //               OpenNewsScreen(itemlist: itemList)));
    //
    //         }catch(e){
    //           print(e);
    //         }
    //       }
    //    }
    //
    //
  }
}