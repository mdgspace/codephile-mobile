part of 'contests_bloc.dart';

@freezed
class ContestsState with _$ContestsState {
  const factory ContestsState({
    @Default(true) bool isLoading,
    @Default([]) List contests,
    ContestFilter? filter,
    int? duration,
  }) = _ContestsState;

  const ContestsState._();
}
