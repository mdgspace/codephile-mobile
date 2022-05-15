import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/sign_up_bloc.dart';
import 'widgets/signup_widgets.dart';

/// The sign-up screen widget.
class SignUpScreen extends StatelessWidget {
  /// The sign-up screen widget.
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (_) => SignUpBloc()..add(const Initialize()),
      child: SnackBarWrapper(
        child: ScrollAndNavWrapper(
          child: BlocSelector<SignUpBloc, SignUpState, int>(
            selector: (state) => state.pageIndex,
            builder: (context, pageIndex) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const PopButton(),
                  SizedBox(height: 25.r),
                  signUpPages[pageIndex](),
                  SizedBox(height: 25.r),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
