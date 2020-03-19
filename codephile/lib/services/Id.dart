import 'package:codephile/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:codephile/resources/strings.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<String> id(String token) async {
  String endpoint = "/user/";
  String uri = url + endpoint;
  User user;

  var tokenAuth = {HttpHeaders.authorizationHeader: token};

  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );

    final jsonResponse = jsonDecode(response.body);
    user = new User.fromJson(jsonResponse);
    print(user.id);
    return user.id;

  } on Exception catch (e) {
    print(e);
    return null;
  }
}
