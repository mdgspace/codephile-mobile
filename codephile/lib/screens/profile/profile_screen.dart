import 'package:codephile/models/submission.dart';
import 'package:codephile/models/user.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/profile/profile_card.dart';
import 'package:codephile/screens/submission/recently_solved_card.dart';
import 'package:codephile/screens/submission/submission_screen.dart';
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

  Profile(this.token, this.uId, this._isMyProfile);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool _isLoading = true;

  User _user;
  UserDetails _userPlatformDetails;
  Submission _submissionsList;
  List<dynamic> _mostRecentSubmissions;
  bool _isFollowing;

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
              false, //TODO: implement isFollowingCheck        Priority: 1
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
          RecentlySolvedCard(_mostRecentSubmissions[0].name, submissionType(_mostRecentSubmissions[0]), _mostRecentSubmissions[0].creationDate, _mostRecentSubmissions[0].url)
              :
          Container()
          ,
          ((_mostRecentSubmissions != null)&&(_mostRecentSubmissions.length > 1))?
          RecentlySolvedCard(_mostRecentSubmissions[1].name, submissionType(_mostRecentSubmissions[1]), _mostRecentSubmissions[1].creationDate, _mostRecentSubmissions[1].url)
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
    var user = await getUser(widget.token, widget.uId);
    var platformDetails = await getAllPlatformDetails(widget.token, widget.uId);
    var submissionsList = await getSubmissionList(widget.token, widget.uId);
    //TODO: use shared prefs
    _user = user;
    _userPlatformDetails = platformDetails;
    _submissionsList = submissionsList;
    getLatestTwoSubmissions();

    setState(() {
      _isLoading = false;
    });
  }

  void getLatestTwoSubmissions() {
    List<CodechefSubmission> codechefSubmissions = _submissionsList.codechef;
    List<CodeforcesSubmission> codeforcesSubmissions = _submissionsList.codeforces;
    List<HackerrankSubmission> hackerrankSubmissions = _submissionsList.hackerrank;
    List<SpojSubmission> spojSubmissions = _submissionsList.spoj;

    int noOfCodechefSubmissions = (codechefSubmissions == null)? 0 : codechefSubmissions.length;
    int noOfCodeforcesSubmissions = (codeforcesSubmissions == null)? 0 : codeforcesSubmissions.length;
    int noOfHackerrankSubmissions = (hackerrankSubmissions == null)? 0 : hackerrankSubmissions.length;
    int noOfSpojSubmissions = (spojSubmissions == null)? 0 : spojSubmissions.length;

    print(noOfCodechefSubmissions);
    print(noOfCodeforcesSubmissions);
    print(noOfHackerrankSubmissions);
    print(noOfSpojSubmissions);

    for(int i = 0; (i < 2)&&(i < noOfCodechefSubmissions); i++){
      print(i);
      checkAndAddToList(codechefSubmissions[i]);
    }
    for(int i = 0; (i < 2)&&(i < noOfCodeforcesSubmissions); i++){
      checkAndAddToList(codeforcesSubmissions[i]);
    }
    for(int i = 0; (i < 2)&&(i < noOfHackerrankSubmissions); i++){
      checkAndAddToList(hackerrankSubmissions[i]);
    }
    for(int i = 0; (i < 2)&&(i < noOfSpojSubmissions); i++){
      checkAndAddToList(spojSubmissions[i]);
    }
  }

  void checkAndAddToList(dynamic submission) {
    if(_mostRecentSubmissions == null){
      _mostRecentSubmissions = List<dynamic>();
      _mostRecentSubmissions.add(submission);
      print("initialise list");
    }else if(_mostRecentSubmissions.length == 1){
      print("lenght = 1");
      DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ssZ");
      DateTime incomingSubmissionDate = dateFormat.parse(submission.creationDate);
      DateTime oldSubmissionDate = dateFormat.parse(_mostRecentSubmissions[0].creationDate);
      if(oldSubmissionDate.isBefore(incomingSubmissionDate)){
        print("new is more recent");
        var temp = _mostRecentSubmissions[0];
        _mostRecentSubmissions.removeLast();
        _mostRecentSubmissions.add(submission);
        _mostRecentSubmissions.add(temp);
      }else{
        _mostRecentSubmissions.add(submission);
        print("old is more recent");
      }
    }else if(_mostRecentSubmissions.length == 2){
      print("lenght = 2");
      DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ssZ");
      DateTime incomingSubmissionDate = dateFormat.parse(submission.creationDate);
      DateTime oldSubmissionDate = dateFormat.parse(_mostRecentSubmissions[0].creationDate);
      DateTime oldSubmissionDate1 = dateFormat.parse(_mostRecentSubmissions[1].creationDate);

      if(oldSubmissionDate.isBefore(incomingSubmissionDate)){
        print("new is most recent");
        var temp = _mostRecentSubmissions[0];
        _mostRecentSubmissions.removeLast();
        _mostRecentSubmissions.removeLast();
        _mostRecentSubmissions.add(submission);
        _mostRecentSubmissions.add(temp);
      }else{
        if(oldSubmissionDate1.isBefore(incomingSubmissionDate)){
          print("new is 2nd most recent");
          _mostRecentSubmissions.removeLast();
          _mostRecentSubmissions.add(submission);
        }
      }
    }
  }

  String submissionType(submission) {
    if(submission is CodechefSubmission) return "Codechef";
    else if(submission is CodeforcesSubmission) return "Codeforces";
    else if(submission is HackerrankSubmission) return "Hackerrank";
    else return "Spoj";
  }
}
