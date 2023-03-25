import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppStyles {
  static final TextStyle h1 = TextStyle(
    color: AppColors.grey3,
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle h2 = TextStyle(
    color: AppColors.white,
    fontSize: 24.sp,
    fontWeight: FontWeight.w900,
  );
  static final TextStyle h4 = TextStyle(
    color: AppColors.grey3,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle h5 = TextStyle(
    color: AppColors.white.withOpacity(0.85),
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle h6 = TextStyle(
    color: AppColors.grey1,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static final ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      background: AppColors.white,
      onBackground: AppColors.grey3,
      surface: AppColors.white,
      onSurface: AppColors.grey3,
      secondary: AppColors.primaryAccent,
    ),
    textTheme: TextTheme(
      displayLarge: h1,
      displayMedium: h2,
      headlineMedium: h4,
      headlineSmall: h5,
      titleLarge: h6,
    ),
    scaffoldBackgroundColor: AppColors.white,
  );
}
