import 'dart:convert';

SignUp signUpFromJson(String str) => SignUp.fromJson(json.decode(str));
String signUpToJson(SignUp data) => json.encode(data.toJson());

class SignUp {
  Handle? handle;
  String? email;
  String? password;
  String? username;
  String? fullname;
  String? institute;

  SignUp(
      {this.handle,
      this.email,
      this.password,
      this.username,
      this.fullname,
      this.institute});

  factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        fullname: json["fullname"],
        institute: json["institute"],
        handle: Handle.fromJson(json["handle"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "fullname": fullname,
        "institute": institute,
        "handle": handle!.toJson(),
      };
}

class Handle {
  String? codechef;
  String? codeforces;
  String? hackerrank;
  String? spoj;

  Handle({this.codechef, this.codeforces, this.hackerrank, this.spoj});

  factory Handle.fromJson(Map<String, dynamic> json) => Handle(
        codechef: json["handle.codechef"],
        codeforces: json["handle.codeforces"],
        hackerrank: json["handle.hackerrank"],
        spoj: json["handle.spoj"],
      );

  Map<String, dynamic> toJson() => {
        "handle.codechef": codechef,
        "handle.codeforces": codeforces,
        "handle.hackerrank": hackerrank,
        "handle.spoj": spoj,
      };
}

//class Info {
//  String name;
//  String institute;
//
//  Info({
//    this.name,
//    this.institute,
//  });
//
//  factory Info.fromJson(Map<String, dynamic> json) => Info(
//    name: json["name"],
//    institute: json["institute"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "name": name,
//    "institute": institute,
//  };
//
//}
