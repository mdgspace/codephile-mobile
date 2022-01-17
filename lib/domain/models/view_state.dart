import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_state.freezed.dart';

@freezed
class ViewState with _$ViewState {
  factory ViewState([String? message]) = Idle;
  const factory ViewState.loading() = Loading;
  factory ViewState.error(String message) = Error;
}
