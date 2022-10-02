import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

import '../../../data/constants/routes.dart';
import '../../../data/constants/strings.dart';
import '../../../data/services/local/image_service.dart';
import '../../../domain/models/handle.dart';
import '../../../domain/models/sign_up.dart';
import '../../../domain/models/status.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../utils/bloc_transformer.dart';
import '../../../utils/failures.dart';
import '../widgets/signup_widgets.dart';

part 'sign_up_bloc.freezed.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

/// The Bloc for the sign-up screen.
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  /// The Bloc for the sign-up screen.
  SignUpBloc() : super(const SignUpState()) {
    on<Initialize>(_initialize);

    on<Back>(_handleBack);
    on<Next>(_handleNext);

    on<EmailInput>(
      _updateEmail,
      transformer: getDebounce<EmailInput>(),
    );
    on<InstituteInput>(
      _updateInstitute,
      transformer: getDebounce<InstituteInput>(),
    );
    on<NameInput>(
      _updateName,
      transformer: getDebounce<NameInput>(),
    );
    on<PasswordInput>(
      _updatePassword,
      transformer: getDebounce<PasswordInput>(),
    );
    on<PlatformHandleInput>(
      _updateHandles,
      transformer: getDebounce<PlatformHandleInput>(),
    );
    on<UsernameInput>(
      _updateUsername,
      transformer: getDebounce<UsernameInput>(),
    );

    on<SelectImage>(_selectImage);
    on<ToggleObscure>(_toggleObscurePassword);
  }

  static List<String> institutes = <String>[
    'Indian Institute of Technology Roorkee',
    'Indian Institute of Technology Delhi',
    'Indian Institute of Technology Mandi',
    'Indian Institute of Technology Indore',
    'Indian Institute of Technology Bombay',
  ];

  Future<void> _initialize(Initialize event, Emitter<SignUpState> emit) async {
    // initialize controllers
    final newState = state.copyWith(
      status: const Status(),
      emailController: TextEditingController(),
      instituteController: TextEditingController(),
      nameController: TextEditingController(),
      passwordController: TextEditingController(),
      usernameController: TextEditingController(),
      handleControllers: {
        'codechef': TextEditingController(),
        'hackerrank': TextEditingController(),
        'codeforces': TextEditingController(),
        'spoj': TextEditingController(),
        'leetcode': TextEditingController(),
      },
    );
    emit(newState);
    // fetch list of institutes
    final newInstitutes = await UserRepository.getInstituteList();
    if (newInstitutes.isNotEmpty) {
      institutes = newInstitutes;
      emit(newState.copyWith(numberOfInstitutes: institutes.length));
    }
  }

  void _handleBack(Back event, Emitter<SignUpState> emit) {
    if (state.pageIndex == 0) {
      Get.back();
    } else {
      emit(state.copyWith(pageIndex: state.pageIndex - 1));
    }
  }

  Future<void> _handleNext(Next event, Emitter<SignUpState> emit) async {
    if (state.pageIndex < signUpPages.length - 1) {
      emit(state.copyWith(pageIndex: state.pageIndex + 1));
    } else {
      // Last page
      emit(state.copyWith(status: const Status.loading()));
      final details = SignUp(
        fullname: state.nameController!.text,
        email: state.emailController!.text,
        institute: state.instituteController!.text,
        username: state.usernameController!.text,
        password: state.passwordController!.text,
        handle: Handle(
          codechef: state.handleControllers['codechef']!.text,
          hackerrank: state.handleControllers['hackerrank']!.text,
          codeforces: state.handleControllers['codeforces']!.text,
          spoj: state.handleControllers['spoj']!.text,
          leetcode: state.handleControllers['leetcode']!.text,
        ),
      );

      try {
        // Check if unique identity is unique
        final isEmailUnique =
            await UserRepository.isEmailAvailable(details.email);
        final isUsernameUnique =
            await UserRepository.isUsernameAvailable(details.username);
        if (!isEmailUnique) throw const DuplicateEmail();
        if (!isUsernameUnique) throw const DuplicateUsername();

        // Sign up
        final id = await UserRepository.signUp(details);
        if (id == null || !id.isNotEmpty) throw const InternalFailure();
        // ELSE
        Get.offAllNamed(
          AppRoutes.verify,
          arguments: {
            'username': state.usernameController!.text,
            'password': state.passwordController!.text,
            'userId': id,
            'profilePicture': state.image,
          },
        );
      } on Failure catch (failure) {
        emit(state.copyWith(status: Status.error(failure.message)));
        // Reset status after three seconds.
        await Future.delayed(const Duration(seconds: 3));
        emit(state.copyWith(status: const Status()));
      }
    }
  }

  void _selectImage(SelectImage event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(image: await ImageService.pickProfileImage()));
  }

  void _toggleObscurePassword(ToggleObscure event, Emitter<SignUpState> emit) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> _updateEmail(EmailInput event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(
      emailController: state.emailController?.updateWith(event.value),
    ));
    if (event.value.isNotEmpty &&
        RegExp(AppStrings.emailValidationRegex).hasMatch(event.value)) {
      final isEmailUnique = await UserRepository.isEmailAvailable(event.value);
      emit(state.copyWith(isEmailUnique: isEmailUnique));
    } else {
      emit(state.copyWith(isEmailUnique: true));
    }
  }

  void _updateInstitute(InstituteInput event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
      instituteController: state.instituteController?.updateWith(event.value),
    ));
  }

  void _updateName(NameInput event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
      nameController: state.nameController?.updateWith(event.value),
    ));
  }

  void _updatePassword(PasswordInput event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
      passwordController: state.passwordController?.updateWith(event.value),
    ));
  }

  Future<void> _updateUsername(
    UsernameInput event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(
      usernameController: state.usernameController?.updateWith(event.value),
    ));
    if (event.value.length >= 3) {
      final isUsernameUnique =
          await UserRepository.isUsernameAvailable(event.value);
      emit(state.copyWith(isUsernameUnique: isUsernameUnique));
    } else {
      emit(state.copyWith(isUsernameUnique: true));
    }
  }

  void _updateHandles(PlatformHandleInput event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
      handleControllers: {
        ...state.handleControllers,
        event.platform:
            state.handleControllers[event.platform]?.updateWith(event.value),
      },
    ));
  }
}

extension on TextEditingController {
  TextEditingController updateWith(String value) {
    final controller = TextEditingController(text: value);
    // ignore: cascade_invocations
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
      // TextPosition(offset: selection.baseOffset),
    );
    return controller;
  }
}
