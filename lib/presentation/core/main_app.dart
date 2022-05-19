import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../data/constants/routes.dart';
import '../../data/constants/styles.dart';
import '../../data/services/local/image_service.dart';
import '../../data/services/local/storage_service.dart';
import '../../data/services/remote/api_service.dart';
import 'navigation_observer.dart';
import 'router.dart';

class Codephile extends StatelessWidget {
  const Codephile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () {
        return GetMaterialApp(
          builder: (context, widget) {
            ScreenUtil.setContext(context);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: widget!,
            );
          },
          debugShowCheckedModeBanner: false,
          // TODO(developers): Update this with the screen you're testing.
          initialRoute: AppRoutes.home,
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

    return const Codephile();
  }
}
