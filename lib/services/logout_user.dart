import 'dart:io';

import 'package:codephile/resources/strings.dart';
import "package:http/http.dart" as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<bool> logoutUser(String token) async {
  String endpoint = "/user/logout";
  String uri = url + endpoint;
  var tokenAuth = {HttpHeaders.authorizationHeader: token};

  try {
    var response = await client.post(Uri.parse(uri), headers: tokenAuth);

    if (response.statusCode == 200) return true;

    return false;
  } on Exception catch (e) {
    print(e);
    return false;
  }
}
