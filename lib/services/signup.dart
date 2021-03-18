import 'dart:convert';

import 'package:codephile/models/signup.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<dynamic> signUp(SignUp details) async {
  String endpoint = "/user/signup";
  String uri = url + endpoint;

  try {
    var response = await client.post(
      uri,
      body: {
        "username": details.username,
        "email": details.email,
        "password": details.password,
        "fullname": details.fullname,
        "institute": details.institute,
        "handle.codechef": details.handle.codechef,
        "handle.codeforces": details.handle.codeforces,
        "handle.hackerrank": details.handle.hackerrank,
        "handle.spoj": details.handle.spoj
      },
    );
    print(response.body);
    final json = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return {
        "statusCode": 201,
        "response": json["id"],
      };
    } else if (response.statusCode == 409) {
      return {
        "statusCode": 409,
        "response": "Username Already Taken!",
      };
    } else if (response.statusCode == 400) {
      return {
        "statusCode": 400,
        "response": "Bad request! Empty fields.",
      };
    } else if (response.statusCode == 500) {
      return {
        "statusCode": 500,
        "response": "Server error.",
      };
    } else {
      return {
        "statusCode": response.statusCode,
        "response": "Something went wrong!😔",
      };
    }
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
