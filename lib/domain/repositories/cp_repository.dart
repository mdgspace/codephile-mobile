import 'dart:convert';

import '../../data/services/remote/api_service.dart';
import '../models/activity_details.dart';
import '../models/contest.dart';
import '../models/feed.dart';
import '../models/submission.dart';

class CPRepository {
  static void init() => instance = CPRepository();

  static late final CPRepository instance;

  Future<List<ActivityDetails>?> getActivityDetails(String uid) async {
    final endPoint = 'graph/activity/$uid';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.post(
      endPoint,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return List<ActivityDetails>.from(json
          .decode(response['data'])
          .map((e) => ActivityDetails.fromJson(e)));
    }
  }

  Future<Contest?> contestList() async {
    const endpoint = 'contest/';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return Contest.fromJson(json.decode(response['data']));
    }
  }

  Future<List<Feed>?> getFeed({DateTime? before}) async {
    final endpoint = 'feed/friend-activity?before='
        '${(before ?? DateTime.now()).millisecondsSinceEpoch ~/ 1000}';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return List<Feed>.from(
        json.decode(response['data']).map((e) => Feed.fromJson(e)),
      );
    }
  }

  Future<List<Submission>?> getSubmissionList(String uid) async {
    final endpoint = 'submission/all/$uid';
    final headers = <String, dynamic>{};

    await ApiService.addTokenToHeaders(headers);
    final response = await ApiService.get(
      endpoint,
      headers: headers,
    );

    if (response['status_code'] == 200) {
      return List<Submission>.from(
        json.decode(response['data']).map((e) => Submission.fromJson(e)),
      );
    }
  }
}
