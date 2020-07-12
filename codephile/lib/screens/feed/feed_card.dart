import 'package:codephile/models/grouped_feed.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/resources/strings.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:intl/intl.dart';

class FeedCard extends StatefulWidget {
  final GroupedFeed feed;
  FeedCard({this.feed});

  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  bool open;
  @override
  void initState() {
    super.initState();
    open = false;
  }

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: EdgeInsets.all(10),
      dense: true,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.white),
        child: ExpansionTile(
            backgroundColor: Colors.white,
            title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: CircleAvatar(
                      radius: 16.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(widget.feed.picture),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '${widget.feed.fullname.trim()} solved',
                              style: TextStyle(
                                  fontSize: 14.0, color: Color(0xFF979797)),
                            ),
                            Text(
                              DateFormat("dd-MM-yyyy kk:mm")
                                  .format(widget.feed.submissions[0].createdAt),
                              style: TextStyle(
                                  fontSize: 14.0, color: Color(0xFF979797)),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                            '${widget.feed.name}',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Row(children: <Widget>[
                          Text(
                            'on ',
                            style: TextStyle(
                                fontSize: 12.0, color: Color(0xFF979797)),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                AssetImage(getAsset(widget.feed.url)),
                            radius: 10.0,
                          ),
                          Text(
                              ' ${getPlatform(widget.feed.url)} | ${widget.feed.language}',
                              style: TextStyle(
                                  fontSize: 12.0, color: Color(0xFF979797))),
                          Spacer(),
                          Icon(
                            open
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: codephileMain,
                          )
                        ])
                      ],
                    ),
                  ),
                ]),
            onExpansionChanged: (value) {
              setState(() {
                open = value;
              });
            },
            trailing: SizedBox(),
            children: [
              Container(
                  color: Color(0xFFFAFAFA),
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child:
                      Column(children: _buildChildren(widget.feed.submissions)))
            ]),
      ),
    );
  }

  List<Widget> _buildChildren(List<Submissions> list) {
    List<Widget> children = List();
    for (int i = 0; i < list.length; i++) {
      Submissions element = list[i];
      Color statusColor;
      bool top = (i != 0);
      bool bottom = (i != (list.length - 1));
      String status;
      switch (element.status) {
        case "AC":
          statusColor = Colors.lightGreen;
          status = "Accepted";
          break;
        case "WA":
          statusColor = Colors.red;
          status = "Wrong Answer";
          break;
        case "CE":
          statusColor = Colors.red;
          status = "Compilation Error";
          break;
        case "RE":
          statusColor = Colors.red;
          status = "Runtime Error";
          break;
        case "TLE":
          statusColor = Colors.orange;
          status = "Time Limit Exceeded";
          break;
        case "MLE":
          statusColor = Colors.orange;
          status = "Memory Limit Exceeded";
          break;
        case "PTL":
          statusColor = Colors.lightGreen;
          status = "Parital Answer";
          break;
        default:
          statusColor = Colors.red;
          status = "Other";
      }
      children.add(Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(children: <Widget>[
            Container(
              height: 9,
              width: 2,
              color: top ? Color(0xFFE5E5E5) : Colors.white,
            ),
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  color: statusColor, borderRadius: BorderRadius.circular(6)),
            ),
            Container(
              height: 9,
              width: 2,
              color: bottom ? Color(0xFFE5E5E5) : Colors.white,
            )
          ]),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
            child: Text(
              status,
              style: TextStyle(color: statusColor),
            ),
          ),
          Spacer(),
          Text(
            DateFormat('dd-MM-yyyy kk-ss').format(element.createdAt),
            style: TextStyle(color: Color(0xFF919191)),
          )
        ],
      ));
    }
    return children;
  }

  String getPlatform(String url) {
    if (url.startsWith('https://www.hackerrank.com'))
      return 'HackerRank';
    else if (url.startsWith('https://www.spoj.com'))
      return 'Spoj';
    else if (url.startsWith('http://www.codechef.com'))
      return 'CodeChef';
    else if (url.startsWith('http://codeforces.com'))
      return 'CodeForces';
    else
      return url;
  }

  String getAsset(String url) {
    switch (getPlatform(url)) {
      case 'HackerRank':
        return hackerRankIcon;
      case 'Spoj':
        return spojIcon;
      case 'CodeChef':
        return codeChefIcon;
      case 'CodeForces':
        return codeForcesIcon;
      default:
        return otherIcon;
    }
  }
}
