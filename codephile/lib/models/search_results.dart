// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
import 'package:codephile/models/user.dart';

List<User> searchResultUsersFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String searchResultUsersToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
