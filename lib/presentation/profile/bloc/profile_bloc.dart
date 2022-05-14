import 'dart:math' as math;
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/constants/strings.dart';
import '../../../data/services/local/storage_service.dart';
import '../../../domain/models/activity_details.dart';
import '../../../domain/models/following.dart';
import '../../../domain/models/status.dart';
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
    on<ShowFollowing>(_onShowFollowing);
  }

  void _onFetchDetails(FetchDetails event, Emitter<ProfileState> emit) async {
    if (state.status is! Loading) {
      emit(state.copyWith(status: const Status.loading()));
    }

    // Fetch user details
    if (event.userId.isEmpty) {
      _user = StorageService.user;
    } else {
      _user = await UserRepository.fetchUserDetails(uid: event.userId);
    }

    SubmissionStatus? _subStats;
    List<ActivityDetails>? _activityDetails;
    // TODO(aman-singh7): Throw specific Error
    try {
      _followingList = await UserRepository.getFollowingList();

      _subStats = await UserRepository.getSubmissionStatusData(_user!.id!);

      _activityDetails = await UserRepository.getActivityDetails(_user!.id!);
    } on Exception catch (_) {
      emit(state.copyWith(status: const Status.error(AppStrings.genericError)));
      return;
    }

    for (final activity in _activityDetails ?? <ActivityDetails>[]) {
      if (activity.createdAt == null) continue;
      _activity[activity.createdAt!] = activity.correct;
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
      status: const Status(),
      user: _user,
      following: _followingList,
      submissionStatus: _subStats,
      personalProfile: event.userId.isEmpty,
      isFollowing: _isFollowing,
      currentYear: _currentYear,
      currentTriplet: _currentTriplet,
      showFollowing: false,
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

  void _onShowFollowing(ShowFollowing event, Emitter<ProfileState> emit) async {
    if (event.toShow) {
      _followingList = await UserRepository.getFollowingList();
    }
    emit(state.copyWith(
      following: _followingList,
      showFollowing: event.toShow,
    ));
  }

  static Future follow(String userId) async {
    final statuscode = await UserRepository.followUser(userId);

    if (statuscode != 200) {
      throw Exception(AppStrings.genericError);
    }
  }

  static Future unfollow(String userId) async {
    final statuscode = await UserRepository.unfollowUser(userId);

    if (statuscode != 200) {
      throw Exception(AppStrings.genericError);
    }
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
  Color getCellColor(DateTime date) {
    final index = _activity[date] ?? 0;
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
  List<Following>? _followingList;
  User? _user;
  final Map<DateTime, dynamic> _activity = <DateTime, dynamic>{};
}
