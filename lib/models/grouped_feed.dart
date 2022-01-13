class GroupedFeed {
  String? username;
  String? userId;
  String? fullname;
  String? picture;
  String? name;
  String? url;
  String? language;
  List<Submissions>? submissions;

  GroupedFeed(
      {this.username,
      this.userId,
      this.fullname,
      this.picture,
      this.name,
      this.url,
      this.language,
      this.submissions});
}

class Submissions {
  DateTime? createdAt;
  String? status;
  int? points;
  List<String>? tags;
  int? rating;

  Submissions(
      {this.createdAt, this.status, this.points, this.tags, this.rating});
}
