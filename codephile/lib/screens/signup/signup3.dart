import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import 'package:codephile/colors.dart';
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
  bool _buttonText = false, _buttonColor = false;
  bool _iconColor1 = false, _iconColor2 = false, _iconColor3 = false;
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
              _bar(width, true),
              _bar(width, true),
              _bar(width, true),
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
                          padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
                          child: Text('Setup a username and password for Codephile',
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 25.0),
                        _showUsernameInput(),
                        SizedBox(height: 15.0),
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
      onTap: (){
        setState(() {
          _iconColor1 = true;
        });
      },
      maxLines: 1,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: new InputDecoration(
        labelText: "Username",
        prefixIcon: new Icon(
          Icons.person,
          color: _iconColor1 ? codephileMain : Colors.grey,
          size: 39,
        ),
        border: OutlineInputBorder(),
        labelStyle: new TextStyle(
          color: Colors.grey,
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
        onTap: (){
          setState(() {
            _iconColor2 = true;
            _iconColor3 = true;
          });
        },
        maxLines: 1,
        obscureText: _obscureText,
        autofocus: false,
        decoration: new InputDecoration(
          suffixIcon: GestureDetector(
            child: new Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: _iconColor3 ?  codephileMain : Colors.grey,
            ),
            onTap: _toggle,
          ),
          labelText: "Password",
          border: OutlineInputBorder(),
          prefixIcon: new Icon(
            Icons.lock,
            color: _iconColor2 ?  codephileMain : Colors.grey,
            size: 39,
          ),
          labelStyle: new TextStyle(
            color: Colors.grey,
          ),
        ),
        validator: (value){
          return value.isEmpty ? 'Password can\'t be empty' : null;
        },
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showCreateAccountButton() {
    showConnectivityStatus();
    return (isCreateAccountButtonTapped)
        ? new FlatButton(
        padding: EdgeInsets.all(8),
        color: _buttonColor ? codephileMain : Colors.grey[500],
        shape: new Border.all(
          width: 2,
          color: Colors.grey,
          style: BorderStyle.solid,
        ),
        child: new Text(
          'Creating...',
          style: new TextStyle(
            color: _buttonText ? Colors.white : Colors.grey[700],
          ),
        ),
        onPressed: () {})
        : (isCreateAccountSuccessful)
        ? new FlatButton(
        padding: EdgeInsets.all(8),
        color: _buttonColor ? codephileMain : Colors.grey[500],
        shape: new Border.all(
          width: 2,
          color: Colors.grey,
          style: BorderStyle.solid,
        ),
        child: new Text(
          'Created Successfully',
          style: new TextStyle(
            color: _buttonText ? Colors.white : Colors.grey[700],
          ),
        ),
        onPressed: () {})
        : new FlatButton(
      padding: EdgeInsets.all(8),
      color: _buttonColor ? codephileMain : Colors.grey[500],
      shape: new Border.all(
        width: 2,
        color: Colors.grey,
        style: BorderStyle.solid,
      ),
      child: new Text(
        'Create Account',
        style: new TextStyle(
          color: _buttonText ? Colors.white : Colors.grey[700],
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
        _buttonText = true;
        _buttonColor = true;
        _iconColor1 = true;
        _iconColor2 = true;
        _iconColor3 = true;
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

  Widget _bar(double width, bool shade) {
    return  Container(
      margin: EdgeInsets.only(top: 45),
      height: 10.0,
      width: width/3.5,
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: shade ? codephileMain : codephileMainShade ,
        elevation: 7.0,
      ),
    );
  }
}
