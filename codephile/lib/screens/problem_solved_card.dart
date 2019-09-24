import 'package:flutter/material.dart';

class ProblemSolvedCard extends StatelessWidget{

  final String _date = "10 Aug, 2019";
  final String _time = "8:30 pm";
  final String _website = "Codechef";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "http://cdn.onlinewebfonts.com/svg/img_357118.png"
                              )
                          )
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
                      child: Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                      child: Text(
                        "@usename",
                        style: TextStyle(
                            fontSize: 16.0
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Divider(
              height: 2.0,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
              child: Text(
                "Solved",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
              child: Text(
                "Problem name/ details",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
              child: Text(
                "on $_website",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 2.0, 1.0, 8.0),
                  child: Text(
                    "Time",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(1.0, 2.0, 4.0, 8.0),
                  child: Text(
                    "$_time",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: const Color.fromRGBO(0, 0, 0, 0.85)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 2.0, 1.0, 8.0),
                  child: Text(
                    "Date",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(1.0, 2.0, 8.0, 8.0),
                  child: Text(
                    "$_date",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: const Color.fromRGBO(0, 0, 0, 0.85)
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
