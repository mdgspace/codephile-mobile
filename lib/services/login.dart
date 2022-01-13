import 'package:codephile/models/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:codephile/resources/strings.dart';
import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart' as foundation;

var header = {"Content-Type": "application/json"};
http.Client client = http.Client();

Future<Token?> login(String? username, String? pass) async {
  String endpoint = "/user/login";
  String uri = url + endpoint;
  Token token;
  final SentryClient sentry = SentryClient(SentryOptions(dsn: dsn));

  try {
    var response = await client.post(
      Uri.parse(uri),
      body: {'username': username, 'password': pass},
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      token = Token.fromJson(jsonResponse);
      return token;
    } else if (response.statusCode == 403) {
      return Token(token: "unverified");
    } else if (response.statusCode == 401) {
      return Token(token: "wrong credentials");
    }
    return null;
  } catch (error, stackTrace) {
    foundation.debugPrint('$error');
    if (foundation.kReleaseMode) {
      await sentry.captureException(
        error,
        stackTrace: stackTrace,
      );
    }
    return null;
  }
}
