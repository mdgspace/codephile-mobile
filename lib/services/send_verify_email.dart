import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';
import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart' as foundation;

var header = {"Content-Type": "application/json"};
http.Client client = http.Client();

Future sendVerifyEmail(String uid) async {
  String endpoint = "/user/send-verify-email/";
  String uri = url + endpoint + uid;
  final SentryClient sentry = SentryClient(SentryOptions(dsn: dsn));

  try {
    await client.post(
      Uri.parse(uri),
    );
    return 1;
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
