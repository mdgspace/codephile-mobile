import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../contests/contests_screen.dart';
import '../../feed/feed_screen.dart';
import '../../profile/profile_screen.dart';
import '../../search/search_screen.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<BottomNavItemPressed>(_changeScreen);
  }
  late final List<Widget> screens;

  void init() {
    screens = <Widget>[
      const FeedScreen(),
      const ContestsScreen(),
      SearchScreen(),
      const ProfileScreen(),
    ];
  }

  void _changeScreen(BottomNavItemPressed event, Emitter<HomeState> emit) {
    if (state.selectedIndex == event.index) return;

    emit(state.copyWith(
      screen: screens[event.index],
      selectedIndex: event.index,
    ));
  }
}
