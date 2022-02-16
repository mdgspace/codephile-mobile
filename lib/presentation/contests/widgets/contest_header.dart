import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/colors.dart';

class ContestHeader extends StatelessWidget {
  const ContestHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.white,
      title: const Text(
        'Contest',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(AppAssets.filter),
        ),
      ],
    );
  }
}
