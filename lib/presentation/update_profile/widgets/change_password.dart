import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/styles.dart';
import '../../components/inputs/text_input.dart';
import '../../components/widgets/primary_button.dart';
import '../bloc/update_profile_bloc.dart';

part 'text_fields.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.r),
                  Text(
                    'Setup a new password for Codephile',
                    style: AppStyles.h4.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 24.r),
                  const CurrentPasswordField(),
                  SizedBox(height: 24.r),
                  const NewPasswordField(),
                  SizedBox(height: 24.r),
                  const ReEnterPasswordField(),
                ],
              ),
            ),
          ),
        ),
        BlocSelector<UpdateProfileBloc, UpdateProfileState, bool>(
          selector: (state) => state.isUpdating,
          builder: (context, isUpdating) {
            return PrimaryButton(
              label: 'Update Password',
              isLoading: isUpdating,
              onPressed: () {
                if (isUpdating) return;
                if (_key.currentState!.validate()) {
                  context.read<UpdateProfileBloc>().add(const UpdatePassword());
                }
              },
            );
          },
        ),
      ],
    );
  }
}
