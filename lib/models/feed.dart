import 'dart:convert';

List<Feed> feedFromJson(String str) {
  if (str == "null") {
    return null;
  } else {
    return List<Feed>.from(json.decode(str).map((x) => Feed.fromJson(x)));
  }
}

class Feed {
  String username;
  String userId;
  String fullname;
  String picture;
  Submission submission;

  Feed(
      {this.username,
      this.userId,
      this.fullname,
      this.picture,
      this.submission});

  Feed.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    userId = json['user_id'];
    fullname = json['fullname'];
    picture = json['picture'];
    submission = json['submission'] != null
        ? new Submission.fromJson(json['submission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['user_id'] = this.userId;
    data['fullname'] = this.fullname;
    data['picture'] = this.picture;
    if (this.submission != null) {
      data['submission'] = this.submission.toJson();
    }
    return data;
  }
}

class Submission {
  String name;
  String url;
  DateTime createdAt;
  String status;
  String language;
  int points;
  List<String> tags;
  int rating;

  Submission(
      {this.name,
      this.url,
      this.createdAt,
      this.status,
      this.language,
      this.points,
      this.tags,
      this.rating});

  Submission.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    createdAt = DateTime.parse(json['created_at']);
    status = json['status'];
    language = json['language'];
    points = json['points'];
    // tags = json['tags'].cast<String>();
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['created_at'] = this.createdAt.toIso8601String();
    data['status'] = this.status;
    data['language'] = this.language;
    data['points'] = this.points;
    data['tags'] = this.tags;
    data['rating'] = this.rating;
    return data;
  }
}
