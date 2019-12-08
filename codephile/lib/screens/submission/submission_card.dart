import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:codephile/colors.dart';

class SubmissionCard extends StatelessWidget {

  final String _username;
  final String _handle;
  final String _time;
  final String _problem;
  final String _platform;
  final String _picture;

  final Widget contestIcon = new SvgPicture.asset(
    "assets/mask.svg",
    color: const Color.fromRGBO(152,219 , 17, 1),
    width: 12.0,
    height: 12.0,
  );

  final Widget bookmark = new SvgPicture.asset(
    "assets/bookmark.svg",
    width: 14.0,
    height: 14.0,
  );

  SubmissionCard(this._username,
      this._handle,
      this._platform,
      this._problem,
      this._time,
      this._picture);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                              child: Container(
                                width: 23.0,
                                height: 23.0,
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage("https://storage.googleapis.com/codephile-a71b6.appspot.com/profile/3c10263f-0d10-4864-a7fd-7e0323e5c339.jpg"),
                                  ),
                                ),
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
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 3.0, 6.0),
                          child: Card(
                            elevation: 0.0,
                            color: codephileSolvedBAckground,
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
                                    'Solved',
                                    style: TextStyle(
                                      color: Color.fromRGBO(152, 219, 17, 1),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width*.64),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: bookmark,
                        ),
                      ],
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
                              getIconUrl(_platform),
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

  String getIconUrl(String platform){
    final String codeChefIcon =
        "assets/platformIcons/codeChefIcon.png";
    final String hackerRankIcon =
        "assets/platformIcons/hackerRankIcon.png";
    final String hackerEarthIcon =
        "assets/platformIcons/hackerEarthIcon.png";
    final String codeForcesIcon =
        "assets/platformIcons/codeForcesIcon.png";
    final String spojIcon =
        "assets/platformIcons/spoj.png";
    final String otherIcon =
        "assets/platformIcons/otherIcon.jpg";

    switch(platform.toLowerCase()){
      case "codechef" :
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
      case "spoj":
        return spojIcon;
        break;
      default:
        return otherIcon;
    }
  }
}