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
  const SearchPeople({required this.query, this.selectedField = 'username'});
  final String query;
  final String selectedField;

  @override
  List<Object?> get props => [query, selectedField];
}

class UpdateFilterField extends SearchEvent {
  const UpdateFilterField();
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
