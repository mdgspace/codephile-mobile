import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:codephile/models/signup.dart';
import 'package:codephile/services/signup.dart';
import 'package:codephile/homescreen.dart';

class SignUpPage3 extends StatefulWidget {
  final String name;
  final String institute;
  final Handle handle;

  const SignUpPage3({Key key, this.name, this.institute, this.handle}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState(name: name, institute: institute, handle: handle);
}

class _SignUpPageState extends State<SignUpPage3> {
  String _username, _password;
  String name;
  String institute;
  Handle handle;
  _SignUpPageState({Key key, this.name, this.institute, this.handle});

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = new GlobalKey<FormState>();

  bool isCreateAccountButtonTapped = false;
  bool isCreateAccountSuccessful = false;
  bool _obscureText = true;

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
    final width = MediaQuery.of(context).size.width;
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _bar(width, 500),
              _bar(width, 500),
              _bar(width, 500),
            ],
          ),

          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                  child: new Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
                          child: Text('Setup a username and password for Codephile',
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                        _showUsernameInput(),
                        _showPasswordInput(),
                        SizedBox(height: 260.0),
                        _showCreateAccountButton(),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ))),
        ],
      ),
    );
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

  Widget _showCreateAccountButton() {
    showConnectivityStatus();

    return (isCreateAccountButtonTapped)
        ? new FlatButton(
        padding: EdgeInsets.all(8),
        color: Colors.white,
        shape: new Border.all(
          width: 2,
          color: Colors.grey,
          style: BorderStyle.solid,
        ),
        child: new Text(
          'Creating...',
          style: new TextStyle(
            color: Colors.grey,
          ),
        ),
        onPressed: () {})
        : (isCreateAccountSuccessful)
        ? new FlatButton(
        padding: EdgeInsets.all(8),
        color: Colors.white,
        shape: new Border.all(
          width: 2,
          color: Colors.grey,
          style: BorderStyle.solid,
        ),
        child: new Text(
          'Created Successfully',
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
        'Create Account',
        style: new TextStyle(
          color: Colors.grey,
        ),
      ),
      onPressed: _validateAndSubmit,
    );
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() {
    if (_validateAndSave()) {
      setState(() {
        isCreateAccountButtonTapped = true;
      });
      FocusScope.of(context).requestFocus(new FocusNode());
      SignUp details = new SignUp(handle: handle, password: _password, username: _username, fullname: name, institute: institute);
      signUp(details).then((T) async {
        if(T == true){
          setState(() {
            isCreateAccountButtonTapped = false;
            isCreateAccountSuccessful = true;
          });
          Fluttertoast.showToast(
            msg: "Account Creation unsuccessful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 7,
            fontSize: 12.0,
          );
          await new Future.delayed(const Duration(seconds: 5));
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => HomePage()),
          );
        }else{
          setState(() {
            isCreateAccountButtonTapped = false;
            isCreateAccountSuccessful = false;
          });
        }
      });
    }
  }

  Widget _bar(double width, int shade) {
    return  Container(
      margin: EdgeInsets.only(top: 45),
      height: 10.0,
      width: width/3.5,
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[shade],
        elevation: 7.0,
      ),
    );
  }
}
