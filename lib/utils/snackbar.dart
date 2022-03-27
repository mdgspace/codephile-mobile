import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../data/constants/colors.dart';
import '../data/constants/styles.dart';

Future<SnackBarClosedReason> showSnackBar({
  required String message,
  String? actionTitle,
  Function()? action,
}) {
  return ScaffoldMessenger.of(Get.context!)
      .showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppStyles.h6.copyWith(
              color: AppColors.white,
              fontSize: 16.sp,
            ),
          ),
          backgroundColor: AppColors.grey3,
          action: action != null && actionTitle != null
              ? SnackBarAction(
                  label: actionTitle,
                  onPressed: action,
                  textColor: AppColors.white,
                )
              : null,
        ),
      )
      .closed;
}
