import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/local/storage_service.dart';
import '../../data/services/remote/api_service.dart';
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

    return MultiRepositoryProvider(
      providers: <RepositoryProvider>[
        RepositoryProvider(
          create: (context) => const UserRepository(),
        ),
      ],
      child: const Codephile(),
    );
  }
}
