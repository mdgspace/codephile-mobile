import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contest_filter.freezed.dart';
part 'contest_filter.g.dart';

@freezed
class ContestFilter extends Equatable with _$ContestFilter {
  const factory ContestFilter({
    int? duration,
    bool? ongoing,
    bool? upcoming,
    DateTime? startDate,
    @Default([]) List<bool> platform,
  }) = _ContestFilter;

  factory ContestFilter.fromJson(Map<String, dynamic> json) =>
      _$ContestFilterFromJson(json);

  const ContestFilter._();

  @override
  List<Object?> get props => [duration, ongoing, upcoming, startDate, platform];
}
