part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object?> get props => [];
}

class Initialize extends UpdateProfileEvent {
  const Initialize();
}

class SelectImage extends UpdateProfileEvent {
  const SelectImage();
}

class UpdateInstitute extends UpdateProfileEvent {
  const UpdateInstitute({required this.institute});

  final String institute;

  @override
  List<Object?> get props => [institute];
}

class SwitchView extends UpdateProfileEvent {
  const SwitchView();
}

class UpdateFocusField extends UpdateProfileEvent {
  const UpdateFocusField({required this.index});

  final int index;

  @override
  List<Object?> get props => [index];
}

class ToggleObscure extends UpdateProfileEvent {
  const ToggleObscure({required this.index});

  final int index;

  @override
  List<Object?> get props => [index];
}

class UpdatePassword extends UpdateProfileEvent {
  const UpdatePassword();
}

class UpdateUserDetails extends UpdateProfileEvent {
  const UpdateUserDetails();
}
