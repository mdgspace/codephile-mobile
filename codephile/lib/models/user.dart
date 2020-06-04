import 'dart:convert';

import 'package:codephile/models/submission.dart';
import 'package:codephile/models/user_profile_details.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String fullname;
  Handle handle;
  String id;
  String institute;
  int noOfFollowing;
  String picture;
  UserProfileDetails profiles;
  List<Submission> recentSubmissions;
  String username;

  User({
    this.fullname,
    this.handle,
    this.id,
    this.institute,
    this.noOfFollowing,
    this.picture,
    this.profiles,
    this.recentSubmissions,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    fullname: json["fullname"],
    handle: Handle.fromJson(json["handle"]),
    id: json["id"],
    institute: json["institute"],
    noOfFollowing: json["no_of_following"],
    picture: json["picture"],
    profiles: (json["profiles"] == null)? null : UserProfileDetails.fromJson(json["profiles"]),
    recentSubmissions: (json["recent_submissions"] == null)? null :  List<Submission>.from(json["recent_submissions"].map((x) => Submission.fromJson(x))),
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "handle": handle.toJson(),
    "id": id,
    "institute": institute,
    "no_of_following": noOfFollowing,
    "picture": picture,
    "profiles": (profiles != null)? profiles.toJson(): null,
    "recent_submissions": (recentSubmissions != null )? List<dynamic>.from(recentSubmissions.map((x) => x.toJson())) : null,
    "username": username,
  };
}

class Handle {
  String codechef;
  String codeforces;
  String hackerearth;
  String hackerrank;
  String spoj;

  Handle({
    this.codechef,
    this.codeforces,
    this.hackerearth,
    this.hackerrank,
    this.spoj,
  });

  factory Handle.fromJson(Map<String, dynamic> json) => Handle(
    codechef: json["codechef"],
    codeforces: json["codeforces"],
    hackerearth: json["hackerearth"],
    hackerrank: json["hackerrank"],
    spoj: json["spoj"],
  );

  Map<String, dynamic> toJson() => {
    "codechef": codechef,
    "codeforces": codeforces,
    "hackerearth": hackerearth,
    "hackerrank": hackerrank,
    "spoj": spoj,
  };
}
