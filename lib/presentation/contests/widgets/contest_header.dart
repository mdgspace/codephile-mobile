import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';
import '../bloc/contests_bloc.dart';
import 'filter_sheet.dart';

class ContestHeader extends StatelessWidget {
  const ContestHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.white,
      title: Text(
        'Contest',
        style: AppStyles.h4.copyWith(
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            final bloc = context.read<ContestsBloc>()
              ..add(const FilterButton());
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return FilterSheet(bloc: bloc);
              },
            );
          },
          icon: SvgPicture.asset(AppAssets.filter),
        ),
      ],
    );
  }
}
