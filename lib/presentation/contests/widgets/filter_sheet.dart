import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';
import '../../../utils/contest_util.dart';
import '../bloc/contests_bloc.dart';

class FilterSheet extends StatelessWidget {
  FilterSheet({required this.bloc, Key? key}) : super(key: key);
  final ContestsBloc bloc;

  final List<String> platfromIcons = [
    AppAssets.codechef,
    AppAssets.codeforces,
    AppAssets.hackerEarth,
    AppAssets.hackerRank,
    AppAssets.otherPlatform,
  ];

  Widget _buildPlatfromIcon(String icon, VoidCallback callback, bool isActive) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, top: 10.h, bottom: 20.h),
      child: InkWell(
        onTap: callback,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: isActive ? 1.0 : 0.2,
          child: Card(
            elevation: isActive ? 10.0 : 1.0,
            color: Colors.white,
            child: Image.asset(
              icon,
              height: 50.r,
              width: 50.r,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContestsBloc>.value(
      value: bloc,
      child: BlocBuilder<ContestsBloc, ContestsState>(
        builder: (context, state) {
          return Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: AppColors.grey7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15.r),
                        child: Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 22.sp,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<ContestsBloc>().saveFilter();
                          Get.back(result: true);
                        },
                        child: Text(
                          'Apply',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, top: 10.h),
                  child: Text(
                    'Platforms',
                    style: AppStyles.h6.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      platfromIcons.length,
                      (index) {
                        return _buildPlatfromIcon(
                          platfromIcons[index],
                          () {
                            final updatedPlatform = state.filter!.platform;
                            updatedPlatform[index] = !updatedPlatform[index];
                            context.read<ContestsBloc>().add(
                                  UpdateFilter(
                                    updatedFilter: state.filter!.copyWith(
                                      platform: updatedPlatform,
                                    ),
                                  ),
                                );
                          },
                          state.filter!.platform[index],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Max. Duration',
                        style: AppStyles.h6.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          ContestUtil.getLabel(state.filter!.duration),
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Slider(
                  activeColor: AppColors.primary,
                  inactiveColor: AppColors.grey8,
                  max: 6,
                  divisions: 6,
                  value: state.duration!.toDouble(),
                  label: ContestUtil.getLabel(state.duration),
                  onChanged: (_value) {
                    context
                        .read<ContestsBloc>()
                        .add(UpdateFilter(duration: _value.toInt()));
                  },
                  onChangeEnd: (_value) {
                    context.read<ContestsBloc>().add(
                          UpdateFilter(
                            duration: _value.toInt(),
                            updatedFilter: state.filter!.copyWith(
                              duration: _value.toInt(),
                            ),
                          ),
                        );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text(
                    'Start Date',
                    style: AppStyles.h6.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final ongoing = state.filter!.ongoing!;
                    context.read<ContestsBloc>().add(UpdateFilter(
                            updatedFilter: state.filter!.copyWith(
                          ongoing: !ongoing,
                        )));
                  },
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 15, 10),
                        child: SvgPicture.asset(
                          state.filter!.ongoing!
                              ? AppAssets.trueRadioButton
                              : AppAssets.falseRadioButton,
                          height: 28,
                          width: 28,
                        ),
                      ),
                      const Text(
                        'Ongoing',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final upcoming = state.filter!.upcoming!;
                    context.read<ContestsBloc>().add(UpdateFilter(
                            updatedFilter: state.filter!.copyWith(
                          upcoming: !upcoming,
                          startDate: !upcoming ? DateTime.now() : null,
                        )));
                  },
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 15, 10),
                        child: SvgPicture.asset(
                          state.filter!.upcoming!
                              ? AppAssets.trueRadioButton
                              : AppAssets.falseRadioButton,
                          height: 28,
                          width: 28,
                        ),
                      ),
                      const Text(
                        'Upcoming',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          showDatePicker(
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme:
                                      const ColorScheme.light().copyWith(
                                    primary: AppColors.primary,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2025),
                          ).then((val) {
                            context.read<ContestsBloc>().add(UpdateFilter(
                                  updatedFilter: state.filter!.copyWith(
                                    upcoming: true,
                                    startDate: val ??= DateTime.now(),
                                  ),
                                ));
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            (state.filter!.startDate != null)
                                ? DateFormat('d MMMM, yyyy')
                                    .format(state.filter!.startDate!)
                                : 'Select Date',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
