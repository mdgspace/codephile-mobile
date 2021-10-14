import 'package:codephile/resources/colors.dart';
import 'package:codephile/resources/strings.dart';
import 'package:flutter/material.dart';

class AccuracyTile extends StatelessWidget {
  final String _platform;
  final String? _accuracy;

  const AccuracyTile(this._platform, this._accuracy, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 4.0, 8.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
            color: uiBackground,
            borderRadius: const BorderRadius.all(Radius.circular(2.0)),
            border: Border.all(
              color: secondaryTextGrey,
              width: 1,
            )),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(
                    color: secondaryTextGrey,
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  getIconUrl(_platform),
                  width: MediaQuery.of(context).size.width / 14,
                  height: MediaQuery.of(context).size.width / 14,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: uiBackground,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ((_accuracy == "NaN") || (_accuracy == ""))
                      ? "-"
                      : (_accuracy!.length > 4)
                          ? _accuracy!.substring(0, 4)
                          : "$_accuracy",
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: secondaryTextGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
