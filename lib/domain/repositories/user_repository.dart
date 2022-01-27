import '../../data/services/local/storage_service.dart';

import '../../data/services/remote/api_service.dart';
import '../models/sign_up.dart';

class UserRepository {
  const UserRepository();

  Future<bool> isEmailAvailable(String email) async {
    final endPoint = 'user/available?email=$email';

    try {
      await ApiService.post(
        endPoint,
      );
      return true;
    } on Exception catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<bool> isUsernameAvailable(String username) async {
    final endpoint = 'user/available?username=$username';

    try {
      await ApiService.post(
        endpoint,
      );

      return true;
    } on Exception catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<String> signUp(SignUp details) async {
    const endpoint = 'user/signup';
    final data = {...details.toJson(), ...details.handle?.toJson() ?? {}}
      ..remove('handle');
    try {
      final response = await ApiService.post(
        endpoint,
        data: data,
      );

      return response['id'];
    } on Exception catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<String> login(String username, String password) async {
    const endpoint = 'user/login';

    try {
      final response = await ApiService.post(
        endpoint,
        data: {
          'username': username,
          'password': password,
        },
      );

      return response['token'];
    } on Exception catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<bool> logout() async {
    const endPoint = 'user/logout';

    try {
      await ApiService.post(
        endPoint,
        headers: {'authorization': StorageService.authToken},
      );

      return true;
    } on Exception catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<bool> sendVerifyEmail(String uid) async {
    final endpoint = 'user/send-verify-email/$uid';

    try {
      await ApiService.post(
        endpoint,
      );

      return true;
    } on Exception catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<bool> resetPassword(String email) async {
    const endpoint = 'user/password-reset-email';

    try {
      await ApiService.post(
        endpoint,
        data: {'email': email},
      );

      return true;
    } on Exception catch (err) {
      throw Exception(err.toString());
    }
  }
}
