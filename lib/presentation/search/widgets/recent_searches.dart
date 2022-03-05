import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';
import '../bloc/search_bloc.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.recentSearches.isEmpty) return Container();

        return ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Text('RECENT SEARCHES', style: AppStyles.h6),
            ),
            ...state.recentSearches.map((result) {
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: result.picture!,
                ),
                title: Text(
                  result.fullname,
                  style: AppStyles.h5.copyWith(
                    color: AppColors.grey3,
                  ),
                ),
                subtitle: Text(
                  '@${result.username}',
                  style: AppStyles.h6,
                ),
              );
            }).toList()
          ],
        );
      },
    );
  }
}
