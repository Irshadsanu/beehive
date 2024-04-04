import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import 'add_equipments_screen.dart';

class AdminViewEquipmentList extends StatelessWidget {
  String adminName, adminID;

  AdminViewEquipmentList(
      {Key? key, required this.adminName, required this.adminID});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                onTap: () {
                  finish(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                  size: 18,
                )),
          ),
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: width * .1),
            child: Text(
              "Equipment's",
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
      floatingActionButton:
          Consumer<DonationProvider>(builder: (context, value, child) {
        return InkWell(
          onTap: () {
            // donationProvider.clearSubcriptionScreen();
            // callNext(AddSubscribersScreen(adminID: adminID,adminName: adminName,from: "Add Subscriber",id: ""), context);
            donationProvider.clearEquipmentScreen();

            callNext(
                AdminAddEqupmentsScreen(
                    adminName: adminName,
                    adminID: adminID,
                    editID: '',
                    from: ''),
                context);
          },
          child: Container(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 15,
                ),
                Text(
                  ' Add Equipment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        );
      }),
      body: Consumer<DonationProvider>(builder: (context, value1, child) {
        return SingleChildScrollView(
          child: Column(
            children: [

              Text(
                'Patient Supporting Equipment',
                style: TextStyle(
                  color: Color(0xFF253068),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: cl898989,
                    fontFamily: "PoppinsRegular",
                    fontWeight: FontWeight.w100,
                    fontSize: 12,
                  ),
                  onChanged: (value2) {
                    value1.searchEquipments(value2);
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


              Consumer<DonationProvider>(builder: (context, value, child) {
                return SizedBox(
                  width: width / 0.8,
                  // height: height * 0.8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 8.0,
                                  mainAxisExtent: 240,
                              ),
                          itemCount: value.filterEquipmentsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = value.filterEquipmentsList[index];
                            print(item.collectedCount);
                            return InkWell(
                              onLongPress: () {
                                deleteAlert(context, item.id);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(

                                  decoration: BoxDecoration(
                                      color: cl_F5F5F5,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: item.selectedBool
                                              ? myGreen
                                              : Colors.white)),
                                  // width: width / 4,
                                  // height: height/3,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                        child: Column(
                                          children: [
                                            Image.network(
                                              item.photo,
                                              width: 150,
                                              height: 130,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              item.equipmentName,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Lato',
                                                  color: cl_253068),
                                            ),
                                            SizedBox(height: 8),
                                            Text(item.collectedCount
                                                    .toString() +
                                                '/' +
                                                item.requeredCount.toString()),
                                            SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          child: PercentageIndicator(
                                              percentage: (item.collectedCount/item.requeredCount)*100)),
                                      Positioned(
                                        top: 10,
                                        right: 18,
                                        child: Container(
                                          width: width / 7,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: cl_2D8E00, // Change color as needed
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                            child: Text(
                                              "₹" + item.equipmentPrice,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'JaldiBold'),
                                            ), // Change the icon as needed
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        left: 18,
                                        child: InkWell(
                                          onTap: () {
                                            // callNext(AdminAddVolunteerScreen(adminName: adminName,adminID: adminID,editID: item.id,from: 'edit'), context);
                                            value1.setToControllerEquipment(
                                                item.id);
                                            callNext(
                                                AdminAddEqupmentsScreen(
                                                    adminName: adminName,
                                                    adminID: adminID,
                                                    editID: item.id,
                                                    from: 'edit'),
                                                context);
                                          },
                                          child: Container(
                                            width: width / 10,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                color:
                                                    cl_2D8E00, // Change color as needed
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Center(
                                                child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 18,
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Consumer<DonationProvider>(
                            builder: (context, value, child) {
                              print( value.equipmentCount.toString()+'  sfafasfasfasd  '+value.filterEquipmentsList.length.toString());

                          return
                            // value.equipmentCount <= value.filterEquipmentsList.length &&value.filterSponsersList.length>0?

                            value.equipmentCount <=  value.filterEquipmentsList.length && value.filterEquipmentsList.length > 0
                              ? InkWell(
                                  onTap: () {
                                    donationProvider.fetchEquipment(false, value.filterEquipmentsList[value.filterEquipmentsList.length - 1].addedTime);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 100),
                                    child: Container(
                                      height: 35,
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
                                      child: Center(
                                          child: Text("Load More",style: const TextStyle(fontFamily: "JaldiBold",fontWeight: FontWeight.w400,
                                              fontSize: 14,color: Colors.white),),
                                    ),),
                                  )
                                )
                              : SizedBox();
                        })
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}

deleteAlert(context,String id) async {
  HomeProvider homeProvider =
  Provider.of<HomeProvider>(context, listen: false);
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
                            donationProvider.deleteEquipment(id);
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

class PercentageIndicator extends StatelessWidget {
  final double percentage;

  PercentageIndicator({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: 150,
        height: 10,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            if (percentage < 100)
              FractionallySizedBox(
                widthFactor: percentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF74799d),
                        Color(0xFF74799d),
                        Colors.white,
// Add your third color here

                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            if (percentage == 100)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: cl_253068, // Progressed color (red)
                ),
              ),
          ],
        ),
      ),
    );
  }
}
