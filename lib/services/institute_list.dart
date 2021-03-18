import 'package:codephile/models/institute_list.dart';
import 'package:codephile/resources/strings.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart' as Foundation;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<List<String>> getInstituteList() async {
  String uri = "https://codephile.mdg.iitr.ac.in/institutes";
  final SentryClient sentry = new SentryClient(dsn: dsn);

  try {
    var response = await client.get(uri);

    List<String> instituteList = institutesFromJson(response.body);
    return instituteList;
  } catch (error, stackTrace) {
    print(error);
    if(Foundation.kReleaseMode) {
      await sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
    return [];
  }
}
