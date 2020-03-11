// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
import 'package:codephile/models/user.dart';

List<User> searchResultUsersFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String searchResultUsersToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//class User {
//  String fullname;
//  Handle handle;
//  Id id;
//  String institute;
//  String picture;
//  String username;
//
//  User({
//    this.fullname,
//    this.handle,
//    this.id,
//    this.institute,
//    this.picture,
//    this.username,
//  });
//
//  factory User.fromJson(Map<String, dynamic> json) => User(
//    fullname: json["fullname"],
//    handle: Handle.fromJson(json["handle"]),
//    id: Id.fromJson(json["id"]),
//    institute: json["institute"],
//    picture: json["picture"],
//    username: json["username"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "fullname": fullname,
//    "handle": handle.toJson(),
//    "id": id.toJson(),
//    "institute": institute,
//    "picture": picture,
//    "username": username,
//  };
//}
//
//class Handle {
//  String codechef;
//  String codeforces;
//  String hackerearth;
//  String hackerrank;
//  String spoj;
//
//  Handle({
//    this.codechef,
//    this.codeforces,
//    this.hackerearth,
//    this.hackerrank,
//    this.spoj,
//  });
//
//  factory Handle.fromJson(Map<String, dynamic> json) => Handle(
//    codechef: json["codechef"],
//    codeforces: json["codeforces"],
//    hackerearth: json["hackerearth"],
//    hackerrank: json["hackerrank"],
//    spoj: json["spoj"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "codechef": codechef,
//    "codeforces": codeforces,
//    "hackerearth": hackerearth,
//    "hackerrank": hackerrank,
//    "spoj": spoj,
//  };
//}
//
//class Id {
//  Id();
//
//  factory Id.fromJson(Map<String, dynamic> json) => Id(
//  );
//
//  Map<String, dynamic> toJson() => {
//  };
//}
