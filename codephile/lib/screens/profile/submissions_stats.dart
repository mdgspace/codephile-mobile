import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/profile/submission_chart_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as Charts;

class SubmissionStatistics extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Status of total submissions",
            style: TextStyle(
              color: primaryBlackText,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width/1.7,
              width: MediaQuery.of(context).size.width/1.7,
              child: Charts.PieChart(
                getPieChartData(),
                animate: false,
                defaultRenderer: new Charts.ArcRendererConfig(
                  arcWidth: (MediaQuery.of(context).size.width/9).floor(),
                  arcRendererDecorators: [
                    Charts.ArcLabelDecorator(
                      labelPosition: Charts.ArcLabelPosition.inside
                    )
                  ]
                ),
              ),
            ),
            SubmissionChartKey(),
          ],
        ),
      ],
    );
  }

  List<Charts.Series<SubmissionData, String>> getPieChartData(){
    var submissionData = [
      SubmissionData("Accepted", 27.5, subAccepted),
      SubmissionData("Partially Accepted", 24.6, subPartiallySolved),
      SubmissionData("Wrong Answer", 31.2, subWrongAnswer),
      SubmissionData("Time Limit Exceeded", 8.8, subTimeLimitExceeded),
      SubmissionData("Runtime Error", 5.6, subRuntimeError),
      SubmissionData("Compilation Error", 2.4, subCompilationError)
    ];
    List<Charts.Series<SubmissionData, String>> pieChartData = List<Charts.Series<SubmissionData, String>>();
    pieChartData.add(
      Charts.Series(
        data: submissionData,
        domainFn: (SubmissionData subData, _) => subData.submissionType,
        measureFn: (SubmissionData subData, _) => subData.percentage,
        colorFn: (SubmissionData subData, _) => Charts.ColorUtil.fromDartColor(subData.color),
        id: "Submissions",
        labelAccessorFn: (SubmissionData subData, _) => "${subData.percentage}%",
      ),
    );
    return pieChartData;
  }
}

class SubmissionData{
  String submissionType;
  double percentage;
  Color color;
  SubmissionData(this.submissionType, this.percentage, this.color);
}
