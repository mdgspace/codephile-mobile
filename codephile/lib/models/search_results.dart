import 'dart:convert';
import 'user.dart';

SearchResults searchResultsFromJson(String str, int statusCode) => SearchResults.fromJson(json.decode(str), statusCode);

String contestsToJson(SearchResults data) => json.encode(data.toJson());

class SearchResults{
  List<User> users;
  int statusCode;

  SearchResults({
    this.users,
    this.statusCode
  });

  factory SearchResults.fromJson(List<dynamic> json, int statusCode) => SearchResults(
    users: List<User>.from(json.map((x) => User.fromJson(x))),
    statusCode: statusCode
  );

  //TODO: implement function
  Map<String, dynamic> toJson() => {};
  
}
