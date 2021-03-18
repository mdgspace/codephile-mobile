import 'dart:io';
import 'package:codephile/models/submission_status_data.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/resources/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart' as Foundation;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<SubStatusData> getSubmissionStatusData(
    String token, String id, BuildContext context) async {
  String endpoint = "/graph/status/$id";
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
    SubStatusData data;
    if (response.statusCode == 200) {
      data = subStatusDataFromJson(response.body);
    } else {
      data = null;
    }

    return data;
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
