import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SubmissionCard extends StatelessWidget {

  final String _username;
  final String _handle;
  final String _time;
  final String _problem;
  final String _platform;

  final Widget contestIcon = new SvgPicture.asset(
    "assets/problem.svg",
    color: const Color.fromRGBO(255, 168, 00, 1),
    width: 12.0,
    height: 12.0,
  );

  SubmissionCard(this._username,
      this._handle,
      this._platform,
      this._problem,
      this._time,);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 2.0),
                        child: Container(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                "assets/facebook.png",
                                width: 23.0,
                                height: 23.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "$_username",
                              style: TextStyle(
                                color: const Color.fromRGBO(36, 36, 36, 1),
                                fontSize: 16.0,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            Text(
                              _handle,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ]),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.0, right: 5.0),
                        child: Text(
                          "Solved time mins ago",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

              ),

              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 3.0, 6.0),
                      child: Card(
                        elevation: 0.0,
                        color: const Color.fromRGBO(51, 102, 255, .15),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: contestIcon,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 4.0, 5.0, 4.0),
                              child: Text(
                                'Problem',
                                style: TextStyle(
                                  color: const Color.fromRGBO(51, 102, 255, 1),
                                  fontSize: 12.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 6.0, 24.0, 6.0),
                      child: Text(
                        "$_problem",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'Roboto',
                          color: const Color.fromRGBO(36, 36, 36, 1),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 6.0, 6.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                8.0, 0.0, 2.0, 0.0),
                            child: Image.asset(
                              "assets/codeChefIcon.png",
                              width: 23.0,
                              height: 23.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                4.0, 0.0, 2.0, 0.0),
                            child: Text(
                              "$_platform",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}