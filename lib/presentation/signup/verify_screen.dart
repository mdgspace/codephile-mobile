import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/constants/colors.dart';
import '../../data/constants/strings.dart';
import '../../data/constants/styles.dart';
import 'widgets/signup_widgets.dart';

/// The verify screen widget.
class VerifyScreen extends StatelessWidget {
  /// The verify screen widget.
  VerifyScreen(
    Map<String, dynamic> arguments, {
    Key? key,
  }) : super(key: key) {
    username = arguments['username'] as String;
    password = arguments['password'] as String;
    userId = arguments['userId'] as String;
    profilePicture = arguments['profilePicture'] as File?;
  }

  late final String username;
  late final String password;
  late final String userId;
  late final File? profilePicture;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            children: <Widget>[
              const Spacer(flex: 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hooray!',
                  style: AppStyles.h1,
                ),
              ),
              const Spacer(),
              Text(
                AppStrings.signUpSuccess,
                style: AppStyles.h5.copyWith(color: AppColors.grey3),
              ),
              const Spacer(flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  resendEmailButton(userId),
                  loginButton(username, password, profilePicture),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
