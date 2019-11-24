import 'dart:convert';
import 'dart:io';
import 'package:codephile/models/search_results.dart';
import 'package:http/http.dart' as http;

String url = "https://codephile-test.herokuapp.com/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<SearchResults> search(String token, String query) async {

  String endpoint = "/user/search?query='$query'";

  String uri = url + endpoint;
//  var uri = Uri.https(url, endpoint, parameters);
  var tokenAuth = {HttpHeaders.authorizationHeader: token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );

//    print(response.statusCode);
    final jsonResponse = jsonDecode(response.body);
//    print(jsonResponse.length);

    SearchResults results = new SearchResults.fromJson(jsonResponse, response.statusCode);

    return results;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
