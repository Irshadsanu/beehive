import 'package:beehive/providers/web_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/my_colors.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myLightOrangeNewUI,
      body: Center(
        child: InkWell(
          onTap: (){
            WebProvider webProvider = Provider.of<WebProvider>(context, listen: false);
            // webProvider.loopTotalWard();
            // webProvider.loopTotalWardAndUpdateTarget();
            // webProvider.loopWardTargetZero();
            // webProvider.loopTotalAssembly();

            // webProvider.loopTotalPanchyath();
            // webProvider.loopWardNonExist();
            // webProvider.loopPanchayathNonExist();
            // webProvider.loopChangeDistrictName();
            // webProvider.loopWardKasargod();
            webProvider.loopPaymentsToWardtotal();
            // webProvider.districtTotal();
          },
          child: Container(
            height: 100,
            width: 150,
            color: Colors.pink,
            child: const Center(child: Text("Click here to loop",style: TextStyle(color: Colors.white,fontSize: 15),)),
          ),
        ),
      ),
    );
  }
}
