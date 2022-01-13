import 'package:codephile/resources/colors.dart';
import 'package:flutter/material.dart';

class SubmissionChartKey extends StatelessWidget {
  const SubmissionChartKey({Key? key}) : super(key: key);

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
                  height: MediaQuery.of(context).size.width / 25,
                  width: MediaQuery.of(context).size.width / 25,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: subAccepted),
                ),
              ),
              const Text(
                "Accepted",
                style: TextStyle(fontSize: 15.0, color: primaryBlackText),
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
                  height: MediaQuery.of(context).size.width / 25,
                  width: MediaQuery.of(context).size.width / 25,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: subPartiallySolved),
                ),
              ),
              const Text(
                "Partially Solved",
                style: TextStyle(
                  fontSize: 15.0,
                  color: primaryBlackText,
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
                  height: MediaQuery.of(context).size.width / 25,
                  width: MediaQuery.of(context).size.width / 25,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: subWrongAnswer),
                ),
              ),
              const Text(
                "Wrong Answer",
                style: TextStyle(
                  fontSize: 15.0,
                  color: primaryBlackText,
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
                  height: MediaQuery.of(context).size.width / 25,
                  width: MediaQuery.of(context).size.width / 25,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: subTimeLimitExceeded),
                ),
              ),
              const Flexible(
                child: Text(
                  "TLE",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: primaryBlackText,
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
                  height: MediaQuery.of(context).size.width / 25,
                  width: MediaQuery.of(context).size.width / 25,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: subRuntimeError),
                ),
              ),
              const Text(
                "Runtime Error",
                style: TextStyle(
                  fontSize: 15.0,
                  color: primaryBlackText,
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
                  height: MediaQuery.of(context).size.width / 25,
                  width: MediaQuery.of(context).size.width / 25,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: subCompilationError),
                ),
              ),
              const Text(
                "Compilation Error",
                style: TextStyle(
                  fontSize: 15.0,
                  color: primaryBlackText,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
