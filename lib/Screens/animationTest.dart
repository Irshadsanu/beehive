import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:InkWell(
          onTap: (){
            final player=AudioCache();
            player.play('music.mp3');
          },


            child: Text("Cliccck")),
      ),
    );
  }
}
