import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/constants/styles.dart';
import 'bloc/profile_bloc.dart';
import 'widgets/acceptance_graph.dart';
import 'widgets/accuracy_display.dart';
import 'widgets/following_view.dart';
import 'widgets/loading_state.dart';
import 'widgets/profile_header.dart';
import 'widgets/question_solved.dart';
import 'widgets/submission_display.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(const FetchDetails()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        // When Loading state changes
        buildWhen: (previous, current) =>
            previous.isLoading ^ current.isLoading ||
            previous.showFollowing ^ current.showFollowing,
        builder: (context, state) {
          if (state.isLoading) return const ProfileLoadingState();

          if (state.showFollowing) return const FollowingView();

          return ListView(
            children: [
              const ProfileHeader(),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 24.h, 0, 8.h),
                child: Text(
                  'Accuracy',
                  style: AppStyles.h1.copyWith(fontSize: 15.sp),
                ),
              ),
              const AccuracyDisplay(),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 24.h),
                child: Text(
                  'Number of question solved',
                  style: AppStyles.h1.copyWith(fontSize: 15.sp),
                ),
              ),
              const QuestionSolved(),
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 24.h),
                child: Text(
                  'Status of total Submissions',
                  style: AppStyles.h1.copyWith(fontSize: 15.sp),
                ),
              ),
              const SubmissionDisplay(),
              const AcceptanceGraph(),
            ],
          );
        },
      ),
    );
  }
}
