part of 'update_profile_bloc.dart';

@freezed
class UpdateProfileState with _$UpdateProfileState {
  const factory UpdateProfileState({
    @Default(Status.loading()) Status status,
    File? image,
    User? user,
    List<String>? instituteList,
  }) = _UpdateProfileState;

  const UpdateProfileState._();
}
