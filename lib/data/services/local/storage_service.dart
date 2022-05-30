import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/models/contest_filter.dart';
import '../../../domain/models/user.dart';
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
  ///
  /// Stored across sessions.
  static String? get authToken => _get<String>(AppStrings.authTokenKey);

  /// Authorization token for API requests.
  ///
  /// Stored across sessions.
  static set authToken(String? token) =>
      _set<String>(AppStrings.authTokenKey, token);

  /// Currently logged in user.
  static User? get user {
    try {
      return User.fromJson(json.decode(_get<String>(AppStrings.userKey) ?? ''));
    } on FormatException catch (_) {
      // This just means that the user has not been stored previously.
      return null;
    }
  }

  /// Currently logged in user.
  static set user(User? u) {
    try {
      _set<String>(AppStrings.userKey, json.encode(u!.toJson()));
    } on Exception catch (_) {
      // This just means that the passed object is null.
      _set<String?>(AppStrings.userKey, null);
    }
  }

  static ContestFilter? get filter {
    try {
      return ContestFilter.fromJson(
          json.decode(_get<String>(AppStrings.filterKey)!));
    } on Exception catch (_) {
      return null;
    }
  }

  /// recent searches
  static List<User>? get recentSearches {
    try {
      return List<User>.from(json
          .decode(_get<String>(AppStrings.recentSearchKey) ?? '')
          .map((e) => User.fromJson(e)));
    } on Exception catch (_) {
      return null;
    }
  }

  static set recentSearches(List<User>? users) {
    try {
      _set<String>(AppStrings.recentSearchKey,
          json.encode(users!.map((user) => user.toJson()).toList()));
    } on Exception catch (_) {
      _set<String?>(AppStrings.recentSearchKey, null);
    }
  }

  static set filter(ContestFilter? _filter) =>
      _set(AppStrings.filterKey, json.encode(_filter!.toJson()));
}
