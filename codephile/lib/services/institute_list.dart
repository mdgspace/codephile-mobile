import 'package:codephile/models/institute_list.dart';
import 'package:codephile/resources/strings.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<List<String>> getInstituteList() async {
  String endpoint = "/institutes";
  String uri = "https://codephile-test.herokuapp.com/institutes";
  //TODO: use uri= url+endpoint

  try {
    var response = await client.get(uri);

    List<String> instituteList = institutesFromJson(response.body);
    return instituteList;
  } on Exception catch (e) {
    print(e);
    return [];
  }
}
