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
              size: MediaQuery.of(context).size.width/13,
              color: const Color.fromRGBO(51, 102, 255, 1),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width/(13*4),
            top: MediaQuery.of(context).size.width/(13*4),
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
