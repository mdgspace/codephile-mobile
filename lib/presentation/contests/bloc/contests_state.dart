part of 'contests_bloc.dart';

@freezed
class ContestsState with _$ContestsState {
  const factory ContestsState({
    @Default(true) bool isLoading,
    Contest? contest,
  }) = _ContestsState;

  const ContestsState._();
}
