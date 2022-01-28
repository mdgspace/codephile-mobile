import 'dart:convert';

import '../../data/services/remote/api_service.dart';
import '../models/following.dart';
import '../models/sign_up.dart';
import '../models/submission_status.dart';
import '../models/user.dart';
import '../models/user_profile.dart';

class UserRepository {
  const UserRepository();

  Future<bool> isEmailAvailable(String email) async {
    final endpoint = 'user/available?email=$email';

    final response = await ApiService.post(
      endpoint,
    );

    return response['status_code'] == 200;
  }

  Future<bool> isUsernameAvailable(String username) async {
    final endpoint = 'user/available?username=$username';

    final response = await ApiService.post(
      endpoint,
    );

    return response['status_code'] == 200;
  }

  Future<String?> signUp(SignUp details) async {
    const endpoint = 'user/signup';
    final data = {...details.toJson(), ...details.handle?.toJson() ?? {}}
      ..remove('handle');

    final response = await ApiService.post(
      endpoint,
      data: data,
    );

    if (response['status_code'] == 200) {
      return json.decode(response['data'])['id'];
    }
  }

  Future<String?> login(String username, String password) async {
    const endpoint = 'user/login';

    final response = await ApiService.post(
      endpoint,
      data: {
        'username': username,
        'password': password,
      },
    );

    if (response['status_code'] == 200) {
      return json.decode(response['data'])['token'];
    }
  }

  Future<bool> logout() async {
    const endpoint = 'user/logout';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.post(
      endpoint,
      headers: headers,
    );

    return response['status_code'] == 200;
  }

  Future<bool> sendVerifyEmail(String uid) async {
    final endpoint = 'user/send-verify-email/$uid';

    final response = await ApiService.post(
      endpoint,
    );

    return response['status_code'] == 200;
  }

  Future<bool> resetPassword(String email) async {
    const endpoint = 'user/password-reset-email';

    final response = await ApiService.post(
      endpoint,
      data: {'email': email},
    );

    return response['status_code'] == 200;
  }

  Future<int> followUser(String uid) async {
    final endpoint = 'friends/follow?uid2=$uid';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.post(
      endpoint,
      headers: headers,
    );

    return response['status_code'];
  }

  Future<int> unfollowUser(String uid) async {
    final endpoint = 'friends/unfollow?uid2=$uid';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.post(
      endpoint,
      headers: headers,
    );

    return response['status_code'];
  }

  Future<List<Following>?> getFollowingList() async {
    const endpoint = 'friends/following';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return List<Following>.from(
        json.decode(response['data']).map((e) => Following.fromJson(e)),
      );
    }
  }

  Future<bool> verifyHandle(String site, String handle) async {
    final endpoint = 'user/verify/$site?handle=$handle';

    final response = await ApiService.post(
      endpoint,
    );

    return response['status_code'] == 200;
  }

  Future<List<User>?> search(String query) async {}

  Future<List<String>> getInstituteList() async {
    const endpoint = 'institutes';
    const baseUrl = 'https://codephile.mdg.iitr.ac.in/';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      baseUrl: baseUrl,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return List<String>.from(
        json.decode(response['data']).map((e) => e),
      );
    }

    return [];
  }

  // search

  Future<List<SubmissionStatus>?> getSubmissionStatusData(String id) async {
    final endpoint = 'graph/status/$id';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return List<SubmissionStatus>.from(
        json.decode(response['data'])?.map((e) => SubmissionStatus.fromJson(e)),
      );
    }
  }

  Future<int> updatePassword(String oldPassword, String newPassword) async {
    const endpoint = 'user/password-reset';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.post(
      endpoint,
      headers: headers,
      data: <String, String>{
        'new_password': newPassword,
        'old_password': oldPassword,
      },
    );

    return response['status_code'];
  }

  Future<int> updateUserDetails(Map<String, dynamic>? data) async {
    const endpoint = 'user/';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.post(
      endpoint,
      headers: headers,
      data: data,
    );

    return response['status_code'];
  }

  Future<User?> getUser(String uid) async {
    final endpoint = '/user/$uid';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return User.fromJson(json.decode(response['data']));
    }
  }

  Future<UserProfile?> getAllPlatformDetails(String uid) async {
    final endpoint = '/user/fetch/$uid';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return UserProfile.fromJson(json.decode(response['data']));
    }
  }
}
