import 'package:codephile/models/following.dart';
import 'package:codephile/models/submission.dart';
import 'package:codephile/models/user.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/screens/profile/profile_card.dart';
import 'package:codephile/screens/submission/recently_solved_card.dart';
import 'package:codephile/screens/submission/submission_screen.dart';
import 'package:codephile/services/following_list.dart';
import 'package:codephile/services/submission.dart';
import 'package:codephile/services/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/user_details.dart';
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
  UserDetails _userPlatformDetails;
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
      backgroundColor: const Color.fromRGBO(243, 244, 247, 1),
      body: _isLoading?
      Center(
        child: CircularProgressIndicator(),
      )
          :
      ListView(
        children: <Widget>[
          //TODO: implement #following
          ProfileCard(
              widget.token,
              _user,
              checkIfFollowing(widget.uId), //TODO: implement isFollowingCheck        Priority: 1
              widget._isMyProfile,
              _userPlatformDetails
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 16.0),
            child: Text(
              "Recently Solved",
              style: TextStyle(
                fontSize: 22.0,
                color: const Color.fromRGBO(36, 36, 36, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ((_mostRecentSubmissions != null)&&(_mostRecentSubmissions.length >= 1))?
          RecentlySolvedCard(_mostRecentSubmissions[0].name, submissionType(_mostRecentSubmissions[0]), _mostRecentSubmissions[0].createdAt, _mostRecentSubmissions[0].url)
              :
          Container()
          ,
          ((_mostRecentSubmissions != null)&&(_mostRecentSubmissions.length > 1))?
          RecentlySolvedCard(_mostRecentSubmissions[1].name, submissionType(_mostRecentSubmissions[1]), _mostRecentSubmissions[1].createdAt, _mostRecentSubmissions[1].url)
              :
          Container(),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
              child: Text(
                  "View More",
                style: TextStyle(
                  fontSize: 18.0,
                  color: codephileMain,
                ),
              ),
            ),
            onTap: (){
//              Navigator.push(context, new MaterialPageRoute(builder: (context) => new SubmissionScreen(token: widget.token, id: widget.uId)));
            },
          )
        ],
      ),
    );
  }

  void initValues() async{
    getUser(widget.token, widget.uId).then((user){
      _user = user;
    });
    getAllPlatformDetails(widget.token, widget.uId).then((platformDetails){
      _userPlatformDetails = platformDetails;
    });
    var submissionsList = await getSubmissionList(widget.token, widget.uId);
    if(widget.checkIfFollowing){
      var followingList = await getFollowingList(widget.token);
      _followingList = followingList;
    }
    //TODO: use shared prefs
    _submissionsList = submissionsList;
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
