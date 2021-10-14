import 'package:codephile/resources/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = http.Client();

Future<bool?> isUsernameAvailable(String? username) async {
  String endpoint = "/user/available?username=$username";
  String uri = url + endpoint;

  try {
    var response = await client.get(
      Uri.parse(uri),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } on Exception catch (e) {
    debugPrint(e.toString());
    return null;
  }
}
