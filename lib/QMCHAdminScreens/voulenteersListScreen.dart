import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import 'admin_add_volunteerScreen.dart';

//random items-27,11,2023
//phonenumber,date and time,

class VoulnteersListScreen extends StatelessWidget {
  String adminName, adminID;
  VoulnteersListScreen(
      {Key? key, required this.adminName, required this.adminID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
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
              'Volunteers',
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
            homeProvider.clearVoulenteer();
            callNext(
                AdminAddVolunteerScreen(adminName: adminName, adminID: adminID, editID: '', from: 'addNew'),
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
                  ' Add Volunteer',
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
      // floatingActionButton: InkWell(onTap: (){
      //   homeProvider.clearVoulenteer();
      //   callNext(AdminAddVolunteerScreen(adminName: adminName,adminID: adminID,editID: '',from: 'addNew'), context);
      // },
      //   child: const CircleAvatar(
      //     radius: 30,backgroundColor: Colors.blue,
      //     child: Icon(Icons.add,color: Colors.white,size: 20,),
      //   ),
      // ),
      body: Column(
        children: [
          Consumer<HomeProvider>(builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextFormField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: cl898989,
                      fontFamily: "PoppinsRegular",
                      fontWeight: FontWeight.w100,
                      fontSize: 12,
                    ),
                    onChanged: (value1) {
                      value.searchVolunteersss(value1);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: myWhite,
                      hintText: "Search..",
                      hintStyle: TextStyle(
                        color: cl898989.withOpacity(0.56),
                        fontFamily: "PoppinsRegular",
                        fontWeight: FontWeight.w100,
                        height: 0.090,
                        fontSize: 12,
                      ),
                      suffixIcon: const Icon(
                        Icons.search,
                        color: cl898989,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      constraints:
                          const BoxConstraints(minHeight: 40, maxHeight: 50),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Total Volunteers -',
                          style: TextStyle(
                            color: clC9C9C9,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0.14,
                            letterSpacing: -0.10,
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: myBlack,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0.14,
                            letterSpacing: -0.10,
                          ),
                        ),
                        TextSpan(
                          text: value.filterVoulenteersList.length.toString(),
                          style: TextStyle(
                            color: cl3E4FA3,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0.12,
                            letterSpacing: -0.12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                ],
              ),
            );
          }),
          Flexible(fit: FlexFit.tight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<HomeProvider>(
                    builder: (context,value,child) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.filterVoulenteersList.length,
                          itemBuilder: (context, index) {
                            var item = value.filterVoulenteersList[index];
                            return InkWell(
                              onTap: () {
                                homeProvider.clearVoulenteer();
                                homeProvider.fetchVoulenteerDetails(item.id);
                                callNext(
                                    AdminAddVolunteerScreen(
                                        adminName: adminName,
                                        adminID: adminID,
                                        editID: item.id,
                                        from: 'edit'),
                                    context);
                              },
                              onLongPress: () {
                                print(' INFEVNEV');
                                deleteAlert(context, item.id);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(5),
                                height: 60,
                                decoration: ShapeDecoration(
                                  color: myWhite,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
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
                                      padding: const EdgeInsets.only(left: 10),
                                      height: 44,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const ShapeDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment(1.00, 0.00),
                                          end: Alignment(-1, 0),
                                          colors: [
                                            Color(0xFFCECECE),
                                            Color(0x00CECECE)
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(18))),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            ' ${index + 1} ',
                                            style: const TextStyle(
                                              color: myBlack,
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: -0.12,
                                            ),
                                          ),
                                          item.photo == ''
                                              ? Container(
                                            width: 44,
                                            height: 44,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                                color: Colors.white,

                                                // color: myBlack,
                                                shape:
                                                RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors
                                                          .grey.shade200),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      16),
                                                ),
                                                image:
                                                const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/profile.png'),
                                                  scale: 5,
                                                )),
                                          )
                                              : Container(
                                            width: 44,
                                            height: 44,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                                color: myBlack,
                                                shape:
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      16),
                                                ),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        item.photo),
                                                    fit: BoxFit.cover)),
                                          )
                                        ],
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 10,
                                    ),

                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                fit: FlexFit.tight,
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
                                              const SizedBox(width: 3),
                                              InkWell(
                                                  onTap: () {
                                                    ApproveOrRejectAlert(
                                                        context,
                                                        item.id,
                                                        item.name,
                                                        item.number,
                                                        item.photo,
                                                        adminID,
                                                        adminName);
                                                  },
                                                  child: item.status == 'APPROVED'
                                                      ? Row(
                                                    children: const [
                                                      Text(
                                                        "Approved",
                                                        style: TextStyle(
                                                            color:
                                                            cl0FC200),
                                                      ),
                                                      SizedBox(
                                                        width: 1,
                                                      ),
                                                      Icon(
                                                        Icons.done,
                                                        color: cl0FC200,
                                                        size: 19,
                                                      )
                                                    ],
                                                  )
                                                      : item.status == 'PENDING'
                                                      ? Row(
                                                    children: const [
                                                      Text(
                                                        "Pending",
                                                        style:
                                                        TextStyle(
                                                          color:
                                                          cl0085FF,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 1,
                                                      ),
                                                      Icon(
                                                        Icons.autorenew,
                                                        color: cl0085FF,
                                                        size: 19,
                                                      )
                                                    ],
                                                  )
                                                      : Row(
                                                    children: const [
                                                      Text(
                                                        "Rejected",
                                                        style:
                                                        TextStyle(
                                                          color:
                                                          clFE0000,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 1,
                                                      ),
                                                      Icon(
                                                        Icons.clear,
                                                        color: clFE0000,
                                                        size: 19,
                                                      )
                                                    ],
                                                  ))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                item.number,
                                                style: TextStyle(
                                                  color: clACACAC,
                                                  fontSize: 10,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  // height: 0.14,
                                                  letterSpacing: -0.10,
                                                ),
                                              ),
                                              Text(
                                                item.time,
                                                style: TextStyle(
                                                  color: cl7E7E7E,
                                                  fontSize: 8,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                  letterSpacing: -0.08,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 5,
                                    ),

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
                            );
                          });
                    }
                  ),
                  Consumer<HomeProvider>(builder: (context, value, child) {
                    print(value.volunteerCount.toString()+'  '+value.filterVoulenteersList.length.toString()+' USCNUSCNS U');
                    return value.volunteerCount <= value.filterVoulenteersList.length &&
                        value.filterVoulenteersList.length > 0
                        ? InkWell(
                      onTap: () {
                        homeProvider.fetchVoulenteers(
                            false,
                            value
                                .filterVoulenteersList[
                            value.filterVoulenteersList.length -
                                1]
                                .addedTime);
                      },
                      child: Container(
                        height: 35,
                        width: width * .5,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment(-1.00, -0.00),
                              end: Alignment(1, 0),
                              colors: [
                                Color(0xFF3E4FA3),
                                Color(0xFF253068)
                              ]),
                          borderRadius: BorderRadius.circular(15),
                        ),
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
                  SizedBox(height: 100,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

deleteAlert(context, String id) async {
  HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        final width = MediaQuery.of(context).size.width;
        return AlertDialog(
          // shadowColor: Colors.transparent,
          backgroundColor: myWhite,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          content: Container(
            width: width * .70,
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
                const SizedBox(height: 10),
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
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
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
                              color: cl253068,
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
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            homeProvider.deleteVoulenteer(id);
                            // finish(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.black,
                                    content: Text("Successfully Deleted")));
                            finish(context);
                          },
                          child: Container(
                            height: 35,
                            alignment: Alignment.center,
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
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

ApproveOrRejectAlert(context, String id, String name, String number,
    String image, String adminId, String adminName) async {
  HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        final width = MediaQuery.of(context).size.width;
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          content: Container(
            width: width * .80,
            height: 350,
            decoration: BoxDecoration(
              color: myWhite,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 110,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 15, 30, 0),
                            height: 80,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(26),
                                  topLeft: Radius.circular(26),
                                ),
                                image: DecorationImage(
                                  image: AssetImage("assets/VolunRA.png"),
                                  fit: BoxFit.cover,
                                )),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      finish(context);
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: myWhite,
                                      size: 20,
                                    ),
                                  ),
                                  const Text(
                                    'Profile',
                                    style: TextStyle(
                                      color: myWhite,
                                      fontSize: 12,
                                      fontFamily: 'PoppinsRegular',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox()
                                ]),
                          ),
                          Container(
                            height: 30,
                          ),
                        ],
                      ),
                      image.isEmpty
                          ? Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(

                          radius: 29,
                          backgroundColor: Colors.grey.shade200,
                          child: CircleAvatar(
                            radius: 27,
                            backgroundColor: Colors.white,
                            child: Image.asset('assets/profile.png', scale: 5),
                          ),
                        ),
                      )
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: myWhite,
                                child: CircleAvatar(
                                  radius: 27,
                                  backgroundColor: c_Grey,
                                  backgroundImage: NetworkImage(image),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Flexible(
                            fit: FlexFit.tight,
                            child: Container(
                              // color: Colors.red,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name*',
                                    style: TextStyle(
                                      color: myBlack.withOpacity(0.3),
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.10,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    name,
                                    style: TextStyle(
                                      color: myBlack,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      // height: 0.11,
                                      letterSpacing: 0.12,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            homeProvider.clearVoulenteer();
                            homeProvider.fetchVoulenteerDetails(id);
                            callNext(
                                AdminAddVolunteerScreen(
                                    adminName: adminName,
                                    adminID: adminId,
                                    editID: id,
                                    from: 'edit'),
                                context);
                          },
                          child: CircleAvatar(
                            backgroundColor: myBlack.withOpacity(0.07),
                            radius: 20,
                            child: const Icon(
                              Icons.edit_outlined,
                              color: myBlack,
                            ),
                          ),
                        )
                      ]),

                      const SizedBox(
                        height: 10,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mobile Number*',
                            style: TextStyle(
                              color: myBlack.withOpacity(0.3),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.10,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            number,
                            style: TextStyle(
                              color: myBlack,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              // height: 0.11,
                              letterSpacing: 0.12,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 40,
                      ),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       'Address*',
                      //       style: TextStyle(
                      //         color: myBlack.withOpacity(0.3),
                      //         fontSize: 10,
                      //         fontFamily: 'Poppins',
                      //         fontWeight: FontWeight.w400,
                      //         letterSpacing: 0.10,
                      //       ),
                      //     ),
                      //
                      //     const SizedBox(height: 5),
                      //
                      //     const Text(
                      //       'Chengayi (H) Chennai, THIRUVOTRIYUR, 676519',
                      //       style: TextStyle(
                      //         color: myBlack,
                      //         fontSize: 12,
                      //         fontFamily: 'Poppins',
                      //         fontWeight: FontWeight.w500,
                      //         // height: 0.11,
                      //         letterSpacing: 0.12,
                      //       ),
                      //     ),
                      //
                      //   ],
                      // ),

                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 39,
                            width: 120,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(Colors
                                        .transparent), // Remove overlay color
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.blue.withOpacity(
                                            0.5)), // Set shadow color
                                    // Define the shadow properties
                                    elevation: MaterialStateProperty.all(5), //
                                    textStyle: MaterialStateProperty.all(
                                        const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900)),
                                    backgroundColor:
                                        MaterialStateProperty.all(clC90000),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18)))),
                                onPressed: () {
                                  homeProvider.adminRejectVoulenteer(id);
                                  finish(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Reject',
                                      style: TextStyle(
                                        color: myWhite,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.clear,
                                      color: myWhite,
                                      size: 20,
                                    )
                                  ],
                                )),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            height: 39,
                            width: 120,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(Colors
                                        .transparent), // Remove overlay color
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.blue.withOpacity(
                                            0.5)), // Set shadow color
                                    // Define the shadow properties
                                    elevation: MaterialStateProperty.all(5), //
                                    textStyle: MaterialStateProperty.all(
                                        const TextStyle(
                                            color: myBlack,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900)),
                                    backgroundColor:
                                        MaterialStateProperty.all(cl0FC200),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18)))),
                                onPressed: () {
                                  homeProvider.adminApproveVoulenteer(id);
                                  finish(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Approve',
                                      style: TextStyle(
                                        color: myWhite,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.done,
                                      color: myWhite,
                                      size: 20,
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
