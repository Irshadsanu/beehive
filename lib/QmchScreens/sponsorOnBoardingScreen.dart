import 'package:beehive/QmchScreens/patient_sponsership_homescreen.dart';
import 'package:flutter/material.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';

class UserSponsorOnboardingScreen extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
   UserSponsorOnboardingScreen({Key? key,required this.loginUsername,
     required this.loginUserID,required this.subScriberType,required this.loginUserPhone,
     required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/sponsorBg.png"),fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0,top: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Patient Sponsorship",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "Poppins",color: myBlack) ,),
              Text("consectetur adipiscing elit. Ut viverra sapien in est porta,\nvel cursus urnrutrum.consectetur adipiscing elit.\n"
                  "Ut viverra sapien in est porta, vel cursus urna rutrum.",style:TextStyle(fontSize: 10,fontWeight: FontWeight.w500,fontFamily: "Poppins",color: myBlack) ,),
             Spacer(),
              Padding(
                padding:  EdgeInsets.only(bottom: height*0.04),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(onTap: (){
                    callNextReplacement(PatientSposershipHomeScreen(loginUserPhone: loginUserPhone,
                        loginUserID: loginUserID,loginUsername: loginUsername,subScriberType: subScriberType ,zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                      sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                      foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
                  },
                    child: Container(
                      width: width/2.9,
                      height:50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        gradient:  LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [cl_3F50A4, cl_253068],
                        ),
                      ),
                      child: Center(
                        child: Text("Next",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w600,
                            fontSize: 12,color: myWhite),),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),

    );
  }
}
