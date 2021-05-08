class Contests {
  List<Ongoing> ongoing;
  String timestamp;
  List<Upcoming> upcoming;

  Contests({this.ongoing, this.timestamp, this.upcoming});

  Contests.fromJson(Map<String, dynamic> json) {
    if (json['ongoing'] != null) {
      ongoing = <Ongoing>[];
      json['ongoing'].forEach((v) {
        ongoing.add(new Ongoing.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
    if (json['upcoming'] != null) {
      upcoming = <Upcoming>[];
      json['upcoming'].forEach((v) {
        upcoming.add(new Upcoming.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ongoing != null) {
      data['ongoing'] = this.ongoing.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
    if (this.upcoming != null) {
      data['upcoming'] = this.upcoming.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ongoing {
  DateTime endTime;
  String name;
  String platform;
  String url;
  String challengeType;

  Ongoing(
      {this.endTime, this.name, this.platform, this.url, this.challengeType});

  Ongoing.fromJson(Map<String, dynamic> json) {
    endTime = DateTime.parse(json['EndTime']);
    name = json['Name'];
    platform = json['Platform'];
    url = json['url'];
    challengeType = json['challenge_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EndTime'] = this.endTime;
    data['Name'] = this.name;
    data['Platform'] = this.platform;
    data['url'] = this.url;
    data['challenge_type'] = this.challengeType;
    return data;
  }
}

class Upcoming {
  String duration;
  DateTime endTime;
  String name;
  String platform;
  DateTime startTime;
  String url;
  String challengeType;

  Upcoming(
      {this.duration,
      this.endTime,
      this.name,
      this.platform,
      this.startTime,
      this.url,
      this.challengeType});

  Upcoming.fromJson(Map<String, dynamic> json) {
    duration = json['Duration'];
    endTime = DateTime.parse(json['EndTime']);
    name = json['Name'];
    platform = json['Platform'];
    startTime = DateTime.parse(json['StartTime']);
    url = json['url'];
    challengeType = json['challenge_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Duration'] = this.duration;
    data['EndTime'] = this.endTime;
    data['Name'] = this.name;
    data['Platform'] = this.platform;
    data['StartTime'] = this.startTime;
    data['url'] = this.url;
    data['challenge_type'] = this.challengeType;
    return data;
  }
}
