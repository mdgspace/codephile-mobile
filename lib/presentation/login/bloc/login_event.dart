part of 'login_bloc.dart';

/// Base event class for [LoginBloc].
abstract class LoginEvent extends Equatable {
  /// Base event class for [LoginBloc].
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

/// Added when the text in the password field is changed.
class PasswordInput extends LoginEvent {
  /// Added when the text in the password field is changed.
  const PasswordInput(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

/// Added when the login button is pressed.
class Submit extends LoginEvent {
  /// Added when the login button is pressed.
  const Submit();
}

/// Added when the "Forgot Password" button is pressed or the dialog is closed.
class ToggleDialog extends LoginEvent {
  /// Added when the "Forgot Password" button is pressed or the dialog is closed.
  const ToggleDialog({this.email});

  /// Value entered in the text field in the dialog.
  final String? email;

  @override
  List<Object?> get props => [email];
}

/// Added when the password field's eye icon is pressed.
class ToggleObscure extends LoginEvent {
  /// Added when the password field's eye icon is pressed.
  const ToggleObscure();
}

/// Added when the "Keep me signed in" checkbox is toggled.
class ToggleRememberMe extends LoginEvent {
  /// Added when the "Keep me signed in" checkbox is toggled.
  const ToggleRememberMe();
}

/// Added when the text in the username field is changed.
class UsernameInput extends LoginEvent {
  /// Added when the text in the username field is changed.
  const UsernameInput(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}
