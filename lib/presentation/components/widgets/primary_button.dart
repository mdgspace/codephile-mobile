import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    this.isLoading = false,
    this.onPressed,
    Key? key,
  }) : super(key: key);
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const ContinuousRectangleBorder(),
        ),
        side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 48.r,
        padding: EdgeInsets.symmetric(horizontal: 40.r),
        child: isLoading
            ? SizedBox(
                width: 20.r,
                height: 20.r,
                child: const CircularProgressIndicator(
                  color: AppColors.white,
                ),
              )
            : Text(
                label,
                style: AppStyles.h6.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
