import 'dart:io';

import 'package:codephile/models/feed.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/resources/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<List<Feed>> getFeed(String token, BuildContext context) async {
  String endpoint =
      "/feed/friend-activity?before=${DateTime.now().millisecondsSinceEpoch}";
  String uri = url + endpoint;

  var tokenAuth = {HttpHeaders.authorizationHeader: token};

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

    return feedFromJson(response.body);
  } catch (e) {
    print(e.toString());
    return null;
  }
}
