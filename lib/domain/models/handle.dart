import 'package:freezed_annotation/freezed_annotation.dart';

part 'handle.freezed.dart';
part 'handle.g.dart';

@freezed
class Handle with _$Handle {
  factory Handle({
    @JsonKey(name: 'handle.codechef') String? codechef,
    @JsonKey(name: 'handle.codeforces') String? codeforces,
    @JsonKey(name: 'handle.hackerrank') String? hackerrank,
    @JsonKey(name: 'handle.spoj') String? spoj,
  }) = _Handle;

  factory Handle.fromJson(Map<String, dynamic> json) => _$HandleFromJson(json);
}
