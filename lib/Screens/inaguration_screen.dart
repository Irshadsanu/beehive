import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../providers/home_provider.dart';
import '../providers/web_provider.dart';

class InagurationScreen extends StatelessWidget {
  const InagurationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    WebProvider webProvider = Provider.of<WebProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(

        actions: <Widget>[
           //IconButton
          IconButton(
            icon: const Icon(Icons.power_settings_new_sharp),
            tooltip: 'Setting Icon',
            onPressed: () {
              homeProvider.inagurationOFF();

            },
          ), //IconButton
        ], //<Widget>[]
        backgroundColor: Colors.greenAccent[400],
        elevation: 0.0,

        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Center(
        child: InkWell(
          onTap: (){
            final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

            print("Startededd");
           homeProvider.inagurationON();
            mRoot.child("0").child("inaguration").set("ON");

          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: Colors.green,
            ),
            width: 300,
            height: 300,

            child: const Center(child: Text("Launch",style: TextStyle(color: myWhite,fontSize: 50,fontWeight: FontWeight.bold ),)),
          ),
        ),
      ),
    );
  }
}
