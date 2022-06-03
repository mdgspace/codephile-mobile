import 'package:freezed_annotation/freezed_annotation.dart';

import 'handle.dart';
import 'submission.dart';
import 'user_profile.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required String fullname,
    String? email,
    Handle? handle,
    String? id,
    String? institute,
    @JsonKey(name: 'no_of_following') int? noOfFollowing,
    String? picture,
    UserProfile? profiles,
    @JsonKey(name: 'recent_submissions') List<Submission>? recentSubmissions,
    String? username,
    @JsonKey(name: 'solved_problems_count')
        SolvedProblemsCount? solvedProblemsCount,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class SolvedProblemsCount with _$SolvedProblemsCount {
  factory SolvedProblemsCount({
    int? codechef,
    int? codeforces,
    int? hackerrank,
    int? spoj,
  }) = _SolvedProblemsCount;

  factory SolvedProblemsCount.fromJson(Map<String, dynamic> json) =>
      _$SolvedProblemsCountFromJson(json);
}
