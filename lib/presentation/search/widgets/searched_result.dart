import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/styles.dart';
import '../../../domain/models/status.dart';
import '../../../utils/user_util.dart';
import '../../home/bloc/home_bloc.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../bloc/search_bloc.dart';

class SearchedResult extends StatelessWidget {
  const SearchedResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.status is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.searchedResult.isEmpty) {
          return Center(
            child: Text(
              'No matching users found',
              style: AppStyles.h5.copyWith(color: AppColors.grey3),
            ),
          );
        }

        return ListView(
          children: state.searchedResult.map((result) {
            return ListTile(
              onTap: () {
                context.read<SearchBloc>().add(RecentSearch(user: result));

                context
                    .read<ProfileBloc>()
                    .add(FetchDetails(userId: result.id ?? ''));

                context
                    .read<HomeBloc>()
                    .add(const BottomNavItemPressed(index: 3));
              },
              leading: ClipOval(
                child: SizedBox(
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
              ),
              title: Text(
                result.fullname,
                style: AppStyles.h5.copyWith(color: AppColors.grey3),
              ),
              subtitle: Text(
                '@${result.username}',
                style: AppStyles.h6,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
