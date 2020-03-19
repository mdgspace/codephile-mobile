import 'dart:core';
import 'dart:async';
import 'dart:io';
import 'package:codephile/models/token.dart';
import 'package:codephile/screens/login/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:codephile/homescreen.dart';
import 'package:codephile/screens/signup/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codephile/services/login.dart';
import 'package:codephile/colors.dart';
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
  bool isLoading = false;
  bool isLoginButtonTapped = false;
  bool _obscureText = true;
  bool _iconPerson = false, _iconLock = false, _iconEye = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
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
        isLoginButtonTapped = false;
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
    double height = MediaQuery.of(context).size.height;
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80.0,
            ),
            Center(
              child: logo,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(15.0, 70.0, 0.0, 0.0),
              child: Text('Login',
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ),
            Container(
                height: height / 3,
                child: Padding(
                    padding: EdgeInsets.only(top: 0.0, left: 10.0, right: 20.0),
                    child: new Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          _showUsernameInput(),
                          SizedBox(height: 20.0),
                          _showPasswordInput(),
                          SizedBox(height: 40.0),
                          // _showLoginButton(),
                          // SizedBox(height: 20.0),
                        ],
                      ),
                    ))),
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 70.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'New to Codephile?',
                        style: TextStyle(fontFamily: 'Montserrat'),
                      ),
                      SizedBox(width: 5.0),
                      InkWell(
                        onTap: () {
                          if (!isLoading) {
                            _iconPerson = false;
                            _iconLock = false;
                            _iconEye = false;
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SignUpPage()),
                            ).then((_) => _formKey.currentState.reset());
                          }
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
                ),
                Center(
                  child: ProgressButton(
                    onPressed: loginCallback,
                    positiveCallback: navigateCallback,
                    negativeCallback: () {},
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _showUsernameInput() {
    return new TextFormField(
      onTap: () {
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
      validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
      onSaved: (value) => _username = value,
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: new TextFormField(
        onTap: () {
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
            color: _iconLock ? codephileMain : Colors.grey,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Future<bool> loginCallback() async {
    showConnectivityStatus();
    if (!_validateAndSave()) {
      return false;
    } else {
      setState(() {
        isLoading = true;
      });
      FocusScope.of(context).requestFocus(new FocusNode());
      Token T = await login(_username, _password);
      if (T != null) {
        print(T.token);
        String uid = await id(T.token);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", T.token);
        prefs.setString("uid", uid);
        setState(() {
          isLoading = false;
        });
        return true;
      } else {
        setState(() {
          isLoading = false;
        });
        return false;
      }
    }
  }

  Future navigateCallback() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String uid = prefs.getString('uid');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(token: token, userId: uid)),
    ).then((_) => _formKey.currentState.reset());
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
