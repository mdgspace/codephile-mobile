import 'package:flutter/material.dart';

var pageList = [
  PageModel(
      imageUrl: "assets/illustration.png",
      title: "Browse friends and mentors",
      body: "to stalk"),
  PageModel(
    imageUrl: "assets/illustration2.png",
    title: "Follow people to see their",
    body: "contributions",
  ),
  PageModel(
    imageUrl: "assets/illustration3.png",
    title: "Get personalised feed based",
    body: "on who you follow",
  ),
];

class PageModel {
  var imageUrl;
  var title;
  var body;
  List<Color> titleGradient = [];
  PageModel({this.imageUrl, this.title, this.body, this.titleGradient});
}
