import 'package:flutter/material.dart';

import '../../data/services/local/storage_service.dart';
import '../../data/services/remote/api_service.dart';

class Codephile extends StatelessWidget {
  const Codephile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }

  static Future<Widget> run() async {
    ApiService.init();
    StorageService.init();

    return const Codephile();
  }
}
