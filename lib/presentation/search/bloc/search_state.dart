part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default(Status.loading()) Status status,
    @Default('All') String selectedInstitute,
    @Default('') String query,
    @Default(false) bool showSearches,
    @Default([]) List<User> searchedResult,
    @Default([]) List<User> recentSearches,
    @Default(0) int count,
  }) = _SearchState;

  const SearchState._();
}
