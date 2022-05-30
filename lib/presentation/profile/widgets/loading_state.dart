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
              color: AppColors.grey10,
            ),
          ),
        ),
        ...List.generate(3, (_) {
          return Padding(
            padding: EdgeInsets.all(8.r),
            child: Container(
              height: 20.r,
              width: 180.r,
              color: AppColors.grey10,
            ),
          );
        }),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.r,
              horizontal: 10.r,
            ),
            child: Container(
              height: 20.r,
              width: 180.r,
              color: AppColors.grey10,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(4, (_) {
            return Padding(
              padding: EdgeInsets.all(10.r),
              child: Container(
                height: 35.r,
                width: 35.r,
                color: AppColors.grey10,
              ),
            );
          }),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.r,
              horizontal: 10.r,
            ),
            child: Container(
              height: 20.r,
              width: 180.r,
              color: AppColors.grey10,
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
                height: 34.r,
                width: 90.r,
                color: AppColors.grey10,
              ),
            );
          }),
        ),
      ],
    );
  }
}
