import 'dart:convert';
import 'package:codephile/models/submission.dart';
import 'package:http/http.dart' as http;

String url = "https://codephile-test.herokuapp.com/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<Submission> submissionList() async {
  String endpoint = "/submission/";
  String uid = "5dda30645c2ead0004283d4a";
  String uri = url + endpoint + uid;
  var tokenAuth = {"Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NzcwMjQ3MzMsImlhdCI6MTU3NDYwNTUzMywiaXNzIjoibWRnIiwic3ViIjoiNWRkYTMwNjQ1YzJlYWQwMDA0MjgzZDRhIn0.RvjHMryrrh64BOEscCd6Ynqda_lnjruWqyzuD_JpQDE"};
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
