import 'dart:convert';
import 'dart:core';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/models/contests.dart';
import 'package:codephile/models/filters.dart';
import 'package:codephile/screens/contests/contest_card.dart';
import 'package:codephile/screens/contests/filter_button.dart';
import 'package:codephile/services/contests.dart';
import 'package:codephile/services/notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContestScreen extends StatefulWidget {
  final String token;
  ContestScreen({this.token, Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ContestScreenState createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {
  List<Ongoing> ongoingContests;
  List<Upcoming> upcomingContests;
  List<Widget> allContests = List<Widget>();
  List<Ongoing> filteredOngoingContests = List<Ongoing>();
  List<Upcoming> filteredUpcomingContests = List<Upcoming>();
  bool _isLoading = true;
  ContestFilter filter;

  @override
  void initState() {
    print('initState');
    SharedPreferences.getInstance().then((pref) {
      if (pref.containsKey('filter')) {
        setState(() {
          filter = ContestFilter.fromJson(jsonDecode(pref.getString('filter')));
        });
      } else {
        setState(() {
          filter = ContestFilter(
              duration: 4,
              platform: [true, true, true, true, false],
              startDate: DateTime.now(),
              ongoing: true,
              upcoming: true);
        });
        pref.setString('filter', jsonEncode(filter.toJson()));
      }
    });
    contestList(widget.token).then((contests) {
      ongoingContests = contests.ongoing;
      upcomingContests = contests.upcoming;
      applyFilter();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
        floatingActionButton: FilterButton(
          filter: filter,
          applyFilter: applyFilter,
        ),
        body: (_isLoading)
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return allContests[index];
                },
                itemCount: allContests.length,
              ));
  }

  applyFilter() async {
    List notificationList = await getNotificationList();
    print('applyFilter');
    setState(() {
      filteredOngoingContests.clear();
      filteredUpcomingContests.clear();

      if (filter.ongoing) {
        filteredOngoingContests.addAll(ongoingContests
            .where((u) =>
                (checkPlatform(platform: u.platform, filter: filter) &&
                    checkDuration(endTime: u.endTime, filter: filter)))
            .toList());
      }
      if (filter.upcoming) {
        filteredUpcomingContests.addAll(upcomingContests
            .where((u) =>
                (checkPlatform(platform: u.platform, filter: filter) &&
                    checkDuration(
                        endTime: u.endTime,
                        filter: filter,
                        startTime: u.startTime) &&
                    checkStartTime(filter: filter, startTime: u.startTime)))
            .toList());
      }
      allContests.clear();
      for (var i = 0; i < filteredOngoingContests.length; i++) {
        allContests.add(ContestCard(
          filteredOngoingContests[i].name.trim(),
          filteredOngoingContests[i].endTime,
          filteredOngoingContests[i].platform,
          filteredOngoingContests[i].challengeType,
          filteredOngoingContests[i].url,
        ));
      }
      for (var i = 0; i < filteredUpcomingContests.length; i++) {
        allContests.add(ContestCard(
            filteredUpcomingContests[i].name.trim(),
            filteredUpcomingContests[i].endTime,
            filteredUpcomingContests[i].platform,
            filteredUpcomingContests[i].challengeType,
            filteredUpcomingContests[i].url,
            notificationList.indexOf(filteredUpcomingContests[i].name.trim()) !=
                -1,
            filteredUpcomingContests[i].startTime));
      }
    });
  }
}
