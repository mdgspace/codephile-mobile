part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(FeedScreen()) Widget screen,
    @Default(0) int selectedIndex,
  }) = _HomeState;

  const HomeState._();
}
