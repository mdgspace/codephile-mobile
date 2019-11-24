import 'dart:convert';
import 'dart:io';
import 'package:codephile/models/contests.dart';
import 'package:http/http.dart' as http;

String url = "https://codephile-test.herokuapp.com/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<Contests> contestList(String token) async {

  String endpoint = "/contests/";
  String uri = url + endpoint;
  var tokenAuth = {HttpHeaders.authorizationHeader: token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );

//    http.Response response = await client.get(uri);

    final jsonResponse = jsonDecode(response.body);
    Contests contests = new Contests.fromJson(jsonResponse);
    //print(response.body);
    //print(contests.result.ongoing);
    return contests;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
