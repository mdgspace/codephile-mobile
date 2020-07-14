import 'dart:convert';
import 'dart:io';
import 'package:codephile/models/contests.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/resources/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<Contests> contestList(String token, BuildContext context) async {
  String endpoint = "/contests/";
  String uri = url + endpoint;
  var tokenAuth = {HttpHeaders.authorizationHeader: token};

  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    if(response.statusCode == 401){
      logout(token: token, context: context);
      showToast("Please login again");
      return null;
    }
    Contests contests = new Contests.fromJson(jsonResponse);

    return contests;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
