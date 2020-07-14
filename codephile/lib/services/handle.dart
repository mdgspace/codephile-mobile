import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<bool> verifyHandle(String site, String handle) async {
  String endpoint = "/user/verify/$site?handle=$handle";
  String uri = url + endpoint;

  try {
    var response = await client.get(
      uri,
    );

    if (response.statusCode == 200) {
      return true;
    }
    return null;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
