import 'package:codephile/models/submission.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';
import 'package:sentry/sentry.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<List<Submission>> getSubmissionList(String token, String uId, BuildContext context) async {
  String endpoint = "/submission/all/";
  String uri = url + endpoint + uId;
  var tokenAuth = {"Authorization": token};
  final SentryClient sentry = new SentryClient(dsn: dsn);

  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    if(response.statusCode == 401){
      logout(token: token, context: context);
      showToast("Please login again");
      return null;
    }
    List<Submission> submissionList = submissionFromJson(response.body);
    return submissionList;

  } catch(error, stackTrace){
    print(error);
    await sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
    return null;
  }
}
