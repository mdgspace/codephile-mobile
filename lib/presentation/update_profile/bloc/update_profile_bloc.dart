import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/services/local/image_service.dart';
import '../../../data/services/local/storage_service.dart';
import '../../../domain/models/status.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../utils/failures.dart';
import '../../../utils/snackbar.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';
part 'update_profile_bloc.freezed.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(const UpdateProfileState()) {
    on<Initialize>(_onInitialize);
    on<SelectImage>(_onSelectImage);
    on<UpdateInstitute>(_onUpdateInstitute);
    on<SwitchView>(_onSwitchView);
    on<UpdateFocusField>(_onUpdateFocusField);
    on<ToggleObscure>(_onToggleObscure);
    on<UpdatePassword>(_onUpdatePassword);
  }

  static List<String> institutes = <String>[
    'Indian Institute of Technology Roorkee',
    'Indian Institute of Technology Delhi',
    'Indian Institute of Technology Mandi',
    'Indian Institute of Technology Indore',
    'Indian Institute of Technology Bombay',
  ];

  void _onInitialize(Initialize event, Emitter<UpdateProfileState> emit) async {
    final _instituteList = await UserRepository.getInstituteList();
    if (_instituteList.isNotEmpty) {
      institutes = _instituteList;
    }

    final _controllers = <String, TextEditingController?>{
      'codechef': TextEditingController(),
      'codeforces': TextEditingController(),
      'hackerrank': TextEditingController(),
      'spoj': TextEditingController(),
      'leetcode': TextEditingController(),
      'old_pass': TextEditingController(),
      'new_pass': TextEditingController(),
      're_enter': TextEditingController(),
    };

    emit(state.copyWith(
      status: const Status(),
      user: _currentUser,
      controllers: _controllers,
    ));
  }

  void _onSelectImage(
      SelectImage event, Emitter<UpdateProfileState> emit) async {
    emit(state.copyWith(image: await ImageService.pickProfileImage()));
  }

  void _onUpdateInstitute(
      UpdateInstitute event, Emitter<UpdateProfileState> emit) {
    _updatedUser = _updatedUser.copyWith(institute: event.institute);

    emit(state.copyWith(user: _updatedUser));
  }

  void _onSwitchView(SwitchView event, Emitter<UpdateProfileState> emit) {
    final currentState = state.showChangePasswordView;
    final _controllers = state.controllers;
    _controllers['old_pass']?.text = '';
    _controllers['new_pass']?.text = '';
    _controllers['re_enter']?.text = '';
    emit(state.copyWith(
      showChangePasswordView: !currentState,
      activePasswordTextField: -1,
      controllers: _controllers,
    ));
  }

  void _onUpdateFocusField(
      UpdateFocusField event, Emitter<UpdateProfileState> emit) {
    emit(state.copyWith(activePasswordTextField: event.index));
  }

  void _onToggleObscure(ToggleObscure event, Emitter<UpdateProfileState> emit) {
    final list = state.passwordFieldObscureState;
    emit(state.copyWith(passwordFieldObscureState: [
      ...List.generate(
        list.length,
        (index) {
          if (index == event.index) return !list[index];
          return list[index];
        },
      )
    ]));
  }

  void _onUpdatePassword(
      UpdatePassword event, Emitter<UpdateProfileState> emit) async {
    emit(state.copyWith(isUpdating: true));
    try {
      await UserRepository.updatePassword(state.controllers['old_pass']!.text,
          state.controllers['new_pass']!.text);
      add(const SwitchView());
      showSnackBar(message: 'Password Changed');
    } on Failure catch (err) {
      showSnackBar(message: err.message);
    }
    emit(state.copyWith(isUpdating: false));
  }

  Future<bool> onWillPop() async {
    if (state.showChangePasswordView) {
      add(const SwitchView());
      return false;
    }

    return true;
  }

  final User _currentUser = StorageService.user!;
  User _updatedUser = StorageService.user!;
}
