import 'package:freezed_annotation/freezed_annotation.dart';

part 'status.freezed.dart';

@freezed

/// State of a screen.
class Status with _$Status {
  /// State of a screen.
  const factory Status([String? message]) = Idle;

  /// State of a screen.
  const factory Status.loading() = Loading;

  /// State of a screen.
  const factory Status.error(String errorMessage) = Error;
}
