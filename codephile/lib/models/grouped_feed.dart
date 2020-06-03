class GroupedFeed {
  String username;
  String userId;
  String fullname;
  String picture;
  String name;
  String url;
  List<Submissions> submissions;

  GroupedFeed(
      {this.username,
      this.userId,
      this.fullname,
      this.picture,
      this.name,
      this.url,
      this.submissions});
}

class Submissions {
  DateTime createdAt;
  String status;
  String language;
  int points;
  List<String> tags;
  int rating;

  Submissions(
      {this.createdAt,
      this.status,
      this.language,
      this.points,
      this.tags,
      this.rating});
}
