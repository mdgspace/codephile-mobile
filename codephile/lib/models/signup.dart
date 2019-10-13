import 'dart:convert';

SignUp signUpFromJson(String str) => SignUp.fromJson(json.decode(str));
String signUpToJson(SignUp data) => json.encode(data.toJson());

class SignUp {
  Handle handle;
  String password;
  String username;

  SignUp({this.handle, this.password, this.username});

  factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
        handle: Handle.fromJson(json["handle"]),
        password: json["password"],
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

class Info {
  String name;
  String institute;

  Info({
    this.name,
    this.institute,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    name: json["name"],
    institute: json["institute"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "institute": institute,
  };

}
