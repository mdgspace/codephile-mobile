import 'package:codephile/models/user.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/following/following_screen.dart';
import 'package:codephile/screens/profile/settings_popup_menu.dart';
import 'package:codephile/services/follow.dart';
import 'package:codephile/services/unfollow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileCard extends StatefulWidget{

  final String title;
  final String _token;
  final User _user;
  final bool _isFollowing;
  final bool _isMyProfile;
  final Function _callback;

  ProfileCard(
      this._token,
      this._user,
      this._isFollowing,
      this._isMyProfile,
      this._callback,
      {Key key, this.title}
      ) : super(key: key);


  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard>{

  bool isFollowing;

  @override
  void initState(){
    isFollowing = widget._isFollowing;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: codephileMain,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 4.0),
                child: Container(
                  height: MediaQuery.of(context).size.width/4,
                  width: MediaQuery.of(context).size.width/4,
                  alignment: (widget._user.picture == "")? Alignment(0.0, 0.0): Alignment.center,
                  child: (widget._user.picture == "")?
                  SizedBox(
                    height: MediaQuery.of(context).size.width/3,
                    width: MediaQuery.of(context).size.width/3,
                    child: SvgPicture.asset(
                      'assets/default_user_icon.svg',
                      fit: BoxFit.fitWidth,
                    ),
                  )
                      :
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(
                            widget._user.picture,
                          ),
                        )
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: codephileBackground,
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 2,
                          color: Colors.white
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  widget._user.fullname,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 22.0
                  ),
                ),
              ),
              Text(
                "@"+ widget._user.username,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.65),
                    fontSize: 16.0
                ),
              ),
              Container(
                child: (widget._user.institute == "")?
                Container(
                  height: 0,
                  width: 0,
                )
                    :
                Padding(
                  padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 0.0),
                  child: Text(
                    widget._user.institute,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      )
                  ),
                  child: (widget._isMyProfile)?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "${widget._user.noOfFollowing} Following",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        onTap: (){
                          if(widget._isMyProfile){
                            Navigator.push(
                                context,
                                new MaterialPageRoute(builder: (context) => new FollowingScreen(widget._token, widget._user.id))
                            ).then((v){
                              widget._callback();
                            });
                          }
                        },
                      )
                    ],
                  )
                      :
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "${widget._user.noOfFollowing} Following",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 16.0, 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: isFollowing?
                                    codephileMain
                                        :
                                    Colors.white,
                                    border: Border.all(
                                      color: codephileMain,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(2.0))
                                ),
                                child: isFollowing?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 2.0, 5.0),
                                      child: Text(
                                        "FOLLOWING",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 8.0),
                                      child: Icon(
                                        Icons.check,
                                        size: 16.0,
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
                                      padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
                                      child: Text(
                                        "FOLLOW",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: codephileMain,
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
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: userIconBorderGrey,
              )
            ],
          ),
        ),
        Positioned(
          top: 24.0,
          right: 16.0,
          child: (widget._isMyProfile)?
          SettingsIcon(widget._token, widget._user, widget._callback)
              :
          Container(
            height: 0,
            width: 0,
          ),
        )
      ],
    );
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

}
