import 'package:freezed_annotation/freezed_annotation.dart';

part 'contest.freezed.dart';
part 'contest.g.dart';

@freezed
class Contest with _$Contest {
  factory Contest({
    List<Ongoing>? ongoing,
    String? timestamp,
    List<Upcoming>? upcoming,
  }) = _Contest;

  factory Contest.fromJson(Map<String, dynamic> json) =>
      _$ContestFromJson(json);
}

@freezed
class Ongoing with _$Ongoing {
  factory Ongoing({
    @JsonKey(name: 'EndTime') required DateTime endTime,
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'Platform') required String platform,
    required String url,
    @JsonKey(name: 'challenge_type') String? challengeType,
  }) = _Ongoing;

  factory Ongoing.fromJson(Map<String, dynamic> json) =>
      _$OngoingFromJson(json);
}

@freezed
class Upcoming with _$Upcoming {
  factory Upcoming({
    @JsonKey(name: 'StartTime') required DateTime startTime,
    @JsonKey(name: 'EndTime') required DateTime endTime,
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'Platform') required String platform,
    required String url,
    @JsonKey(name: 'challenge_type') String? challengeType,
    @JsonKey(name: 'Duration') String? duration,
  }) = _Upcoming;

  factory Upcoming.fromJson(Map<String, dynamic> json) =>
      _$UpcomingFromJson(json);
}
