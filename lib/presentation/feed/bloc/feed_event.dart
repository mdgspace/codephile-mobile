part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object?> get props => [];
}

class FeedFetch extends FeedEvent {
  const FeedFetch({this.fetchNext = false});

  final bool fetchNext;

  @override
  List<Object?> get props => [fetchNext];
}
