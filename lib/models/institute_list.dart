import 'dart:convert';

List<String> institutesFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));
String institutesToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
