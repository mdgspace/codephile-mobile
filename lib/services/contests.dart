import 'dart:convert';
import 'dart:io';
import 'package:codephile/models/contests.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/resources/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart' as foundation;

var header = {"Content-Type": "application/json"};
http.Client client = http.Client();

Future<Contests?> contestList(String token, BuildContext context) async {
  String endpoint = "/contests/";
  String uri = url + endpoint;
  var tokenAuth = {HttpHeaders.authorizationHeader: token};
  final SentryClient sentry = SentryClient(SentryOptions(dsn: dsn));

  try {
    var response = await client.get(
      Uri.parse(uri),
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 401) {
      logout(token: token, context: context);
      showToast("Please login again");
      return null;
    }
    Contests contests = Contests.fromJson(jsonResponse);
    return contests;
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
