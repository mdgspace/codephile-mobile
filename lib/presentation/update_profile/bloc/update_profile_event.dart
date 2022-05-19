part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();
}

class Initialize extends UpdateProfileEvent {
  const Initialize();

  @override
  List<Object?> get props => [];
}

class SelectImage extends UpdateProfileEvent {
  const SelectImage();

  @override
  List<Object?> get props => [];
}

class UpdateInstitute extends UpdateProfileEvent {
  const UpdateInstitute({required this.institute});

  final String institute;

  @override
  List<Object?> get props => [institute];
}
