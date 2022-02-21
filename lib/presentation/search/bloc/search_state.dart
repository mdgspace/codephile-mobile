part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default(true) bool isLoading,
    @Default([]) List<String> instituteList,
    @Default('All') String selectedInstitute,
    @Default('') String query,
    @Default(false) bool showSearches,
    @Default([]) List<User> searchedResult,
    @Default([]) List<User> recentSearches,
  }) = _SearchState;

  const SearchState._();
}
