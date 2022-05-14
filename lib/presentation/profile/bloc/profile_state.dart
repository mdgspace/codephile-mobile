part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(Status.loading()) Status status,
    @Default(true) bool personalProfile,
    @Default(false) bool isFollowing,
    @Default(false) bool showFollowing,
    User? user,
    List<Following>? following,
    SubmissionStatus? submissionStatus,
    int? currentYear,
    int? currentTriplet,
  }) = _ProfileState;

  const ProfileState._();
}
