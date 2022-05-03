import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/colors.dart';
import '../bloc/profile_bloc.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
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
                      onPressed: () {
                        // TODO(aman-singh7): Implement Settings.
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
                          if (!state.personalProfile) return;
                          // TODO(aman-singh7): Navigate to Following Screen
                        },
                      ),
                      if (!state.personalProfile) ...<Widget>[
                        const Spacer(),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 10, 16, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: state.isFollowing
                                    ? AppColors.primary
                                    : AppColors.white,
                                border: Border.all(
                                  color: AppColors.primary,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(2),
                                ),
                              ),
                              padding: EdgeInsets.all(8.r),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: state.isFollowing
                                          ? 'FOLLOWING'
                                          : 'FOLLOW',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: state.isFollowing
                                            ? AppColors.white
                                            : AppColors.primary,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Visibility(
                                        visible: state.isFollowing,
                                        child: Icon(
                                          Icons.check,
                                          size: 16.r,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {},
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
