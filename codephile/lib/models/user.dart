import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  Handle handle;
  Id id;
  String picture;
  String username;

  User({
    this.handle,
    this.id,
    this.picture,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    handle: Handle.fromJson(json["handle"]),
    id: Id.fromJson(json["id"]),
    picture: json["picture"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "handle": handle.toJson(),
    "id": id.toJson(),
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

class Id {
  Id();

  factory Id.fromJson(Map<String, dynamic> json) => Id(
  );

  Map<String, dynamic> toJson() => {
  };
}
