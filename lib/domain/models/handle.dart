import 'package:freezed_annotation/freezed_annotation.dart';

part 'handle.freezed.dart';
part 'handle.g.dart';

@freezed
class Handle with _$Handle {
  factory Handle({
    @JsonKey(name: 'codechef') String? codechef,
    @JsonKey(name: 'codeforces') String? codeforces,
    @JsonKey(name: 'hackerrank') String? hackerrank,
    @JsonKey(name: 'spoj') String? spoj,
    @JsonKey(name: 'leetcode') String? leetcode,
  }) = _Handle;

  factory Handle.fromJson(Map<String, dynamic> json) => _$HandleFromJson(json);
}
