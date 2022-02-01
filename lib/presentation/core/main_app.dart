import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'router.dart';

import '../../data/services/local/storage_service.dart';
import '../../data/services/remote/api_service.dart';

class Codephile extends StatelessWidget {
  const Codephile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const SplashScreen(),
      navigatorObservers: <NavigatorObserver>[
        SentryNavigatorObserver(),
      ],
      onGenerateRoute: AppRouter.generateRoute,
      title: 'Codephile',
    );
  }

  static Future<Widget> run() async {
    ApiService.init();
    StorageService.init();

    return const Codephile();
  }
}
