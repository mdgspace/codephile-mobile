import 'package:http/http.dart' as http;

String url = "https://codephile-test.herokuapp.com/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<bool> handleVerify(String site, String handle) async {
  String endpoint = "/user/verify/$site?handle=$handle";
  String uri = url + endpoint;
  print(uri);
  var tokenAuth = {"Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1Nzg0MDUzNjMsImlhdCI6MTU3NTk4NjE2MywiaXNzIjoibWRnIiwic3ViIjoiNWRkYTMwNjQ1YzJlYWQwMDA0MjgzZDRhIn0.YszcPWJWrQ5iQ1hYSYmNOGZp_TSjq7PHCEQoJ1SCA2w"};
  print(site + handle);
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }
    return null;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}