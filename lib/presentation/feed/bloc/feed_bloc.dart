import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

import '../../../domain/models/feed.dart';
import '../../../domain/models/grouped_feed.dart';
import '../../../domain/repositories/cp_repository.dart';

part 'feed_bloc.freezed.dart';
part 'feed_state.dart';
part 'feed_event.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(const FeedState()) {
    on<FeedFetch>(_onFeedFetch);
  }

  void _onFeedFetch(FeedFetch event, Emitter<FeedState> emit) async {
    if (state.isFetchingNext) return;

    if (event.fetchNext) {
      emit(state.copyWith(isFetchingNext: true));
    } else {
      emit(state.copyWith(isLoading: true));
    }

    feeds = await CPRepository.getFeed(
          before: event.fetchNext
              ? groupedFeeds.last.submissions?.last.createdAt
              : null,
        ) ??
        <Feed>[];

    if (feeds.isEmpty) _allLoaded = true;

    for (final feed in feeds) {
      final groupFeed = groupedFeeds.firstWhere(
        (element) => element.name == feed.submission?.name,
        orElse: () {
          groupedFeeds.add(feed.toGroupedFeed());
          return groupedFeeds.last;
        },
      );
      groupFeed.submissions!.add(
        Submissions(
          createdAt: feed.submission?.createdAt,
          status: feed.submission?.status,
          points: feed.submission?.points,
          tags: feed.submission?.tags,
          rating: feed.submission?.rating,
        ),
      );
    }

    emit(
      state.copyWith(
        isLoading: false,
        feeds: [...groupedFeeds],
        isFetchingNext: false,
        allLoaded: _allLoaded,
      ),
    );
  }

  void _onScrolled() {
    final hasReachedEnd = scrollController.position.maxScrollExtent -
            scrollController.position.pixels <=
        MediaQuery.of(Get.context!).size.width / 2;

    if (hasReachedEnd && !_allLoaded) {
      add(const FeedFetch(fetchNext: true));
    }
  }

  void init() {
    add(const FeedFetch());
    scrollController.addListener(_onScrolled);
  }

  List<Feed> feeds = <Feed>[];
  List<GroupedFeed> groupedFeeds = <GroupedFeed>[];
  bool _allLoaded = false;
  final ScrollController scrollController = ScrollController();
}

extension on Feed {
  GroupedFeed toGroupedFeed() {
    return GroupedFeed(
      username: username,
      userId: userId,
      fullname: fullname,
      picture: picture,
      name: submission?.name,
      url: submission?.url,
      language: submission?.language,
      submissions: [],
    );
  }
}
