import 'package:codephile/screens/profile/profile_card.dart';
import 'package:codephile/services/user.dart';
import 'package:codephile/services/user_details.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {

  final String _uId;
  Profile(this._uId);

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

    getUserDetails(widget._uId).then((userDetails){
      _institute = userDetails.codechefProfile.profile.school;
    });
    getUser(widget._uId).then((user){
      _username = user.username;
      _handle = "user.handle???";
      _image = user.picture;
      //TODO: get user institute
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ProfileCard(
              _username,
              _handle,
              _image,
              _institute,
              false
          ),
        ],
      ),
    );
  }
}
