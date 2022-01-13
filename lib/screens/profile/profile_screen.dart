import 'package:codephile/models/activity_details.dart';
import 'package:codephile/models/following.dart';
import 'package:codephile/models/submission.dart';
import 'package:codephile/models/submission_status_data.dart';
import 'package:codephile/models/user.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/resources/strings.dart';
import 'package:codephile/screens/profile/profile_skeleton.dart';
import 'package:codephile/screens/profile/acceptance_graph.dart';
import 'package:codephile/screens/profile/accuracy_display.dart';
import 'package:codephile/screens/profile/no_of_questions_solved_display.dart';
import 'package:codephile/screens/profile/profile_card.dart';
import 'package:codephile/screens/profile/settings_popup_menu.dart';
import 'package:codephile/screens/profile/submissions_stats.dart';
import 'package:codephile/services/activity_details.dart';
import 'package:codephile/services/following_list.dart';
import 'package:codephile/services/submissions_status.dart';
import 'package:codephile/services/user.dart';
import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';
import '../../models/user_profile_details.dart';
import 'package:flutter/foundation.dart' as foundation;

class Profile extends StatefulWidget {
  final String? token;
  final String? uId;
  final bool _isMyProfile;
  final bool checkIfFollowing;

  const Profile(this.token, this.uId, this._isMyProfile, this.checkIfFollowing,
      {Key? key})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = true;
  final SentryClient sentry = SentryClient(SentryOptions(dsn: dsn));

  CodephileUser? _user;
  UserProfileDetails? _userPlatformDetails;
  List<Submission>? _submissionsList;
  late List<Submission> _mostRecentSubmissions;
  List<Following>? _followingList;
  List<ActivityDetails>? _activityDetails;
  SubStatusData? _subStats;

  @override
  void initState() {
    super.initState();
    initValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: codephileMain,
          actions: <Widget>[
            (widget._isMyProfile)
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 16.0, 16.0, 0.0),
                    child: SettingsIcon(widget.token, _user, refreshPage),
                  )
                : Container(),
          ],
        ),
        backgroundColor: Colors.white,
        body: RefreshIndicator(
            child: _isLoading
                ? Center(
                    child: profileSkeleton(context),
                  )
                : ListView(
                    children: <Widget>[
                      ProfileCard(
                        widget.token,
                        _user,
                        checkIfFollowing(widget.uId),
                        widget._isMyProfile,
                        refreshPage,
                      ),
                      AccuracyDisplay(_userPlatformDetails),
                      ((_user == null) || (_user!.solvedProblemsCount == null))
                          ? const QuestionsSolvedDisplay(0, 0, 0, 0)
                          : QuestionsSolvedDisplay(
                              _user!.solvedProblemsCount!.codechef,
                              _user!.solvedProblemsCount!.codeforces,
                              _user!.solvedProblemsCount!.hackerrank,
                              _user!.solvedProblemsCount!.spoj),
                      SubmissionStatistics(_subStats),
                      AcceptanceGraph(
                        activityDetails:
                            (_activityDetails != null) ? _activityDetails : [],
                      )
                    ],
                  ),
            onRefresh: refreshPage));
  }

  void initValues() async {
    try {
      var user = await getUser(widget.token!, widget.uId, context);
      _user = user;
      _userPlatformDetails = (_user == null) ? null : _user!.profiles;
      var followingList = await getFollowingList(widget.token!, context);
      _followingList = followingList;
      var subData =
          await getSubmissionStatusData(widget.token!, widget.uId, context);
      _subStats = subData;

      _submissionsList = (_user == null) ? null : _user!.recentSubmissions;
      getLatestTwoSubmissions();
      _activityDetails =
          await getActivityDetails(widget.token!, widget.uId, context);
      setState(() {
        _isLoading = false;
      });
    } catch (error, stackTrace) {
      if (foundation.kReleaseMode) {
        await sentry.captureException(
          error,
          stackTrace: stackTrace,
        );
      }
    }
  }

  void getLatestTwoSubmissions() {
    if (_submissionsList != null) {
      if (_submissionsList!.length >= 2) {
        _mostRecentSubmissions = <Submission>[];
        _mostRecentSubmissions.add(_submissionsList![0]);
        _mostRecentSubmissions.add(_submissionsList![1]);
      } else if (_submissionsList!.length == 1) {
        _mostRecentSubmissions = <Submission>[];
        _mostRecentSubmissions.add(_submissionsList![0]);
      }
    }
  }

  bool checkIfFollowing(String? id) {
    if (_followingList != null) {
      for (int i = 0; i < _followingList!.length; i++) {
        if (_followingList![i].id == id) {
          return true;
        }
      }
      return false;
    }
    return false;
  }

  Future<void> refreshPage() async {
    setState(() {
      _isLoading = true;
    });
    initValues();
  }
}
