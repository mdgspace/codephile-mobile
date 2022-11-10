import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';
import '../../../utils/date_utils.dart' as util;
import '../bloc/profile_bloc.dart';

class AcceptanceGraph extends StatelessWidget {
  const AcceptanceGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) {
        return (previous.currentYear != current.currentYear) ||
            (previous.currentTriplet != current.currentTriplet) ||
            (previous.user != current.user);
      },
      builder: (context, state) {
        final bloc = context.read<ProfileBloc>();
        var day = 0;

        final firstWeekDay = util.DateUtils.fistDayofMonth(
            state.currentTriplet! * 3 + 1, state.currentYear!);

        final totalDays = util.DateUtils.totalDayInTriplet(
            state.currentTriplet!, state.currentYear!);

        final weeks = (totalDays - firstWeekDay + 7) ~/ 7 - 1;

        final lastWeekDays = totalDays - 7 * weeks - (7 - firstWeekDay);

        return Column(
          children: [
            // Section Heading
            Padding(
              padding: EdgeInsets.only(
                left: 16.r,
                top: 24.r,
                bottom: 10.r,
              ),
              child: Row(
                children: [
                  Text(
                    'Acceptance Graph',
                    style: AppStyles.h1.copyWith(fontSize: 15.sp),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      context
                          .read<ProfileBloc>()
                          .add(const UpdateYear(increment: false));
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      size: 24.r,
                      color: AppColors.grey1,
                    ),
                  ),
                  Text(
                    '${state.currentYear}',
                    style: AppStyles.h4.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      bloc.add(const UpdateYear(increment: true));
                    },
                    icon: Icon(
                      Icons.chevron_right,
                      size: 24.r,
                      color: AppColors.grey1,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    bloc.add(const UpdateMonth(increment: false));
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    size: 24.r,
                    color: AppColors.grey1,
                  ),
                ),
                ...ProfileBloc.monthTriplet(state.currentTriplet!).map(
                  (month) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.r),
                      child: Text(
                        month,
                        style: AppStyles.h6,
                      ),
                    );
                  },
                ).toList(),
                IconButton(
                  onPressed: () {
                    bloc.add(const UpdateMonth(increment: true));
                  },
                  icon: Icon(
                    Icons.chevron_right,
                    size: 24.r,
                    color: AppColors.grey1,
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 10.r),
                  Column(
                    children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map(
                      (week) {
                        return Padding(
                          padding: EdgeInsets.all(3.r),
                          child: Text(
                            week,
                            style: AppStyles.h6,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  SizedBox(width: 10.r),
                  // Generate First Week
                  Column(
                    children: [
                      ...List.generate(firstWeekDay, (_) {
                        return Container(
                          width: 20.r,
                          height: 20.r,
                          margin: EdgeInsets.all(2.r),
                        );
                      }),
                      ...List.generate(7 - firstWeekDay, (_) {
                        day++;
                        return Container(
                          width: 20.r,
                          height: 20.r,
                          margin: EdgeInsets.all(2.r),
                          color: bloc.getCellColor(util.DateUtils.getDateTime(
                              day, state.currentTriplet!, state.currentYear!)),
                        );
                      }),
                    ],
                  ),
                  ...List.generate(
                    weeks,
                    (index) {
                      return Column(
                        children: List.generate(7, (_) {
                          day++;
                          return Container(
                            width: 20.r,
                            height: 20.r,
                            margin: EdgeInsets.all(2.r),
                            color: bloc.getCellColor(util.DateUtils.getDateTime(
                                day,
                                state.currentTriplet!,
                                state.currentYear!)),
                          );
                        }),
                      );
                    },
                  ),
                  // Generate Last Week
                  if (lastWeekDays > 0)
                    Column(
                      children: [
                        ...List.generate(lastWeekDays, (_) {
                          day++;
                          util.DateUtils.getDateTime(
                              day, state.currentTriplet!, state.currentYear!);
                          return Container(
                            width: 20.r,
                            height: 20.r,
                            margin: EdgeInsets.all(2.r),
                            color: bloc.getCellColor(util.DateUtils.getDateTime(
                                day,
                                state.currentTriplet!,
                                state.currentYear!)),
                          );
                        }),
                        ...List.generate(7 - lastWeekDays, (_) {
                          return Container(
                            width: 20.r,
                            height: 20.r,
                            margin: EdgeInsets.all(2.r),
                          );
                        }),
                      ],
                    ),

                  SizedBox(width: 10.r),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('-5', style: AppStyles.h6.copyWith(fontSize: 12.sp)),
                  SizedBox(width: 50.r),
                  Text('0', style: AppStyles.h6.copyWith(fontSize: 12.sp)),
                  SizedBox(width: 55.r),
                  Text('5', style: AppStyles.h6.copyWith(fontSize: 12.sp)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.r, 5.r, 20.r, 20.r),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 130.r,
                  height: 10.r,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red, Colors.white, Colors.green],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
