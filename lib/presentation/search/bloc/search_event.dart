part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class FetchInstituteList extends SearchEvent {
  const FetchInstituteList();
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
