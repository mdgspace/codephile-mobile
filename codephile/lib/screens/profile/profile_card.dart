import 'package:codephile/homescreen.dart';
import 'package:codephile/models/following.dart';
import 'package:codephile/models/user.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/login/login.dart';
import 'package:codephile/services/follow.dart';
import 'package:codephile/services/unfollow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_details.dart';
import 'accuracy_tile.dart';

class ProfileCard extends StatefulWidget{

  final String title;
  final String _token;
  final User _user;
  final bool _isFollowing;
  final bool _isMyProfile;
  final UserDetails _platformDetails;

  ProfileCard(
      this._token,
      this._user,
      this._isFollowing,
      this._isMyProfile,
      this._platformDetails,
      {Key key, this.title}
      ) : super(key: key);


  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard>{

  bool isFollowing;
//  List<Following> _followingList;

  @override
  void initState(){
    isFollowing = widget._isFollowing;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 12.0),
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width/1.05,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                    child: Container(
                      height: MediaQuery.of(context).size.width/6.2,
                      width: MediaQuery.of(context).size.width/6.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      ),
                      child: Image.network(
                        widget._user.picture!=""?
                        widget._user.picture
                            :
                        "https://cdn2.iconfinder.com/data/icons/ios-7-icons/50/user_male2-512.png",
                        //TODO: use defalut image         Priority: 1
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/1.5,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width/3,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 2.0),
                                      child: Text(
                                        "${widget._user.fullname}",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromRGBO(36, 36, 36, 1)
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/3,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 2.0),
                                      child: Text(
                                        "@${widget._user.username}",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: const Color.fromRGBO(145, 145, 145, 1),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: codephileMain,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget._isMyProfile? "Logout":"Compare",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  if(widget._isMyProfile){
                                    logout();
                                  }else{
                                    //TODO: implement compare       Priority: 1
                                  }
                                },
                              ),
                            ],
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width/1.5 ,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 2.0, 16.0, 9.0),
                            child: Text(
                              "${widget._user.institute}",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: const Color.fromRGBO(145, 145, 145, 1),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 4.0),
              child: Text(
                "Accuracy",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(36, 36, 36, 1)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 14.0),
              child: Wrap(
                children: getAccuracyTileList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 4.0),
                          child: Text(
                            "${widget._user.noOfFollowing} Following",//TODO: implement following       Priority: 1
                            style: TextStyle(
                              fontSize: 18.0,
                              color: const Color.fromRGBO(36, 36, 36, 1),
                            ),
                          ),
                        ),
                        onTap: (){
                          //TODO: implement following page       Priority: 2
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            (widget._isMyProfile == true)?
            Container()
                :
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: isFollowing?
                      const Color.fromRGBO(51, 102, 255, 1)
                          :
                      Colors.white,
                      border: Border.all(
                        color: const Color.fromRGBO(51, 102, 255, 1),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(2.0))
                  ),
                  child: isFollowing?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 2.0, 10.0),
                        child: Text(
                          "FOLLOWED",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2.0, 8.0, 10.0, 8.0),
                        child: Icon(
                          Icons.check,
                          size: 20.0,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                      :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "FOLLOW",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: const Color.fromRGBO(51, 102, 255, 1),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onTap: (){
                if(isFollowing){
                  unFollow();
                }else{
                  follow();
                }

                changeButtonAppearance();
                //TODO: implement load on follow/ un-follow     Priority: 2
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getAccuracyTileList(){
    List<AccuracyTile> accuracyTileList = List<AccuracyTile>();
    if(widget._platformDetails != null){
      if(widget._platformDetails.codechefProfile != null){
        accuracyTileList.add(AccuracyTile("codechef", widget._platformDetails.codechefProfile.profile.accuracy));
      }else {
        accuracyTileList.add(AccuracyTile("codechef", "-"));
      }

      if(widget._platformDetails.codeforcesProfile != null){
        accuracyTileList.add(AccuracyTile("codeforces", widget._platformDetails.codeforcesProfile.profile.accuracy));
      }else {
        accuracyTileList.add(AccuracyTile("codeforces", "-"));
      }

      if(widget._platformDetails.hackerrankProfile != null){
        accuracyTileList.add(AccuracyTile("hackerrank", widget._platformDetails.hackerrankProfile.profile.accuracy));
      }else {
        accuracyTileList.add(AccuracyTile("hackerrank", "-"));
      }

      if(widget._platformDetails.spojProfile != null){
        accuracyTileList.add(AccuracyTile("spoj", widget._platformDetails.spojProfile.profile.accuracy));
      }else {
        accuracyTileList.add(AccuracyTile("spoj", "-"));
      }
    }else{
      print("user details are null");
      accuracyTileList.add(AccuracyTile("codechef", "-"));
      accuracyTileList.add(AccuracyTile("codeforces", "-"));
      accuracyTileList.add(AccuracyTile("hackerrank", "-"));
      accuracyTileList.add(AccuracyTile("spoj", "-"));

    }

    return accuracyTileList;
  }

  void follow() async{
    print("follow");
    followUser(widget._token, widget._user.id).then((statusCode){
      print(statusCode);
      if(statusCode != 200){
        Fluttertoast.showToast(
          msg: "Something went wrong. Please try again later.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 7,
          fontSize: 12.0,
        );
        setState(() {
          isFollowing = false;
        });
      }
    });
  }

  void unFollow() async{
    print("Unfollow");
    unfollowUser(widget._token, widget._user.id).then((statusCode){
      print(statusCode);
      if(statusCode != 200){
        Fluttertoast.showToast(
          msg: "Something went wrong. Please try again later.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 7,
          fontSize: 12.0,
        );
        setState(() {
          isFollowing = true;
        });
      }
    });
  }

  void changeButtonAppearance() {
    if(isFollowing){
      setState(() {
        isFollowing = false;
      });
    }else{
      setState(() {
        isFollowing = true;
      });
    }
  }

  void logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("uid");
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
