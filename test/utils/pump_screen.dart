import 'package:codephile/presentation/core/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

/// Pumps a screen, wrapping it with the necessary configuration widgets.
Future<void> pumpScreen(WidgetTester tester, Widget Function() screen) async {
  await tester.pumpWidget(
    ScreenUtilInit(
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
          onGenerateRoute: AppRouter.generateRoute,
          home: screen(),
        );
      },
    ),
  );
}
