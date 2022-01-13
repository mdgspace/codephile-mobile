import 'dart:io';
import 'package:codephile/models/feed.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/resources/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart' as foundation;

var header = {"Content-Type": "application/json"};
http.Client client = http.Client();

Future<List<Feed>?> getFeed(String token, BuildContext context) async {
  String endpoint =
      "/feed/friend-activity?before=${DateTime.now().millisecondsSinceEpoch}";
  String uri = url + endpoint;

  var tokenAuth = {HttpHeaders.authorizationHeader: token};
  final SentryClient sentry = SentryClient(SentryOptions(dsn: dsn));
  try {
    var response = await client.get(
      Uri.parse(uri),
      headers: tokenAuth,
    );
    if (response.statusCode == 401) {
      logout(token: token, context: context);
      showToast("Please login again");
      return null;
    }
    return feedFromJson(response.body);
  } catch (error, stackTrace) {
    debugPrint('$error');
    if (foundation.kReleaseMode) {
      await sentry.captureException(
        error,
        stackTrace: stackTrace,
      );
    }
    return null;
  }
}
