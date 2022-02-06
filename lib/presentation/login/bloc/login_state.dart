part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(true) bool rememberMe,
    @Default(false) bool isUsernameFocused,
    @Default(false) bool isPasswordFocused,
    @Default(true) bool obscurePassword,
    @Default(false) bool showDialog,
    @Default(Status()) Status status,
    @Default('') String username,
    @Default('') String password,
  }) = _LoginState;

  const LoginState._();

  bool isFormFilled() => username.isNotEmpty && password.isNotEmpty;

  bool isLoginButtonActive() => isFormFilled() && status is! Loading;
}
