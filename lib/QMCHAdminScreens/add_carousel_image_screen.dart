import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';

class AddCarouselImagesScreen extends StatelessWidget {
  String adminName,adminID;
   AddCarouselImagesScreen({Key? key,required this.adminName,required this.adminID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(height: 200,width: width,
          color: Colors.yellowAccent,
          child: Consumer<DonationProvider>(
            builder: (context,value,child) {
              return SizedBox(height: 200,width: width,
                child: Row(
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: value.carouselfileList.length,
                    itemBuilder: (context, index) {
                      var item = value.carouselfileList[index];
                      return Stack(
                        children: [
                          Container(height: 100,width: 100,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              image: DecorationImage(
                              image: FileImage(item)
                            )
                          ),
                          ),
                          InkWell(onTap:(){
                            donationProvider.deleteImage(index,'fileImage');
                          },
                              child: Icon(Icons.delete,color: Colors.blue,))
                        ],
                      );
                    }),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: value.carouselModelList.length,
                    itemBuilder: (context, index) {
                      var item = value.carouselModelList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Stack(
                          children: [
                            Container(height: 100,width: 100,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                image: DecorationImage(
                                image: NetworkImage(item.toString())
                              )
                            ),
                            ),
                            InkWell(onTap: (){
                              donationProvider.deleteImage(index,'FetchImage');
                            },
                                child: Icon(Icons.delete,color: Colors.blue,))
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            }
          ),
        ),
          SizedBox(height: 50,),
          InkWell(onTap: (){
            donationProvider.fileImage=null;
            donationProvider.showBottomSheet(context);
          },
            child: Container(height: 50,width: 100,color: Colors.tealAccent,
            child: Text('Add Images'),),
          ),
          SizedBox(height: 50,),

          InkWell(onTap: (){
            donationProvider.addCarouselImages(adminName,adminID);
            finish(context);
          },
            child: Container(height: 50,
              width: 100,
              color: Colors.green,
              child: Text('SAVE'),),
          ),

        ],
      ),
    );
  }
}
