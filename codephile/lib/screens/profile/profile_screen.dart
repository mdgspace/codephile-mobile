import 'package:codephile/models/following.dart';
import 'package:codephile/models/submission.dart';
import 'package:codephile/models/user.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/screens/profile/accuracy_display.dart';
import 'package:codephile/screens/profile/no_of_questions_solved_display.dart';
import 'package:codephile/screens/profile/profile_card.dart';
import 'package:codephile/screens/profile/submissions_stats.dart';
import 'package:codephile/screens/submission/recently_solved_card.dart';
import 'package:codephile/screens/submission/submission_screen.dart';
import 'package:codephile/services/following_list.dart';
import 'package:codephile/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/user_profile_details.dart';
import '../../services/user_details.dart';

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

  @override
  void initState() {
    super.initState();
    initValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading?
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
          ),
          AccuracyDisplay(_userPlatformDetails),
          QuestionsSolvedDisplay(
            _user.solvedProblemsCount.codechef,
            _user.solvedProblemsCount.codeforces,
            _user.solvedProblemsCount.hackerrank,
            _user.solvedProblemsCount.spoj
          ),
          SubmissionStatistics(),
        ],
      ),
    );
  }

  void initValues() async{
    var user = await getUser(widget.token, widget.uId);
    _user = user;
    _userPlatformDetails = _user.profiles;
    if(widget.checkIfFollowing){
      var followingList = await getFollowingList(widget.token);
      _followingList = followingList;
    }
    //TODO: use shared prefs
    _submissionsList = _user.recentSubmissions;
    getLatestTwoSubmissions();

    setState(() {
      _isLoading = false;
    });
  }

  void getLatestTwoSubmissions() {
    if(_submissionsList != null){
      if(_submissionsList.length >=2){
        _mostRecentSubmissions = List<Submission>();
        _mostRecentSubmissions.add(_submissionsList[0]);
        _mostRecentSubmissions.add(_submissionsList[1]);
      } else if(_submissionsList.length == 1){
        _mostRecentSubmissions = List<Submission>();
        _mostRecentSubmissions.add(_submissionsList[0]);
      }
    }
  }

  bool checkIfFollowing(String id) {
    if(_followingList != null){
      for(int i = 0; i < _followingList.length; i++){
        if(_followingList[i].fId == id){
          return true;
        }
      }
      return false;
    }
    return false;
  }
}
