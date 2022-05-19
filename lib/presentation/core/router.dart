import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../data/constants/routes.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';
import '../onboarding/onboarding_screen.dart';
import '../signup/signup_screen.dart';
import '../signup/verify_screen.dart';
import '../update_profile/bloc/update_profile_bloc.dart';
import '../update_profile/update_profile.dart';

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
          page: () => const HomeScreen(),
          routeName: settings.name,
          settings: settings,
        );
      case AppRoutes.signUp:
        return GetPageRoute(
          page: () => const SignUpScreen(),
          routeName: settings.name,
          settings: settings,
        );
      case AppRoutes.verify:
        return GetPageRoute(
          page: () => VerifyScreen(settings.arguments as Map<String, dynamic>),
          routeName: settings.name,
          settings: settings,
        );
      case AppRoutes.updateProfile:
        return GetPageRoute(
          page: () => BlocProvider(
            create: (context) => UpdateProfileBloc()..add(const Initialize()),
            child: const UpdateProfile(),
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
