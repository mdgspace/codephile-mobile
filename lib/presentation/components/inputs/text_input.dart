import 'package:flutter/material.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';

/// App-wide common customization of [TextFormField].
class TextInput extends StatelessWidget {
  /// App-wide common customization of [TextFormField].
  const TextInput({
    required this.hint,
    this.action = TextInputAction.next,
    this.controller,
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

  final bool obscureText;
  final int maxLines;
  final String initialValue;
  final String hint;
  final Function(String)? onChanged;
  final TextInputAction action;
  final TextInputType? keyboard;
  final TextEditingController? controller;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppStyles.h6,
        prefixIcon: prefix,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
      initialValue: controller == null ? initialValue : null,
      keyboardType: keyboard,
      maxLines: maxLines,
      obscureText: obscureText,
      onChanged: onChanged,
      style: AppStyles.h6.copyWith(color: AppColors.grey3),
      textInputAction: action,
    );
  }
}
