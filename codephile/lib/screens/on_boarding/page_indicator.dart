import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;
  PageIndicator(this.currentIndex, this.pageCount);

  _indicator(bool isActive) {
    return Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            height: isActive ? 14.0 : 10.0,
            width: isActive ? 14.0 : 10.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ?
                  Colors.white
                  : Color.fromRGBO(0, 0, 0, 0.24),
            ),
          ),
        ),
    );
  }

  _buildPageIndicators() {
    List<Widget> indicatorList = [];
    for (int i = 0; i < pageCount; i++) {
      indicatorList
          .add(i == currentIndex ? _indicator(true) : _indicator(false));
    }
    return indicatorList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildPageIndicators(),
    );
  }
}