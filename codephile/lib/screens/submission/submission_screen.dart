import 'dart:core';
import 'package:codephile/models/submission.dart';
import 'package:codephile/screens/submission/submission_card.dart';
import 'package:codephile/services/submission.dart';
import 'package:flutter/material.dart';

class Submission extends StatefulWidget {
  Submission({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SubmissionState createState() => _SubmissionState();
}

class _SubmissionState extends State<Submission> {

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

      for(var i = 0; i < codechef.length; i++){
        allSubmission.add(SubmissionCard(
            "Vishwajeet",
            "@vishwajeet123",
            "Codechef",
            codechef[i].name,
            codechef[i].time,
        ));
      }

      for(var i = 0; i < codeforces.length; i++){
        allSubmission.add(SubmissionCard(
          "Vishwajeet",
          "@vishwajeet123",
          "Codechef",
          codeforces[i].name,
          codeforces[i].time,
        ));
      }

      for(var i = 0; i < hackerrank.length; i++){
        allSubmission.add(SubmissionCard(
          "Vishwajeet",
          "@vishwajeet123",
          "Codechef",
          hackerrank[i].name,
          hackerrank[i].time,
        ));
      }

      for(var i = 0; i < spoj.length; i++){
        allSubmission.add(SubmissionCard(
          "Vishwajeet",
          "@vishwajeet123",
          "Codechef",
          spoj[i].name,
          spoj[i].time,
        ));
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
}