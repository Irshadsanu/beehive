import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/my_colors.dart';
import '../constants/text_style.dart';

class Update extends StatelessWidget {
  String text;
  String button;
  String ADDRESS;
  Update({Key? key,required this.text,required this.button,required this.ADDRESS}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:  const BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     myWhite,cl2C4680,
            //   ]
            // )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 130,
                margin: const EdgeInsets.only(bottom: 10),

                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/qmchBg.png",),
                    scale: 1,
                    fit: BoxFit.fitHeight,
                  ),
                ),

              ),
              Text(
                'QUAID-E-MILLATH\nCENTRE FOR HUMANITY',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Jaldi',fontWeight:FontWeight.w600,letterSpacing: 1.2 ),
              ),
              // SizedBox(height: 50,),

              Padding(
                padding: const EdgeInsets.only(right: 30,left: 30,top: 36,bottom: 10),
                child: Text(text ,
                  style: TextStyle(
                    color: Color(0xFF18182B),
                fontSize: 12.67,
                fontFamily: 'Montserrat',
                letterSpacing: 0.8,
                fontWeight: FontWeight.w600,
              ),),
              ),
              SizedBox(height: 10,),
              InkWell(
                splashColor: Colors.white,
                onTap: (){
                  _launchURL(ADDRESS);
                },
                child: Container(
                  height: 40,
                  width: 150,

                  decoration: BoxDecoration(
                    gradient: const LinearGradient(

                      colors: [Color(0xFF253068), Color(0xFF3E4FA3)],

                    ),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,),
                          child: Text(button,style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            color: myWhite,
                          ),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png",scale:3),
            ],
          ),
        ),


      ),
    );

  }
  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
