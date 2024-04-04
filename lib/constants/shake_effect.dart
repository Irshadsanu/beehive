import 'package:flutter/material.dart';
class ShakeX extends StatefulWidget {
  final Widget child;
  final double horizontalPadding;
  final double animationRange;
  final ShakeXController controller;
  final Duration animationDuration;
  String text;
  TextStyle style;

   ShakeX(
      {Key? key,
        required this.child,
        this.horizontalPadding = 3,
        this.animationRange = 10,
        required this.controller,
        this.animationDuration = const Duration(milliseconds: 500),required this.text,required this.style})
      : super(key: key);

  @override
  _ShakeXState createState() => _ShakeXState();
}

class _ShakeXState extends State<ShakeX> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool valid=true;

  @override
  void initState() {
    try {
      animationController =
          AnimationController(duration: widget.animationDuration, vsync: this);
    }catch(e){

    }

    widget.controller.setState(this);

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation =
    Tween(begin: 0.0, end: widget.animationRange)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
      });

    return AnimatedBuilder(
      animation: offsetAnimation,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: offsetAnimation.value + widget.horizontalPadding+5,
                  right: 40 - offsetAnimation.value),
              child: Text(widget.text,style:widget.style)),
            Container(
              padding: EdgeInsets.only(
                  left: offsetAnimation.value + widget.horizontalPadding,
                  right: 40 - offsetAnimation.value),
              child: widget.child,
            ),
          ],
        );
      },
    );
  }
}

class ShakeXController {
  late _ShakeXState _state;
  void setState(_ShakeXState state) {
    _state = state;
  }

  Future<void> shake() {
    try {
      _state.valid = false;
    }catch(e){
     print(e.toString());

     return Future(() => null);


    }
    return _state.animationController.forward(from: 0.0);
  }
}