import 'dart:io';
import 'package:codephile/models/user.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';
import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart' as foundation;

var header = {"Content-Type": "application/json"};
http.Client client = http.Client();

Future<CodephileUser?> getUser(
    String token, String? uId, BuildContext context) async {
  String endpoint = "/user/$uId";
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
    CodephileUser user = userFromJson(response.body);

    return user;
  } catch (error, stackTrace) {
    debugPrint(error.toString());
    if (foundation.kReleaseMode) {
      await sentry.captureException(
        error,
        stackTrace: stackTrace,
      );
    }
    return null;
  }
}
