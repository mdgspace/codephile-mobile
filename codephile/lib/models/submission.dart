import 'dart:convert';

Submission submissionFromJson(String str) => Submission.fromJson(json.decode(str));

String submissionToJson(Submission data) => json.encode(data.toJson());

class Submission {
  List<Codechef> codechef;
  List<Codeforces> codeforces;
  List<Hackerrank> hackerrank;
  List<Spoj> spoj;

  Submission({
    this.codechef,
    this.codeforces,
    this.hackerrank,
    this.spoj,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
        codechef: List<Codechef>.from(json["codechef"].map((x) => Codechef.fromJson(x))),
        codeforces: List<Codeforces>.from(json["codeforces"].map((x) => Codeforces.fromJson(x))),
        hackerrank: List<Hackerrank>.from(json["hackerrank"].map((x) => Hackerrank.fromJson(x))),
        spoj: List<Spoj>.from(json["spoj"].map((x) => Spoj.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "codechef": List<dynamic>.from(codechef.map((x) => x.toJson())),
    "codeforces": List<dynamic>.from(codeforces.map((x) => x.toJson())),
    "hackerrank": List<dynamic>.from(hackerrank.map((x) => x.toJson())),
    "spoj": List<dynamic>.from(spoj.map((x) => x.toJson())),
  };
}

class Codechef {
  String time;
  String language;
  String name;
  int points;
  String status;
  String url;

  Codechef({
    this.time,
    this.name,
    this.language,
    this.status,
    this.url,
  });

  factory Codechef.fromJson(Map<String, dynamic> json) => Codechef(
        time: json["creation_date"],
        language: json["language"],
        name: json["name"],
        status: json["status"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "creation_date": time,
        "language": language,
        "name": name,
        "status": status,

        "url": url,
      };
}

class Codeforces {
  String time;
  String language;
  String name;
  int points;
  String status;

  String url;

  Codeforces({
    this.time,
    this.name,
    this.language,
    this.status,

    this.url,
  });

  factory Codeforces.fromJson(Map<String, dynamic> json) => Codeforces(
    time: json["creation_date"],
    language: json["language"],
    name: json["name"],

    status: json["status"],

    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "creation_date": time,
    "language": language,
    "name": name,

    "status": status,

    "url": url,
  };
}

class Hackerrank {
  String time;
  String language;
  String name;
  int points;
  String status;

  String url;

  Hackerrank({
    this.time,
    this.name,
    this.language,

    this.status,

    this.url,
  });

  factory Hackerrank.fromJson(Map<String, dynamic> json) => Hackerrank(
    time: json["creation_date"],
    language: json["language"],
    name: json["name"],

    status: json["status"],

    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "creation_date": time,
    "language": language,
    "name": name,

    "status": status,

    "url": url,
  };
}

class Spoj {
  String time;
  String language;
  String name;
  int points;
  String status;

  String url;

  Spoj({
    this.time,
    this.name,
    this.language,

    this.status,

    this.url,
  });

  factory Spoj.fromJson(Map<String, dynamic> json) => Spoj(
    time: json["creation_date"],
    language: json["language"],
    name: json["name"],

    status: json["status"],

    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "creation_date": time,
    "language": language,
    "name": name,

    "status": status,

    "url": url,
  };
}


class Tags {
  String tags;

  Tags({this.tags});

factory Tags.fromJson(Map<String, dynamic> json) => Tags(

);

Map<String, dynamic> toJson() => {

};

}
