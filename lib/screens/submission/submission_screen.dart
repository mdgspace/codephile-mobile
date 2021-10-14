import 'dart:core';
import 'package:codephile/models/submission.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/screens/submission/submission_card.dart';
import 'package:codephile/services/submission.dart';
import 'package:flutter/material.dart';
import 'package:codephile/services/user.dart';

class SubmissionScreen extends StatefulWidget {
  final String? token;
  final String? id;
  const SubmissionScreen({Key? key, this.token, this.id}) : super(key: key);

  @override
  _SubmissionScreenState createState() => _SubmissionScreenState();
}

class _SubmissionScreenState extends State<SubmissionScreen> {
  late final String? token, uid;

  List<Submission>? submissionList;
  List<Widget> allSubmission = <Widget>[];
  bool _isLoading = true;
  String? _username;
  String? _picture;
  String? _fullName;

  @override
  void initState() {
    getSubmissionList(token!, uid!, context).then((submissions) {
      submissionList = submissions;

      getUser(token!, uid, context).then((user) {
        _fullName = user!.fullname;
        _username = user.username;
        _picture = user.picture;

        if (submissionList != null) {
          for (int i = 0; i < submissionList!.length; i++) {
            allSubmission.add(SubmissionCard(
              _fullName,
              "@" + _username!,
              submissionType(submissionList![i]),
              submissionList![i].name,
              submissionList![i].createdAt,
              _picture,
            ));
          }
        }

        setState(() {
          _isLoading = false;
        });
      });
    });
    token = widget.token;
    uid = widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_isLoading)
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, position) {
                return allSubmission[position];
              },
              itemCount: allSubmission.length,
            ),
    );
  }

  String getIconUrl(String platform) {
    const String codeChefIcon = "assets/platformIcons/codeChefIcon.png";
    const String hackerRankIcon = "assets/platformIcons/hackerRankIcon.png";
    const String hackerEarthIcon = "assets/platformIcons/hackerEarthIcon.png";
    const String codeForcesIcon = "assets/platformIcons/codeForcesIcon.png";
    const String otherIcon = "assets/platformIcons/otherIcon.jpg";

    switch (platform.toLowerCase()) {
      case "codechef":
        return codeChefIcon;

      case "hackerrank":
        return hackerRankIcon;

      case "hackerearth":
        return hackerEarthIcon;

      case "codeforces":
        return codeForcesIcon;

      default:
        return otherIcon;
    }
  }
}
