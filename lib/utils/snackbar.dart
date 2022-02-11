import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../data/constants/colors.dart';
import '../data/constants/styles.dart';

void showSnackBar({required String message}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: AppStyles.h6.copyWith(
          color: AppColors.white,
          fontSize: 16.sp,
        ),
      ),
      backgroundColor: AppColors.grey3,
    ),
  );
}
