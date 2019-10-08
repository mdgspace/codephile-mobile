import 'dart:convert';

Signup signupFromJson(String str) => Signup.fromJson(json.decode(str));
String signupToJson(Signup data) => json.encode(data.toJson());

class Signup {
  Handle handle;
  String id;
  String username;

  Signup({this.handle, this.id, this.username});

  factory Signup.fromJson(Map<String, dynamic> json) => Signup(
        handle: Handle.fromJson(json["handle"]),
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "handle": handle.toJson(),
      };
}

//class ObjectId {
//
//}

class Handle {
  String codechef;
  String codeforces;
  String hackerearth;
  String hackerrank;
  String spoj;

  Handle(
      {this.codechef,
      this.codeforces,
      this.hackerearth,
      this.hackerrank,
      this.spoj});

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
