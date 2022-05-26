import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';
import '../../../utils/user_util.dart';
import '../../home/bloc/home_bloc.dart';
import '../../profile/bloc/profile_bloc.dart';
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
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: Text('RECENT SEARCHES', style: AppStyles.h6),
            ),
            ...state.recentSearches.map((result) {
              return ListTile(
                onTap: () {
                  context
                      .read<ProfileBloc>()
                      .add(FetchDetails(userId: result.id ?? ''));

                  context
                      .read<HomeBloc>()
                      .add(const BottomNavItemPressed(index: 3));
                },
                leading: SizedBox(
                  width: 35.r,
                  child: CachedNetworkImage(
                    cacheKey: result.id,
                    imageUrl: (result.picture ?? '').isEmpty
                        ? UserUtil.picture
                        : result.picture!,
                    errorWidget: (context, url, error) =>
                        const CircularProgressIndicator(),
                  ),
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
                trailing: IconButton(
                  onPressed: () {
                    context
                        .read<SearchBloc>()
                        .add(RecentSearch(user: result, toAdd: false));
                  },
                  icon: const Icon(Icons.close),
                ),
              );
            }).toList()
          ],
        );
      },
    );
  }
}
