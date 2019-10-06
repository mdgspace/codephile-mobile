import 'package:codephile/screens/profile/profile_card.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Profile"),
//      ),
      body: ListView(
        children: <Widget>[
          ProfileCard(
              "SlimShady",
              "therealslimshady",
              "",
              "Indian Institute of Technology",
              false
          ),
        ],
      ),
    );
  }
}
