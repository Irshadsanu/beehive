import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../qmchModels/subScriberModel.dart';

class SelectBank extends StatelessWidget {
  String paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice,subScriberType;
  String loginUsername,loginUserID,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
  List<MonthBool> monthList;
   SelectBank({Key? key
     ,required this.paymentCategory
     ,required this.equipmentCount
     ,required this.equipmentID
     ,required this.oneEquipmentPrice,required this.loginUsername,required this.loginUserID,
     required this.subScriberType,required this.loginUserPhone,
     required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,required this.monthList,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }
  Widget mobile(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60.0,
        title: TextField(
          decoration: const InputDecoration(
              hintText: " Search...",
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search, color: Colors.black,)),
          onChanged: (value) {
            donationProvider.onFilterBank(value);
          },
          style: const TextStyle(color: Colors.black, fontSize: 15.0),
        ),
      ),
      body: SafeArea(

        child:
        Consumer<DonationProvider>(
            builder: (context, value, child) {
              return
                ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: value.filteredBanks.length,
                    itemBuilder:
                        (BuildContext context, int index) {
                      var item = value.filteredBanks[index];

                      return InkWell(
                        onTap: () {
                          donationProvider.seamlessNetbankingPayment(
                              context, item.code.toString(),paymentCategory,equipmentCount,equipmentID,
                              oneEquipmentPrice,loginUsername,loginUserID,subScriberType,loginUserPhone,
                            zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice, foodkitPrice, footkitCount,equipmentAmount, sponsorPatientAmonut, foodkitAmount,monthList);
                        },
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(item.bank,
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
            }


        ),
      ),
    );
  }
  Widget web(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    return Stack(children: [
      Row(
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/KnmWebBackground1.jpg'),fit: BoxFit.cover
                )
            ),
            child: Row(
              children: [
                SizedBox(
                    height: height,
                    width: width / 3,
                    child: Image.asset("assets/Group 2.png",scale: 4,)),
                SizedBox(
                  height: height,
                  width: width / 3,
                ),
                SizedBox(
                    height: height,
                    width: width / 3,
                    child: Image.asset("assets/Group 3.png",scale: 6,)),
              ],
            ),
          ),


        ],
      ),
      Center(child:queryData.orientation==Orientation.portrait?  Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(width: width/3,),
          SizedBox(width:width,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                toolbarHeight: 60.0,
                title: TextField(
                  decoration: const InputDecoration(
                      hintText: " Search...",
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search, color: Colors.black,)),
                  onChanged: (value) {
                    donationProvider.onFilterBank(value);
                  },
                  style: const TextStyle(color: Colors.black, fontSize: 15.0),
                ),
              ),
              body: SafeArea(

                child:
                Consumer<DonationProvider>(
                    builder: (context, value, child) {
                      return
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: value.filteredBanks.length,
                            itemBuilder:
                                (BuildContext context, int index) {
                              var item = value.filteredBanks[index];

                              return InkWell(
                                onTap: () {
                                  donationProvider.seamlessNetbankingPayment(
                                      context, item.code.toString(),paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice,
                                      loginUsername,loginUserID,subScriberType,loginUserPhone,
                                    zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice, foodkitPrice, footkitCount,equipmentAmount, sponsorPatientAmonut, foodkitAmount,monthList);
                                },
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(item.bank,
                                        style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                    }


                ),
              ),
            ),
          ),
          // SizedBox(width: width/3,),
        ],
      ):
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(width: width/3,),
          SizedBox(width:width/3,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                toolbarHeight: 60.0,
                title: TextField(
                  decoration: const InputDecoration(
                      hintText: " Search...",
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search, color: Colors.black,)),
                  onChanged: (value) {
                    donationProvider.onFilterBank(value);
                  },
                  style: const TextStyle(color: Colors.black, fontSize: 15.0),
                ),
              ),
              body: SafeArea(

                child:
                Consumer<DonationProvider>(
                    builder: (context, value, child) {
                      return
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: value.filteredBanks.length,
                            itemBuilder:
                                (BuildContext context, int index) {
                              var item = value.filteredBanks[index];

                              return InkWell(
                                onTap: () {
                                  donationProvider.seamlessNetbankingPayment(
                                      context, item.code.toString(),paymentCategory,equipmentCount,equipmentID,oneEquipmentPrice,
                                      loginUsername,loginUserID,subScriberType,loginUserPhone,
                                    zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice, foodkitPrice, footkitCount,equipmentAmount, sponsorPatientAmonut, foodkitAmount,monthList);
                                },
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(item.bank,
                                        style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                    }


                ),
              ),
            ),
          ),
          // SizedBox(width: width/3,),
        ],
      ),)
    ],);
  }

}
