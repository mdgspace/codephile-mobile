import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_details.freezed.dart';
part 'activity_details.g.dart';

@freezed
class ActivityDetails with _$ActivityDetails {
  factory ActivityDetails({
    int? correct,
    int? details,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ActivityDetails;

  factory ActivityDetails.fromJson(Map<String, dynamic> json) =>
      _$ActivityDetailsFromJson(json);
}
