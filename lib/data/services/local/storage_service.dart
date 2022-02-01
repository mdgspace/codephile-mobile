import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/strings.dart';

class StorageService {
  /// Service initializer
  static void init() => _box = Hive.box(AppStrings.hiveBoxName);

  // Data
  /// The Hive [Box] which contains all data stored by the app.
  static late final Box _box;

  // CRUD methods
  static T? _get<T>(String key) => _box.get(key);

  static void _set<T>(String key, T? value) => _box.put(key, value);

  /// Remove a key from storage.
  static T? delete<T>(String key) {
    final T? value = _box.get(key);
    _box.delete(key);
    return value;
  }

  /// Safely check whether a key exists in storage.
  /// Optionally check if the value is non-null.
  static bool exists(String key, {bool checkForNull = false}) {
    if (!_box.containsKey(key)) return false;
    return !checkForNull || _box.get(key) != null;
  }

  /// Get a stream of [BoxEvent]s performed on a particular [key].
  static Stream<BoxEvent> stream(String key) => _box.watch(key: key);

  // Specific getters and setters
  /// Authorization token for API requests.
  static String? get authToken => _get<String>(AppStrings.authTokenKey);

  /// Authorization token for API requests.
  static set authToken(String? token) =>
      _set<String>(AppStrings.authTokenKey, token);
}
