import 'package:codephile/resources/strings.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<int> uploadImage(String token, String userImagePath) async {
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
    print(response.statusCode);
    return response.statusCode;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
