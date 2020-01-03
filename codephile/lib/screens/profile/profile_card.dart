import 'package:flutter/material.dart';

import 'accuracy_tile.dart';

class ProfileCard extends StatefulWidget{
  ProfileCard(
      this._name,
      this._handle,
      this._userIcon,
      this._institute,
      this._followers,
      this._following,
      this._isFollowing,
      {Key key, this.title}
      ) : super(key: key);

  final String title;
  final String _name;
  final String _handle;
  final String _userIcon;
  final String _institute;
  final bool _isFollowing;
  final int _followers;
  final int _following;

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard>{

  bool isFollowing = false;

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
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                  child: Container(
                    height: 64.0,
                    width: 64.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                    child: Image.network(
                      widget._userIcon!=""?
                      widget._userIcon
                          :
                      "https://cdn2.iconfinder.com/data/icons/ios-7-icons/50/user_male2-512.png",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 2.0),
                        child: Text(
                          "${widget._name}",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(36, 36, 36, 1)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 2.0),
                        child: Text(
                          "@${widget._handle}",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: const Color.fromRGBO(145, 145, 145, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 2.0, 16.0, 9.0),
                        child: Text(
                          "${widget._institute}",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: const Color.fromRGBO(145, 145, 145, 1),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              ],
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
                children: <Widget>[
                  //TODO: implement map function
                  AccuracyTile("codechef", 32.1),
                  AccuracyTile("codechef", 32.1),
                  AccuracyTile("codechef", 32.1),
//                  AccuracyTile("codechef", 32.1),
//                  AccuracyTile("codechef", 32.1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "${widget._followers}",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: const Color.fromRGBO(36, 36, 36, 1),
                      ),
                    ),
                    Text(
                      " Followers",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: const Color.fromRGBO(36, 36, 36, 1),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "${widget._following}",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: const Color.fromRGBO(36, 36, 36, 1),
                      ),
                    ),
                    Text(
                      " Following",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: const Color.fromRGBO(36, 36, 36, 1),
                      ),
                    )
                  ],
                ),
              ],
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: widget._isFollowing?
                      const Color.fromRGBO(51, 102, 255, 1)
                          :
                      Colors.white,
                      border: Border.all(
                        color: const Color.fromRGBO(51, 102, 255, 1),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(2.0))
                  ),
                  child: widget._isFollowing?
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
                //TODO: implement onTap
              },
            ),
          ],
        ),
      ),
    );
  }
}
