import 'dart:core';
import 'package:codephile/models/submission.dart';
import 'package:codephile/screens/submission/submission_card.dart';
import 'package:codephile/services/submission.dart';
import 'package:flutter/material.dart';
import 'package:codephile/services/Id.dart';
import 'package:codephile/services/user.dart';

class Submission extends StatefulWidget {
  final String token;
  final String id;
  Submission({Key key, this.token, this.id}) : super(key: key);

  @override
  _SubmissionState createState() => _SubmissionState(token: token, uid: id);
}

class _SubmissionState extends State<Submission> {

  final String token;
  final String uid;
  String _usernameCodechef;
  String _username;
  String _picture;
  _SubmissionState({Key key, this.token, this.uid});

  List<Codechef> codechef;
  List<Codeforces> codeforces;
  List<Hackerrank> hackerrank;
  List<Spoj> spoj;
  List<Widget> allSubmission = List<Widget>();
  bool _isLoading = true;

  @override
  void initState() {
    submissionList().then((submission){
      codechef = submission.codechef;
      codeforces = submission.codeforces;
      hackerrank = submission.hackerrank;
      spoj = submission.spoj;


      id(token).then((T) async {
        getUser(token, T).then((user){
        _username = user.username;
        print(_username);
        _usernameCodechef = user.handle.codechef;
        _picture = user.picture;
        print(_usernameCodechef);
        print(token);
        print(id);
      });
      });

      for(var i = 0; i < codechef.length; i++){
        codechef[i].status == "AC" ?
        allSubmission.add(SubmissionCard(
            _username != null ? _username : "Vishwajeet",
            _usernameCodechef != null ? _usernameCodechef : "@vishwajeet123",
            "Codechef",
            codechef[i].name,
            codechef[i].time,
            _picture,
        )) : null ;
      }

      for(var i = 0; i < codeforces.length; i++){
        allSubmission.add(SubmissionCard(
          "Vishwajeet",
          "@vishwajeet123",
          "Codefroces",
          codeforces[i].name,
          codeforces[i].time,
          _picture,
        ));
      }

      for(var i = 0; i < hackerrank.length; i++){
        allSubmission.add(SubmissionCard(
          "Vishwajeet",
          "@vishwajeet123",
          "Hackerrank",
          hackerrank[i].name,
          hackerrank[i].time,
          _picture,
        ));
      }

      for(var i = 0; i < spoj.length; i++){
        spoj[i].status == "accepted" ?
        allSubmission.add(SubmissionCard(
          "Vishwajeet",
          "@vishwajeet123",
          "Spoj",
          spoj[i].name,
          spoj[i].time,
          _picture,
        )) : null;
      }

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