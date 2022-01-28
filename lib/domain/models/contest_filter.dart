import 'package:freezed_annotation/freezed_annotation.dart';

part 'contest_filter.freezed.dart';
part 'contest_filter.g.dart';

@freezed
class ContestFilter with _$ContestFilter {
  factory ContestFilter({
    int? duration,
    bool? ongoing,
    bool? upcoming,
    DateTime? startDate,
    List<dynamic>? platform,
  }) = _ContestFilter;

  factory ContestFilter.fromJson(Map<String, dynamic> json) =>
      _$ContestFilterFromJson(json);
}
