import 'package:freezed_annotation/freezed_annotation.dart';

part 'following.freezed.dart';
part 'following.g.dart';

@freezed
class Following with _$Following {
  factory Following({
    required String id,
    required String username,
    String? fullname,
    String? picture,
  }) = _Following;

  factory Following.fromJson(Map<String, dynamic> json) =>
      _$FollowingFromJson(json);
}
