import 'package:codephile/library/feed_expansion_tile.dart';
import 'package:codephile/models/feed.dart';
import 'package:codephile/models/grouped_feed.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/feed/feed_card.dart';
import 'package:codephile/services/feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FeedScreen extends StatefulWidget {
  final String token;
  FeedScreen({this.token});
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<GroupedFeed> feed;
  @override
  void initState() {
    super.initState();
    refreshFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  feed = null;
                });
                refreshFeed();
              })
        ],
        title: Text(
          "Feed",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (feed == null) {
            double width = MediaQuery.of(context).size.width;
            return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(25, 15, 15, 0),
                            child: CircleAvatar(
                                backgroundColor: Color(0xFFE5E5E5),
                                radius: 18)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                                width: width * 2 / 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Color(0xFFE5E5E5)),
                                height: 14),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              width: width * 3 / 4,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Color(0xFFE5E5E5)),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                              width: width * 3 / 4,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Color(0xFFE5E5E5)),
                            )
                          ],
                        )
                      ]);
                });
          } else {
            return ListView.builder(
              itemCount: feed.length,
              itemBuilder: (context, index) {
                return FeedCard(feed: feed[index]);
              },
            );
          }
        },
      ),
    );
  }

  void refreshFeed() {
    getFeed(token: widget.token).then((value) {
      List<GroupedFeed> groupedFeed = List();
      value.forEach((feedElement) {
        GroupedFeed e = groupedFeed.firstWhere(
          (grpFeedElement) =>
              grpFeedElement.name == feedElement.submission.name,
          orElse: () {
            groupedFeed.add(GroupedFeed(
                fullname: feedElement.fullname,
                name: feedElement.submission.name,
                picture: feedElement.picture,
                url: feedElement.submission.url,
                userId: feedElement.userId,
                username: feedElement.username,
                submissions: List()));
            return groupedFeed.last;
          },
        );
        e.submissions.add(Submissions(
            createdAt: feedElement.submission.createdAt,
            language: feedElement.submission.language,
            points: feedElement.submission.points,
            rating: feedElement.submission.rating,
            status: feedElement.submission.status,
            tags: feedElement.submission.tags));
      });
      setState(() {
        feed = groupedFeed;
      });
    });
  }
}
