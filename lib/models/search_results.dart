// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
import 'package:codephile/models/user.dart';

List<CodephileUser> searchResultUsersFromJson(String str) =>
    List<CodephileUser>.from(json.decode(str).map((x) => CodephileUser.fromJson(x)));

String searchResultUsersToJson(List<CodephileUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
