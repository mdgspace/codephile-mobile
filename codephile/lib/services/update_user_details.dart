import 'dart:io';

import 'package:codephile/resources/strings.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<int> updateUserDetails(String token, var body) async {
  String endpoint = "/user/";
  String uri = url + endpoint;

  var tokenAuth = {HttpHeaders.authorizationHeader: token};
  try {
    var response = await client.put(
      uri,
      headers: tokenAuth,
      body: body,
    );

    return response.statusCode;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
