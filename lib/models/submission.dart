// To parse this JSON data, do
//
//     final submission = submissionFromJson(jsonString);

import 'dart:convert';

List<Submission> submissionFromJson(String str) =>
    List<Submission>.from(json.decode(str).map((x) => Submission.fromJson(x)));

String submissionToJson(List<Submission> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Submission {
  String? createdAt;
  String? language;
  String? name;
  int? points;
  int? rating;
  String? status;
  List<String>? tags;
  String? url;

  Submission({
    this.createdAt,
    this.language,
    this.name,
    this.points,
    this.rating,
    this.status,
    this.tags,
    this.url,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
        createdAt: json["created_at"],
        language: json["language"],
        name: json["name"],
        points: json["points"],
        rating: json["rating"],
        status: json["status"],
        tags: (json["tags"] != null)
            ? List<String>.from(json["tags"].map((x) => x))
            : null,
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "language": language,
        "name": name,
        "points": points,
        "rating": rating,
        "status": status,
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "url": url,
      };
}
