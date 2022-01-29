import 'package:flutter/material.dart';

import '../../data/services/local/storage_service.dart';
import '../../data/services/remote/api_service.dart';
import '../../domain/repositories/cp_repository.dart';
import '../../domain/repositories/user_repository.dart';

class Codephile extends StatelessWidget {
  const Codephile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }

  static Future<Widget> run() async {
    // Service
    ApiService.init();
    StorageService.init();

    // Repositories
    UserRepository.init();
    CPRepository.init();

    return const Codephile();
  }
}
