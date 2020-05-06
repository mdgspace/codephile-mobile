import 'package:codephile/screens/on_boarding/data.dart';
import 'package:codephile/screens/on_boarding/on_boarding_template.dart';
import 'package:flutter/material.dart';


class OnBoardingScreen3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return OnBoardingTemplate(
        2,
        noOfScreens,
        pageList[2].widgetToDisplay,
        pageList[2].heading,
        pageList[2].description
    );
  }
}

