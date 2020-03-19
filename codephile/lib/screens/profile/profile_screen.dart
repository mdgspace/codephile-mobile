import 'package:codephile/screens/profile/profile_card.dart';
import 'package:codephile/screens/submission/recently_solved_card.dart';
import 'package:codephile/services/user.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {

  final String token;
  final String uId;
  Profile(this.token, this.uId);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool _isLoading = true;
  var userDetails;
  var user;

  String _username;
  String _handle;
  String _image;
  String _institute;
  //TODO: implement following functionality
  bool _isFollowing;

  @override
  void initState(){
    super.initState();
    getUser(widget.token, widget.uId).then((user){
      _username = user.fullname;
      _handle = user.username;
      _image = user.picture;
      _institute = user.institute;

      setState(() {
        _isLoading = false;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 244, 247, 1),
//      appBar: AppBar(
//        title: Text("Profile"),
//      ),
      body: _isLoading?
          Center(
            child: CircularProgressIndicator(),
          )
      :
      ListView(
        children: <Widget>[
          //TODO: implement #followers and #following
          ProfileCard(
              _username,
              _handle,
              _image,
              _institute,
              344,
              45,
              false
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 16.0),
            child: Text(
              "Recently Solved",
              style: TextStyle(
                fontSize: 22.0,
                color: const Color.fromRGBO(36, 36, 36, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //TODO: implement submissions list
          RecentlySolvedCard("a very very very very very very very very very very long descripiton", "Codechef",15),
          RecentlySolvedCard("a very very very very very very very very very very long descripiton", "Codechef",15),
        ],
      ),
    );
  }
}
