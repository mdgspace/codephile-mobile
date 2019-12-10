import 'dart:convert';
import 'package:codephile/models/submission.dart';
import 'package:http/http.dart' as http;

String url = "https://codephile-test.herokuapp.com/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<Submission> submissionList(String token, String uId) async {
  String endpoint = "/submission/";
  print(uId);
  print(token);
  String uri = url + endpoint + uId;
  var tokenAuth = {"Authorization": token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Submission submission = new Submission.fromJson(jsonResponse);
    return submission;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
