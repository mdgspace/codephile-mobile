import 'dart:io';
import 'package:codephile/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<User> getUser(String token, String uId) async {
  String endpoint = "/user/$uId";
  String uri = url + endpoint;
  var tokenAuth = {HttpHeaders.authorizationHeader: token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );

    print(response.body);
    User user = userFromJson(response.body);

    return user;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
