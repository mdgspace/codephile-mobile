import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/styles.dart';
import '../../../utils/platform_util.dart';

class UpdateHandles extends StatelessWidget {
  const UpdateHandles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Update Handles',
          style: AppStyles.h4.copyWith(fontSize: 16.sp),
        ),
        SizedBox(height: 16.h),
        PlatformUtil.handleInput(
          platformName: 'CodeChef',
          assetPath: AppAssets.codechef,
          onChanged: (value) {},
        ),
        SizedBox(height: 16.h),
        PlatformUtil.handleInput(
          platformName: 'HackerRank',
          assetPath: AppAssets.hackerRank,
          onChanged: (value) {},
        ),
        SizedBox(height: 16.h),
        PlatformUtil.handleInput(
          platformName: 'CodeForces',
          assetPath: AppAssets.codeforces,
          onChanged: (value) {},
        ),
        SizedBox(height: 16.h),
        PlatformUtil.handleInput(
          platformName: 'Spoj',
          assetPath: AppAssets.spoj,
          onChanged: (value) {},
        ),
        SizedBox(height: 16.h),
        PlatformUtil.handleInput(
          platformName: 'LeetCode',
          assetPath: AppAssets.leetCode,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
