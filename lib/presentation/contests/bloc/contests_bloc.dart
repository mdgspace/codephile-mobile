import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/contest.dart';
import '../../../domain/repositories/cp_repository.dart';

part 'contests_event.dart';
part 'contests_state.dart';
part 'contests_bloc.freezed.dart';

class ContestsBloc extends Bloc<ContestsEvent, ContestsState> {
  ContestsBloc() : super(const ContestsState()) {
    on<FetchContests>(_fetchContests);
    on<UpdateFilter>(_updateFilter);
  }

  void _fetchContests(FetchContests event, Emitter<ContestsState> emit) async {
    final contest = await CPRepository.contestList();
    emit(state.copyWith(contest: contest, isLoading: false));
  }

  void _updateFilter(UpdateFilter event, Emitter<ContestsState> emit) {}

  void init() {
    add(const FetchContests());
  }
}
