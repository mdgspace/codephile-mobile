import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';
import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart' as Foundation;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future sendVerifyEmail(String uid) async {
  String endpoint = "/user/send-verify-email/";
  String uri = url + endpoint + uid;
  final SentryClient sentry = new SentryClient(dsn: dsn);

  try {
    await client.post(
      uri,
    );
    return 1;
  } catch (error, stackTrace) {
    print(error);
    if (Foundation.kReleaseMode) {
      await sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
    return null;
  }
}
