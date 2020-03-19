import 'dart:convert';

List<Following>   followingFromJson(String str) => List<Following>.from(json.decode(str).map((x) => Following.fromJson(x)));

String followingToJson(List<Following> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Following {
  String codephileHandle;
  String fId;

  Following({
    this.codephileHandle,
    this.fId,
  });

  factory Following.fromJson(Map<String, dynamic> json) => Following(
    codephileHandle: json["codephile_handle"],
    fId: json["f_id"],
  );

  Map<String, dynamic> toJson() => {
    "codephile_handle": codephileHandle,
    "f_id": fId,
  };
}
