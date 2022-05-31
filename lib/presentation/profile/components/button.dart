import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/colors.dart';

/// [Button] is the model for the Follow and Following Buttons
class Button extends StatelessWidget {
  const Button({
    required this.text,
    required this.isFilled,
    this.showTrailingButton = false,
    this.trailing,
    this.onTap,
    Key? key,
  })  : assert(!(showTrailingButton ^ (trailing != null)), ''),
        super(key: key);
  final String text;
  final bool isFilled;
  final bool showTrailingButton;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 6.r,
          vertical: 5.r,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isFilled ? AppColors.primary : AppColors.white,
            border: Border.all(
              color: AppColors.primary,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(2.r),
            ),
          ),
          padding: EdgeInsets.all(8.r),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: text,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: isFilled ? AppColors.white : AppColors.primary,
                  ),
                ),
                if (showTrailingButton)
                  WidgetSpan(
                    child: trailing!,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
