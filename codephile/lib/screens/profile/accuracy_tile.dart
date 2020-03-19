import 'package:codephile/resources/strings.dart';
import 'package:flutter/material.dart';

class AccuracyTile extends StatelessWidget{

  final String _platform;
  final String _accuracy;

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
                  width: MediaQuery.of(context).size.width/16,
                  height: MediaQuery.of(context).size.width/16,
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
                  ((_accuracy == "NaN")||(_accuracy == ""))?
                  "-"
                      :
                  (_accuracy.length > 4)?
                  "${_accuracy.substring(0, 4)}"
                  :
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
