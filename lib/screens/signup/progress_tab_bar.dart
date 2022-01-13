import 'package:codephile/resources/colors.dart';
import 'package:flutter/material.dart';

class ProgressTabBar extends StatelessWidget {
  final int pageNo;
  const ProgressTabBar(this.pageNo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ProgressTab(1 <= pageNo),
        ProgressTab(2 <= pageNo),
        ProgressTab(3 <= pageNo),
        ProgressTab(4 <= pageNo),
      ],
    );
  }
}

class ProgressTab extends StatelessWidget {
  final bool shade;
  const ProgressTab(this.shade, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.only(top: 45),
        height: 10.0,
        width: width / 4.5,
        child: Material(
          borderRadius: BorderRadius.circular(2.0),
          color: shade ? codephileMain : codephileMainShade,
          elevation: 0.0,
        ));
  }
}
