import 'package:codephile/models/following.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/following/following_user_tile.dart';
import 'package:codephile/services/following_list.dart';
import 'package:flutter/material.dart';

class FollowingScreen extends StatefulWidget{

  final String _token;
  final String _userId;

  const FollowingScreen(this._token, this._userId, {Key key}) : super(key: key);

  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {

  bool isLoading = true;
  List<Following> _userFollowing;

  @override
  void initState(){
    initFollowingList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Following",
          style: TextStyle(
            fontSize: 24.0,
            color: primaryBlackText,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.clear,
              color: primaryBlackText,
              size: MediaQuery.of(context).size.width/15,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: isLoading?
      Center(child: CircularProgressIndicator(),)
          :
      ListView.builder(
        shrinkWrap: true,
        itemCount: (_userFollowing == null)? 0 : _userFollowing.length,
        itemBuilder: (BuildContext context, int i){
          Following user = _userFollowing[i];
          return GestureDetector(
            child: FollowingUserTile(
                widget._token,
                user,
                true
            ),
          );
        },
      ),
    );
  }

  void initFollowingList() async{
    List<Following> followingList = await getFollowingList(widget._token);
    setState(() {
      _userFollowing = followingList;
      isLoading = false;
    });
  }
}
