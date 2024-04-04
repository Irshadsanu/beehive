import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../QmchScreens/userActivityDetailsScreen.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';
import 'adminAddNews.dart';


class AdminViewAllNews extends StatelessWidget {
  String adminName,adminID;

  AdminViewAllNews({Key? key,required this.adminName,required this.adminID});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    return  Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
      Consumer<DonationProvider>(builder: (context, value, child) {
        return InkWell(
          onTap: () {
            // donationProvider.clearSubcriptionScreen();
            // callNext(AddSubscribersScreen(adminID: adminID,adminName: adminName,from: "Add Subscriber",id: ""), context);
            donationProvider.clearNews();
            callNext(AdminAddNewsScreen(adminName: adminName, adminID: adminID, from: 'new',editID: ''), context);
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
                  ' Add Feed',
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
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: myWhite,
        leading: InkWell(
          onTap: (){
            finish(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.only(right: 5),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.05000000074505806),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(37.40),
                ),
              ),
              child: const Icon(Icons.arrow_back_ios_new_outlined,color: myBlack, size: 18,),),
          ),
        ),
        title: const Text(
          'Activities',
          style: TextStyle(
            color: myBlack,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            // height: 0.08,
          ),
        ),
      ),

      body:                             Consumer<DonationProvider>(
          builder: (context, value1, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: value1.filterNewsList.length,
                  //   itemBuilder: (context, index) {
                  //     var item = value1.filterNewsList[index];
                  //     return InkWell(
                  //       onLongPress: () {
                  //         deleteAlert(context,item.id);
                  //       },
                  //       onTap: () {
                  //         donationProvider.clearNews();
                  //         donationProvider.fetchNewsFeedDetails(item.id);
                  //         callNext(AdminAddNewsScreen(adminName: adminName, adminID: adminID, from: 'edit',editID: item.id), context);
                  //
                  //       },
                  //       child: Container(
                  //         height: 120,
                  //         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  //         padding: const EdgeInsets.all(12),
                  //         decoration: BoxDecoration(
                  //           color: Colors.red,// Set your desired background color here
                  //           borderRadius: BorderRadius.circular(8),
                  //         ),
                  //         child: Column(
                  //           children: [
                  //             Text(
                  //               item.title,
                  //               style: TextStyle(fontSize: 18, color: Colors.black),
                  //             ), Text(
                  //               item.description,
                  //               style: TextStyle(fontSize: 18, color: Colors.black),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  Consumer<DonationProvider>(
                      builder: (context,value,child) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
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
                                  onChanged: (value1) {
                                    value.searchActivities(value1);
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

                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: value.filterNewsList.length,
                                itemBuilder: (BuildContext context, int index) {

                                  var item =value.filterNewsList[index];
                                  print("sgugibujs"+item.image.toString());
                                  return Padding(
                                    padding:  const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onLongPress: () {
                                        DeleteAlert(context, item.id);

                                      },
                                      onTap: (){
                                      callNext(UserActivityDetailsScreen(newsFeedModel: item,), context);
                                    },
                                      child: Container(
                                        width: double.infinity,
                                        child: ListTile(
                                          leading: Container(width: width/6,height: height/5,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),
                                              image:item.image!=''? DecorationImage(
                                                image: NetworkImage(item.image),
                                                fit: BoxFit.fill,
                                              ) : const DecorationImage(
                                                image: AssetImage("assets/noImage.png"),
                                                fit: BoxFit.fill,
                                              ),
                                            ),),
                                          title: Text(item.title,style: const TextStyle(fontFamily: "JaldiBold",fontWeight: FontWeight.w400,
                                              fontSize: 14,color: cl_3F50A4),),
                                          subtitle: Text(item.description,
                                            maxLines: 2
                                            ,style: const TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w400,
                                              fontSize: 10,color: myBlack),),

                                          trailing:InkWell(
                                            onTap: () {
                                              value1.setToControllerActivities(item.id);
                                              callNext(AdminAddNewsScreen(adminName: adminName, adminID: adminID, from: 'edit',editID:item.id ), context);
                                            },
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: Colors.grey.shade200,
                                                    child: Icon(Icons.edit,size:18,color: Colors.black,)),
                                                Text(item.nowDifferece,style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500,
                                                    fontSize: 8,color: myBlack.withOpacity(0.5)),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Consumer<DonationProvider>(
                                  builder: (context,value,child) {
                                    return value.newsFeedCount <= value.newsList.length && value.newsList.length>0? Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: InkWell(
                                        onTap: (){
                                          value.fetchAllNews(false,value.filterNewsList[value.filterNewsList.length-1].addedTime);
                                        },
                                        child: Container(
                                          height: 35 ,
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
                                          child:const Center(child:  Text("Load More",style: const TextStyle(fontFamily: "JaldiBold",fontWeight: FontWeight.w400,
                                              fontSize: 14,color: Colors.white),)),
                                        ),
                                      ),
                                    ): const SizedBox();
                                  }
                              )
                            ],
                          ),
                        );
                      }
                  ),

                  // Consumer<DonationProvider>(
                  //     builder: (context, value, child) {
                  //       return value.newsFeedCount >  value.filterNewsList.length ? InkWell(
                  //         onTap: () {
                  //
                  //           value1.fetchAllNews(false, value.filterNewsList[value.filterNewsList.length - 1].addedTime);
                  //         },
                  //         child: Container(
                  //           height: 50,
                  //           width: width * 0.8,
                  //           decoration: const BoxDecoration(
                  //               borderRadius: BorderRadius.all(
                  //                   Radius.circular(25)),
                  //               color: Colors.blue),
                  //           child: const Center(
                  //             child: Text(
                  //               'Load More',
                  //               style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.bold),
                  //             ),
                  //           ),
                  //         ),
                  //       ) : SizedBox();
                  //     }),

                ],
              ),
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
            child: Column(
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
                const Text(
                  "Do you want to Delete?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 1.56,
                  ),
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
                            donationProvider.deleteNewsFeed(id);
                            finish(context);
                          },
                          child: const Text(
                            'Delete',
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
                            Navigator.of(context).pop();

                          },
                          child: const Text(
                            'Cancel',
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
            ),
          ),
        );
      });
}
DeleteAlert(context,String id) async {
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
                            donationProvider.deleteactivity(id);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor:Colors.black,
                                    content: Text("Successfully Deleted ")));
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
