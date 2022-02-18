part of 'contests_bloc.dart';

@freezed
class ContestsState extends Equatable with _$ContestsState {
  const factory ContestsState({
    @Default(true) bool isLoading,
    @Default([]) List contests,
    ContestFilter? filter,
    int? duration,
    @Default(0) int updateIdx,
  }) = _ContestsState;

  const ContestsState._();

  @override
  List<Object?> get props => [isLoading, contests, filter, duration, updateIdx];
}
