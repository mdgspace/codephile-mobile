import 'package:codephile/models/submission_status_data.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/profile/submission_chart_key.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SubmissionStatistics extends StatefulWidget {
  final SubStatusData? _subStats;

  const SubmissionStatistics(this._subStats, {Key? key}) : super(key: key);

  @override
  _SubmissionStatisticsState createState() => _SubmissionStatisticsState();
}

class _SubmissionStatisticsState extends State<SubmissionStatistics> {
  late int ac, ce, ptl, re, tle, wa;
  late String acPercentage,
      cePercentage,
      ptlPercentage,
      rePercentage,
      tlePercentage,
      waPercentage;
  bool allZeroes = false;

  @override
  void initState() {
    initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 36.0, 16.0, 16.0),
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
              height: MediaQuery.of(context).size.width / 1.7,
              width: MediaQuery.of(context).size.width / 1.7,
              child: (allZeroes)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.width / 2.2,
                        width: MediaQuery.of(context).size.width / 2.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: primaryBlackText,
                            width: 1.55,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "No Submissions",
                            style: TextStyle(
                              color: primaryBlackText,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  : charts.PieChart<String>(
                      getPieChartData(),
                      animate: false,
                      defaultRenderer: charts.ArcRendererConfig(
                        arcWidth:
                            (MediaQuery.of(context).size.width / 9).floor(),
                        arcRendererDecorators: [
                          charts.ArcLabelDecorator(
                            labelPosition: charts.ArcLabelPosition.inside,
                          ),
                        ],
                      ),
                    ),
            ),
            const SubmissionChartKey(),
          ],
        ),
      ],
    );
  }

  List<charts.Series<SubmissionData, String>> getPieChartData() {
    var submissionData = [
      SubmissionData("Accepted", acPercentage, subAccepted),
      SubmissionData("Partially Accepted", ptlPercentage, subPartiallySolved),
      SubmissionData("Wrong Answer", waPercentage, subWrongAnswer),
      SubmissionData(
          "Time Limit Exceeded", tlePercentage, subTimeLimitExceeded),
      SubmissionData("Runtime Error", rePercentage, subRuntimeError),
      SubmissionData("Compilation Error", cePercentage, subCompilationError)
    ];
    List<charts.Series<SubmissionData, String>> pieChartData =
        <charts.Series<SubmissionData, String>>[];
    pieChartData.add(
      charts.Series(
        data: submissionData,
        domainFn: (SubmissionData subData, _) => subData.submissionType,
        measureFn: (SubmissionData subData, _) =>
            double.parse(subData.percentage),
        colorFn: (SubmissionData subData, _) =>
            charts.ColorUtil.fromDartColor(subData.color),
        id: "Submissions",
        labelAccessorFn: (SubmissionData subData, _) =>
            "${subData.percentage}%",
      ),
    );
    return pieChartData;
  }

  void initValues() {
    if (widget._subStats == null) {
      ac = 0;
      ce = 0;
      ptl = 0;
      re = 0;
      tle = 0;
      wa = 0;
      allZeroes = true;
    } else {
      ac = widget._subStats!.ac as int;
      ce = widget._subStats!.ce as int;
      ptl = widget._subStats!.ptl as int;
      re = widget._subStats!.re as int;
      tle = widget._subStats!.tle as int;
      wa = widget._subStats!.wa as int;
      if ((ac == 0) &&
          (ce == 0) &&
          (ptl == 0) &&
          (re == 0) &&
          (tle == 0) &&
          (wa == 0)) {
        allZeroes = true;
      } else {
        int sum = ac + ce + ptl + re + tle + wa;
        acPercentage = (ac * 100 / sum).toStringAsFixed(1);
        cePercentage = (ce * 100 / sum).toStringAsFixed(1);
        ptlPercentage = (ptl * 100 / sum).toStringAsFixed(1);
        rePercentage = (re * 100 / sum).toStringAsFixed(1);
        tlePercentage = (tle * 100 / sum).toStringAsFixed(1);
        waPercentage = (wa * 100 / sum).toStringAsFixed(1);
      }
    }
  }
}

class SubmissionData {
  String submissionType;
  String percentage;
  Color color;
  SubmissionData(this.submissionType, this.percentage, this.color);
}
