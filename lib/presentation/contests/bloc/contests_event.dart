part of 'contests_bloc.dart';

abstract class ContestsEvent extends Equatable {
  const ContestsEvent();

  @override
  List<Object?> get props => [];
}

class FetchContests extends ContestsEvent {
  const FetchContests();

  @override
  List<Object?> get props => [];
}

class FilterButton extends ContestsEvent {
  const FilterButton();

  @override
  List<Object?> get props => [];
}

class UpdateFilter extends ContestsEvent {
  const UpdateFilter({
    this.duration,
    this.updatedFilter,
  });
  final int? duration;
  final ContestFilter? updatedFilter;

  @override
  List<Object?> get props => [updatedFilter, duration];
}
