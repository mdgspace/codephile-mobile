import 'package:codephile/models/institute_list.dart';
import 'package:codephile/resources/strings.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart' as foundation;

var header = {"Content-Type": "application/json"};
http.Client client = http.Client();

Future<List<String>> getInstituteList() async {
  String uri = "https://codephile.mdg.iitr.ac.in/institutes";
  final SentryClient sentry = SentryClient(SentryOptions(dsn: dsn));

  try {
    var response = await client.get(Uri.parse(uri));

    List<String> instituteList = institutesFromJson(response.body);
    return instituteList;
  } catch (error, stackTrace) {
    foundation.debugPrint('$error');
    if (foundation.kReleaseMode) {
      await sentry.captureException(
        error,
        stackTrace: stackTrace,
      );
    }
    return [];
  }
}
