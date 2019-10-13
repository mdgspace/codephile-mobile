import 'dart:convert';
import 'package:codephile/models/signup.dart';
import 'package:http/http.dart' as http;

String url = "https://codephile-test.herokuapp.com/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<bool> signUp(SignUp details) async {
  String endpoint = "/user/signup";
  String uri = url + endpoint;
  var json = details;
  try {
    var response = await client.post(
      uri,
      headers: header,
      body: jsonEncode(json),
    );
    if (response.statusCode == 200) {
      return true;
    }
    return null;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}