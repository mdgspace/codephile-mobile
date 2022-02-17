import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/styles.dart';
import '../../../domain/models/contest.dart';
import '../../../utils/contest_util.dart';

class ContestCard extends StatelessWidget {
  const ContestCard({
    this.upcoming,
    this.ongoing,
    Key? key,
  })  : assert(upcoming != null || ongoing != null, ''),
        super(key: key);
  final Upcoming? upcoming;
  final Ongoing? ongoing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssets.bell),
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
