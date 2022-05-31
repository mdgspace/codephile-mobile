import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/colors.dart';
import 'button.dart';

class FollowingButton extends StatelessWidget {
  const FollowingButton({this.onTap, Key? key}) : super(key: key);
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Button(
      text: 'FOLLOWING',
      isFilled: true,
      onTap: onTap,
      showTrailingButton: true,
      trailing: Icon(
        Icons.check,
        size: 16.r,
        color: AppColors.white,
      ),
    );
  }
}
