part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchDetails extends ProfileEvent {
  const FetchDetails({this.userId = ''});

  final String userId;

  @override
  List<Object?> get props => [userId];
}

class UpdateYear extends ProfileEvent {
  const UpdateYear({required this.increment});

  final bool increment;

  @override
  List<Object?> get props => [increment];
}

class UpdateMonth extends ProfileEvent {
  const UpdateMonth({required this.increment});

  final bool increment;

  @override
  List<Object?> get props => [increment];
}
