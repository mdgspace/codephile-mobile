import 'dart:core';
import 'package:codephile/models/submission.dart';
import 'package:codephile/screens/submission/submission_card.dart';
import 'package:codephile/services/submission.dart';
import 'package:flutter/material.dart';
import 'package:codephile/services/user.dart';

class SubmissionScreen extends StatefulWidget {
  final String token;
  final String id;
  SubmissionScreen({Key key, this.token, this.id}) : super(key: key);

  @override
  _SubmissionScreenState createState() => _SubmissionScreenState(token: token, uid: id);
}

class _SubmissionScreenState extends State<SubmissionScreen> {

  final String token;
  final String uid;

  _SubmissionScreenState({Key key, this.token, this.uid});

  List<CodechefSubmission> codechef;
  List<CodeforcesSubmission> codeforces;
  List<HackerrankSubmission> hackerrank;
  List<SpojSubmission> spoj;
  List<Widget> allSubmission = List<Widget>();
  bool _isLoading = true;
  String _usernameCodechef;
  String _username;
  String _picture;
  String _usernameSpoj;
  String _usernameHackerrank;
  String _usernameCodeforces;

  @override
  void initState() {

    getSubmissionList(token, uid).then((submission){
      codechef = submission.codechef;
      codeforces = submission.codeforces;
      hackerrank = submission.hackerrank;
      spoj = submission.spoj;

      getUser(token, uid).then((user){
        _username = user.username;
        _usernameCodechef = user.handle.codechef;
        _usernameSpoj = user.handle.spoj;
        _usernameHackerrank = user.handle.hackerrank;
        _usernameCodeforces = user.handle.codeforces;
        _picture = user.picture;


      for(var i = 0; i < codechef.length; i++){
        codechef[i].status == "AC" && codechef != []?
        allSubmission.add(SubmissionCard(
            _username,
            "@" +_usernameCodechef,
            "Codechef",
            codechef[i].name,
            codechef[i].creationDate,
            _picture,
        )) : null ;
      }

      for(var i = 0; i < codeforces.length; i++){
        codeforces[i].status == "AC" && codeforces != []?
        allSubmission.add(SubmissionCard(
          _username,
          "@" + _usernameCodeforces,
          "Codefroces",
          codeforces[i].name,
          codeforces[i].creationDate,
          _picture,
        )): null;
      }

      for(var i = 0; i < hackerrank.length; i++){
//        hackerrank[i].status == "AC" && hackerrank != [] ?
        allSubmission.add(SubmissionCard(
          _username,
          "@" + _usernameHackerrank,
          "Hackerrank",
          hackerrank[i].name,
          hackerrank[i].creationDate,
          _picture,
        ));
      }

      for(var i = 0; i < spoj.length; i++){
        spoj[i].status == "accepted" && spoj != [] ?
        allSubmission.add(SubmissionCard(
          _username,
          "@" + _usernameSpoj,
          "Spoj",
          spoj[i].name,
          spoj[i].creationDate,
          _picture,
        )) : null;
      }

      setState(() {
        _isLoading = false;
      });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: (_isLoading)?
      Center(
          child: CircularProgressIndicator()
      )
          :
      ListView.builder(
        itemBuilder: (context, position){
          return allSubmission[position];
        },
        itemCount: allSubmission.length,
      ),
    );
  }

  String getIconUrl(String platform){
    final String codeChefIcon =
        "assets/platformIcons/codeChefIcon.png";
    final String hackerRankIcon =
        "assets/platformIcons/hackerRankIcon.png";
    final String hackerEarthIcon =
        "assets/platformIcons/hackerEarthIcon.png";
    final String codeForcesIcon =
        "assets/platformIcons/codeForcesIcon.png";
    final String otherIcon =
        "assets/platformIcons/otherIcon.jpg";

    switch(platform.toLowerCase()){
      case "codechef" :
        return codeChefIcon;
        break;
      case "hackerrank":
        return hackerRankIcon;
        break;
      case "hackerearth":
        return hackerEarthIcon;
        break;
      case "codeforces":
        return codeForcesIcon;
        break;
      default:
        return otherIcon;
    }
  }

  String getTime(String time){

  }
}