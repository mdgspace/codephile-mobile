part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();
}

class Initialize extends UpdateProfileEvent {
  const Initialize();

  @override
  List<Object?> get props => [];
}

class SelectImage extends UpdateProfileEvent {
  const SelectImage();

  @override
  List<Object?> get props => [];
}

class UpdateInstitute extends UpdateProfileEvent {
  const UpdateInstitute({required this.institute});

  final String institute;

  @override
  List<Object?> get props => [institute];
}

class SwitchView extends UpdateProfileEvent {
  const SwitchView();

  @override
  List<Object?> get props => [];
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

  @override
  List<Object?> get props => [];
}
