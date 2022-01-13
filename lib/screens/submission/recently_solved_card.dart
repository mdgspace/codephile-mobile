import 'package:codephile/resources/strings.dart';
import 'package:flutter/material.dart';

class RecentlySolvedCard extends StatelessWidget {
  final String _problemName;
  final String _platform;
  final String _time;
//TODO: implement mins/hours ago feature

  const RecentlySolvedCard(this._problemName, this._platform, this._time,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: Card(
        shape: const RoundedRectangleBorder(
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
                      _problemName,
                      style: const TextStyle(
                        fontSize: 17.0,
                        color: Color.fromRGBO(36, 36, 36, 1),
                      ),
                    ),
                  ),
                ),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: RecentlySolvedBookmarkIcon(),
//              )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset(
                          getIconUrl(_platform),
                          width: MediaQuery.of(context).size.width / 20,
                          height: MediaQuery.of(context).size.width / 20,
                        ),
                      ),
                      Text(
                        _platform,
                        style: const TextStyle(
                          color: Color.fromRGBO(36, 36, 36, 1),
                          fontSize: 15.0,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _time.substring(0, 10),
                    //TODO: automate according to date format       Priority: 3
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color.fromRGBO(145, 145, 145, 1),
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

//TODO: make import function from file
  String getIconUrl(String platform) {
    switch (platform.toLowerCase()) {
      case "codechef":
        return codeChefIcon;

      case "hackerrank":
        return hackerRankIcon;

      case "hackerearth":
        return hackerEarthIcon;

      case "codeforces":
        return codeForcesIcon;

      case "spoj":
        return spojIcon;

      default:
        return otherIcon;
    }
  }
}
