import 'dart:convert';
import 'dart:io';

import '../../data/config/config.dart';
import '../../data/constants/strings.dart';
import '../../data/services/local/storage_service.dart';
import '../../data/services/remote/api_service.dart';
import '../../utils/auth_token.dart' as auth_token_utils;
import '../../utils/failures.dart';
import '../models/activity_details.dart';
import '../models/following.dart';
import '../models/sign_up.dart';
import '../models/submission_status.dart';
import '../models/user.dart';
import '../models/user_profile.dart';

class UserRepository {
  // Data
  /// Authorization token for API requests.
  ///
  /// Vanishes after each session.
  static String? authToken;

  // Methods
  /// Checks whether the passed email entered is unique.
  static Future<bool> isEmailAvailable(String email) async {
    final endpoint = 'user/available?email=$email';

    final response = await ApiService.get(endpoint, shouldVerify: false);

    return response['status_code'] == 200;
  }

  /// Checks whether the username entered is unique.
  static Future<bool> isUsernameAvailable(String username) async {
    final endpoint = 'user/available?username=$username';

    final response = await ApiService.get(endpoint, shouldVerify: false);

    return response['status_code'] == 200;
  }

  /// Registers the user.
  static Future<String?> signUp(SignUp details) async {
    const endpoint = 'user/signup';
    final data = {...details.toJson(), ...details.handle?.toJson() ?? {}}
      ..remove('handle');

    final response = await ApiService.post(
      endpoint,
      data: data,
      shouldVerify: false,
    );

    switch (response['status_code']) {
      case 201:
        return json.decode(response['data'])['id'];
      case 400:
        throw const IncorrectFormat();
      case 409:
        throw const SimilarUserExists();
      default:
        throw const InternalFailure();
    }
  }

  /// Upload profile picture.
  static Future<bool> uploadProfilePicture(File profilePicture) async {
    const endpoint = 'user/picture';
    final headers = <String, dynamic>{};
    ApiService.addTokenToHeaders(headers);

    final response = await ApiService.putLarge(
      endpoint,
      headers: headers,
      file: profilePicture,
    );

    return response['status_code'] == 200;
  }

  /// Logs in the user.
  static Future<void> login({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    const endpoint = 'user/login';

    final response = await ApiService.post(
      endpoint,
      data: {
        'username': username,
        'password': password,
      },
      shouldVerify: false,
    );

    switch (response['status_code']) {
      case 200:
        auth_token_utils.setAuthToken(
          response['data']['token'],
          shouldPersist: rememberMe,
        );
        StorageService.user = await fetchUserDetails();
        return;
      case 400:
        throw const IncorrectFormat();
      case 401:
        throw const IncorrectCredentials();
      case 403:
        throw const UnverifiedEmail();
      default:
        throw const InternalFailure();
    }
  }

  static Future<bool> logout() async {
    const endpoint = 'user/logout';
    final headers = <String, dynamic>{};

    ApiService.addTokenToHeaders(headers);
    final response = await ApiService.post(
      endpoint,
      headers: headers,
    );

    return response['status_code'] == 200;
  }

  /// Sends a new confirmation link to user's registered email.
  static Future<bool> sendVerifyEmail(String uid) async {
    final endpoint = 'user/send-verify-email/$uid';

    final response = await ApiService.post(endpoint);

    return response['status_code'] == 200;
  }

  /// Requests a password reset.
  static Future<void> resetPassword(String email) async {
    const endpoint = 'user/password-reset-email';

    final response = await ApiService.post(
      endpoint,
      data: {'email': email},
    );

    switch (response['status_code']) {
      case 200:
        return;
      case 403:
        throw const EmailNotFound();
      default:
        throw const InternalFailure();
    }
  }

  static Future<int> followUser(String uid) async {
    final endpoint = 'friends/follow?uid2=$uid';
    final headers = <String, dynamic>{};

    ApiService.addTokenToHeaders(headers);
    final response = await ApiService.post(
      endpoint,
      headers: headers,
    );

    return response['status_code'];
  }

  static Future<int> unfollowUser(String uid) async {
    final endpoint = 'friends/unfollow?uid2=$uid';
    final headers = <String, dynamic>{};

    ApiService.addTokenToHeaders(headers);
    final response = await ApiService.post(
      endpoint,
      headers: headers,
    );

    return response['status_code'];
  }

  static Future<List<Following>?> getFollowingList() async {
    const endpoint = 'friends/following';
    final headers = <String, dynamic>{};

    ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return List<Following>.from(
        response['data'].map((e) => Following.fromJson(e)),
      );
    }

    throw Exception(AppStrings.genericError);
  }

  static Future<bool> verifyHandle(String site, String handle) async {
    final endpoint = 'user/verify/$site?handle=$handle';

    final response = await ApiService.post(
      endpoint,
    );

    return response['status_code'] == 200;
  }

  static Future<List<User>> search(String query) async {
    final endpoint = 'user/search?query=$query';
    final headers = <String, dynamic>{};

    ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      headers: headers,
    );

    final _users = <User>[];
    if (response['status_code'] == 200) {
      for (final user in response['data'] ?? []) {
        _users.add(User.fromJson(user));
      }
    }

    return _users;
  }

  /// Get a list the names of recognized institutes.
  static Future<List<String>> getInstituteList() async {
    final headers = <String, dynamic>{};
    ApiService.addTokenToHeaders(headers);

    final response = await ApiService.get(
      'institutes',
      baseUrl: Environment.baseUrl.replaceAll('/v1', ''),
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return List<String>.from(response['data']);
    }

    return [];
  }

  static Future<SubmissionStatus?> getSubmissionStatusData(
    String id,
  ) async {
    final endpoint = 'graph/status/$id';
    final headers = <String, dynamic>{};

    ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return SubmissionStatus.fromJson(response['data']);
    }

    throw Exception(AppStrings.genericError);
  }

  static Future<List<ActivityDetails>?> getActivityDetails(String id) async {
    final endpoint = 'graph/activity/$id';
    final headers = <String, dynamic>{};

    ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return List<ActivityDetails>.from(
        response['data'].map((e) => ActivityDetails.fromJson(e)),
      );
    }

    throw Exception(AppStrings.genericError);
  }

  static Future updatePassword(
    String oldPassword,
    String newPassword,
  ) async {
    const endpoint = 'user/password-reset';
    final headers = <String, dynamic>{};

    ApiService.addTokenToHeaders(headers);
    final response = await ApiService.post(
      endpoint,
      headers: headers,
      data: <String, String>{
        'new_password': newPassword,
        'old_password': oldPassword,
      },
    );

    switch (response['status_code']) {
      case 200:
        return;
      case 403:
        throw const IncorrectCredentials();
      default:
        throw const InternalFailure();
    }
  }

  static Future<int> updateUserDetails(Map<String, dynamic>? data) async {
    const endpoint = 'user/';
    final headers = <String, dynamic>{};

    ApiService.addTokenToHeaders(headers);
    final response = await ApiService.post(
      endpoint,
      headers: headers,
      data: data,
    );

    return response['status_code'];
  }

  /// Fetches details of user with the given [uid]. To fetch info about
  /// currently logged in user, call without arguments.
  static Future<User?> fetchUserDetails({String uid = ''}) async {
    final endpoint = '/user/$uid';
    final headers = <String, dynamic>{};

    ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return User.fromJson(response['data']);
    }
    return null;
  }

  static Future<UserProfile?> getAllPlatformDetails(String uid) async {
    final endpoint = '/user/fetch/$uid';
    final headers = <String, dynamic>{};

    ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return UserProfile.fromJson(json.decode(response['data']));
    }
    return null;
  }
}
