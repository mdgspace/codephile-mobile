import 'package:flutter/material.dart';

class RecentlySolvedBookmarkIcon extends StatelessWidget {
  const RecentlySolvedBookmarkIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Icon(
            Icons.bookmark,
            size: MediaQuery.of(context).size.width / 13,
            color: const Color.fromRGBO(51, 102, 255, 1),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / (13 * 4),
          top: MediaQuery.of(context).size.width / (13 * 4),
          child: const Icon(
            Icons.check,
            size: 15.0,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
