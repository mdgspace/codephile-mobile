import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/constants/routes.dart';

/// Wrapper for a single method to be passed to [GetMaterialApp.onGenerateRoute].
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return GetPageRoute(
          // page: () => const SplashScreen(),
          routeName: settings.name,
          settings: settings,
        );
      case AppRoutes.home:
        return GetPageRoute(
          // page: () => const HomeScreen(),
          routeName: settings.name,
          settings: settings,
        );
      case AppRoutes.login:
        return GetPageRoute(
          // page: () => const LoginScreen(),
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
