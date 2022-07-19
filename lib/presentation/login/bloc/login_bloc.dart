import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

import '../../../data/constants/routes.dart';
import '../../../data/constants/strings.dart';
import '../../../domain/models/status.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../utils/failures.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

/// The Bloc for the login screen.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// The Bloc for the login screen.
  LoginBloc() : super(const LoginState()) {
    on<ToggleDialog>(_toggleDialog);
    on<PasswordInput>(_updatePasswordInput);
    on<Submit>(_submitForm);
    on<ToggleObscure>(_toggleObscurePassword);
    on<ToggleRememberMe>(_toggleRememberMe);
    on<UsernameInput>(_updateUsernameInput);
  }

  void _submitForm(Submit event, Emitter<LoginState> emit) async {
    if (!state.isFormFilled()) return;

    emit(state.copyWith(
      status: const Status.loading(),
    ));

    try {
      await UserRepository.login(
        username: state.username,
        password: state.password,
        rememberMe: state.rememberMe,
      );
      Get.offNamed(AppRoutes.home);
    } on Failure catch (failure) {
      emit(state.copyWith(status: Status.error(failure.message)));
      // Reset status after three seconds.
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(status: const Status()));
    }
  }

  void _toggleDialog(ToggleDialog event, Emitter<LoginState> emit) async {
    if (event.email == null) {
      emit(state.copyWith(
        showDialog: !state.showDialog,
        status: const Status(),
      ));
    } else {
      if (event.email!.isEmpty) return;
      emit(state.copyWith(
        showDialog: !state.showDialog,
        status: const Status.loading(),
      ));
      try {
        await UserRepository.resetPassword(event.email!);
        emit(state.copyWith(
          status: const Status(AppStrings.passwordResetSuccess),
        ));
      } on Failure catch (failure) {
        emit(state.copyWith(status: Status.error(failure.message)));
        // Reset status after three seconds.
        await Future.delayed(const Duration(seconds: 3));
        emit(state.copyWith(status: const Status()));
      }
    }
  }

  void _toggleObscurePassword(ToggleObscure event, Emitter<LoginState> emit) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _toggleRememberMe(ToggleRememberMe event, Emitter<LoginState> emit) {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  void _updatePasswordInput(PasswordInput event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.value));
  }

  void _updateUsernameInput(UsernameInput event, Emitter<LoginState> emit) {
    emit(state.copyWith(username: event.value));
  }
}
