import 'dart:io';

import 'package:codephile/models/feed.dart';
import 'package:codephile/resources/strings.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<List<Feed>> getFeed({String token}) async {
  String endpoint =
      "/feed/friend-activity?before=${DateTime.now().millisecondsSinceEpoch}";
  String uri = url + endpoint;

  var tokenAuth = {HttpHeaders.authorizationHeader: token};

  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    return feedFromJson(response.body);
  } catch (e) {
    print(e.toString());
    return null;
  }
}
