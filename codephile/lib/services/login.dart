import 'package:codephile/models/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = "https://codephile-test.herokuapp.com/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future login(String username, String pass) async {
  String endpoint = "/user/login";
  String uri = url + endpoint;
  print(username + pass);
  Token token;
//  var json = {
//    "username": username,
//    "password": pass,
//  };
  try {
    var response = await client.post(
      uri,
      body: {'username': username, 'password': pass},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      token = new Token.fromJson(jsonResponse);
      return token;
    }
    return null;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}