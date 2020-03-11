import 'package:codephile/colors.dart';
import 'package:codephile/services/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class ContestCard2 extends StatefulWidget {

  final String _platform;
  final String _name;
  final String _endTime;
  final String _startTime;
  final String _challengeType;
  final String _url;
  bool _notification = false;

  ContestCard2(
      this._name, this._endTime, this._platform, this._challengeType, this._url,
      [this._startTime]);

  @override
  _ContestCard2State createState() => _ContestCard2State();
}

class _ContestCard2State extends State<ContestCard2> {
  final Widget contestIcon = new SvgPicture.asset(
    "assets/contest_icon.svg",
    color: const Color.fromRGBO(255, 168, 00, 1),
    width: 12.0,
    height: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FlutterWebBrowser.openWebPage(
            url:widget._url, androidToolbarColor: Colors.deepPurple);
      },
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
                        padding: const EdgeInsets.fromLTRB(8.0, 2.0, 4.0, 2.0),
                        child: Container(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                getIconUrl(widget._platform),
                                width: 23.0,
                                height: 23.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        getFormattedPlatformName(widget._platform),
                        style: TextStyle(
                          color: const Color.fromRGBO(36, 36, 36, 1),
                          fontSize: 14.0,
                          fontFamily: 'Roboto',
                        ),
                      )
                    ],
                  ),
//              Padding(
//                padding: const EdgeInsets.fromLTRB(4.0, 2.0, 8.0, 8.0),
//                child: Text(
//                  "$_notificationTime ago",
//                  style: TextStyle(
//                    color: const Color.fromRGBO(145, 145, 145, 1),
//                    fontSize: 12.0,
//                  ),
//                ),
//              )
                ],
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Card(
                              elevation: 0.0,
                              color: const Color.fromRGBO(252, 191, 73, .15),
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
                                      'Contest',
                                      style: TextStyle(
                                        color: const Color.fromRGBO(
                                            255, 168, 00, 1),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (widget._startTime != null) {
                                  if (widget._notification) {
                                    await removeNotification(name: widget._name);
                                    setState(() {
                                      widget._notification = false;
                                    });
                                  } else {
                                    await setNotification(
                                        name: widget._name,
                                        platform: widget._platform,
                                        startTime: widget._startTime);
                                    setState(() {
                                      widget._notification = true;
                                    });
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Can't set alert for ongoing contests.");
                                }
                              },
                              child: Icon(
                                Icons.add_alert,
                                color: widget._notification
                                    ? codephileMain
                                    : codephileMainShade,
                              ),
                            )
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 6.0, 24.0, 6.0),
                      child: Text(
                        "${widget._name}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          fontFamily: 'Roboto',
                          color: const Color.fromRGBO(36, 36, 36, 1),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 6.0, 6.0, 8.0),
                      child: (widget._startTime != null)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0.0, 2.0, 0.0),
                                  child: Icon(
                                    Icons.access_time,
                                    size: 18.0,
                                    color:
                                        const Color.fromRGBO(145, 145, 145, 1),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      2.0, 0.0, 2.0, 0.0),
                                  child: Text(
                                    "Starts : ",
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            145, 145, 145, 1)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      2.0, 0.0, 2.0, 0.0),
                                  child: Text(
                                    widget._startTime,
                                  ),
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0.0, 2.0, 0.0),
                                  child: Icon(
                                    Icons.access_time,
                                    size: 18.0,
                                    color:
                                        const Color.fromRGBO(145, 145, 145, 1),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      2.0, 0.0, 2.0, 0.0),
                                  child: Text(
                                    "Ongoing",
                                    style: TextStyle(
//                                fontSize: 12.0,
                                        color: const Color.fromRGBO(
                                            145, 145, 145, 1)),
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

  String timeToStart() {
    //TODO: implement function
    return null;
  }

  String getFormattedPlatformName(String platform) {
    switch (platform.toLowerCase()) {
      case "codechef":
        return "CodeChef";
        break;
      case "hackerrank":
        return "HackerRank";
        break;
      case "hackerearth":
        return "HackerEarth";
        break;
      case "codeforces":
        return "CodeForces";
        break;
      default:
        return "Other";
    }
  }

  String getIconUrl(String platform) {
    final String codeChefIcon = "assets/platformIcons/codeChefIcon.png";
    final String hackerRankIcon = "assets/platformIcons/hackerRankIcon.png";
    final String hackerEarthIcon = "assets/platformIcons/hackerEarthIcon.png";
    final String codeForcesIcon = "assets/platformIcons/codeForcesIcon.png";
    final String otherIcon = "assets/platformIcons/otherIcon.jpg";

    switch (platform.toLowerCase()) {
      case "codechef":
        return codeChefIcon;
        break;
      case "hackerrank":
        return hackerRankIcon;
        break;
      case "hackerearth":
        return hackerEarthIcon;
        break;
      case "codeforces":
        return codeForcesIcon;
        break;
      default:
        return otherIcon;
    }
  }
}
