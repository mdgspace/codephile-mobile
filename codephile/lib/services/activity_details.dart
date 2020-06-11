import 'dart:io';
import 'package:codephile/models/activity_details.dart';
import 'package:codephile/resources/strings.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<List<ActivityDetails>> getActivityDetails(
    String token, String uid) async {
  String endpoint = "/graph/activity/$uid";
  String uri = url + endpoint;
  var tokenAuth = {HttpHeaders.authorizationHeader: token};

  try {
    var response = await client.get(uri, headers: tokenAuth);
    return activityDetailsFromJson(response.body);
  } on Exception catch (error) {
    print(error);
    return null;
  }
}
