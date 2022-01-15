import 'package:codephile/models/user.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/update_details/update_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:codephile/resources/helper_functions.dart';

class SettingsIcon extends StatefulWidget {
  final String? _token;
  final CodephileUser? _user;
  final Function _callbackRefresh;
  const SettingsIcon(this._token, this._user, this._callbackRefresh, {Key? key})
      : super(key: key);
  @override
  _SettingsIconState createState() => _SettingsIconState();
}

class _SettingsIconState extends State<SettingsIcon> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.width / 15,
          width: MediaQuery.of(context).size.width / 15,
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
              size: MediaQuery.of(context).size.width / 15,
            ),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: "update",
                  child: Text(
                    "Update Details",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: primaryBlackText,
                    ),
                  ),
                ),
                const PopupMenuItem(
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
    switch (value) {
      case "update":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateDetails(
              widget._token,
              widget._user,
              widget._callbackRefresh,
            ),
          ),
        );
        break;
      case "logout":
        logout(token: widget._token!, context: context);
        break;
    }
  }
}
