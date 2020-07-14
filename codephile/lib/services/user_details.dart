import 'dart:convert';
import 'dart:io';
import 'package:codephile/models/user_profile_details.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';
import 'package:sentry/sentry.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<UserProfileDetails> getAllPlatformDetails(
    String token, String uId, BuildContext context) async {
  String endpoint = "/user/fetch/$uId/";
  String uri = url + endpoint;
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
    UserProfileDetails user = new UserProfileDetails.fromJson(jsonResponse);
    return user;
  } catch(error, stackTrace){
    print(error);
    await sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
    return null;
  }
}
