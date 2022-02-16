import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../data/constants/routes.dart';
import '../home/bloc/home_bloc.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';
import '../onboarding/onboarding_screen.dart';

/// Wrapper for a single method to be passed to [GetMaterialApp.onGenerateRoute].
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return GetPageRoute(
          page: () => const LoginScreen(),
          routeName: settings.name,
          settings: settings,
        );
      case AppRoutes.onboarding:
        return GetPageRoute(
          page: () => OnboardingScreen(),
          routeName: settings.name,
          settings: settings,
        );
      case AppRoutes.home:
        return GetPageRoute(
          page: () => BlocProvider(
            create: (context) => HomeBloc()..init(),
            child: const HomeScreen(),
          ),
          routeName: settings.name,
          settings: settings,
        );
      default:
        return GetPageRoute(
          page: () => Scaffold(
            body: Center(
              child: Text(
                'No route defined for '
                '${settings.name}',
              ),
            ),
          ),
          routeName: '/undefined',
          settings: settings,
        );
    }
  }
}
