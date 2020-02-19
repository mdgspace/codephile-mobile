import 'dart:convert';
import 'package:codephile/models/submission.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<Submission> getSubmissionList(String token, String uId) async {
  String endpoint = "/submission/";
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
