import 'package:flutter/material.dart';

class RecentlySolvedBookmarkIcon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Icon(
              Icons.bookmark,
              size: 30.0,
              color: const Color.fromRGBO(51, 102, 255, 1),
            ),
          ),
          Positioned(
            left: 7.5,
            top: 7.5,
            child: Icon(
              Icons.check,
              size: 15.0,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

}
