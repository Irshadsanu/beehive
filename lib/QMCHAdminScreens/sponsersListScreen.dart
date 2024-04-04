import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';
import 'add_sponser_screen.dart';

class SponsersListScreen extends StatelessWidget {
  String adminName, adminID;
  SponsersListScreen({Key? key, required this.adminName, required this.adminID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            // width: 10,
            // height: 10,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0.05000000074505806),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(37.40),
              ),
            ),
            child: InkWell(
                onTap: (){
                  finish(context);
                },
                child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black, size: 18,)),),
        ),
        title: Center(
          child: Padding(
            padding:  EdgeInsets.only(right: width*.1),
            child: Text(
              'Sponsors',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                // height: 0.08,
              ),
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () {
          donationProvider.clearSponserScreen();
          callNext(AddSponserScreen(adminID: adminID, adminName: adminName,from: 'Add',editID: ''),
              context);
        },
        child:   Container(
          width: width,
          height: 46,
          margin: const EdgeInsets.only(

            left: 20,
            right: 20,

          ),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.00, -0.00),
              end: Alignment(1, 0),
              colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(34),
            ),
          ),
          child: Row( mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.add,color: Colors.white,size: 15,),
              Text(
                ' Add Sponsor',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,

                ),
              )
            ],
          ),),
      ),
      body: Consumer<DonationProvider>(builder: (context, value, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: cl898989,
                  fontFamily: "PoppinsRegular",
                  fontWeight: FontWeight.w100,
                  fontSize: 12,
                ),
                onChanged: (value11) {
                  value.searchSponsers(value11);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: myWhite,
                  hintText: "Search..",
                  hintStyle:TextStyle(
                    color: cl898989.withOpacity(0.56),
                    fontFamily: "PoppinsRegular",
                    fontWeight: FontWeight.w100,
                    height: 0.090,
                    fontSize: 12,
                  ),
                  suffixIcon: const Icon(Icons.search,color: cl898989,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                  ),
                  constraints: const BoxConstraints(
                      minHeight: 40,
                      maxHeight: 50
                  ),

                ),
              ),
            ),

            Flexible(fit:FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.filterSponsersList.length,
                          itemBuilder: (context, index) {
                            var item = value.filterSponsersList[index];
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: (){
                                  donationProvider.clearSponserScreen();
                                  donationProvider.fetchSponserDetails(item.id);
                                  callNext(AddSponserScreen(adminID: adminID, adminName: adminName,from: 'edit',editID: item.id),
                                      context);
                                },
                                onLongPress: (){
                                  print(' INFEVNEV');
                                  deleteAlert(context,item.id);
                              },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(5),
                                  height: 70,
                                  decoration: ShapeDecoration(
                                    color: myWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x0A000000),
                                        blurRadius: 5.15,
                                        offset: Offset(0, 2.58),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(left:10,),
                                        height: 58,
                                        clipBehavior: Clip.antiAlias,
                                        decoration:  ShapeDecoration(
                                          color:  Color(0xFFCECECE).withOpacity(.3),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(20))
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left: width*.02,right: width*.02),
                                              child: Text(
                                                ' ${index+1} ',
                                                style: const TextStyle(
                                                  color: myBlack,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: -0.12,
                                                ),
                                              ),
                                            ),

                                            item.photo.isEmpty? Container(
                                              width: 54,
                                              height: 54,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),

                                              ),
                                              child: Image.asset('assets/profile.png',scale: 5),
                                            ):
                                            Container(
                                              width: 54,
                                              height: 54,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: ShapeDecoration(
                                                  color: myBlack,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  image:  DecorationImage(
                                                      image: NetworkImage(item.photo),
                                                      fit: BoxFit.cover
                                                  )
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                      const SizedBox(width: 10,),

                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [

                                                Flexible(
                                                  fit:FlexFit.tight,
                                                  child: Container(
                                                    // color:Colors.green,
                                                    child: Text(
                                                      item.name,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        color: cl3E4FA3,
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: -0.12,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),

                                            Text(item.phone,
                                              style: const TextStyle(
                                                color: clACACAC,
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                // height: 0.14,
                                                letterSpacing: -0.10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(width: 5,),

                                      ///

                                      // InkWell(onTap: (){
                                      //   ApproveOrRejectAlert(context,item.id);
                                      // },
                                      //   child: Container(height: 25,width: 50,
                                      //   color: item.status=='APPROVED'?Colors.green:Colors.red,),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      Consumer<DonationProvider>(
                          builder: (context,value,child) {
                            print( value.equipmentCount.toString()+'  sfafasfasfasd  '+value.filterSponsersList.length.toString());

                            return
                              value.equipmentCount <= value.filterSponsersList.length &&value.filterSponsersList.length>0?

                              // value.sponsersCount > value.filterSponsersList.length?
                              InkWell(onTap: (){
                                donationProvider.fetchSponsers(false,value.filterSponsersList[value.filterSponsersList.length-1].addedTime);
                              },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 100),
                                    child: Container( height: 35 ,
                                      width:width*.5 ,
                                      decoration:  BoxDecoration(
                                        gradient: const LinearGradient(
                                            begin:
                                            Alignment(-1.00, -0.00),
                                            end: Alignment(1, 0),
                                            colors: [
                                              Color(0xFF3E4FA3),
                                              Color(0xFF253068)
                                            ]
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Center(child:  Text("Load More",style: const TextStyle(fontFamily: "JaldiBold",fontWeight: FontWeight.w400,
                                          fontSize: 14,color: Colors.white),)),
                                    ),
                                  )) : SizedBox();
                          }
                      ),
                      SizedBox(height: 100,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
deleteAlert(context,String id) async {
  DonationProvider donationProvider =
  Provider.of<DonationProvider>(context, listen: false);
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
      final width=MediaQuery.of(context).size.width;
        return AlertDialog(
          // shadowColor: Colors.transparent,
          backgroundColor: myWhite,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          content: Container(
            width:width*.70,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),

              // image: const DecorationImage(
              //   scale: 1.5,
              //   image: AssetImage('assets/logoForAlert.png',), // Replace with your image asset
              //   // fit: BoxFit.fill, // Adjust the background size as needed
              // ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const Text(
                  'Confirm Delete',
                  style: TextStyle(
                    color: myBlack,
                    fontSize: 14,
                    fontFamily: 'JaldiBold',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height:10),

                const Text(
                  'Are you sure want to delete?',
                  style: TextStyle(
                    color: cl5C5C5C,
                    fontSize: 12,
                    fontFamily: 'JaldiBold',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex:1,
                      child: InkWell(
                        onTap:(){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment:Alignment.center,
                          height: 35,
                          decoration: ShapeDecoration(
                            color: myWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(34),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x1C000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color:cl253068,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                        flex:1,
                        child:InkWell(
                          onTap:(){
                            donationProvider.deleteSponser(id);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor:Colors.black,
                                    content: Text("Successfully Deleted")));
                            finish(context);
                          },
                          child: Container(
                            height: 35,
                            alignment:Alignment.center,
                            decoration: ShapeDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(-1.00, -0.00),
                                end: Alignment(1, 0),
                                colors: [cl3E4FA3, cl253068],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(34),
                              ),
                            ),
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                color: myWhite,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
