import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/resources/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<int> uploadImage(String token, String userImagePath, BuildContext context) async {
  String endpoint = "/user/picture";
  String uri = url + endpoint;
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
    if(response.statusCode == 401){
      logout(token: token, context: context);
      showToast("Please login again");
      return null;
    }
    return response.statusCode;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
