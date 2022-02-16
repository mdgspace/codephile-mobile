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

class UpdateFilter extends ContestsEvent {
  const UpdateFilter();

  @override
  List<Object?> get props => [];
}
