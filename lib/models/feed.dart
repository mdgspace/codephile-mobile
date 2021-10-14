import 'dart:convert';

List<Feed>? feedFromJson(String str) {
  if (str == "null") {
    return null;
  } else {
    return List<Feed>.from(json.decode(str).map((x) => Feed.fromJson(x)));
  }
}

class Feed {
  String? username;
  String? userId;
  String? fullname;
  String? picture;
  Submission? submission;

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
        ? Submission.fromJson(json['submission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['user_id'] = userId;
    data['fullname'] = fullname;
    data['picture'] = picture;
    if (submission != null) {
      data['submission'] = submission!.toJson();
    }
    return data;
  }
}

class Submission {
  String? name;
  String? url;
  DateTime? createdAt;
  String? status;
  String? language;
  int? points;
  List<String>? tags;
  int? rating;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['created_at'] = createdAt!.toIso8601String();
    data['status'] = status;
    data['language'] = language;
    data['points'] = points;
    data['tags'] = tags;
    data['rating'] = rating;
    return data;
  }
}
