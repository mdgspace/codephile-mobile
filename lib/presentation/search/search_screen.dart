import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/constants/colors.dart';
import '../components/inputs/text_input.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 13.w,
            vertical: 30.h,
          ),
          child: TextInput(
            hint: 'Search people by name or handles',
            onChanged: (val) {},
            isFilled: true,
            fillColor: AppColors.grey7,
            suffix: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: const EdgeInsets.fromLTRB(4, 1, 1, 4),
                  icon: const Icon(
                    Icons.filter_alt,
                    color: AppColors.grey6,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  padding: const EdgeInsets.fromLTRB(4, 1, 1, 4),
                  icon: const Icon(
                    Icons.clear,
                    color: AppColors.grey6,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
