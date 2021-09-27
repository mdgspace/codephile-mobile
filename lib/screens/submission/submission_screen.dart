import 'dart:core';
import 'package:codephile/models/submission.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/screens/submission/submission_card.dart';
import 'package:codephile/services/submission.dart';
import 'package:flutter/material.dart';
import 'package:codephile/services/user.dart';

class SubmissionScreen extends StatefulWidget {
  final String token;
  final String id;
  SubmissionScreen({Key key, this.token, this.id}) : super(key: key);

  @override
  _SubmissionScreenState createState() =>
      _SubmissionScreenState(token: token, uid: id);
}

class _SubmissionScreenState extends State<SubmissionScreen> {
  final String token;
  final String uid;

  _SubmissionScreenState({Key key, this.token, this.uid});

  List<Submission> submissionList;
  List<Widget> allSubmission = <Widget>[];
  bool _isLoading = true;
  String _username;
  String _picture;
  String _fullName;

  @override
  void initState() {
    getSubmissionList(token, uid, context).then((submissions) {
      submissionList = submissions;

      getUser(token, uid, context).then((user) {
        _fullName = user.fullname;
        _username = user.username;
        _picture = user.picture;

        if (submissionList != null) {
          for (int i = 0; i < submissionList.length; i++) {
            allSubmission.add(SubmissionCard(
              _fullName,
              "@" + _username,
              submissionType(submissionList[i]),
              submissionList[i].name,
              submissionList[i].createdAt,
              _picture,
            ));
          }
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
      body: (_isLoading)
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, position) {
                return allSubmission[position];
              },
              itemCount: allSubmission.length,
            ),
    );
  }

  String getIconUrl(String platform) {
    final String codeChefIcon = "assets/platformIcons/codeChefIcon.png";
    final String hackerRankIcon = "assets/platformIcons/hackerRankIcon.png";
    final String hackerEarthIcon = "assets/platformIcons/hackerEarthIcon.png";
    final String codeForcesIcon = "assets/platformIcons/codeForcesIcon.png";
    final String otherIcon = "assets/platformIcons/otherIcon.jpg";

    switch (platform.toLowerCase()) {
      case "codechef":
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
}
