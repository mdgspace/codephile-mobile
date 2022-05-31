import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/styles.dart';
import '../../../utils/platform_util.dart';
import '../bloc/update_profile_bloc.dart';

class UpdateHandles extends StatelessWidget {
  const UpdateHandles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Handles',
              style: AppStyles.h4.copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 16.r),
            PlatformUtil.handleInput(
              platformName: 'CodeChef',
              assetPath: AppAssets.codechef,
              onChanged: (value) {},
              controller: UpdateProfileBloc.controllers['codechef'],
              errorText: state.errors['codechef'],
            ),
            SizedBox(height: 16.r),
            PlatformUtil.handleInput(
              platformName: 'HackerRank',
              assetPath: AppAssets.hackerRank,
              onChanged: (value) {},
              controller: UpdateProfileBloc.controllers['hackerrank'],
              errorText: state.errors['hackerrank'],
            ),
            SizedBox(height: 16.r),
            PlatformUtil.handleInput(
              platformName: 'CodeForces',
              assetPath: AppAssets.codeforces,
              onChanged: (value) {},
              controller: UpdateProfileBloc.controllers['codeforces'],
              errorText: state.errors['codeforces'],
            ),
            SizedBox(height: 16.r),
            PlatformUtil.handleInput(
              platformName: 'Spoj',
              assetPath: AppAssets.spoj,
              onChanged: (value) {},
              controller: UpdateProfileBloc.controllers['spoj'],
              errorText: state.errors['spoj'],
            ),
            SizedBox(height: 16.r),
            PlatformUtil.handleInput(
              platformName: 'LeetCode',
              assetPath: AppAssets.leetCode,
              onChanged: (value) {},
              controller: UpdateProfileBloc.controllers['leetcode'],
              errorText: state.errors['leetcode'],
            ),
          ],
        );
      },
    );
  }
}
