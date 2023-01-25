part of 'search_bloc.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class SearchState with _$SearchState {
  const factory SearchState({
    @Default(Status.loading()) Status status,
    @Default('username') String selectedField,
    @Default('') String query,
    @Default(false) bool showSearches,
    @Default([]) List<User> searchedResult,
    @Default([]) List<User> recentSearches,
    @Default(0) int count,
  }) = _SearchState;

  const SearchState._();
}
