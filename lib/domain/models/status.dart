import 'package:freezed_annotation/freezed_annotation.dart';

part 'status.freezed.dart';

@freezed
class Status with _$Status {
  const factory Status([String? message]) = Idle;
  const factory Status.loading() = Loading;
  const factory Status.error(String message) = Error;
}
