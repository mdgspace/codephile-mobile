import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as nav;

import '../../../utils/auth_token.dart' as utils;
import '../../config/config.dart';
import '../../constants/routes.dart';

class ApiService {
  /// Service initializer
  static void init() {
    _channel = Dio()..options.contentType = Headers.formUrlEncodedContentType;
  }

  // Data
  /// The [Dio] channel through which all requests will be routed.
  static late final Dio _channel;

  /// Safe method to send GET request to an endpoint **below** [Environment.baseUrl].
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    String? baseUrl,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    bool shouldVerify = true,
  }) async {
    log('[API] [GET] >> $endpoint');
    Response? response;
    try {
      response = await _channel.get(
        (baseUrl ?? Environment.baseUrl) + endpoint,
        queryParameters: query,
        options: Options(
          validateStatus: shouldVerify ? _validateStrict : _validateLoose,
          headers: headers,
        ),
      );
    } on Exception catch (exception, stacktrace) {
      debugPrint(
        'ERROR: Failed during a GET request.\n'
        'Endpoint: $endpoint\nQuery: $query\n'
        'Exception: $exception\nStacktrace: $stacktrace',
      );
      rethrow;
    }
    log('[API] [GET] << received ${response.statusCode} from $endpoint');
    return {
      'status_code': response.statusCode ?? 0,
      'data': response.data ?? 'null',
    };
  }

  /// Safe method to send POST request to an endpoint **below** [Environment.baseUrl].
  static Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    bool shouldVerify = true,
  }) async {
    log('[API] [POST] >> $endpoint');
    Response? response;
    try {
      response = await _channel.post(
        Environment.baseUrl + endpoint,
        data: data,
        options: Options(
          validateStatus: shouldVerify ? _validateStrict : _validateLoose,
          headers: headers,
        ),
      );
    } on Exception catch (exception, stacktrace) {
      debugPrint(
        'ERROR: Failed during a POST request.\n'
        'Endpoint: $endpoint\nData: $data\n'
        'Exception: $exception\nStacktrace: $stacktrace',
      );
      rethrow;
    }
    log('[API] [POST] << received ${response.statusCode} from $endpoint');
    return {
      'status_code': response.statusCode ?? 0,
      'data': response.data ?? 'null',
    };
  }

  /// Safe method to send PUT request to an endpoint **below** [Environment.baseUrl].
  static Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    bool shouldVerify = true,
  }) async {
    log('[API] [PUT] >> $endpoint');
    Response? response;
    try {
      response = await _channel.put(
        Environment.baseUrl + endpoint,
        data: data,
        options: Options(
          validateStatus: shouldVerify ? _validateStrict : _validateLoose,
          headers: headers,
        ),
      );
    } on Exception catch (exception, stacktrace) {
      debugPrint(
        'ERROR: Failed during a PUT request.\n'
        'Endpoint: $endpoint\nData: $data\n'
        'Exception: $exception\nStacktrace: $stacktrace',
      );
      rethrow;
    }
    log('[API] [PUT] << received ${response.statusCode} from $endpoint');
    return {
      'status_code': response.statusCode ?? 0,
      'data': response.data ?? 'null',
    };
  }

  /// Adds common tokens to outgoing requests.
  static void addTokenToHeaders(Map<String, dynamic> headers) {
    headers.addAll({'authorization': utils.authToken});
  }

  /// Strict validation. Used after authentication.
  static bool _validateStrict(int? status) {
    if (status == 401) {
      utils.clearAuthToken();
      nav.Get.offAllNamed(AppRoutes.login);
    }
    return status! < 500;
  }

  /// Looser validation. Used before authentication.
  static bool _validateLoose(int? status) {
    return status! < 500;
  }
}
