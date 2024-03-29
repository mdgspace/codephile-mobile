import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/constants/assets.dart';
import '../../data/constants/colors.dart';
import '../contests/bloc/contests_bloc.dart';
import '../feed/bloc/feed_bloc.dart';
import '../profile/bloc/profile_bloc.dart';
import '../search/bloc/search_bloc.dart';
import 'bloc/home_bloc.dart';
import 'widgets/nav_bar_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc()..init(),
        ),
        BlocProvider(
          create: (context) => FeedBloc()..init(),
        ),
        BlocProvider(
          create: (context) => ContestsBloc()..init(),
        ),
        BlocProvider(
          create: (context) => SearchBloc()..add(const Init()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc()..add(const FetchDetails()),
        ),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: state.screen,
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 16,
                      color: Color.fromRGBO(193, 193, 193, 0.5),
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavBarItem(
                      label: 'Feed',
                      isActive: state.selectedIndex == 0,
                      callback: () {
                        context
                            .read<HomeBloc>()
                            .add(const BottomNavItemPressed(index: 0));
                      },
                      icon: AppAssets.feed,
                    ),
                    NavBarItem(
                      label: 'Contests',
                      isActive: state.selectedIndex == 1,
                      callback: () {
                        context
                            .read<HomeBloc>()
                            .add(const BottomNavItemPressed(index: 1));
                      },
                      icon: AppAssets.contest,
                    ),
                    NavBarItem(
                      label: 'Search',
                      isActive: state.selectedIndex == 2,
                      callback: () {
                        context
                            .read<HomeBloc>()
                            .add(const BottomNavItemPressed(index: 2));
                      },
                      icon: AppAssets.search,
                    ),
                    NavBarItem(
                      label: 'Profile',
                      isActive: state.selectedIndex == 3,
                      callback: () {
                        // Set to default
                        if (!context.read<ProfileBloc>().isSelfProfile) {
                          context.read<ProfileBloc>().add(const FetchDetails());
                        }

                        context
                            .read<HomeBloc>()
                            .add(const BottomNavItemPressed(index: 3));
                      },
                      icon: AppAssets.profile,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
