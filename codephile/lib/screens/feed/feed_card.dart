import 'package:codephile/models/feed.dart';
import 'package:codephile/models/grouped_feed.dart';
import 'package:codephile/resources/strings.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:intl/intl.dart';

class FeedCard extends StatelessWidget {
  final GroupedFeed feed;
  FeedCard({this.feed});
  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: EdgeInsets.all(10),
      dense: true,
      child: ExpansionTile(
          backgroundColor: Colors.white,
          title: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: CircleAvatar(
                radius: 16.0,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(feed.picture),
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
                        '${feed.fullname.trim()} solved',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                      Text(
                        DateFormat("dd-MM-yyyy kk:mm")
                            .format(feed.submissions[0].createdAt),
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      )
                    ],
                  ),
                  Text(
                    '${feed.name}',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(children: <Widget>[
                    Text(
                      'on ',
                      style: TextStyle(fontSize: 12.0, color: Colors.black),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(getAsset(feed.url)),
                      radius: 10.0,
                    ),
                    Text(' ${getPlatform(feed.url)}',
                        style: TextStyle(fontSize: 12.0, color: Colors.black)),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_down)
                  ])
                ],
              ),
            ),
          ]),
          trailing: SizedBox(),
          children: _buildChildren(feed.submissions)),
    );
  }

  List<Widget> _buildChildren(List<Submissions> list) {
    return list
        .map((e) => Row(
              children: <Widget>[
                Text(e.status),
                Text(DateFormat('dd-MM-yyyy kk-ss').format(e.createdAt))
              ],
            ))
        .toList();
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
