part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class BottomNavItemPressed extends HomeEvent {
  const BottomNavItemPressed({required this.index});
  final int index;

  @override
  List<Object?> get props => [index];
}
