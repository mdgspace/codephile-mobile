import 'package:flutter/material.dart';
import 'package:codephile/screens/submission/recently_soved_bookmark_icon.dart';

class RecentlySolvedCard extends StatelessWidget{

final String _problemDescription;
final String _platform;
final int _minsAgo;
//TODO: implement mins/hours ago feature

RecentlySolvedCard(this._problemDescription, this._platform, this._minsAgo);

@override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "$_problemDescription",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: const Color.fromRGBO(36, 36, 36, 1),
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RecentlySolvedBookmarkIcon(),
              )

            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        getIconUrl(_platform),
                        width: 20.0,
                        height: 20.0,
                      ),
                    ),
                    Text(
                      "$_platform",
                      style: TextStyle(
                          color: const Color.fromRGBO(36, 36, 36, 1),
                          fontSize: 15.0
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$_minsAgo mins ago",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: const Color.fromRGBO(145, 145, 145, 1),
                  ),
                ),
              ),
            ],
          ),
        ],
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
    default:
      return otherIcon;
  }
}
}
