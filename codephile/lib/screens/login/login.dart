import 'dart:core';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:codephile/homescreen.dart';
import 'package:codephile/screens/signup/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codephile/services/login.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/services/Id.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {

  final String code;

  const LoginPage({Key key, this.code}) : super(key: key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = new GlobalKey<FormState>();

  String _username, _password;
  bool isLoading;
  bool isLoginButtonTapped = false;
  bool _isLoginSuccessful = false;
  bool _buttonText = false, _buttonColor = false;
  bool _obscureText = true;
  bool _iconPerson = false, _iconLock = false, _iconEye = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState(){
    super.initState();
    showConnectivityStatus();
  }

  Future showConnectivityStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      setState(() {
        _isLoginSuccessful = false;
        isLoginButtonTapped = false;
        _buttonColor = false;
        _buttonText = false;
      });
      Fluttertoast.showToast(
        msg: "Please check your connection!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 7,
        fontSize: 12.0,
      );
    }
  }

  final Widget logo = new SvgPicture.asset(
    "assets/logo.svg",
    width: 80.0,
    height: 80.0,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 80),
            ),
            Center(
              child: logo,
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 70.0, 0.0, 0.0),
                    child: Text('Login',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Padding(
                padding: EdgeInsets.only(top: 0.0, left: 10.0, right: 20.0),
                child: new Form(
                  key: _formKey,
                  child: ListView(
                  children: <Widget>[
                    _showUsernameInput(),
                    SizedBox(height: 20.0),
                   _showPasswordInput(),
                    SizedBox(height: 5.0),
                    SizedBox(height: 40.0),
                    _showLoginButton(),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New to Codephile?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        SizedBox(width: 5.0),
                        InkWell(
                          onTap: () {
                            _iconPerson = false;
                            _iconLock = false;
                            _iconEye = false;
                            _isLoginSuccessful = false;
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => SignUpPage()),
                            ).then((_) => _formKey.currentState.reset());
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none),
                          ),
                        )
                      ],
                    ),
                  ],
                  ),
                ))),

          ],
        ));
  }

  Widget _showUsernameInput() {
    return new TextFormField(
      onTap: (){
        _iconPerson = true;
      },
      maxLines: 1,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: new InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          Icons.person,
          color: _iconPerson ? codephileMain : Colors.grey,
          size: 39,
        ),
        labelText: "Username",
        labelStyle: new TextStyle(
          color: _iconPerson ? codephileMain : Colors.grey,
        ),
      ),
      validator: (value) =>
      value.isEmpty ? 'Username can\'t be empty' : null,
      onSaved: (value) => _username = value,
    );
  }

  Widget _showPasswordInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: new TextFormField(
        onTap: (){
          _iconEye = true;
          _iconLock = true;
        },
        maxLines: 1,
        obscureText: _obscureText,
        autofocus: false,
        decoration: new InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.lock,
            color: _iconLock ? codephileMain : Colors.grey,
            size: 39,
          ),
          suffixIcon: GestureDetector(
            child: new Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: _iconEye ? codephileMain : Colors.grey,
            ),
            onTap: _toggle,
          ),
          labelText: "Password",
          labelStyle: new TextStyle(
            color: _iconLock ? codephileMain: Colors.grey,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showLoginButton() {
    showConnectivityStatus();
    return (isLoginButtonTapped)
        ? new FlatButton(
        padding: EdgeInsets.all(8),
        color: _buttonColor ? codephileMain : Colors.grey[500],
//        shape: new Border.all(
//          width: 2,
//          color: Colors.grey,
//          style: BorderStyle.solid,
//        ),
        child: new Text(
          'AUTHENTICATING...',
          style: new TextStyle(
            color: _buttonText ? Colors.white : Colors.grey[700],
          ),
        ),
        onPressed: () {})
        : (_isLoginSuccessful)
        ? new FlatButton(
        padding: EdgeInsets.all(8),
        color: _buttonColor ? codephileMain : Colors.grey[500],
//        shape: new Border.all(
//          width: 2,
//          color: Colors.grey,
//          style: BorderStyle.solid,
//        ),
        child: new Text(
          'LOGGED IN SUCCESSFULLY',
          style: new TextStyle(
            color: _buttonText ? Colors.white : Colors.grey[700],
          ),
        ),
        onPressed: () {})
        : new FlatButton(
      padding: EdgeInsets.all(8),
      color: _buttonColor ? codephileMain : Colors.grey[500],
//      shape: new Border.all(
//        width: 2,
//        color: Colors.grey,
//        style: BorderStyle.solid,
//      ),
      child: new Text(
        'LOGIN',
        style: new TextStyle(
          color: _buttonText ? Colors.white : Colors.grey[700],
        ),
      ),
      onPressed: _validateAndSubmit,
    );
  }

  void _validateAndSubmit() {
    if(_validateAndSave()) {
      setState(() {
        isLoginButtonTapped = true;
        _buttonText = true;
        _buttonColor = true;
      });
      FocusScope.of(context).requestFocus(new FocusNode());
      login(_username, _password).then((T) async {
        if (T != null) {
          print(T.token);
          saveToken(T.token);
          setState(() {
            _isLoginSuccessful = true;
            isLoginButtonTapped = false;
            _iconPerson = false;
            _iconLock = false;
            _iconEye = false;
          });
          await new Future.delayed(const Duration(seconds: 3));
          id(T.token).then((id) async {
            Navigator.push(
             context,
             CupertinoPageRoute(builder: (context) => HomePage(token: T.token, userId: id)),
          ).then((_) => _formKey.currentState.reset());
          });
        } else {
          setState(() {
            _isLoginSuccessful = false;
            isLoginButtonTapped = false;
          });
        }
      });
    }
  }

  Future<void> saveToken(
    String token,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<SharedPreferences> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
