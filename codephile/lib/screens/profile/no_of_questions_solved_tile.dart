import 'package:codephile/resources/colors.dart';
import 'package:flutter/material.dart';

class QuestionsSolvedTile extends StatelessWidget {
  final String _platform;
  final int _noOfQuestionsSolved;
  final bool isFirst;
  final bool isLast;

  const QuestionsSolvedTile(this._platform, this._noOfQuestionsSolved,
      {Key key, this.isFirst, this.isLast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          width: 1,
          color: userIconBorderGrey,
        ),
        left: BorderSide(
          width: (isFirst == true) ? 1 : 0,
          color: (isFirst == true) ? userIconBorderGrey : Colors.white,
        ),
        right: BorderSide(
          width: (isFirst == true) ? 1 : 0,
          color: (isFirst == true) ? userIconBorderGrey : Colors.white,
        ),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: questionsSolvedBackground,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _platform,
                style: TextStyle(
                  fontSize: 18.0,
                  color: primaryBlackText,
                ),
              ),
            ),
          ),
          Container(
//            decoration: BoxDecoration(
//              border: Border(
//                bottom: BorderSide(
//                  width: 1,
//                  color: userIconBorderGrey,
//                ),
//                left: BorderSide(
//                  width: 1,
//                  color: (isFirst == true)? userIconBorderGrey : Colors.white,
//                ),
//                right: BorderSide(
//                  width: 1,
//                  color: (isFirst == true)? userIconBorderGrey : Colors.white,
//                ),
//              )
//            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "$_noOfQuestionsSolved",
                style: TextStyle(
                  fontSize: 18.0,
                  color: primaryBlackText,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
