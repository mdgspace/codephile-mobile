import 'package:codephile/resources/colors.dart';
import 'package:flutter/material.dart';

class UpdatePasswordScreen extends StatefulWidget{

  final String _token;
  const UpdatePasswordScreen(this._token, {Key key}) : super(key: key);

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Change Password",
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: primaryBlackText
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
    );
  }
}
