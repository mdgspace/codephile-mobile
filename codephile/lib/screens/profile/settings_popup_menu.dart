import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/login/login.dart';
import 'package:codephile/services/logout_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsIcon extends StatefulWidget{
  final String _token;

  const SettingsIcon(this._token, {Key key }) : super(key: key);
  @override
  _SettingsIconState createState() => _SettingsIconState();
}

class _SettingsIconState extends State<SettingsIcon> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width/15,
          width: MediaQuery.of(context).size.width/15,
          child: SvgPicture.asset(
            "assets/settings_icon.svg",
          ),
        ),
        Positioned(
          top: -10.0,
          right: -10.0,
          child: PopupMenuButton(
            icon: Icon(
              Icons.settings,
              color: Colors.transparent,
              size: MediaQuery.of(context).size.width/15,
            ),
            itemBuilder: (BuildContext context){
              return [
                PopupMenuItem(
                  value: "update",
                  child: Text(
                    "Update Details",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: primaryBlackText,
                    ),
                  ),

                ),
                PopupMenuItem(
                  value: "logout",
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: primaryBlackText,
                    ),
                  ),
                )
              ];
            },
            onSelected: optionSelect,
          ),
        ),
      ],
    );
  }

  void optionSelect(String value) {
    switch(value){
      case "update" :
        //TODO: Navigate to update page       Priority 1
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//              builder: (context) =>
//          )
//        );
        break;
      case "logout" :
        logout(widget._token);
        break;
    }
  }

  void logout(String token) async{
    logoutUser(token).then((wasSuccessful){
      print(wasSuccessful);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("uid");
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage())
    );
  }
}
