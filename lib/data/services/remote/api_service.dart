import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as nav;

import '../../config/config.dart';
import '../../constants/routes.dart';
import '../../constants/strings.dart';
import '../local/storage_service.dart';

class ApiService {
  /// Service initializer
  static void init() => _channel = Dio();

  // Data
  /// The [Dio] channel through which all requests will be routed.
  static late final Dio _channel;

  /// Safe method to send GET request to an endpoint **below** [Environment.baseUrl].
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    String? baseUrl,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    log('[API] [GET] >> $endpoint');
    Response? response;
    try {
      response = await _channel.get(
        (baseUrl ?? Environment.baseUrl) + endpoint,
        queryParameters: query,
        options: Options(
          validateStatus: _validate,
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
  }) async {
    log('[API] [POST] >> $endpoint');
    Response? response;
    try {
      response = await _channel.post(
        Environment.baseUrl + endpoint,
        data: data,
        options: Options(
          validateStatus: _validate,
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
  }) async {
    log('[API] [PUT] >> $endpoint');
    Response? response;
    try {
      response = await _channel.put(
        Environment.baseUrl + endpoint,
        data: data,
        options: Options(
          validateStatus: _validate,
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
    final token = StorageService.authToken;
    headers.addAll({'authorization': token});
  }

  static bool _validate(int? status) {
    if (status == 401) {
      StorageService.delete(AppStrings.authTokenKey);
      nav.Get.offAllNamed(AppRoutes.login);
    }
    return status! < 500;
  }
}
