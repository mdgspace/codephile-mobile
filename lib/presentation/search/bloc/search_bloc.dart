import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/services/local/storage_service.dart';
import '../../../domain/models/status.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/user_repository.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<Init>(_onInit);
    on<SearchPeople>(_onSearchPeople);
    on<UpdateFilterField>(_onUpdateFilterField);
    on<Reset>(_onReset);
    on<RecentSearch>(_onRecentSearch);
  }

  static List<String> fields = <String>[
    'username',
    'fullname',
    'handle.codechef',
    'handle.codeforces',
    'handle.hackerearth',
    'handle.hackerrank',
    'handle.spoj'
  ];

  void _onInit(Init event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
      recentSearches: StorageService.recentSearches ?? <User>[],
    ));
  }

  void _onSearchPeople(SearchPeople event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
      showSearches: true,
      status: const Status.loading(),
    ));

    searchedResult =
        await UserRepository.search(event.query, event.selectedField);

    emit(state.copyWith(
      showSearches: true,
      status: const Status(),
      searchedResult: searchedResult,
    ));
  }

  void _onUpdateFilterField(
      UpdateFilterField event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
      selectedField: updatedFilter,
      showSearches: true,
      status: const Status(),
    ));
  }

  void _onReset(Reset event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      showSearches: false,
      searchedResult: [],
      status: const Status.loading(),
    ));
  }

  void _onRecentSearch(RecentSearch event, Emitter<SearchState> emit) {
    final recent = state.recentSearches;
    if (event.toAdd) {
      if (!recent.contains(event.user)) {
        recent.insert(0, event.user);
      }
    } else {
      recent.remove(event.user);
    }

    StorageService.recentSearches = recent;

    emit(state.copyWith(
      recentSearches: [...recent],
      count: state.count + 1,
    ));
  }

  String updatedFilter = '';
  List<User> searchedResult = [];
  List<User> filteredSearchResult = [];
  final TextEditingController controller = TextEditingController();
}
