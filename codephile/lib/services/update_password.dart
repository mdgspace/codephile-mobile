import 'dart:convert';
import 'dart:io';
import 'package:codephile/resources/strings.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<int> updatePassword(String token, String oldPassword, String newPassword) async{
  String endpoint = "/user/password-reset";
  String uri = url + endpoint;

  var tokenAuth = {HttpHeaders.authorizationHeader : token};

  try{
    var response = await client.post(
      uri,
      headers: tokenAuth,
      body: jsonEncode(<String, String>{
        "new_password" : newPassword,
        "old_password" : oldPassword,
      })
    );

    return response.statusCode;
  }on Exception catch(e){
    print(e);
    return null;
  }
}
