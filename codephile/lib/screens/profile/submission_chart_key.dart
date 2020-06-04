import 'package:codephile/resources/colors.dart';
import 'package:flutter/material.dart';

class SubmissionChartKey extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: MediaQuery.of(context).size.width/25,
                  width: MediaQuery.of(context).size.width/25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: subAccepted
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Accepted",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: primaryBlackText
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: MediaQuery.of(context).size.width/25,
                  width: MediaQuery.of(context).size.width/25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: subPartiallySolved
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Prtially Solved",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: primaryBlackText
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: MediaQuery.of(context).size.width/25,
                  width: MediaQuery.of(context).size.width/25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: subWrongAnswer
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Wrong Answer",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: primaryBlackText
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: MediaQuery.of(context).size.width/25,
                  width: MediaQuery.of(context).size.width/25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: subTimeLimitExceeded
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "TLE",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: primaryBlackText
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: MediaQuery.of(context).size.width/25,
                  width: MediaQuery.of(context).size.width/25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: subRuntimeError
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Runtime Error",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: primaryBlackText
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: MediaQuery.of(context).size.width/25,
                  width: MediaQuery.of(context).size.width/25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: subCompilationError
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Compilation Error",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: primaryBlackText
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

}
