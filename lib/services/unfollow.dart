import 'dart:io';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/resources/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = http.Client();

Future<int?> unfollowUser(
    String token, String? uid, BuildContext context) async {
  String endpoint = "/friends/unfollow?uid2=$uid";
  String uri = url + endpoint;

  var tokenAuth = {HttpHeaders.authorizationHeader: token};

  try {
    var response = await client.post(
      Uri.parse(uri),
      headers: tokenAuth,
    );
    if (response.statusCode == 401) {
      logout(token: token, context: context);
      showToast("Please login again");
      return null;
    }
    return response.statusCode;
  } on Exception catch (e) {
    debugPrint(e.toString());
    return null;
  }
}
