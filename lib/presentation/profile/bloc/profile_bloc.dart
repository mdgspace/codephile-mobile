import 'dart:math' as math;
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/services/local/storage_service.dart';
import '../../../domain/models/activity_details.dart';
import '../../../domain/models/following.dart';
import '../../../domain/models/submission.dart';
import '../../../domain/models/submission_status.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<FetchDetails>(_onFetchDetails);
    on<UpdateYear>(_onUpdateYear);
    on<UpdateMonth>(_onUpdateMonth);
  }

  void _onFetchDetails(FetchDetails event, Emitter<ProfileState> emit) async {
    if (!state.isLoading) emit(state.copyWith(isLoading: true));

    // Fetch user details
    final User? _user;
    if (event.userId.isEmpty) {
      _user = StorageService.user;
    } else {
      _user = await UserRepository.fetchUserDetails(uid: event.userId);
    }

    final _followingList = await UserRepository.getFollowingList();

    final _subStats = await UserRepository.getSubmissionStatusData(_user!.id!);

    final _submission = _user.recentSubmissions;

    final _activityDetails = await UserRepository.getActivityDetails(_user.id!);

    final _activity = <DateTime, dynamic>{};
    for (final activity in _activityDetails ?? <ActivityDetails>[]) {
      if (activity.createdAt == null) continue;
      _activity[activity.createdAt!] = activity.correct;
    }

    final _mostRecentSubmission = <Submission>[];
    for (var index = 0;
        index < (_submission?.length ?? 0) && index < 2;
        index++) {
      _mostRecentSubmission.add(_submission![index]);
    }

    bool? _isFollowing;
    for (final follower in _followingList ?? <Following>[]) {
      if (follower.id == event.userId) {
        _isFollowing = true;
        break;
      }
    }

    _isFollowing ??= false;

    emit(state.copyWith(
      isLoading: false,
      user: _user,
      following: _followingList,
      submissionStatus: _subStats,
      submission: _submission,
      activity: _activity,
      personalProfile: event.userId.isEmpty,
      isFollowing: _isFollowing,
      currentYear: _currentYear,
      currentTriplet: _currentTriplet,
    ));
  }

  void _onUpdateYear(UpdateYear event, Emitter<ProfileState> emit) {
    if (event.increment) {
      _currentYear++;
    } else {
      _currentYear--;
    }

    emit(state.copyWith(currentYear: _currentYear));
  }

  void _onUpdateMonth(UpdateMonth event, Emitter<ProfileState> emit) {
    if (event.increment) {
      if (_currentTriplet == 3) _currentYear++;
      _currentTriplet++;
    } else {
      if (_currentTriplet == 0) _currentYear--;
      _currentTriplet--;
    }

    _currentTriplet %= 4;

    emit(state.copyWith(
      currentTriplet: _currentTriplet,
      currentYear: _currentYear,
    ));
  }

  // Index -> Index%4
  static List<String> monthTriplet(int index) {
    switch (index) {
      case 0:
        return ['Jan', 'Feb', 'Mar'];

      case 1:
        return ['Apr', 'May', 'Jun'];

      case 2:
        return ['Jul', 'Aug', 'Sep'];

      default:
        return ['Oct', 'Nov', 'Dec'];
    }
  }

  // Cell Color for Acceptance Graph
  static Color getCellColor(int index) {
    if (index < 0) {
      return Color.fromRGBO(255, 0, 0, math.min(-0.2 * index, 1));
    } else if (index > 0) {
      return Color.fromRGBO(0, 255, 0, math.min(0.2 * index, 1));
    }

    // Default cell color
    return const Color(0xFFEEEEEE);
  }

  int _currentYear = DateTime.now().year;
  int _currentTriplet = DateTime.now().month ~/ 3;
}
