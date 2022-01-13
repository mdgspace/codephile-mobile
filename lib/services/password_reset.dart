import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';
import 'package:sentry/sentry.dart';

var header = {"Content-Type": "application/json"};
http.Client client = http.Client();

Future<bool> resetPassword(String email) async {
  String endpoint = "/user/password-reset-email";
  String uri = url + endpoint;
  final SentryClient sentry = SentryClient(SentryOptions(dsn: dsn));
  try {
    var response = await client.post(
      Uri.parse(uri),
      body: {'email': email},
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (error, stackTrace) {
    debugPrint('$error');
    await sentry.captureException(
      error,
      stackTrace: stackTrace,
    );
    return false;
  }
}
