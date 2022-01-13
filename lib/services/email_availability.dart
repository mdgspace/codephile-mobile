import 'package:codephile/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = http.Client();

Future<bool> isEmailAvailable(String email) async {
  String endpoint = "/user/available?email=$email";
  String uri = url + endpoint;

  try {
    var response = await client.get(
      Uri.parse(uri),
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } on Exception catch (e) {
    debugPrint('$e');
    return true;
  }
}
