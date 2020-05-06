import 'package:codephile/screens/on_boarding/data.dart';
import 'package:codephile/screens/on_boarding/on_boarding_template.dart';
import 'package:flutter/material.dart';


class OnBoardingScreen2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return OnBoardingTemplate(
        1,
        noOfScreens,
        pageList[1].widgetToDisplay,
        pageList[1].heading,
        pageList[1].description
    );
  }
}

