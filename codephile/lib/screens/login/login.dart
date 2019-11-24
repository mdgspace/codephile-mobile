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

  bool _obscureText = true;

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
      Fluttertoast.showToast(
        msg: "Please check your connection!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 7,
        fontSize: 12.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 250.0, 0.0, 0.0),
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
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => SignUpPage()),
                            );
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
      maxLines: 1,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: new InputDecoration(
        labelText: "Username",
        labelStyle: new TextStyle(
          color: Colors.grey,
        ),
        icon: new Icon(
          Icons.person,
          color: Colors.grey,
          size: 39,
        ),
      ),
      validator: (value) =>
      value.isEmpty ? 'Username can\'t be empty' : null,
      onSaved: (value) => _username = value,
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: _obscureText,
        autofocus: false,
        decoration: new InputDecoration(
          suffixIcon: GestureDetector(
            child: new Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onTap: _toggle,
          ),
          labelText: "Password",
          labelStyle: new TextStyle(
            color: Colors.grey,
          ),
          icon: new Icon(
            Icons.lock,
            color: Colors.grey,
            size: 39,
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
        color: Colors.white,
        shape: new Border.all(
          width: 2,
          color: Colors.grey,
          style: BorderStyle.solid,
        ),
        child: new Text(
          'Authenticating...',
          style: new TextStyle(
            color: Colors.grey,
          ),
        ),
        onPressed: () {})
        : (_isLoginSuccessful)
        ? new FlatButton(
        padding: EdgeInsets.all(8),
        color: Colors.white,
        shape: new Border.all(
          width: 2,
          color: Colors.grey,
          style: BorderStyle.solid,
        ),
        child: new Text(
          'Logged In Successfully',
          style: new TextStyle(
            color: Colors.grey,
          ),
        ),
        onPressed: () {})
        : new FlatButton(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      shape: new Border.all(
        width: 2,
        color: Colors.grey,
        style: BorderStyle.solid,
      ),
      child: new Text(
        'LOGIN',
        style: new TextStyle(
          color: Colors.grey,
        ),
      ),
      onPressed: _validateAndSubmit,
    );
  }

  void _validateAndSubmit() {
    if(_validateAndSave()) {
      setState(() {
        isLoginButtonTapped = true;
      });
    }
    FocusScope.of(context).requestFocus(new FocusNode());
    login(_username, _password).then((T) async {
      if(T == true) {
        setState(() {
          _isLoginSuccessful = true;
          isLoginButtonTapped = false;
        });
        await new Future.delayed(const Duration(seconds: 5));
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => HomePage()),
        );
      }else{
        setState(() {
          _isLoginSuccessful = false;
          isLoginButtonTapped = false;
        });

      }
    });
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<SharedPreferences> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}