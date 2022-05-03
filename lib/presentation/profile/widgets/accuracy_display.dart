import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';
import '../../../utils/contest_util.dart';
import '../bloc/profile_bloc.dart';

class AccuracyDisplay extends StatelessWidget {
  const AccuracyDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Wrap(
          children: [
            SizedBox(width: 10.r),
            _buildAccuracyTile(
              'codechef',
              state.user?.profiles?.codechefProfile?.accuracy ?? '-',
            ),
            _buildAccuracyTile(
              'codeforces',
              state.user?.profiles?.codeforcesProfile?.accuracy ?? '-',
            ),
            _buildAccuracyTile(
              'hackerrank',
              state.user?.profiles?.hackerrankProfile?.accuracy ?? '-',
            ),
            _buildAccuracyTile(
              'spoj',
              state.user?.profiles?.spojProfile?.accuracy ?? '-',
            ),
          ],
        );
      },
    );
  }

  Widget _buildAccuracyTile(String platform, String accuracy) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.r),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(2)),
        border: Border.all(
          color: AppColors.grey1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(
                right: BorderSide(
                  color: AppColors.grey1,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(5.r),
              child: Image.asset(
                ContestUtil.getPlatformIcon(platform),
                width: 25.r,
                height: 25.r,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Text(
              accuracy.length > 4 ? accuracy.substring(0, 4) : accuracy,
              style: AppStyles.h6,
            ),
          ),
        ],
      ),
    );
  }
}
