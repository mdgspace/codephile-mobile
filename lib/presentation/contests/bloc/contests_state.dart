part of 'contests_bloc.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ContestsState extends Equatable with _$ContestsState {
  const factory ContestsState({
    @Default(Status.loading()) Status status,
    @Default([]) List contests,
    ContestFilter? filter,
    int? duration,
    @Default(0) int updateIdx,
  }) = _ContestsState;

  const ContestsState._();

  @override
  List<Object?> get props => [status, contests, filter, duration, updateIdx];
}
