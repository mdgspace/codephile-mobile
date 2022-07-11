part of 'login_bloc.dart';

@freezed

/// State class for [LoginBloc].
class LoginState with _$LoginState {
  /// State class for [LoginBloc].
  const factory LoginState({
    /// Whether the password field should be obscured.
    @Default(true) bool obscurePassword,

    /// State of the "Keep me signed in" checkbox.
    @Default(true) bool rememberMe,

    /// Whether the "Forgot Password" dialog should be displayed.
    @Default(false) bool showDialog,

    /// State of the screen.
    @Default(Status()) Status status,

    /// Value in the username field.
    @Default('') String username,

    /// Value in the password field.
    @Default('') String password,
  }) = _LoginState;

  const LoginState._();

  /// The form is considered filled when both fields are non-empty.
  bool isFormFilled() => username.isNotEmpty && password.isNotEmpty;

  /// The login button is active when the form is filled and the screen is not loading.
  bool isLoginButtonActive() => isFormFilled() && status is! Loading;
}
