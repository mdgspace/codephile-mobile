import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/resources/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart' as Foundation;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<int> uploadImage(
    String token, String userImagePath, BuildContext context) async {
  String endpoint = "/user/picture";
  String uri = url + endpoint;
  final SentryClient sentry = new SentryClient(SentryOptions(dsn: dsn));

  try {
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(uri),
    );
    request.headers['authorization'] = token;
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      userImagePath,
    ));

    var response = await request.send();
    if (response.statusCode == 401) {
      logout(token: token, context: context);
      showToast("Please login again");
      return null;
    }
    return response.statusCode;
  } catch (error, stackTrace) {
    print(error);
    if (Foundation.kReleaseMode) {
      await sentry.captureException(
        error,
        stackTrace: stackTrace,
      );
    }
    return null;
  }
}
