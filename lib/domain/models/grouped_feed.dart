import 'package:freezed_annotation/freezed_annotation.dart';

part 'grouped_feed.freezed.dart';
part 'grouped_feed.g.dart';

@freezed
class GroupedFeed with _$GroupedFeed {
  factory GroupedFeed({
    required String username,
    @JsonKey(name: 'user_id') required String userId,
    String? fullname,
    String? picture,
    String? name,
    String? url,
    String? language,
    List<Submissions>? submissions,
  }) = _GroupedFeed;

  factory GroupedFeed.fromJson(Map<String, dynamic> json) =>
      _$GroupedFeedFromJson(json);
}

@freezed
class Submissions with _$Submissions {
  factory Submissions({
    DateTime? createdAt,
    String? status,
    int? points,
    List<String>? tags,
    int? rating,
  }) = _Submissions;

  factory Submissions.fromJson(Map<String, dynamic> json) =>
      _$SubmissionsFromJson(json);
}
