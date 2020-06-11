import 'package:codephile/screens/on_boarding/bottom_info_display.dart';
import 'package:codephile/screens/on_boarding/data.dart';
import 'package:codephile/screens/on_boarding/on_boarding_background.dart';
import 'package:codephile/screens/on_boarding/page_indicator.dart';
import 'package:flutter/material.dart';

class OnBoardingTemplate extends StatelessWidget {
  final int pageNo;
  final int noOfPages;
  final Widget widgetToDisplay;
  final String heading;
  final String description;

  const OnBoardingTemplate(this.pageNo, this.noOfPages, this.widgetToDisplay,
      this.heading, this.description,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        OnBoardingBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
                child: Center(
                  child: widgetToDisplay,
                ),
              )),
              BottomInfoDisplay(heading, description),
            ],
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 25,
          bottom: MediaQuery.of(context).size.height / 15,
          child: PageIndicator(pageNo, noOfPages),
        ),
        Positioned(
            right: MediaQuery.of(context).size.width / 25,
            bottom: MediaQuery.of(context).size.height / 20,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_forward,
                color: Color.fromRGBO(35, 31, 32, 1),
              ),
              onPressed: () => handleNextPress(pageNo, context),
            ))
      ],
    );
  }
}
