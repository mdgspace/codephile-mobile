import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';
import '../../../utils/graph_util.dart';
import '../bloc/profile_bloc.dart';

class SubmissionDisplay extends StatelessWidget {
  const SubmissionDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final ac = state.submissionStatus?.ac ?? 0;
        final ce = state.submissionStatus?.ce ?? 0;
        final ptl = state.submissionStatus?.ptl ?? 0;
        final re = state.submissionStatus?.re ?? 0;
        final tle = state.submissionStatus?.tle ?? 0;
        final wa = state.submissionStatus?.wa ?? 0;

        final sum = ac + ce + ptl + re + tle + wa;

        final submissionData = [
          SubmissionData('Accepted', ac, 'ac'),
          SubmissionData('Partially Accepted', ptl, 'ptl'),
          SubmissionData('Wrong Answer', wa, 'wa'),
          SubmissionData('Time Limit Exceeded', tle, 'tle'),
          SubmissionData('Runtime Error', re, 're'),
          SubmissionData('Compilation Error', ce, 'ce')
        ];

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: sum == 0
                  ? Container(
                      height: 160.r,
                      width: 160.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.grey3,
                          width: 1.55,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'No Submissions',
                          style: TextStyle(
                            color: AppColors.grey3,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 170.r,
                      width: 170.r,
                      child: charts.PieChart<String>(
                        [
                          charts.Series<SubmissionData, String>(
                            data: submissionData,
                            domainFn: (SubmissionData subData, _) =>
                                subData.submissionType,
                            measureFn: (SubmissionData subData, _) =>
                                subData.percentage(sum),
                            colorFn: (SubmissionData subData, _) =>
                                charts.ColorUtil.fromDartColor(
                                    GraphUtil.getChartColor(subData.key)!),
                            id: 'Submissions',
                            labelAccessorFn: (SubmissionData subData, _) =>
                                '${subData.percentage(sum)}%',
                          ),
                        ],
                        animate: false,
                        defaultRenderer: charts.ArcRendererConfig(
                          arcWidth: (40.r).floor(),
                          arcRendererDecorators: [
                            charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: submissionData.map(
                (data) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 12.r,
                          height: 12.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: GraphUtil.getChartColor(data.key),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          data.submissionType,
                          style: AppStyles.h6.copyWith(
                            color: AppColors.grey3,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            )
          ],
        );
      },
    );
  }
}

class SubmissionData {
  SubmissionData(
    this.submissionType,
    this.value,
    this.key,
  );

  final String submissionType;
  final int value;
  final String key;
}

extension on SubmissionData {
  double percentage(int total) {
    return double.parse((value * 100 / total).toStringAsFixed(1));
  }
}
