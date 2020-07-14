import 'package:codephile/resources/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:codephile/resources/strings.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<bool> submissionPost(String token, String site, BuildContext context) async {
  String endpoint = "/submission/$site";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": token};
  try {
    var response = await client.post(
      uri,
      headers: tokenAuth,
    );
    if(response.statusCode == 401){
      logout(token: token, context: context);
      showToast("Please login again");
      return null;
    }
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
