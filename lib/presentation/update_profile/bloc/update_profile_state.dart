part of 'update_profile_bloc.dart';

@freezed
class UpdateProfileState with _$UpdateProfileState {
  const factory UpdateProfileState({
    @Default(Status.loading()) Status status,
    @Default(false) bool showChangePasswordView,
    File? image,
    User? user,
    @Default(-1) int activePasswordTextField,
    @Default([true, true, true]) List<bool> passwordFieldObscureState,
    @Default({}) Map<String, dynamic> errors,
    @Default(false) bool isUpdating,
  }) = _UpdateProfileState;

  const UpdateProfileState._();
}
