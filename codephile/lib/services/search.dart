import 'dart:io';
import 'package:codephile/models/search_results.dart';
import 'package:codephile/models/user.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';
import 'package:sentry/sentry.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<List<CodephileUser>> search(String token, String query, BuildContext context) async {
  String endpoint = "/user/search?query=$query";
  String uri = url + endpoint;
  final SentryClient sentry = new SentryClient(dsn: dsn);

  var tokenAuth = {HttpHeaders.authorizationHeader: token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );

    List<CodephileUser> results;
    if(response.statusCode == 401){
      logout(token: token, context: context);
      showToast("Please login again");
      return null;
    }
    if (response.statusCode == 200) {
      if (response.body != "null") {
        results = searchResultUsersFromJson(response.body);
      } else {
        results = null;
      }
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
        msg: "Search query too small!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 7,
        fontSize: 12.0,
      );
      results = null;
    } else {
      results = null;
    }

    return results;
  } catch(error, stackTrace){
    print(error);
    await sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
    return null;
  }
}
