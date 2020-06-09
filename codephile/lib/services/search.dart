import 'dart:io';
import 'package:codephile/models/search_results.dart';
import 'package:codephile/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<List<User>> search(String token, String query) async {
  String endpoint = "/user/search?query=$query";
//  print(endpoint);
  String uri = url + endpoint;
  print(uri);
//  var uri = Uri.https(url, endpoint, parameters);
  var tokenAuth = {HttpHeaders.authorizationHeader: token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );

    print(response.body);
    List<User> results;
    print(response.body is String);

    if (response.statusCode == 200) {
      if (response.body != "null") {
        results = searchResultUsersFromJson(response.body);
      } else {
        results = null;
      }
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
        msg: "Search query too small!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 7,
        fontSize: 12.0,
      );
      results = null;
    } else {
      results = null;
    }

    return results;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
