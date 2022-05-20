// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/constants/assets.dart';
import '../data/constants/colors.dart';
import '../data/constants/styles.dart';
import '../presentation/components/inputs/text_input.dart';

class PlatformUtil {
  static String getIcon(String platformName) {
    switch (platformName.toLowerCase()) {
      case 'codechef':
        return AppAssets.codechef;
      case 'codeforces':
        return AppAssets.codeforces;
      case 'hackerearth':
        return AppAssets.hackerEarth;
      case 'hackerrank':
        return AppAssets.hackerRank;
      default:
        return AppAssets.otherPlatform;
    }
  }

  static String getName(String platformName) {
    switch (platformName.toLowerCase()) {
      case 'codechef':
        return 'CodeChef';
      case 'codeforces':
        return 'CodeForces';
      case 'hackerearth':
        return 'HackerEarth';
      case 'hackerrank':
        return 'HackerRank';
      default:
        return 'Other';
    }
  }

  static String getLabel(int? value) {
    switch (value) {
      case 0:
        return '2 hours';
      case 1:
        return '3 hours';
      case 2:
        return '5 hours';
      case 3:
        return '1 day';
      case 4:
        return '10 days';
      case 5:
        return '1 month';
      case 6:
        return '∞';
      default:
        return '10 days';
    }
  }

  static String getNamefromUrl(String? url) {
    if (url == null) return '';

    final regExp =
        RegExp('^(?:https?:\/\/)?(?:[^@\/\n]+@)?(?:www\.)?([^:\/?\n]+)');

    final match = regExp.firstMatch(url);

    return match?[1]?.split('.').first ?? '';
  }

  static Widget handleInput({
    required String platformName,
    required String assetPath,
    Function(String)? onChanged,
    TextEditingController? controller,
    String? errorText,
  }) {
    return TextInput(
      hint: '$platformName handle',
      onChanged: onChanged,
      controller: controller,
      errorText: errorText,
      prefix: Container(
        height: 50.r,
        width: 116.r,
        margin: EdgeInsets.only(right: 10.r),
        decoration: const BoxDecoration(
          color: AppColors.transparent,
          border: Border(
            right: BorderSide(color: AppColors.grey1),
          ),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(width: 10.r),
            Image.asset(
              assetPath,
              width: 20.r,
              height: 20.r,
            ),
            SizedBox(width: 10.r),
            Text(
              platformName,
              style: AppStyles.h6.copyWith(
                color: AppColors.grey3,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
      prefixIconConstraints: const BoxConstraints(),
    );
  }
}
