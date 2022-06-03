part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class Init extends SearchEvent {
  const Init();
}

class SearchPeople extends SearchEvent {
  const SearchPeople({required this.query});
  final String query;

  @override
  List<Object?> get props => [query];
}

class UpdateFilterInstitute extends SearchEvent {
  const UpdateFilterInstitute();
}

class Reset extends SearchEvent {
  const Reset();
}

class RecentSearch extends SearchEvent {
  const RecentSearch({required this.user, this.toAdd = true});
  final User user;
  final bool toAdd;

  @override
  List<Object?> get props => [user, toAdd];
}
