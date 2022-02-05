import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

import '../../../data/constants/routes.dart';
import '../../../domain/models/status.dart';
import '../../../domain/repositories/user_repository.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(rememberMe: true)) {
    on<ToggleDialog>(_toggleDialog);
    on<PasswordInput>(_updatePasswordInput);
    on<Submit>(_submitForm);
    on<ToggleObscure>(_toggleObscurePassword);
    on<ToggleRememberMe>(_toggleRememberMe);
    on<UsernameInput>(_updateUsernameInput);
  }

  void _submitForm(Submit event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: const Status.loading()));

    final result = await UserRepository.login(
      username: state.username,
      password: state.password,
      rememberMe: state.rememberMe,
    );

    if (result == 'Success') {
      Get.offNamed(AppRoutes.home);
    } else {
      if (result == 'Unverified') {
        emit(state.copyWith(
          status: const Status.error(
            'Please verify your email before attempting to log in\n'
            'Check your email for the verification link',
          ),
        ));
      } else if (result == 'Unauthorized') {
        emit(state.copyWith(
          status: const Status.error('Incorrect credentials'),
        ));
      } else {
        emit(state.copyWith(
          status: const Status.error('Something went wrong'),
        ));
      }
    }
  }

  void _toggleDialog(ToggleDialog event, Emitter<LoginState> emit) async {
    if (event.email != null) {
      emit(state.copyWith(
        showDialog: !state.showDialog,
        status: const Status.loading(),
      ));
      if (event.email!.isEmpty) return;
      final result = await UserRepository.resetPassword(event.email!);
      if (result == null) {
        emit(state.copyWith(
          status: const Status.error('Something went wrong'),
        ));
      } else if (result) {
        emit(state.copyWith(
          status: const Status(
            'Success! Please check your email for a password reset link',
          ),
        ));
      } else {
        emit(state.copyWith(
          status: const Status.error(
            'No user associated with given email address',
          ),
        ));
      }
    } else {
      emit(state.copyWith(showDialog: !state.showDialog));
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
