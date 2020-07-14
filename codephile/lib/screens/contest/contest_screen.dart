import 'dart:convert';
import 'package:codephile/models/contests.dart';
import 'package:codephile/models/filters.dart';
import 'package:codephile/resources/strings.dart';
import 'package:codephile/screens/contest/contest_card.dart';
import 'package:codephile/screens/contest/filter_sheet.dart';
import 'package:codephile/services/contests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sentry/sentry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContestScreen extends StatefulWidget {
  final String token;
  ContestScreen({this.token});
  @override
  _ContestScreenState createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {
  final SentryClient sentry = new SentryClient(dsn: dsn);
  List<Ongoing> ongoingContests;
  List<Upcoming> upcomingContests;
  List<Ongoing> filteredOngoingContests = List<Ongoing>();
  List<Upcoming> filteredUpcomingContests = List<Upcoming>();
  ContestFilter filter;

  @override
  void initState() {
    super.initState();
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
    refreshContests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: SvgPicture.asset("assets/filter.svg"),
              onPressed: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return FilterSheet(filter: filter);
                    }).then((value) {
                  if (value != null) {
                    setState(() {
                      filter = value;
                    });
                    SharedPreferences.getInstance().then((pref) {
                      pref.setString('filter', jsonEncode(filter.toJson()));
                    });
                    applyFilter();
                  }
                });
              })
        ],
        title: Text(
          "Contest",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Builder(builder: (context) {
        if ((filteredOngoingContests.length == 0) &&
            (filteredUpcomingContests.length == 0)) {
          double width = MediaQuery.of(context).size.width;
          return ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(25, 15, 15, 0),
                          child: CircleAvatar(
                              backgroundColor: Color(0xFFE5E5E5), radius: 18)),
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
              itemCount: filteredOngoingContests.length +
                  filteredUpcomingContests.length,
              itemBuilder: (context, index) {
                if (index < filteredOngoingContests.length) {
                  return ContestCard(
                      title: filteredOngoingContests[index].name,
                      platform: filteredOngoingContests[index].platform,
                      endTime: filteredOngoingContests[index].endTime,
                      url: filteredOngoingContests[index].url,
                      startTime: null);
                } else {
                  int offset = filteredOngoingContests.length;
                  return ContestCard(
                      title: filteredUpcomingContests[index - offset].name,
                      endTime: filteredUpcomingContests[index - offset].endTime,
                      platform:
                          filteredUpcomingContests[index - offset].platform,
                      url: filteredUpcomingContests[index - offset].url,
                      startTime:
                          filteredUpcomingContests[index - offset].startTime);
                }
              });
        }
      }),
    );
  }

  refreshContests() async {
    try{
      contestList(widget.token, context).then((value) {
        setState(() {
          ongoingContests = value.ongoing;
          upcomingContests = value.upcoming;
        });
        applyFilter();
      });
    } catch(error, stackTrace){
      await sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }

  }

  applyFilter() {
    setState(() {
      filteredOngoingContests.clear();
      filteredUpcomingContests.clear();
      if (filter.ongoing) {
        filteredOngoingContests.addAll(
            ongoingContests.where((element) => filter.check(ongoing: element)));
      }
      if (filter.upcoming) {
        filteredUpcomingContests.addAll(upcomingContests
            .where((element) => filter.check(upcoming: element)));
      }
    });
  }
}
