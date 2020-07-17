import 'package:flutter/material.dart';

class OnBoardingPageModel {
  Widget widgetToDisplay;
  String heading;
  String description;
  OnBoardingPageModel(this.widgetToDisplay, this.heading, this.description);
}

int noOfScreens = 3;
var pageList = [
  OnBoardingPageModel(
      Image.asset(
        "assets/onBoardingShapesAndIcons/FeedCard.png",
      ),
      "Get updates on your Feed",
      "Follow people to get updates when they solve a problem"),
  OnBoardingPageModel(
      Image.asset("assets/onBoardingShapesAndIcons/ContestCard.png"),
      "Get updates about Contests",
      "Get updates about contests from various coding platforms"),
  OnBoardingPageModel(
      Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Image.asset("assets/onBoardingShapesAndIcons/ProfilePage.png"),
      ),
      "Check and compare progress",
      "You can check and compare people's progress by visiting their profile"),
];

