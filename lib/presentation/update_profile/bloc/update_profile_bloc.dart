import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

import '../../../data/constants/strings.dart';
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
    on<ToggleObscure>(_onToggleObscure);
    on<UpdatePassword>(_onUpdatePassword);
    on<UpdateUserDetails>(_onUpdateUserDetails);
  }

  static List<String> institutes = <String>[
    'Indian Institute of Technology Roorkee',
    'Indian Institute of Technology Delhi',
    'Indian Institute of Technology Mandi',
    'Indian Institute of Technology Indore',
    'Indian Institute of Technology Bombay',
  ];

  static User get user => StorageService.user!;

  static Map<String, TextEditingController?> controllers =
      <String, TextEditingController?>{
    'name': TextEditingController(),
    'username': TextEditingController(),
    'codechef': TextEditingController(),
    'codeforces': TextEditingController(),
    'hackerrank': TextEditingController(),
    'spoj': TextEditingController(),
    'leetcode': TextEditingController(),
    'old_pass': TextEditingController(),
    'new_pass': TextEditingController(),
    're_enter': TextEditingController(),
  };

  void _initializeTextField() {
    controllers['name']?.text = _currentUser.fullname;
    controllers['username']?.text = _currentUser.username ?? '';
    controllers['codechef']?.text = _currentUser.handle?.codechef ?? '';
    controllers['codeforces']?.text = _currentUser.handle?.codeforces ?? '';
    controllers['hackerrank']?.text = _currentUser.handle?.hackerrank ?? '';
    controllers['spoj']?.text = _currentUser.handle?.spoj ?? '';
    controllers['leetcode']?.text = _currentUser.handle?.leetcode ?? '';
  }

  void _onInitialize(Initialize event, Emitter<UpdateProfileState> emit) async {
    final instituteList = await UserRepository.getInstituteList();
    if (instituteList.isNotEmpty) {
      institutes = instituteList;
    }

    _initializeTextField();

    emit(state.copyWith(
      status: const Status(),
      user: _currentUser,
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
    _initializeTextField();
    controllers['old_pass']?.text = '';
    controllers['new_pass']?.text = '';
    controllers['re_enter']?.text = '';
    emit(state.copyWith(showChangePasswordView: !currentState));
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
      await UserRepository.updatePassword(controllers['old_pass']!.text.trim(),
          controllers['new_pass']!.text.trim());
      add(const SwitchView());
      showSnackBar(message: 'Password Changed');
    } on Failure catch (err) {
      showSnackBar(message: err.message);
    }
    emit(state.copyWith(isUpdating: false));
  }

  void _onUpdateUserDetails(
      UpdateUserDetails event, Emitter<UpdateProfileState> emit) async {
    isChanged = false;
    emit(state.copyWith(isUpdating: true));

    final errors = <String, dynamic>{};

    /// Name Field Validation
    isChanged |= controllers['name']!.text.trim() != state.user?.fullname;
    if (controllers['name']!.text.isEmpty) {
      errors['name'] = 'Required Field';
    }

    /// Username Field Validation
    if (controllers['username']!.text.isEmpty) {
      errors['username'] = 'Required Field';
    } else if (controllers['username']?.text.trim() != _currentUser.username) {
      isChanged = true;
      final res = await UserRepository.isUsernameAvailable(
          controllers['username']!.text.trim());

      if (!res) errors['username'] = 'Already Taken';
    }

    /// Handles Validation
    final platforms = [
      'codechef',
      'codeforces',
      'hackerrank',
      'spoj',
      'leetcode'
    ];
    for (final platform in platforms) {
      final handle = controllers[platform]!.text.trim();

      if (handle.isEmpty) continue;

      if (!compareHandles(platform, handle)) {
        isChanged |= true;
        final res = await UserRepository.verifyHandle(platform, handle);

        if (!res) errors[platform] = 'Invalid Handle';
      }
    }

    /// Returns if errors are not empty
    if (errors.keys.isNotEmpty || !isChanged) {
      emit(state.copyWith(isUpdating: false, errors: errors));
      return;
    }

    final updatedData = <String, dynamic>{};
    updatedData['fullname'] = controllers['name']?.text.trim();
    updatedData['username'] = controllers['username']?.text.trim();
    updatedData['institute'] = state.user!.institute;
    updatedData['handle.codechef'] = controllers['codechef']?.text.trim();
    updatedData['handle.codeforces'] = controllers['codeforces']?.text.trim();
    updatedData['handle.hackerrank'] = controllers['hackerrank']?.text.trim();
    updatedData['handle.spoj'] = controllers['spoj']?.text.trim();
    updatedData['handle.leetcode'] = controllers['leetcode']?.text.trim();

    final statusCode = await UserRepository.updateUserDetails(updatedData);

    if (state.image != null) {
      await UserRepository.uploadProfilePicture(state.image!);
    }

    if (statusCode == 202) {
      StorageService.user = await UserRepository.fetchUserDetails();
      showSnackBar(message: 'Updated Sucessfully');
      Get.back(result: true);
      return;
    }

    emit(state.copyWith(isUpdating: false));
    showSnackBar(message: AppStrings.genericError);
  }

  /// Compares the value from [TextEditingController] and [User]
  /// model of that handle. Returns true if they are same
  bool compareHandles(String platform, String value) {
    switch (platform) {
      case 'codechef':
        return value == state.user?.handle?.codechef;

      case 'codeforces':
        return value == state.user?.handle?.codeforces;

      case 'hackerrank':
        return value == state.user?.handle?.hackerrank;

      case 'spoj':
        return value == state.user?.handle?.spoj;

      case 'leetcode':
        return value == state.user?.handle?.leetcode;

      default:
        return false;
    }
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
  bool isChanged = false;
}
