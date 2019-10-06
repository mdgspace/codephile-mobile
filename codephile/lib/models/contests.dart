import 'dart:convert';

Contests contestsFromJson(String str) => Contests.fromJson(json.decode(str));

String contestsToJson(Contests data) => json.encode(data.toJson());

class Contests {
  Result result;

  Contests({
    this.result,
  });

  factory Contests.fromJson(Map<String, dynamic> json) => Contests(
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
  };
}

class Result {
  List<Ongoing> ongoing;
  String timestamp;
  List<Upcoming> upcoming;

  Result({
    this.ongoing,
    this.timestamp,
    this.upcoming,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    ongoing: List<Ongoing>.from(json["ongoing"].map((x) => Ongoing.fromJson(x))),
    timestamp: json["timestamp"],
    upcoming: List<Upcoming>.from(json["upcoming"].map((x) => Upcoming.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ongoing": List<dynamic>.from(ongoing.map((x) => x.toJson())),
    "timestamp": timestamp,
    "upcoming": List<dynamic>.from(upcoming.map((x) => x.toJson())),
  };
}

class Ongoing {
  String endTime;
  String name;
  String platform;
  String challengeType;
  String url;

  Ongoing({
    this.endTime,
    this.name,
    this.platform,
    this.challengeType,
    this.url,
  });

  factory Ongoing.fromJson(Map<String, dynamic> json) => Ongoing(
    endTime: json["EndTime"],
    name: json["Name"],
    platform: json["Platform"],
    challengeType: json["challenge_type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "EndTime": endTime,
    "Name": name,
    "Platform": platform,
    "challenge_type": challengeType,
    "url": url,
  };
}

class Upcoming {
  String duration;
  String endTime;
  String name;
  String platform;
  String startTime;
  String challengeType;
  String url;

  Upcoming({
    this.duration,
    this.endTime,
    this.name,
    this.platform,
    this.startTime,
    this.challengeType,
    this.url,
  });

  factory Upcoming.fromJson(Map<String, dynamic> json) => Upcoming(
    duration: json["Duration"],
    endTime: json["EndTime"],
    name: json["Name"],
    platform: json["Platform"],
    startTime: json["StartTime"],
    challengeType: json["challenge_type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "Duration": duration,
    "EndTime": endTime,
    "Name": name,
    "Platform": platform,
    "StartTime": startTime,
    "challenge_type": challengeType,
    "url": url,
  };
}
