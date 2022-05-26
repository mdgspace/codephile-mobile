import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/services/local/storage_service.dart';
import '../../../domain/repositories/user_repository.dart';
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

  void init() async {
    // Fetch User Details on Startup
    try {
      StorageService.user = await UserRepository.fetchUserDetails();
    } on Exception catch (err) {
      debugPrint(err.toString());
    }
    screens = <Widget>[
      const FeedScreen(),
      const ContestsScreen(),
      const SearchScreen(),
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
