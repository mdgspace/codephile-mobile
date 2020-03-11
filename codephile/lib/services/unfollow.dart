import 'dart:io';
import 'package:codephile/resources/strings.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<int> unfollowUser(String token, String uid) async{
  String endpoint = "/friends/unfollow?uid2=$uid";
  String uri = url + endpoint;

  var tokenAuth = {HttpHeaders.authorizationHeader: token};

  try{
    var response = await client.post(
      uri,
      headers: tokenAuth,
    );
    print(uri);
    return response.statusCode;
  }on Exception catch(e){
    print(e);
    return null;
  }
}
