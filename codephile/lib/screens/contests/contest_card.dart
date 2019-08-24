import 'package:flutter/material.dart';

class ContestCard extends StatelessWidget{

  final String _date = "10 Aug, 2019";
  final String _time = "8:30 pm";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 50.0,
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
                    Text(
                      "UserName",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
                  child: Text(
                    "Contest",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                  child: Text(
                    "Website on which it is held",
                    style: TextStyle(
                        fontSize: 18.0
                    ),
                    overflow: TextOverflow.ellipsis,
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
            )
          ],
        ),
      ),
    );
  }
}
