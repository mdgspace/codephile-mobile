import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/colors.dart';
import '../../../data/constants/routes.dart';
import '../../../data/constants/strings.dart';
import '../../../data/constants/styles.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../utils/snackbar.dart';
import '../bloc/profile_bloc.dart';
import '../components/follow_button.dart';
import '../components/following_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        // Follow Notifier
        final _followNotifier = ValueNotifier(state.isFollowing);
        return Container(
          color: AppColors.primary,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 3),
                    Container(
                      height: 80.r,
                      width: 80.r,
                      decoration: BoxDecoration(
                        color: AppColors.grey7,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                      child: state.user?.picture == null
                          ? SvgPicture.asset(
                              AppAssets.defaultUserIcon,
                              fit: BoxFit.fitWidth,
                            )
                          : Image.network(
                              state.user!.picture!,
                              fit: BoxFit.fitWidth,
                            ),
                    ),
                    const Spacer(flex: 2),
                    IconButton(
                      onPressed: () async {
                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(100.w, 70.h, 0, 0),
                          items: [
                            PopupMenuItem(
                              value: 'update',
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
                              ),
                              onTap: () {
                                Future.delayed(
                                  const Duration(seconds: 1),
                                  () {
                                    Get.toNamed(AppRoutes.updateProfile);
                                  },
                                );
                              },
                              child: Text(
                                'Update Details',
                                style: AppStyles.h6.copyWith(
                                  color: AppColors.grey3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            PopupMenuItem(
                              value: 'logout',
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
                              ),
                              onTap: () async {
                                final res = await UserRepository.logout();
                                if (res) {
                                  Get.offNamed(AppRoutes.login);
                                  return;
                                }

                                showSnackBar(message: AppStrings.genericError);
                              },
                              child: Text(
                                'Logout',
                                style: AppStyles.h6.copyWith(
                                  color: AppColors.grey3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                          elevation: 8,
                        );
                      },
                      icon: state.personalProfile
                          ? const Icon(
                              Icons.settings,
                              color: AppColors.white,
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  state.user?.fullname ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                  ),
                ),
              ),
              Text(
                '@${state.user?.username}',
                style: const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.65),
                  fontSize: 16,
                ),
              ),
              if (state.user?.institute != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 8, 32, 0),
                  child: Text(
                    state.user!.institute!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            '${state.user?.noOfFollowing ?? 0} Following',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        onTap: () {
                          /// If it is not the personal profile
                          if (!state.personalProfile) return;

                          /// If the no of following is empty
                          if ((state.user?.noOfFollowing ?? 0) == 0) return;

                          context
                              .read<ProfileBloc>()
                              .add(const ShowFollowing(toShow: true));
                        },
                      ),
                      if (!state.personalProfile) ...<Widget>[
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 16.w,
                          ),
                          child: ValueListenableBuilder<bool>(
                            valueListenable: _followNotifier,
                            builder: (_, value, child) {
                              if (value) {
                                return FollowingButton(
                                  onTap: () async {
                                    try {
                                      await context
                                          .read<ProfileBloc>()
                                          .unfollow(state.user!.id!);
                                      _followNotifier.value = false;
                                    } on Exception catch (_) {
                                      showSnackBar(
                                          message: AppStrings.genericError);
                                    }
                                  },
                                );
                              }

                              return FollowButton(
                                onTap: () async {
                                  try {
                                    await context
                                        .read<ProfileBloc>()
                                        .follow(state.user!.id!);
                                    _followNotifier.value = true;
                                  } on Exception catch (_) {
                                    showSnackBar(
                                        message: AppStrings.genericError);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: AppColors.grey7,
              )
            ],
          ),
        );
      },
    );
  }
}
