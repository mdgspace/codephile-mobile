import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'data/constants/strings.dart';
import 'presentation/core/main_app.dart';

Future<void> main() async {
  // Necessary if you intend to initialize in an async function.
  WidgetsFlutterBinding.ensureInitialized();

  await _initHive();
  final hydratedStorage = await _initHydratedBloc();

  // Zone for Hydrated Bloc.
  HydratedBlocOverrides.runZoned(
    () async => runApp(await Codephile.run()),
    storage: hydratedStorage,
  );
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  await Hive.openBox(AppStrings.hiveBoxName);
}

Future<Storage> _initHydratedBloc() async {
  return HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationSupportDirectory(),
  );
}
