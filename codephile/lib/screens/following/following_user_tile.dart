import 'package:codephile/models/following.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/services/follow.dart';
import 'package:codephile/services/unfollow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FollowingUserTile extends StatefulWidget {
  final String _token;
  final Following _user;
  final bool _isFollowing;

  const FollowingUserTile(this._token, this._user, this._isFollowing, {Key key})
      : super(key: key);

  @override
  _FollowingUserTileState createState() => _FollowingUserTileState();
}

class _FollowingUserTileState extends State<FollowingUserTile> {
  bool isFollowing;

  @override
  void initState() {
    isFollowing = widget._isFollowing;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0.0),
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 4.0, 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.width / 10,
                    width: MediaQuery.of(context).size.width / 10,
                    alignment: (widget._user.picture == "")
                        ? Alignment(0.0, 0.0)
                        : Alignment.center,
                    child: (widget._user.picture == "")
                        ? SizedBox(
                            height: MediaQuery.of(context).size.width / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            child: SvgPicture.asset(
                              'assets/default_user_icon.svg',
                              fit: BoxFit.fitWidth,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(
                                    widget._user.picture,
                                  ),
                                )),
                          ),
                    decoration: BoxDecoration(
                        color: codephileBackground,
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 0, color: userIconBorderGrey)),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 5.0, 8.0, 2.0),
                      child: Text(
                        "${widget._user.fullname}",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: const Color.fromRGBO(36, 36, 36, 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 2.0, 8.0, 8.0),
                      child: Text(
                        "@${widget._user.fullname}",
                        style: TextStyle(
                          color: const Color.fromRGBO(151, 151, 151, 1),
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10.0, 16.0, 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: isFollowing ? codephileMain : Colors.white,
                      border: Border.all(
                        color: codephileMain,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(2.0))),
                  child: isFollowing
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 5.0, 2.0, 5.0),
                              child: Text(
                                "FOLLOWING",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 8.0, 12.0, 8.0),
                              child: Icon(
                                Icons.check,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 5.0, 16.0, 5.0),
                              child: Text(
                                "FOLLOW",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: codephileMain,
                                ),
                              ),
                            )
                          ],
                        ),
                ),
              ),
              onTap: () {
                if (isFollowing) {
                  unFollow();
                } else {
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

  void follow() async {
    followUser(widget._token, widget._user.id).then((statusCode) {
      if (statusCode != 200) {
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

  void unFollow() async {
    unfollowUser(widget._token, widget._user.id).then((statusCode) {
      if (statusCode != 200) {
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
    setState(() {
      isFollowing = !isFollowing;
    });
  }
}
