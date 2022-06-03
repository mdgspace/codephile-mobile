import 'package:flutter/material.dart';

import 'button.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({this.onTap, Key? key}) : super(key: key);
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Button(
      text: 'FOLLOW',
      isFilled: false,
      onTap: onTap,
    );
  }
}
