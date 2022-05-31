import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';
import '../bloc/update_profile_bloc.dart';

class UpdateProfileAppBar extends StatelessWidget {
  const UpdateProfileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UpdateProfileBloc, UpdateProfileState, bool>(
      selector: (state) => state.showChangePasswordView,
      builder: (context, show) {
        return AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          backgroundColor: AppColors.white,
          title: Text(
            show ? 'Change Password' : 'Update Details',
            style: AppStyles.h4.copyWith(
              fontSize: 20.sp,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (show) {
                  context.read<UpdateProfileBloc>().add(const SwitchView());
                } else {
                  Get.back();
                }
              },
              icon: Icon(
                Icons.clear,
                size: 24.r,
                color: AppColors.grey3,
              ),
            ),
          ],
        );
      },
    );
  }
}
