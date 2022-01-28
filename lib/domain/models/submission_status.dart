import 'package:freezed_annotation/freezed_annotation.dart';

part 'submission_status.freezed.dart';
part 'submission_status.g.dart';

@freezed
class SubmissionStatus with _$SubmissionStatus {
  factory SubmissionStatus({
    int? ac,
    int? ce,
    int? mle,
    int? ptl,
    int? re,
    int? tle,
    int? wa,
  }) = _SubmissionStatus;

  factory SubmissionStatus.fromJson(Map<String, dynamic> json) =>
      _$SubmissionStatusFromJson(json);
}
