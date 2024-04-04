import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {

  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;

  Reference ref = FirebaseStorage.instance.ref("ItemImages");




  final List<String> imgList = [];

  void fetchImages() {
    // db.collection("CAROUSAL IMAGES").get().then((value) {
    //   if (value.docs.isNotEmpty) {
    //     print("images exist");
    //     Map<dynamic, dynamic> map = value.docs as Map;
    //
    //     map.forEach((key, value) {
    //       imgList.add(value);
    //     });
    //      print("image list length  "+imgList.length.toString());
    //
    //     notifyListeners();
    //   }
    // }
    // );


    ////////////
    String image="";
    db.collection("CAROUSAL IMAGES").snapshots().listen((value ){
      if (value.docs.isNotEmpty) {
        imgList.clear();
        for(var element in value.docs){
          Map<dynamic, dynamic> map = element.data() as Map;
          image =  map['ItemImage'];
          imgList.add(image);
          notifyListeners();
        }
      }
    });

  }

}