import 'dart:io';

import 'package:codephile/models/submission_status_data.dart';
import 'package:codephile/resources/strings.dart';
import 'package:http/http.dart' as http;

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<SubStatusData> getSubmissionStatusData(String token, String id) async{
  String endpoint = "/graph/status/$id";
  String uri = url + endpoint;

  var tokenAuth = {HttpHeaders.authorizationHeader: token};

  try{
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );

    SubStatusData data;
    if(response.statusCode == 200){
      data = subStatusDataFromJson(response.body);
    }else{
      data = null;
    }

    return data;

  }on Exception catch(e){
    print(e);
    return null;
  }
}
