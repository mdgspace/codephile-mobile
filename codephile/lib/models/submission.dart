import 'dart:convert';

Submission submissionFromJson(String str) => Submission.fromJson(json.decode(str));

String submissionToJson(Submission data) => json.encode(data.toJson());

class Submission {
  List<CodechefSubmission> codechef;
  List<CodeforcesSubmission> codeforces;
  List<HackerrankSubmission> hackerrank;
  List<SpojSubmission> spoj;

  Submission({
    this.codechef,
    this.codeforces,
    this.hackerrank,
    this.spoj,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
    codechef: List<CodechefSubmission>.from(json["codechef"].map((x) => CodechefSubmission.fromJson(x))),
    codeforces: List<CodeforcesSubmission>.from(json["codeforces"].map((x) => CodeforcesSubmission.fromJson(x))),
    hackerrank: List<HackerrankSubmission>.from(json["hackerrank"].map((x) => HackerrankSubmission.fromJson(x))),
    spoj: List<SpojSubmission>.from(json["spoj"].map((x) => SpojSubmission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "codechef": List<dynamic>.from(codechef.map((x) => x.toJson())),
    "codeforces": List<dynamic>.from(codeforces.map((x) => x.toJson())),
    "hackerrank": List<dynamic>.from(hackerrank.map((x) => x.toJson())),
    "spoj": List<dynamic>.from(spoj.map((x) => x.toJson())),
  };
}

class CodechefSubmission {
  String creationDate;
  String language;
  String name;
  String points;
  String status;
  List<String> tags;
  String url;

  CodechefSubmission({
    this.creationDate,
    this.language,
    this.name,
    this.points,
    this.status,
    this.tags,
    this.url,
  });

  factory CodechefSubmission.fromJson(Map<String, dynamic> json) => CodechefSubmission(
    creationDate: json["creation_date"],
    language: json["language"],
    name: json["name"],
    points: json["points"],
    status: json["status"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "creation_date": creationDate,
    "language": language,
    "name": name,
    "points": points,
    "status": status,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "url": url,
  };
}

class CodeforcesSubmission {
  String creationDate;
  String name;
  int points;
  int rating;
  String status;
  List<String> tags;
  String url;
  String language;

  CodeforcesSubmission({
    this.creationDate,
    this.name,
    this.points,
    this.rating,
    this.status,
    this.tags,
    this.url,
    this.language,
  });

  factory CodeforcesSubmission.fromJson(Map<String, dynamic> json) => CodeforcesSubmission(
    creationDate: json["creation_date"],
    name: json["name"],
    points: json["points"],
    rating: json["rating"] == null ? null : json["rating"],
    status: json["status"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    url: json["url"],
    language: json["language"] == null ? null : json["language"],
  );

  Map<String, dynamic> toJson() => {
    "creation_date": creationDate,
    "name": name,
    "points": points,
    "rating": rating == null ? null : rating,
    "status": status,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "url": url,
    "language": language == null ? null : language,
  };
}

class HackerrankSubmission {
  String creationDate;
  String name;
  String url;

  HackerrankSubmission({
    this.creationDate,
    this.name,
    this.url,
  });

  factory HackerrankSubmission.fromJson(Map<String, dynamic> json) => HackerrankSubmission(
    creationDate: json["created_at"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": creationDate,
    "name": name,
    "url": url,
  };
}

class SpojSubmission {
  String creationDate;
  String language;
  String name;
  int points;
  String status;
  List<String> tags;
  String url;

  SpojSubmission({
    this.creationDate,
    this.language,
    this.name,
    this.points,
    this.status,
    this.tags,
    this.url,
  });

  factory SpojSubmission.fromJson(Map<String, dynamic> json) => SpojSubmission(
    creationDate: json["creation_date"],
    language: json["language"],
    name: json["name"],
    points: json["points"],
    status: json["status"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "creation_date": creationDate,
    "language": language,
    "name": name,
    "points": points,
    "status": status,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "url": url,
  };
}
