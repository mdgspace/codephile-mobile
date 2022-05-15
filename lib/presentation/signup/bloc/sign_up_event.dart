part of 'sign_up_bloc.dart';

/// Base event class for [SignUpBloc].
abstract class SignUpEvent extends Equatable {
  /// Base event class for [SignUpBloc].
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

/// Added when the user wants to go back one screen.
class Back extends SignUpEvent {
  /// Added when the user wants to go back one screen.
  const Back();
}

/// Added when the text in the email field is changed.
class EmailInput extends SignUpEvent {
  /// Added when the text in the email field is changed.
  const EmailInput(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

/// Added when the screen first loads.
class Initialize extends SignUpEvent {
  /// Added when the screen first loads.
  const Initialize();
}

/// Added when the text in the institute field is changed.
class InstituteInput extends SignUpEvent {
  /// Added when the text in the institute field is changed.
  const InstituteInput(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

/// Added when the text in the name field is changed.
class NameInput extends SignUpEvent {
  /// Added when the text in the name field is changed.
  const NameInput(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

/// Added when the user wants to go to the next screen.
class Next extends SignUpEvent {
  /// Added when the user wants to go to the next screen.
  const Next();
}

/// Added when the text in the password field is changed.
class PasswordInput extends SignUpEvent {
  /// Added when the text in the password field is changed.
  const PasswordInput(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

/// Added when the text in the handle fields is changed.
class PlatformHandleInput extends SignUpEvent {
  /// Added when the text in the handle fields is changed.
  const PlatformHandleInput({required this.platform, required this.value});

  final String platform;
  final String value;

  @override
  List<Object> get props => [platform, value];
}

/// Added when the user taps the image selector.
class SelectImage extends SignUpEvent {
  /// Added when the user taps the image selector.
  const SelectImage();
}

/// Added when the password field's eye icon is pressed.
class ToggleObscure extends SignUpEvent {
  /// Added when the password field's eye icon is pressed.
  const ToggleObscure();
}

/// Added when the text in the username field is changed.
class UsernameInput extends SignUpEvent {
  /// Added when the text in the username field is changed.
  const UsernameInput(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}
