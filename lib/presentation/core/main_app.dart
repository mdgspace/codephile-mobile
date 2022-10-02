import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../data/constants/routes.dart';
import '../../data/constants/strings.dart';
import '../../data/constants/styles.dart';
import '../../data/services/local/image_service.dart';
import '../../data/services/local/storage_service.dart';
import '../../data/services/remote/api_service.dart';
import '../../data/services/remote/notification_service.dart';
import '../../domain/repositories/user_repository.dart';
import 'navigation_observer.dart';
import 'router.dart';

class Codephile extends StatelessWidget {
  const Codephile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, _) {
        return GetMaterialApp(
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: widget!,
            );
          },
          debugShowCheckedModeBanner: false,
          initialRoute: _getInitialRoute(),
          navigatorObservers: <NavigatorObserver>[
            SentryNavigatorObserver(),
            AppNavigationObserver(),
          ],
          onGenerateRoute: AppRouter.generateRoute,
          title: 'Codephile',
          theme: AppStyles.theme,
        );
      },
    );
  }

  static Future<Widget> run() async {
    ApiService.init();
    ImageService.init();
    StorageService.init();
    NotificationService.init();

    if (StorageService.exists(AppStrings.userKey, checkForNull: true)) {
      // Fetch User Details on Startup
      try {
        StorageService.user = await UserRepository.fetchUserDetails();
      } on Exception catch (err) {
        debugPrint(err.toString());
        //rethrow;
        // Rethrowing error here causes the app
        // to stuck on the splash screen.
      }
    }

    Future.delayed(const Duration(seconds: 1), FlutterNativeSplash.remove);
    return const Codephile();
  }

  String _getInitialRoute() {
    if (StorageService.newUser) {
      return AppRoutes.onboarding;
    } else if (StorageService.user != null &&
        StorageService.authToken != null) {
      return AppRoutes.home;
    } else {
      return AppRoutes.login;
    }
  }
}
