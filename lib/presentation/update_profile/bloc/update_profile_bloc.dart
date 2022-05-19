import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/services/local/image_service.dart';
import '../../../data/services/local/storage_service.dart';
import '../../../domain/models/status.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/user_repository.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';
part 'update_profile_bloc.freezed.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(const UpdateProfileState()) {
    on<Initialize>(_onInitialize);
    on<SelectImage>(_onSelectImage);
    on<UpdateInstitute>(_onUpdateInstitute);
  }

  void _onInitialize(Initialize event, Emitter<UpdateProfileState> emit) async {
    final _instituteList = await UserRepository.getInstituteList();
    if (_instituteList.isEmpty) {
      _instituteList.addAll([
        'Indian Institute of Technology Roorkee',
        'Indian Institute of Technology Delhi',
        'Indian Institute of Technology Mandi',
        'Indian Institute of Technology Indore',
        'Indian Institute of Technology Bombay'
      ]);
    }

    emit(state.copyWith(
      status: const Status(),
      instituteList: _instituteList,
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

  final User _currentUser = StorageService.user!;
  User _updatedUser = StorageService.user!;
}
