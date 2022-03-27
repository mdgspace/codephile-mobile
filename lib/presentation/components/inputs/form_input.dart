import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';
import 'text_input.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    required this.hint,
    required this.title,
    this.action = TextInputAction.next,
    this.controller,
    this.enabled = true,
    this.errorText,
    this.initialValue = '',
    this.keyboard,
    this.maxLines = 1,
    this.obscureText = false,
    this.onChanged,
    this.prefix,
    Key? key,
  })  : assert(
          controller != null || onChanged != null,
          'Both controller and onChanged cannot be null',
        ),
        super(key: key);

  final bool enabled;
  final bool obscureText;
  final int maxLines;
  final String initialValue;
  final String hint;
  final String title;
  final String? errorText;
  final Function(String)? onChanged;
  final TextInputAction action;
  final TextInputType? keyboard;
  final TextEditingController? controller;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: enabled
              ? AppStyles.h4.copyWith(fontWeight: FontWeight.w900)
              : AppStyles.h4.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.grey1,
                ),
        ),
        SizedBox(height: 8.r),
        TextInput(
          obscureText: obscureText,
          maxLines: maxLines,
          initialValue: initialValue,
          hint: hint,
          onChanged: enabled ? onChanged : (_) {},
          action: action,
          keyboard: keyboard,
          controller: enabled ? controller : null,
          prefix: prefix,
          errorText: errorText,
        ),
      ],
    );
  }
}
