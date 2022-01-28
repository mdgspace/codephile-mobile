import 'package:freezed_annotation/freezed_annotation.dart';

part 'submission.freezed.dart';
part 'submission.g.dart';

@freezed
class Submission with _$Submission {
  factory Submission({
    required String name,
    String? url,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    String? status,
    String? language,
    int? points,
    List<String>? tags,
    int? rating,
  }) = _Submission;

  factory Submission.fromJson(Map<String, dynamic> json) =>
      _$SubmissionFromJson(json);
}
