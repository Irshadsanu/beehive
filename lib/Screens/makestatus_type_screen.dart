import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/home_provider.dart';
import 'home_screen.dart';
import 'make_status_page.dart';

class MakeStatusTypeSelection extends StatelessWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
   MakeStatusTypeSelection({Key? key,required this.loginUsername,required this.loginUserPhone,
     required this.loginUserID,required this.subScriberType,  required this.zakathAmount,
     required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(84),
        child: AppBar(
          flexibleSpace: Container(
            height: MediaQuery.of(context).size.height*0.12,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(17),bottomRight: Radius.circular(17))
            ),
          ),
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
          title: const Padding(
            padding: EdgeInsets.only(left: 22,top: 25),
            child: Text(
              "Receipt",
              style: TextStyle(color: cl323A71,fontFamily: "PoppinsMedium"),
            ),
          ),
          leading: InkWell(
              onTap: () {
                callNextReplacement( HomeScreenNew(subScriberType: subScriberType,
                    loginUserID: loginUserID,
                    loginUsername: loginUsername,loginUserPhone: loginUserPhone,zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                  sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                  foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Icon(Icons.arrow_back_ios_new, color: cl323A71),
              )),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){

              callNext(MakeStatusPage(subScriberType: subScriberType,from: "family",
                  loginUserID: loginUserID,loginUsername: loginUsername,loginUserPhone: loginUserPhone,
                zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 22,vertical: 15),
              decoration:  BoxDecoration(
                boxShadow:  [
                  const BoxShadow(
                    color:cl323A71,
                  ),
                  BoxShadow(
                    color: cl000000.withOpacity(0.25),
                    spreadRadius: -5.0,
                    // blurStyle: BlurStyle.inner,
                    blurRadius: 20.0,
                  ),

                ],
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [cl323A71, cl1177BB]),

              ),
              child: const Center(
                  child: Text(
                    "Make Status With Family",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "PoppinsMedium",
                        color: myWhite, fontWeight: FontWeight.w500),
                  )),
            ),
          ),
          InkWell(
            onTap: (){
              HomeProvider homeProvider =
              Provider.of<HomeProvider>(context, listen: false);
              homeProvider.fileImage=null;
              callNext(MakeStatusPage(subScriberType: subScriberType,from: "",
                loginUserID: loginUserID,loginUsername: loginUsername,
                loginUserPhone: loginUserPhone,zakathAmount: zakathAmount,sponsorPatientAmonut: sponsorPatientAmonut,sponsorItemOnePrice: sponsorItemOnePrice,
                sponsorCount: sponsorCount,sponsorCategory: sponsorCategory,footkitCount:footkitCount,deseaseName: deseaseName,
                foodkitPrice:foodkitPrice ,equipmentAmount:equipmentAmount ,foodkitAmount: foodkitAmount, ), context);
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 22,vertical: 15),
              decoration:  BoxDecoration(
                boxShadow:  [
                  const BoxShadow(
                    color:cl323A71,
                  ),
                  BoxShadow(
                    color: cl000000.withOpacity(0.25),
                    spreadRadius: -5.0,
                    blurRadius: 20.0,
                  ),

                ],
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [cl323A71, cl1177BB]),

              ),
              child: const Center(
                  child: Text(
                    "Make My Status",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "PoppinsMedium",
                        color: myWhite, fontWeight: FontWeight.w500),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
