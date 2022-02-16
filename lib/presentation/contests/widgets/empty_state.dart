import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/colors.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(AppAssets.emptyState),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(25.r),
          child: const Text(
            'No contests found, please adjust your filters!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.grey1,
            ),
          ),
        ),
      ],
    );
  }
}
