import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/user.dart';
import '../../../domain/repositories/user_repository.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<FetchInstituteList>(_onFetchInstituteList);
    on<SearchPeople>(_onSearchPeople);
    on<UpdateFilterInstitute>(_onUpdateFilterInstitute);
    on<Reset>(_onReset);
  }

  void _onFetchInstituteList(
    FetchInstituteList event,
    Emitter<SearchState> emit,
  ) async {
    final res = await UserRepository.getInstituteList();
    if (res.isEmpty) {
      instituteList.addAll([
        'Indian Institute of Technology Roorkee',
        'Indian Institute of Technology Delhi',
        'Indian Institute of Technology Mandi',
        'Indian Institute of Technology Indore',
        'Indian Institute of Technology Bombay'
      ]);
    } else {
      instituteList.addAll(res);
    }

    emit(state.copyWith(instituteList: instituteList));
  }

  void _onSearchPeople(SearchPeople event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
      showSearches: true,
      isLoading: true,
    ));

    searchedResult = await UserRepository.search(event.query);
    applyFilter();

    emit(state.copyWith(
      showSearches: true,
      isLoading: false,
      searchedResult: filteredSearchResult,
    ));
  }

  void _onUpdateFilterInstitute(
    UpdateFilterInstitute event,
    Emitter<SearchState> emit,
  ) {
    applyFilter();
    emit(state.copyWith(
      selectedInstitute: updatedFilter,
      searchedResult: filteredSearchResult,
    ));
  }

  void applyFilter() {
    if (state.selectedInstitute == 'All') {
      filteredSearchResult = searchedResult;
      return;
    }

    filteredSearchResult = [];
    filteredSearchResult.addAll(searchedResult.where(
      (element) => element.institute == state.selectedInstitute,
    ));
  }

  void _onReset(Reset event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      showSearches: false,
      isLoading: false,
    ));
  }

  List<String> instituteList = ['All'];
  String updatedFilter = '';
  List<User> searchedResult = [];
  List<User> filteredSearchResult = [];
  final TextEditingController controller = TextEditingController();
}
