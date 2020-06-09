import 'package:codephile/models/following.dart';
import 'package:codephile/models/submission.dart';
import 'package:codephile/models/submission_status_data.dart';
import 'package:codephile/models/user.dart';
import 'package:codephile/screens/profile/accuracy_display.dart';
import 'package:codephile/screens/profile/no_of_questions_solved_display.dart';
import 'package:codephile/screens/profile/profile_card.dart';
import 'package:codephile/screens/profile/submissions_stats.dart';
import 'package:codephile/services/following_list.dart';
import 'package:codephile/services/submissions_status.dart';
import 'package:codephile/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/user_profile_details.dart';

class Profile extends StatefulWidget {
  final String token;
  final String uId;
  final bool _isMyProfile;
  final bool checkIfFollowing;

  Profile(this.token, this.uId, this._isMyProfile, this.checkIfFollowing);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = true;

  User _user;
  UserProfileDetails _userPlatformDetails;
  List<Submission> _submissionsList;
  List<Submission> _mostRecentSubmissions;
  List<Following> _followingList;
  SubStatusData _subStats;

  @override
  void initState() {
    super.initState();
    initValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:
        RefreshIndicator(
          child:_isLoading?
          Center(
            child: CircularProgressIndicator(),
          )
              :
          ListView(
            children: <Widget>[
              ProfileCard(
                widget.token,
                _user,
                checkIfFollowing(widget.uId),
                widget._isMyProfile,
                refreshPage,
              ),
              AccuracyDisplay(_userPlatformDetails),
              QuestionsSolvedDisplay(
                  _user.solvedProblemsCount.codechef,
                  _user.solvedProblemsCount.codeforces,
                  _user.solvedProblemsCount.hackerrank,
                  _user.solvedProblemsCount.spoj
              ),
              SubmissionStatistics(_subStats),
            ],
          ), onRefresh: refreshPage
        )
    );
  }

  void initValues() async {
    var user = await getUser(widget.token, widget.uId);
    _user = user;
    _userPlatformDetails = (_user == null)? null :_user.profiles;
    var followingList = await getFollowingList(widget.token);
    _followingList = followingList;
    var subData = await getSubmissionStatusData(widget.token, widget.uId);
    _subStats = subData;

    _submissionsList = (_user == null)? null : _user.recentSubmissions;
    getLatestTwoSubmissions();

    setState(() {
      _isLoading = false;
    });
  }

  void getLatestTwoSubmissions() {
    if (_submissionsList != null) {
      if (_submissionsList.length >= 2) {
        _mostRecentSubmissions = List<Submission>();
        _mostRecentSubmissions.add(_submissionsList[0]);
        _mostRecentSubmissions.add(_submissionsList[1]);
      } else if (_submissionsList.length == 1) {
        _mostRecentSubmissions = List<Submission>();
        _mostRecentSubmissions.add(_submissionsList[0]);
      }
    }
  }

  bool checkIfFollowing(String id) {
    if(_followingList != null){
      for(int i = 0; i < _followingList.length; i++){
        if(_followingList[i].id == id){
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
