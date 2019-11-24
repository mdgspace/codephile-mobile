import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget{
  ProfileCard(
      this._name,
      this._handle,
      this._userIcon,
      this._institute,
      this._isFollowing,
      {Key key, this.title}
      ) : super(key: key);

  final String title;
  final String _name;
  final String _handle;
  final String _userIcon;
  final String _institute;
  final bool _isFollowing;

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
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: const Color.fromRGBO(244, 244, 244, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 58.0,
                      width: 58.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: Image.network(
                        widget._userIcon!=""?
                        widget._userIcon
                            :
                        "https://cdn2.iconfinder.com/data/icons/ios-7-icons/50/user_male2-512.png",                        //widget._userIcon
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 2.0),
                          child: Text(
                            "${widget._name}",
                            style: TextStyle(
                              fontSize: 14.0,

                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                          child: Text(
                            "@${widget._handle}",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: const Color.fromRGBO(145, 145, 145, 1),
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
              padding: const EdgeInsets.fromLTRB(16.0, 9.0, 16.0, 2.0),
              child: Text(
                "INSTITUTE",
                style: TextStyle(
                  fontSize: 12.0,
                  color: const Color.fromRGBO(145, 145, 145, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 9.0),
              child: Text(
                "${widget._institute}",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 9.0, 16.0, 9.0),
              child: Text(
                "ACCURACY",
                style: TextStyle(
                  fontSize: 14.0,
                  color: const Color.fromRGBO(145, 145, 145, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 9.0, 16.0, 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height:  34.0,
                    width: 51.0,
                    color: const Color.fromRGBO(196, 196, 196, 1),
                  ),
                  Container(
                    height:  34.0,
                    width: 51.0,
                    color: const Color.fromRGBO(196, 196, 196, 1),
                  ),
                  Container(
                    height:  34.0,
                    width: 51.0,
                    color: const Color.fromRGBO(196, 196, 196, 1),
                  ),
                  Container(
                    height:  34.0,
                    width: 51.0,
                    color: const Color.fromRGBO(196, 196, 196, 1),
                  ),
                  Container(
                    height:  34.0,
                    width: 51.0,
                    color: const Color.fromRGBO(196, 196, 196, 1),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 16.0),
              child: SizedBox(
                width: double.infinity,
                child:
                RaisedButton(
                  child: Text(
                    isFollowing?
                    "Following"
                        :
                    "Follow",
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  color: const Color.fromRGBO(196, 196, 196, 1),
                  elevation: 0.0,
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
