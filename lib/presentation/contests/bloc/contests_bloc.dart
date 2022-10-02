import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/constants/strings.dart';
import '../../../data/services/local/storage_service.dart';
import '../../../data/services/remote/notification_service.dart';
import '../../../domain/models/contest.dart';
import '../../../domain/models/contest_filter.dart';
import '../../../domain/models/status.dart';
import '../../../domain/repositories/cp_repository.dart';
import '../../../utils/snackbar.dart';

part 'contests_event.dart';
part 'contests_state.dart';
part 'contests_bloc.freezed.dart';

class ContestsBloc extends Bloc<ContestsEvent, ContestsState> {
  ContestsBloc() : super(const ContestsState()) {
    on<FetchContests>(_fetchContests);
    on<UpdateFilter>(_updateFilter);
    on<FilterButton>(_filterButton);
    on<UpdateContestsList>(_updateContestsList);
  }

  void _fetchContests(FetchContests event, Emitter<ContestsState> emit) async {
    Contest? contest;
    try {
      contest = await CPRepository.contestList();
    } on Exception catch (_) {
      showSnackBar(message: AppStrings.genericError);
      emit(state.copyWith(status: const Status.error(AppStrings.genericError)));
      return;
    }

    _ongoing = [...?contest?.ongoing];
    _upcoming = [...?contest?.upcoming];
    applyFilter();
    final contests = [..._filteredUpcoming, ..._filteredOngoing];
    emit(state.copyWith(
      contests: contests,
      status: const Status(),
      filter: _filter,
    ));
  }

  void _filterButton(FilterButton event, Emitter<ContestsState> emit) {
    _filter = StorageService.filter;

    emit(state.copyWith(
      duration: _filter?.duration,
      filter: _filter,
      updateIdx: state.updateIdx + 1,
    ));
  }

  void _updateFilter(UpdateFilter event, Emitter<ContestsState> emit) {
    _filter = event.updatedFilter ?? _filter;
    emit(
      state.copyWith(
        duration: event.duration ?? _filter?.duration,
        filter: event.updatedFilter ?? _filter,
        updateIdx: state.updateIdx + 1,
      ),
    );
  }

  void _updateContestsList(
    UpdateContestsList event,
    Emitter<ContestsState> emit,
  ) {
    applyFilter();
    final contests = [..._filteredUpcoming, ..._filteredOngoing];
    emit(state.copyWith(
      contests: contests,
    ));
  }

  void applyFilter() {
    _filteredOngoing = [];
    _filteredUpcoming = [];
    if (_filter!.ongoing ?? false) {
      _filteredOngoing.addAll(
        _ongoing.where(
          (element) => _filter!.check(
            ongoing: element,
          ),
        ),
      );
    }

    if (_filter!.upcoming ?? false) {
      _filteredUpcoming.addAll(
        _upcoming.where(
          (element) => _filter!.check(
            upcoming: element,
          ),
        ),
      );
    }
  }

  ContestFilter? _filter;
  List<Ongoing> _ongoing = [], _filteredOngoing = [];
  List<Upcoming> _upcoming = [], _filteredUpcoming = [];
  List<String?> pendingNotification = [];

  void init() async {
    final exists = StorageService.exists(AppStrings.filterKey);
    if (!exists) {
      StorageService.filter = ContestFilter(
        duration: 4,
        platform: const [true, true, true, true, false],
        startDate: DateTime.now(),
        ongoing: true,
        upcoming: true,
      );
    }

    _filter = StorageService.filter;
    pendingNotification = await NotificationService.getPendingNotification();
    add(const FetchContests());
  }

  bool reminderSet(String? title) {
    return pendingNotification.contains(title);
  }

  void saveFilter() {
    StorageService.filter = _filter;
    add(const UpdateContestsList());
  }
}

extension on ContestFilter {
  bool checkPlatform(String platformName) {
    switch (platformName.toLowerCase()) {
      case 'codechef':
        return platform[0];
      case 'codeforces':
        return platform[1];
      case 'hackerearth':
        return platform[2];
      case 'hackerrank':
        return platform[3];
      default:
        return platform[4];
    }
  }

  bool check({
    Upcoming? upcoming,
    Ongoing? ongoing,
  }) {
    assert(upcoming != null || ongoing != null, '');
    final platfromCheck = checkPlatform(
      upcoming != null ? upcoming.platform : ongoing!.platform,
    );

    if (!platfromCheck) return platfromCheck;

    Duration maxDuration;
    switch (duration) {
      case 0:
        maxDuration = const Duration(hours: 2);
        break;
      case 1:
        maxDuration = const Duration(hours: 3);
        break;
      case 2:
        maxDuration = const Duration(hours: 5);
        break;
      case 3:
        maxDuration = const Duration(days: 1);
        break;
      case 4:
        maxDuration = const Duration(days: 10);
        break;
      case 5:
        maxDuration = const Duration(days: 31);
        break;
      default:
        maxDuration = Duration(days: 1e5.toInt());
    }

    final durationCheck = upcoming != null
        ? upcoming.compareDuration(maxDuration)
        : ongoing!.compareDuration(maxDuration);

    if (!durationCheck) return durationCheck;

    bool? startCheck;
    if (upcoming != null) startCheck = upcoming.compareStart(startDate!);

    startCheck ??= true;
    if (!startCheck) return startCheck;

    return true;
  }
}

extension on Upcoming {
  bool compareDuration(Duration duration) {
    return duration.compareTo(endTime.difference(startTime)) >= 0;
  }

  bool compareStart(DateTime startDate) {
    return startTime.isAfter(startDate);
  }
}

extension on Ongoing {
  bool compareDuration(Duration duration) {
    return duration.compareTo(endTime.difference(DateTime.now())) >= 0;
  }
}
