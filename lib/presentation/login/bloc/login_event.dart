part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class PasswordInput extends LoginEvent {
  const PasswordInput(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class Submit extends LoginEvent {
  const Submit();
}

class ToggleDialog extends LoginEvent {
  const ToggleDialog({this.email});

  final String? email;

  @override
  List<Object?> get props => [email];
}

class ToggleObscure extends LoginEvent {
  const ToggleObscure();
}

class ToggleRememberMe extends LoginEvent {
  const ToggleRememberMe();
}

class UsernameInput extends LoginEvent {
  const UsernameInput(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}
