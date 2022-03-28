import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/constants/assets.dart';
import '../../data/constants/colors.dart';
import '../components/widgets/empty_state.dart';
import '../contests/widgets/loading_state.dart';
import 'bloc/feed_bloc.dart';
import 'widgets/feed_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        title: Text(
          'Feed',
          style: Theme.of(context).textTheme.headline4?.copyWith(
                fontSize: 22.sp,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<FeedBloc>().add(const FeedFetch());
            },
            icon: SvgPicture.asset(
              AppAssets.refresh,
              width: 24.r,
              height: 24.r,
            ),
          ),
        ],
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingState();
          }

          if (state.feeds.isEmpty) {
            return const EmptyState(
              description: 'Feed looks empty, search and follow'
                  ' some people to see their updates',
            );
          }

          return ListView.builder(
            controller: context.read<FeedBloc>().scrollController,
            itemCount: state.feeds.length + 1,
            itemBuilder: (context, index) {
              if (index == state.feeds.length) {
                return SizedBox(
                  height: 80,
                  child: Center(
                    child: Visibility(
                      visible: state.allLoaded,
                      replacement: const CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                      child: const Text(
                        'Nothing more to show!!',
                      ),
                    ),
                  ),
                );
              }

              return FeedCard(
                feed: state.feeds[index],
              );
            },
          );
        },
      ),
    );
  }
}
