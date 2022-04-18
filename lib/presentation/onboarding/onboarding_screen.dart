import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'decide_next_screen.dart';
import 'widgets/onboarding_widgets.dart';

/// The onboarding screen widget.
class OnboardingScreen extends StatelessWidget {
  /// The onboarding screen widget.
  OnboardingScreen({Key? key}) : super(key: key) {
    _controller = SwiperController();
    decideNextScreen();
  }

  /// Internal controller for the [Swiper] widget.
  late final SwiperController _controller;

  @override
  Widget build(BuildContext context) {
    return BackgroundDecoration(
      floatingActionButton: NextButton(nextPage: _controller.next),
      child: Swiper(
        controller: _controller,
        itemCount: pages.length,
        itemBuilder: (context, index) => OnboardingPage(index: index),
        loop: false,
        pagination: PaginationDots(),
      ),
    );
  }
}
