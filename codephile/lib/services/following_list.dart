import 'dart:io';
import 'package:codephile/models/following.dart';
import 'package:codephile/resources/strings.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<List<Following>> getFollowingList(String token) async{
  String endpoint = "/follow/following";
  String uri = url + endpoint;

  var tokenAuth = {HttpHeaders.authorizationHeader: token};

  try{
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );

    List<Following> followingList = followingFromJson(response.body);
    return followingList;

  }on Exception catch(e){
    print(e);
    return null;
  }
}
