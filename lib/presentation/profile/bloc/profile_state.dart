part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(true) bool isLoading,
    @Default(true) bool personalProfile,
    @Default(false) bool isFollowing,
    User? user,
    List<Following>? following,
    SubmissionStatus? submissionStatus,
    List<Submission>? submission,
    Map<DateTime, dynamic>? activity,
    int? currentYear,
    int? currentTriplet,
  }) = _ProfileState;

  const ProfileState._();
}
