import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constants/colors.dart';
import '../../data/constants/styles.dart';
import '../../domain/models/status.dart';
import 'bloc/update_profile_bloc.dart';
import 'widgets/profile_details.dart';
import 'widgets/update_handles.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateProfileBloc()..add(const Initialize()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          backgroundColor: AppColors.white,
          title: Text(
            'Update Details',
            style: AppStyles.h4.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: Get.back,
              icon: Icon(
                Icons.clear,
                size: 24.r,
                color: AppColors.grey3,
              ),
            ),
          ],
        ),
        body: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
          builder: (context, state) {
            if (state.status is Idle) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    const ProfileDetails(),
                    SizedBox(height: 30.h),
                    const UpdateHandles(),
                    SizedBox(height: 30.h),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(AppColors.primary),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          const ContinuousRectangleBorder(),
                        ),
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide.none),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 48.r,
                        padding: EdgeInsets.symmetric(horizontal: 40.r),
                        child: Text(
                          'Save Changes',
                          style: AppStyles.h6.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
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
