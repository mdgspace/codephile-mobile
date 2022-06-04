import 'package:get/get.dart';

import '../../data/constants/routes.dart';
import '../../data/services/local/storage_service.dart';

Future<void> decideNextScreen() async {
  if (!StorageService.newUser) {
    if (StorageService.user != null && StorageService.authToken != null) {
      Get.offNamed(AppRoutes.home);
    } else {
      Get.offNamed(AppRoutes.login);
    }
  }
}
