import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/colors.dart';

class ProfileLoadingState extends StatelessWidget {
  const ProfileLoadingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.r),
        Padding(
          padding: EdgeInsets.all(8.r),
          child: Container(
            height: 72.r,
            width: 72.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white1,
            ),
          ),
        ),
        ...List.generate(3, (_) {
          return Padding(
            padding: EdgeInsets.all(8.r),
            child: Container(
              height: 20.h,
              width: 180.w,
              color: AppColors.white1,
            ),
          );
        }),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 10.w,
            ),
            child: Container(
              height: 20.h,
              width: 180.w,
              color: AppColors.white1,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(4, (_) {
            return Padding(
              padding: EdgeInsets.all(10.r),
              child: Container(
                height: 35.h,
                width: 35.w,
                color: AppColors.white1,
              ),
            );
          }),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 10.w,
            ),
            child: Container(
              height: 20.h,
              width: 180.w,
              color: AppColors.white1,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(3, (_) {
            return Padding(
              padding: EdgeInsets.all(8.r),
              child: Container(
                height: 34.h,
                width: 90.w,
                color: AppColors.white1,
              ),
            );
          }),
        ),
      ],
    );
  }
}
