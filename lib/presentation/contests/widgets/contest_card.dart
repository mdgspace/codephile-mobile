import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:intl/intl.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';
import '../../../data/services/remote/notification_service.dart';
import '../../../domain/models/contest.dart';
import '../../../utils/contest_util.dart';
import '../bloc/contests_bloc.dart';

class ContestCard extends StatelessWidget {
  ContestCard({
    required this.isReminderSet,
    this.upcoming,
    this.ongoing,
    Key? key,
  })  : assert(upcoming != null || ongoing != null, ''),
        super(key: key) {
    _notifier = ValueNotifier(isReminderSet);
  }
  final Upcoming? upcoming;
  final Ongoing? ongoing;
  final bool isReminderSet;
  late final ValueNotifier<bool> _notifier;
  final ValueNotifier<int> _remindNotifer = ValueNotifier(2);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FlutterWebBrowser.openWebPage(
          url: upcoming?.url ?? ongoing!.url,
          customTabsOptions: const CustomTabsOptions(
            defaultColorSchemeParams: CustomTabsColorSchemeParams(
              toolbarColor: AppColors.primary,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(15.r),
              child: Container(
                width: 24.r,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image.asset(
                  upcoming != null ? upcoming!.icon : ongoing!.icon,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${upcoming != null ? upcoming!.platformName : ongoing!.platformName} hosted a contest',
                    style: AppStyles.h6,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Text(
                      upcoming != null ? upcoming!.name : ongoing!.name,
                      style: AppStyles.h4.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      SvgPicture.asset(
                        AppAssets.clock,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        upcoming != null ? upcoming!.time : ongoing!.time,
                        style: AppStyles.h6,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _notifier,
              builder: (context, value, _) {
                return IconButton(
                  onPressed: () {
                    final _bloc = context.read<ContestsBloc>();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          titlePadding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(5.r),
                            ),
                          ),
                          title: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: AppColors.grey7,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(5.r),
                              ),
                            ),
                            child: Text(
                              'Set Reminder',
                              style: AppStyles.h6.copyWith(
                                color: AppColors.primaryBlack,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          content: Visibility(
                            visible: upcoming != null,
                            replacement: Padding(
                              padding: EdgeInsets.all(30.r),
                              child: const Text(
                                'The selected contest has already started. 😔 ',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            child: SizedBox(
                              height: 120.h,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 30.w,
                                      vertical: 10.h,
                                    ),
                                    child: Text(
                                      'You will be reminded before the contest starts. Set the timer',
                                      style: AppStyles.h6.copyWith(
                                        color: AppColors.primaryBlack,
                                        fontSize: 12.sp,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ValueListenableBuilder<int>(
                                        valueListenable: _remindNotifer,
                                        builder: (context, value, _) {
                                          return SizedBox(
                                            height: 60.h,
                                            width: 30.w,
                                            child: ListWheelScrollView(
                                              controller:
                                                  FixedExtentScrollController(
                                                initialItem: value,
                                              ),
                                              itemExtent: 25,
                                              useMagnifier: true,
                                              magnification: 1.3,
                                              onSelectedItemChanged: (val) {
                                                _remindNotifer.value = val;
                                              },
                                              children: List.generate(
                                                6,
                                                (index) {
                                                  return Text(
                                                    '${5 * (index + 1)}',
                                                    style:
                                                        AppStyles.h6.copyWith(
                                                      color: index == value
                                                          ? AppColors.primary
                                                          : AppColors
                                                              .primaryBlack,
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        'minutes',
                                        style: AppStyles.h6.copyWith(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            if (upcoming != null)
                              TextButton(
                                onPressed: () {
                                  _notifier.value = false;
                                  _bloc.pendingNotification
                                      .remove(upcoming!.name);

                                  NotificationService.cancelNotification(
                                      name: upcoming!.name);

                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40.w,
                                    vertical: 10.h,
                                  ),
                                  color: AppColors.grey10,
                                  child: Text(
                                    'Cancel',
                                    style: AppStyles.h6.copyWith(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            TextButton(
                              onPressed: () {
                                if (upcoming != null) {
                                  _notifier.value = true;
                                  if (!_bloc.pendingNotification
                                      .contains(upcoming!.name)) {
                                    _bloc.pendingNotification
                                        .add(upcoming!.name);
                                  }
                                  NotificationService.setNotification(
                                    scheduledDate: upcoming!.startTime.subtract(
                                      Duration(
                                        minutes: (_remindNotifer.value + 1) * 6,
                                      ),
                                    ),
                                    title: upcoming!.name,
                                    body: 'Contest Starts at '
                                        '${DateFormat('hh:mm a dd, MMMM yyyy').format(upcoming!.startTime)}',
                                  );
                                }

                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40.w,
                                  vertical: 10.h,
                                ),
                                color: AppColors.primary,
                                child: Text(
                                  'Okay',
                                  style: AppStyles.h6.copyWith(
                                    color: AppColors.white,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: SvgPicture.asset(
                    value ? AppAssets.selectedBell : AppAssets.bell,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension on Ongoing {
  String get platformName => ContestUtil.getPlatformName(platform);
  String get icon => ContestUtil.getPlatformIcon(platform);
  String get time =>
      'Ends on ${DateFormat('dd, MMMM yyyy hh:mm a').format(endTime)}';
}

extension on Upcoming {
  String get platformName => ContestUtil.getPlatformName(platform);
  String get icon => ContestUtil.getPlatformIcon(platform);
  String get time =>
      'Starts on ${DateFormat('dd, MMMM yyyy hh:mm a').format(startTime)}';
}
