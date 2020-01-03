import 'package:flutter/material.dart';

class AccuracyTile extends StatelessWidget{

  final String _platform;
  final double _accuracy;

  AccuracyTile(this._platform, this._accuracy);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            border: Border.all(
              color: const Color.fromRGBO(151, 151, 151, 1),
              width: 1,
            )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: const Color.fromRGBO(151, 151, 151, 1),
                    width: 0,
                  ),
                ),
              ),
//              child: Card(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  getIconUrl(_platform),
                  width: 24.0,
                  height: 24.0,
                ),
              ),
            ),
//            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(243, 244, 247, 1),
                border: Border(
                  left: BorderSide(
                    color: const Color.fromRGBO(151, 151, 151, 1),
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "$_accuracy",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: const Color.fromRGBO(151, 151, 151, 1),
                  ),
                ),
              ),
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
