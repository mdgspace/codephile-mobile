import 'package:codephile/models/contests.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class ContestFilter {
  int duration;
  bool ongoing;
  bool upcoming;
  DateTime startDate;
  List<dynamic> platform;

  ContestFilter({
    this.duration,
    this.platform,
    this.startDate,
    this.ongoing,
    this.upcoming,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration.toString();
    data['ongoing'] = this.ongoing.toString();
    data['upcoming'] = this.upcoming.toString();
    data['startDate'] = this.startDate.toIso8601String();
    data['platform'] = json.encode(this.platform);
    return data;
  }

  ContestFilter.fromJson(Map<String, dynamic> inputJson) {
    duration = int.parse(inputJson['duration']);
    ongoing = inputJson['ongoing'] == 'true';
    upcoming = inputJson['upcoming'] == 'true';
    startDate = DateTime.parse(inputJson['startDate']);
    platform = json.decode(inputJson['platform']);
  }

  bool check({Upcoming upcoming, Ongoing ongoing}) {
    bool platformCheck = true, durationCheck = true, startTimeCheck = true;

    if (upcoming != null) {
      switch (upcoming.platform.toLowerCase()) {
        case "codechef":
          platformCheck = platform[0];
          break;
        case "codeforces":
          platformCheck = platform[1];
          break;
        case "hackerearth":
          platformCheck = platform[2];
          break;
        case "hackerrank":
          platformCheck = platform[3];
          break;
        default:
          platformCheck = platform[4];
      }

      Duration _maxDuration;
      switch (duration) {
        case 0:
          _maxDuration = Duration(hours: 2);
          break;
        case 1:
          _maxDuration = Duration(hours: 3);
          break;
        case 2:
          _maxDuration = Duration(hours: 5);
          break;
        case 3:
          _maxDuration = Duration(days: 1);
          break;
        case 4:
          _maxDuration = Duration(days: 10);
          break;
        case 5:
          _maxDuration = Duration(days: 31);
          break;
        default:
          return true;
      }
      if (_maxDuration
              .compareTo(upcoming.endTime.difference(upcoming.startTime)) >=
          0) {
        durationCheck = true;
      } else {
        durationCheck = false;
      }
      if (upcoming.startTime.isAfter(startDate)) {
        startTimeCheck = true;
      } else {
        startTimeCheck = false;
      }
      return platformCheck && durationCheck && startTimeCheck;
    } else if (ongoing != null) {
      switch (ongoing.platform.toLowerCase()) {
        case "codechef":
          platformCheck = platform[0];
          break;
        case "codeforces":
          platformCheck = platform[1];
          break;
        case "hackerearth":
          platformCheck = platform[2];
          break;
        case "hackerrank":
          platformCheck = platform[3];
          break;
        default:
          platformCheck = platform[4];
      }

      Duration _maxDuration;
      switch (duration) {
        case 0:
          _maxDuration = Duration(hours: 2);
          break;
        case 1:
          _maxDuration = Duration(hours: 3);
          break;
        case 2:
          _maxDuration = Duration(hours: 5);
          break;
        case 3:
          _maxDuration = Duration(days: 1);
          break;
        case 4:
          _maxDuration = Duration(days: 10);
          break;
        case 5:
          _maxDuration = Duration(days: 31);
          break;
        default:
          return true;
      }
      if (_maxDuration.compareTo(ongoing.endTime.difference(DateTime.now())) >=
          0) {
        durationCheck = true;
      } else {
        durationCheck = false;
      }
      return platformCheck && durationCheck && startTimeCheck;
    } else {
      return false;
    }
  }
}

String getLabelForValue(int value) {
  switch (value) {
    case 0:
      return "2 hours";
    case 1:
      return "3 hours";
    case 2:
      return "5 hours";
    case 3:
      return "1 day";
    case 4:
      return "10 days";
    case 5:
      return "1 month";
    case 6:
      return "∞";
    default:
      return "10 days";
  }
}

bool checkPlatform({String platform, ContestFilter filter}) {
  switch (platform.toLowerCase()) {
    case "codechef":
      return filter.platform[0];
    case "codeforces":
      return filter.platform[1];
    case "hackerearth":
      return filter.platform[2];
    case "hackerrank":
      return filter.platform[3];
    default:
      return filter.platform[4];
  }
}

bool checkDuration({ContestFilter filter, String endTime, String startTime}) {
  DateTime _endTime = DateFormat("EEE, dd MMM yyyy hh:mm").parse(endTime);
  DateTime _startTime = DateTime.now();
  if (startTime != null) {
    _startTime = DateFormat("EEE, dd MMM yyyy hh:mm").parse(startTime);
  }
  Duration _maxDuration;
  switch (filter.duration) {
    case 0:
      _maxDuration = Duration(hours: 2);
      break;
    case 1:
      _maxDuration = Duration(hours: 3);
      break;
    case 2:
      _maxDuration = Duration(hours: 5);
      break;
    case 3:
      _maxDuration = Duration(days: 1);
      break;
    case 4:
      _maxDuration = Duration(days: 10);
      break;
    case 5:
      _maxDuration = Duration(days: 31);
      break;
    default:
      return true;
  }
  if (_maxDuration.compareTo(_endTime.difference(_startTime)) >= 0) {
    return true;
  } else {
    return false;
  }
}

bool checkStartTime({String startTime, ContestFilter filter}) {
  DateTime _startTime = DateFormat("EEE, dd MMM yyyy hh:mm").parse(startTime);
  if (_startTime.isAfter(filter.startDate)) {
    return true;
  } else {
    return false;
  }
}
