import 'package:codephile/models/submission.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<List<Submission>> getSubmissionList(String token, String uId) async {
  String endpoint = "/submission/all/";
  String uri = url + endpoint + uId;
  var tokenAuth = {"Authorization": token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    List<Submission> submissionList = submissionFromJson(response.body);
    return submissionList;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
