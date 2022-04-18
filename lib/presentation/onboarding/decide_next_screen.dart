import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../../data/constants/routes.dart';
import '../../data/services/local/storage_service.dart';

Future<void> decideNextScreen() async {
  await Future.delayed(const Duration(seconds: 1));
  if (!StorageService.newUser) {
    if (StorageService.user != null && StorageService.authToken != null) {
      Get.offNamed(AppRoutes.home);
    } else {
      Get.offNamed(AppRoutes.login);
    }
  }
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
}
