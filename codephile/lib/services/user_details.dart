import 'dart:convert';
import 'dart:io';
import 'package:codephile/models/user_profile_details.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<UserProfileDetails>   getAllPlatformDetails(String token, String uId) async {

  String endpoint = "/user/fetch/$uId/";
  String uri = url + endpoint;
  var tokenAuth = {HttpHeaders.authorizationHeader: token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );

//    http.Response response = await client.get(uri);
    final jsonResponse = jsonDecode(response.body);
    UserProfileDetails user = new UserProfileDetails.fromJson(jsonResponse);
    //print(response.body);
    return user;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
