import 'package:codephile/screens/on_boarding/data.dart';
import 'package:codephile/screens/on_boarding/on_boarding_background.dart';
import 'package:codephile/screens/on_boarding/on_boarding_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:card_swiper/card_swiper.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Stack(
      children: <Widget>[
        OnBoardingBackground(),
        Swiper(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return OnBoardingTemplate(
                index,
                noOfScreens,
                pageList[index].widgetToDisplay,
                pageList[index].heading,
                pageList[index].description);
          },
          pagination: SwiperPagination(
            alignment: Alignment(-47.5 / 50, 45 / 50),
            builder: DotSwiperPaginationBuilder(
              color: const Color.fromRGBO(0, 0, 0, 0.24),
              activeColor: Colors.white,
              size: 10.0,
              activeSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}
