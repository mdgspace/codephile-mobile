import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../config/config.dart';
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
    Response? response;
    try {
      response = await _channel.get(
        (baseUrl ?? Environment.baseUrl) + endpoint,
        queryParameters: query,
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
          headers: headers,
        ),
      );
      return {
        'status_code': response.statusCode ?? 0,
        'data': response.data ?? 'null',
      };
    } on Exception catch (exception, stacktrace) {
      debugPrint(
        'ERROR: Failed during a GET request.\n'
        'Endpoint: $endpoint\nQuery: $query\n'
        'Exception: $exception\nStacktrace: $stacktrace',
      );
    }
    return {
      'status_code': response?.statusCode ?? 0,
      'data': response?.data ?? 'null',
    };
  }

  /// Safe method to send POST request to an endpoint **below** [Environment.baseUrl].
  static Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) async {
    Response? response;
    try {
      response = await _channel.post(
        Environment.baseUrl + endpoint,
        data: data,
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
          headers: headers,
        ),
      );
      return {
        'status_code': response.statusCode ?? 0,
        'data': response.data ?? 'null',
      };
    } on Exception catch (exception, stacktrace) {
      debugPrint(
        'ERROR: Failed during a POST request.\n'
        'Endpoint: $endpoint\nData: $data\n'
        'Exception: $exception\nStacktrace: $stacktrace',
      );
    }
    return {
      'status_code': response?.statusCode ?? 0,
      'data': response?.data ?? 'null',
    };
  }

  /// Safe method to send PUT request to an endpoint **below** [Environment.baseUrl].
  static Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) async {
    Response? response;
    try {
      response = await _channel.put(
        Environment.baseUrl + endpoint,
        data: data,
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
          headers: headers,
        ),
      );
      return {
        'status_code': response.statusCode ?? 0,
        'data': response.data ?? 'null',
      };
    } on Exception catch (exception, stacktrace) {
      debugPrint(
        'ERROR: Failed during a PUT request.\n'
        'Endpoint: $endpoint\nData: $data\n'
        'Exception: $exception\nStacktrace: $stacktrace',
      );
    }
    return {
      'status_code': response?.statusCode ?? 0,
      'data': response?.data ?? 'null',
    };
  }

  /// Adds common tokens to outgoing requests.
  static void addTokenToHeaders(Map<String, dynamic> headers) {
    final token = StorageService.authToken;
    headers.addAll({'authorization': token});
  }
}
