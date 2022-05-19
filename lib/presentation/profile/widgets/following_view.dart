import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/strings.dart';
import '../../../data/constants/styles.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/user_util.dart';
import '../bloc/profile_bloc.dart';
import '../components/follow_button.dart';
import '../components/following_button.dart';

class FollowingView extends StatelessWidget {
  const FollowingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: AppColors.white,
        title: Text(
          'Following',
          style: AppStyles.h4.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context
                  .read<ProfileBloc>()
                  .add(const ShowFollowing(toShow: false));
            },
            icon: Icon(
              Icons.clear,
              size: 24.r,
              color: AppColors.grey3,
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        /// Build when the following list changes
        buildWhen: (previous, current) {
          final len = previous.following!.length;
          for (final index in List.generate(len, (index) => index)) {
            if (previous.following?[index].hashCode !=
                current.following?[index].hashCode) {
              return true;
            }
          }

          return false;
        },
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.following?.length,
            itemBuilder: (context, index) {
              final user = state.following![index];
              final _followNotifier = ValueNotifier(true);
              return ListTile(
                leading: SizedBox(
                  width: 35.r,
                  child: CachedNetworkImage(
                    cacheKey: user.id,
                    imageUrl: (user.picture ?? '').isEmpty
                        ? UserUtil.picture
                        : user.picture!,
                    errorWidget: (context, url, error) =>
                        const CircularProgressIndicator(),
                  ),
                ),
                title: Text(
                  '${user.fullname}',
                  style: AppStyles.h5.copyWith(color: AppColors.grey3),
                ),
                subtitle: Text(
                  '@${user.username}',
                  style: AppStyles.h6,
                ),

                /// Whenever the state of one tile changes ValueListenableBuilder
                /// will only build its trailing widget, eliminating the need
                /// to rebuild the whole list
                trailing: ValueListenableBuilder<bool>(
                  valueListenable: _followNotifier,
                  builder: (context, value, _) {
                    if (value) {
                      return FollowingButton(
                        onTap: () async {
                          try {
                            await ProfileBloc.unfollow(user.id);
                            _followNotifier.value = false;
                          } on Exception catch (_) {
                            showSnackBar(message: AppStrings.genericError);
                          }
                        },
                      );
                    }

                    return FollowButton(
                      onTap: () async {
                        try {
                          await ProfileBloc.follow(user.id);
                          _followNotifier.value = true;
                        } on Exception catch (_) {
                          showSnackBar(message: AppStrings.genericError);
                        }
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
