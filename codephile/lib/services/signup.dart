import 'package:codephile/models/signup.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<int> signUp(SignUp details) async {
  String endpoint = "/user/signup";
  String uri = url + endpoint;

  try {
    var response = await client.post(
      uri,
      body: {
        "username": details.username,
        "password": details.password,
        "fullname": details.fullname,
        "institute": details.institute,
        "handle.codechef": details.handle.codechef,
        "handle.codeforces": details.handle.codeforces,
        "handle.hackerrank": details.handle.hackerrank,
        "handle.spoj": details.handle.spoj
      },
    );

    return response.statusCode;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
