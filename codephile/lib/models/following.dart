import 'dart:convert';

List<Following> followingFromJson(String str) => (json.decode(str) != null)? List<Following>.from(json.decode(str).map((x) => Following.fromJson(x))) : [];

String followingToJson(List<Following> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Following {
  Following({
    this.id,
    this.fullname,
    this.picture,
    this.username,
  });

  String id;
  String fullname;
  String picture;
  String username;

  factory Following.fromJson(Map<String, dynamic> json) => Following(
    id: json["_id"],
    fullname: json["fullname"],
    picture: json["picture"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullname": fullname,
    "picture": picture,
    "username": username,
  };
}
