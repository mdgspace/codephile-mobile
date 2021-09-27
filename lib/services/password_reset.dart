import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';
import 'package:sentry/sentry.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future resetPassword(String email) async {
  String endpoint = "/user/password-reset-email";
  String uri = url + endpoint;
  final SentryClient sentry = new SentryClient(SentryOptions(dsn: dsn));
  try {
    var response = await client.post(
      Uri.parse(uri),
      body: {'email': email},
    );
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (error, stackTrace) {
    print(error);
    await sentry.captureException(
      error,
      stackTrace: stackTrace,
    );
    return false;
  }
}
