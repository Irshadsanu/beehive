import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'home_screen.dart';
class NoPaymentGateway extends StatefulWidget {
  String loginUsername,loginUserID,subScriberType,loginUserPhone;
  String zakathAmount,deseaseName,sponsorCategory,sponsorCount,sponsorItemOnePrice,foodkitPrice,footkitCount;
  String equipmentAmount,sponsorPatientAmonut,foodkitAmount;
   NoPaymentGateway({Key? key,required this.loginUsername,required this.loginUserPhone
     ,required this.loginUserID,required this.subScriberType,
     required this.zakathAmount,required this.deseaseName,required this.foodkitAmount,required this.sponsorCategory,
     required this.sponsorPatientAmonut,required this.equipmentAmount,required this.footkitCount
     ,required this.sponsorItemOnePrice,required this.foodkitPrice,required this.sponsorCount,}) : super(key: key);

  @override
  State<NoPaymentGateway> createState() => _NoPaymentGatewayState();
}

class _NoPaymentGatewayState extends State<NoPaymentGateway> {
  ConfettiController controllerCenter=ConfettiController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   controllerCenter = ConfettiController(duration: const Duration(seconds: 10));
  //   controllerCenter.play();
  //
  //   setState(() {
  //
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: cl2C4680,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: controllerCenter,
                  blastDirectionality: BlastDirectionality.explosive, // don't specify a direction, blast randomly
                  shouldLoop:
                  true, // start again as soon as the animation is finished
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ], // manually specify the colors to be used
                  createParticlePath: drawStar, // define a custom shape/path.
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset("assets/tick.png",scale: 3.5,),
                  ),

                  Consumer<HomeProvider>(
                    builder: (context,value,child) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(value.noPaymentText,style: rupeeBigWhite,textAlign: TextAlign.center,),
                      );
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15 ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: myWhite,
                        minimumSize: const Size.fromHeight(40),
                        // fromHeight use double.infinity as width and 40 is the height
                      ),
                      onPressed: () {

                        callNextReplacement(HomeScreenNew(subScriberType: widget.subScriberType,
                            loginUserID: widget.loginUserID,
                            loginUsername: widget.loginUsername,loginUserPhone: widget.loginUserPhone,
                          zakathAmount: widget.zakathAmount,sponsorPatientAmonut: widget.sponsorPatientAmonut,
                          sponsorItemOnePrice: widget.sponsorItemOnePrice,
                          sponsorCount: widget.sponsorCount,sponsorCategory: widget.sponsorCategory,footkitCount:widget.footkitCount,deseaseName: widget.deseaseName,
                          foodkitPrice:widget.foodkitPrice ,equipmentAmount:widget.equipmentAmount ,foodkitAmount:widget. foodkitAmount,), context);
                        // finish(context);
                        // finish(context);

                      },
                      child: Text('Ok',style: green18,),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Path drawStar(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}

