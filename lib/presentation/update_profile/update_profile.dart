import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/models/status.dart';
import '../components/widgets/primary_button.dart';
import 'bloc/update_profile_bloc.dart';
import 'widgets/change_password.dart';
import 'widgets/profile_details.dart';
import 'widgets/update_handles.dart';
import 'widgets/update_profile_appbar.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: context.read<UpdateProfileBloc>().onWillPop,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: UpdateProfileAppBar(),
        ),
        body: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
          builder: (context, state) {
            if (state.status is Idle) {
              if (state.showChangePasswordView) {
                return Padding(
                  padding: EdgeInsets.all(16.r),
                  child: ChangePassword(),
                );
              }
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    const ProfileDetails(),
                    SizedBox(height: 30.h),
                    const UpdateHandles(),
                    SizedBox(height: 30.h),
                    PrimaryButton(
                      label: 'Save Changes',
                      onPressed: () {},
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
