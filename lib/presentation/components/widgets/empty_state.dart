import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/constants/assets.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({required this.description, Key? key}) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(AppAssets.emptyState),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(25.r),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
