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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
        title: Text(
          "Feed",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: getFeed(token: widget.token),
          initialData: null,
          builder: (context, feed) {
            if (feed.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: feed.data.length,
                itemBuilder: (context, index) {
                  return FeedCard(feed: feed.data[index]);
                },
              );
            } else if (feed.connectionState == ConnectionState.waiting) {
              return SpinKitChasingDots(color: codephileMain);
            } else {
              return Center(
                child: Text('Feed not available'),
              );
            }
          }),
    );
  }
}
