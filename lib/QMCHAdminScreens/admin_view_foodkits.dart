import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';
import 'add_food_kit.dart';


class AdminViewFoodKit extends StatelessWidget {
  String adminName,adminID;

  AdminViewFoodKit({Key? key,required this.adminName,required this.adminID});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
         
          callNext(AdminAddFoodKitScreen(adminName: adminName, adminID: adminID, from: 'new',editID: ''), context);
        },
      ),
      appBar: AppBar(
        
        title: Text("title"),
      ),
      body:                             Consumer<DonationProvider>(
          builder: (context, value1, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
              ListView.builder(
                shrinkWrap: true,
              itemCount: value1.fetchFoodKitList.length,
                itemBuilder: (context, index) {
                  var item = value1.fetchFoodKitList[index];
                  return InkWell(
                    onLongPress: () {

                      editDelete(context,adminName,adminID,item.id);

                      // value1.distributorDelete(value1.results[index].id);
                    },
                    onTap: () {

                    },
                    child: Container(
                      height: 120,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red,// Set your desired background color here
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            item.foodName,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ), Text(
                            item.foodPrice,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ), Text(
                            item.foodDescription,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ), Text(
                            item.foodName,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
                  Consumer<DonationProvider>(
                      builder: (context, value, child) {
                        return value.totalFoodListedCount >
                            value.fetchFoodKitList.length &&
                            value.fetchFoodKitList.length != 0
                            ? InkWell(
                          onTap: () {

                            value1.fetchFoodKit(false, value.fetchFoodKitList[value.fetchFoodKitList.length - 1].addedTime);
                          },
                          child: Container(
                            height: 50,
                            width: width * 0.8,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25)),
                                color: Colors.blue),
                            child: const Center(
                              child: Text(
                                'Load More',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                            : const SizedBox();
                      }),

                ],
              ),
            );
          }),

    );
  }
}
Future editDelete(context,String adminName,String adminID,String id) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          content: Container(
            width: 401,
            height: 213,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),



            ),
            child: Consumer<DonationProvider>(
              builder: (context,value11,child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 20,),

                    Divider(
                      height: 20, // Adjust the height of the divider
                      color: Colors.grey, // Set the color of the divider
                      thickness: 2, // Set the thickness of the divider
                      indent: .1, // Set the left indent of the divider
                      endIndent: .1, // Set the right indent of the divider
                    ),

                    const SizedBox(height: 35),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 39,
                          width: 110,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(Colors.transparent), // Remove overlay color
                                  shadowColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.5)), // Set shadow color
                                  // Define the shadow properties
                                  elevation: MaterialStateProperty.all(5), //
                                  textStyle: MaterialStateProperty.all(
                                      const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xff1746A2)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(60)))),
                              onPressed: () {
                                finish(context);

                                value11.setToController(id);
                                callNext(AdminAddFoodKitScreen(adminName: adminName, adminID: adminID,from: 'edit',editID:id ), context);
                                // FirebaseAuth auth = FirebaseAuth.instance;
                                // auth.signOut();
                                // callNextReplacement(const LoginScreen(), context);
                              },
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 39,
                          width: 110,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(Colors.transparent), // Remove overlay color
                                  shadowColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.5)), // Set shadow color
                                  // Define the shadow properties
                                  elevation: MaterialStateProperty.all(5), //
                                  textStyle: MaterialStateProperty.all(
                                      const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xffFFFCF4)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(60)))),
                              onPressed: () {
                                value11.deleteFood(id);
                                Navigator.of(context).pop();

                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  color:Color(0xff1746A2),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                );
              }
            ),
          ),
        );
      });
}
