import 'package:http/http.dart' as http;

String url = "https://codephile-test.herokuapp.com/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<bool> submissionPost(String token, String site) async {
  String endpoint = "/submission/$site";
  print(token);
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": token};
  try {
    var response = await client.post(
      uri,
      headers: tokenAuth,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;

  } on Exception catch (e) {
    print(e);
    return null;
  }
}
