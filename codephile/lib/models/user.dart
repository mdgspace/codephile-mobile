import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String fullname;
  Handle handle;
  String id;
  String institute;
  int noOfFollowing;
  String picture;
  String username;

  User({
    this.fullname,
    this.handle,
    this.id,
    this.institute,
    this.noOfFollowing,
    this.picture,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    fullname: json["fullname"],
    handle: Handle.fromJson(json["handle"]),
    id: json["id"],
    institute: json["institute"],
    noOfFollowing: json["no_of_following"],
    picture: json["picture"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "handle": handle.toJson(),
    "id": id,
    "institute": institute,
    "no_of_following": noOfFollowing,
    "picture": picture,
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
