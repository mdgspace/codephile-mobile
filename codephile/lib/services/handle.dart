import 'dart:convert';
import 'package:http/http.dart' as http;

String url = "https://codephile-test.herokuapp.com/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<bool> handleVerify(String site, String handle) async {
  String endpoint = "/user/verify/";
  String uri = url + endpoint + site;
  print(handle);
  try {
    var response = await client.post(
      uri,
      body: {"handle": handle},
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