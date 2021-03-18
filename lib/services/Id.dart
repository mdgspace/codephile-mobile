import 'package:codephile/models/user.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:codephile/resources/strings.dart';
import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart' as Foundation;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<String> id(String token, BuildContext context) async {
  String endpoint = "/user/";
  String uri = url + endpoint;
  CodephileUser user;

  var tokenAuth = {HttpHeaders.authorizationHeader: token};

  final SentryClient sentry = new SentryClient(dsn: dsn);

  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    if(response.statusCode == 401){
      logout(token: token, context: context);
      showToast("Please login again");
      return null;
    }
    final jsonResponse = jsonDecode(response.body);
    user = new CodephileUser.fromJson(jsonResponse);
    return user.id;

  } catch(error, stackTrace){
    print(error);
    if(Foundation.kReleaseMode) {
      await sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
    return null;
  }
}
