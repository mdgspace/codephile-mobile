import 'dart:convert';

List<ActivityDetails> activityDetailsFromJson(String str) =>
    List<ActivityDetails>.from(
        json.decode(str).map((x) => ActivityDetails.fromJson(x)));

String activityDetailsToJson(List<ActivityDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityDetails {
  ActivityDetails({
    this.correct,
    this.total,
    this.createdAt,
  });

  int correct;
  int total;
  DateTime createdAt;

  factory ActivityDetails.fromJson(Map<String, dynamic> json) =>
      ActivityDetails(
        correct: json["correct"],
        total: json["total"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "correct": correct,
        "total": total,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
