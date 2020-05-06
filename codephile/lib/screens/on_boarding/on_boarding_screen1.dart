import 'package:codephile/screens/on_boarding/data.dart';
import 'package:codephile/screens/on_boarding/on_boarding_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class OnBoardingScreen1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return OnBoardingTemplate(
      0,
      noOfScreens,
      pageList[0].widgetToDisplay,
      pageList[0].heading,
      pageList[0].description
    );
  }
}

