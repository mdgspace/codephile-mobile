import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingBackground extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height*0.2,
          child: SvgPicture.asset(
            'assets/onBoardingShapesAndIcons/circle.svg',
            height: MediaQuery.of(context).size.height*0.45,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height*0.04,
          right: 0,
          child: SvgPicture.asset(
              'assets/onBoardingShapesAndIcons/triangle.svg',
            height: MediaQuery.of(context).size.height*0.4,
          ),
        )
      ],
    );
  }

}
