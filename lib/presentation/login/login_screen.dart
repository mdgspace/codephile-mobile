import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/constants/styles.dart';
import 'bloc/login_bloc.dart';
import 'widgets/login_widgets.dart';

/// The login screen widget.
class LoginScreen extends StatelessWidget {
  /// The login screen widget.
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(),
      child: DialogAndToastWrapper(
        child: BackgroundDecoration(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: SizedBox(
              height: 1.sh,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login',
                      style: AppStyles.h1,
                    ),
                  ),
                  SizedBox(height: 48.r),
                  const UsernameField(),
                  SizedBox(height: 16.r),
                  const PasswordField(),
                  SizedBox(height: 16.r),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      RememberMeButton(),
                      ForgotPasswordButton(),
                    ],
                  ),
                  SizedBox(height: 64.r),
                  const LoginButton(),
                  SizedBox(height: 16.r),
                  const SignUpRedirectButton(),
                  SizedBox(width: 1.sw, height: 32.r),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
