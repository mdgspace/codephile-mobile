import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';
import '../bloc/profile_bloc.dart';

class QuestionSolved extends StatelessWidget {
  const QuestionSolved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(16.r),
          child: Table(
            border: TableBorder.symmetric(
              outside: const BorderSide(
                color: AppColors.lightBlue,
              ),
            ),
            defaultColumnWidth: FixedColumnWidth(90.r),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  color: AppColors.lightBlue,
                ),
                children:
                    ['CodeChef', 'CodeForces', 'Spoj', 'HackerRank'].map((key) {
                  return TableCell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.r),
                      child: Text(
                        key,
                        style: AppStyles.h6.copyWith(
                          color: AppColors.grey3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.r),
                      child: Text(
                        state.user?.solvedProblemsCount?.codechef.toString() ??
                            '0',
                        style: AppStyles.h6.copyWith(
                          color: AppColors.grey3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.r),
                      child: Text(
                        state.user?.solvedProblemsCount?.codeforces
                                .toString() ??
                            '0',
                        style: AppStyles.h6.copyWith(
                          color: AppColors.grey3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.r),
                      child: Text(
                        state.user?.solvedProblemsCount?.hackerrank
                                .toString() ??
                            '0',
                        style: AppStyles.h6.copyWith(color: AppColors.grey3),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.r),
                      child: Text(
                        state.user?.solvedProblemsCount?.spoj.toString() ?? '0',
                        style: AppStyles.h6.copyWith(color: AppColors.grey3),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
