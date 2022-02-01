import 'package:freezed_annotation/freezed_annotation.dart';

import 'submission.dart';

part 'feed.freezed.dart';
part 'feed.g.dart';

@freezed
class Feed with _$Feed {
  factory Feed({
    required String userId,
    required String username,
    required String? fullname,
    String? picture,
    Submission? submission,
  }) = _Feed;

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);
}
