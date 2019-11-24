import 'dart:core';
import 'package:codephile/models/contests.dart';
import 'package:codephile/screens/contests/contest_card_2.dart';
import 'package:codephile/services/contests.dart';
import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  final String token;
  Timeline(this.token, {Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<Ongoing> ongoingContests;
  List<Upcoming> upcomingContests;
  List<Widget> allContests = List<Widget>();
  bool _isLoading = true;

  @override
  void initState() {
    contestList(widget.token).then((contests){
      ongoingContests = contests.result.ongoing;
      upcomingContests = contests.result.upcoming;
      print(ongoingContests.length);

      for(var i = 0; i < ongoingContests.length; i++){
        allContests.add(ContestCard2(
          ongoingContests[i].name,
          ongoingContests[i].endTime,
          ongoingContests[i].platform,
          ongoingContests[i].challengeType,
          ongoingContests[i].url,
          "1 day"
        ));
      }
      for(var i = 0; i < upcomingContests.length; i++){
        allContests.add(ContestCard2(
          upcomingContests[i].name,
          upcomingContests[i].endTime,
          upcomingContests[i].platform,
          upcomingContests[i].challengeType,
          upcomingContests[i].url,
          "1 day",
          upcomingContests[i].startTime
        ));
      }

      print(ongoingContests.length);
      print(upcomingContests.length);
      print(allContests.length);

      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
//      appBar: AppBar(
//        title: Text("Contests"),
//      ),
      body: (_isLoading)?
      Center(
          child: CircularProgressIndicator()
      )
          :
      ListView.builder(
        itemBuilder: (context, position){
          return allContests[position];
        },
        itemCount: allContests.length,
      ),
    );
  }
}
