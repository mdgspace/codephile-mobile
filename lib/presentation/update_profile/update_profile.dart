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
    return BlocProvider(
      create: (context) => UpdateProfileBloc()..add(const Initialize()),
      child: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
          builder: (context, state) {
        return WillPopScope(
          onWillPop: context.read<UpdateProfileBloc>().onWillPop,
          child: Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: UpdateProfileAppBar(),
            ),
            body: _buildBody(context, state),
          ),
        );
      }),
    );
  }

  Widget _buildBody(BuildContext context, UpdateProfileState state) {
    if (state.status is Idle) {
      if (state.showChangePasswordView) {
        return Padding(
          padding: EdgeInsets.all(16.r),
          child: ChangePassword(),
        );
      }
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Column(
          children: [
            const ProfileDetails(),
            SizedBox(height: 30.r),
            const UpdateHandles(),
            SizedBox(height: 30.r),
            PrimaryButton(
              label: 'Save Changes',
              onPressed: () {
                if (state.isUpdating) return;
                context
                    .read<UpdateProfileBloc>()
                    .add(const UpdateUserDetails());
              },
            ),
            SizedBox(height: 30.r),
          ],
        ),
      );
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
