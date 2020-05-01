import 'package:codephile/models/feed.dart';
import 'package:codephile/resources/strings.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class FeedCard extends StatelessWidget {
  final Feed feed;
  FeedCard({this.feed});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          feed.picture != ""
              ? CircleAvatar(
                  radius: 16.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(feed.picture),
                )
              : Icon(Icons.person, size: 36.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${feed.fullname.trim()} solved',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                      Text(
                        timeAgo(feed.submission.createdAt),
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    '${feed.submission.name}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(children: <Widget>[
                    Text(
                      'on ',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          AssetImage(getAsset(feed.submission.url)),
                      radius: 10.0,
                    ),
                    Text(' ${getPlatform(feed.submission.url)}',
                        style: TextStyle(fontSize: 12.0))
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String timeAgo(DateTime time) {
    Duration _duration = DateTime.now().difference(time);
    if (_duration < Duration(minutes: 1))
      return 'just now';
    else if (_duration < Duration(hours: 1))
      return '${_duration.inMinutes} mins';
    else if (_duration < Duration(days: 1))
      return '${_duration.inHours} hours';
    else if (_duration < Duration(days: 365))
      return '${_duration.inDays} days';
    else
      return '${(_duration.inDays / 365).round()} year';
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
