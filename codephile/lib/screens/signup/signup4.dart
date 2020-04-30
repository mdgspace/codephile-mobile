import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/services/upload_user_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:codephile/resources/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:codephile/models/signup.dart';
import 'package:codephile/services/signup.dart';
import 'package:codephile/homescreen.dart';
import 'package:codephile/services/login.dart';
import 'package:codephile/services/Id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'progress_tab_bar.dart';

class SignUpPage4 extends StatefulWidget {
  final String name;
  final String institute;
  final Handle handle;
  final String userImagePath;

  const SignUpPage4({Key key, this.name, this.institute, this.handle, this.userImagePath})
      : super(key: key);

  @override
  _SignUpPageState createState() =>
      _SignUpPageState(name: name, institute: institute, handle: handle, userImagePath: userImagePath);
}

class _SignUpPageState extends State<SignUpPage4> {
  String _username, _password;
  String name;
  String institute;
  Handle handle;
  String userImagePath;
  bool enableTextFields = true;
  bool _userIconColor = false, _lockIconColor = false, _seePasswordIconColor = false;
  _SignUpPageState({Key key, this.name, this.institute, this.handle, this.userImagePath});

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = new GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
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


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                ProgressTabBar(4),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height/15),
                      Text(
                          'Setup a username and password for Codephile',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      SizedBox(height: 25.0),
                      _showUsernameInput(),
                      SizedBox(height: 15.0),
                      _showPasswordInput(),
                    ],
                  ),
                )
              ],
            ),
            _showCreateAccountButton(),
          ],
        ),
      ),
    );
  }

  Widget _showUsernameInput() {
    return new TextFormField(
      onTap: () {
        setState(() {
          _userIconColor = true;
          if((_passwordController.text == '')||(_passwordController.text == null)){
            _seePasswordIconColor = false;
            _lockIconColor = false;
          }
        });
      },
      controller: _usernameController,
      enabled: enableTextFields,
      maxLines: 1,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: new InputDecoration(
        labelText: "Username",
        prefixIcon: new Icon(
          Icons.person,
          color: _userIconColor ? codephileMain : Colors.grey,
          size: 39,
        ),
        border: OutlineInputBorder(),
        labelStyle: new TextStyle(
          color: Colors.grey,
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
          setState(() {
            _lockIconColor = true;
            _seePasswordIconColor = true;
            if((_usernameController.text == '')||(_passwordController.text == null)){
              _userIconColor = false;
            }
          });
        },
        controller: _passwordController,
        enabled: enableTextFields,
        maxLines: 1,
        obscureText: _obscureText,
        autofocus: false,
        decoration: new InputDecoration(
          suffixIcon: GestureDetector(
            child: new Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: _seePasswordIconColor ? codephileMain : Colors.grey,
            ),
            onTap: _toggle,
          ),
          labelText: "Password",
          border: OutlineInputBorder(),
          prefixIcon: new Icon(
            Icons.lock,
            color: _lockIconColor ? codephileMain : Colors.grey,
            size: 39,
          ),
          labelStyle: new TextStyle(
            color: Colors.grey,
          ),
        ),
        validator: (value) {
          return value.isEmpty ? 'Password can\'t be empty' : null;
        },
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showCreateAccountButton() {
    showConnectivityStatus();
    return (isCreateAccountButtonTapped) ?
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: FlatButton(
          color: Colors.grey[500],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.85,
              child: Text(
                'Creating...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          onPressed: () {}),
    )
        : (isCreateAccountSuccessful) ?
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: FlatButton(
          color: codephileMain,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.85,
              child: new Text(
                'Created Successfully',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          onPressed: () {}),
    )
        :
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: FlatButton(
        color: codephileMain,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width*0.85,
            child: new Text(
              'Create Account',
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        onPressed: _validateAndSubmit,
      ),
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
    if (_validateAndSave()){
      setState(() {
        isCreateAccountButtonTapped = true;
        enableTextFields = false;
        _userIconColor = true;
        _lockIconColor = true;
        _seePasswordIconColor = true;
      });
      SignUp details = SignUp(
          handle: handle,
          password: _password,
          username: _username,
          fullname: name,
          institute: institute
      );
      signUp(details).then((statusCode){
        if (statusCode == 201) {
          Fluttertoast.showToast(
            msg: "Account Creation successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 12.0,
          );
          setState(() {
            isCreateAccountButtonTapped = false;
            isCreateAccountSuccessful = true;
          });
          login(_username, _password).then((userToken){
            if (userToken != null) {
              print(userToken.token);
              id(userToken.token).then((id) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("token", userToken.token);
                prefs.setString("uid", id);
                if(userImagePath != null){
                  int uploadStatusCode = await uploadImage(userToken.token, userImagePath);
                  print(uploadStatusCode);
                }
                if (isCreateAccountSuccessful) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(token: userToken.token, userId: id)),
                  ).then((_) => _formKey.currentState.reset());
                }
              });
            } else {
              Fluttertoast.showToast(
                msg: "Something went wrong. Try Again",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                fontSize: 12.0,
              );
              setState(() {
                isCreateAccountButtonTapped = false;
                isCreateAccountSuccessful = false;
                enableTextFields = true;
              });
            }
          });
        } else if(statusCode == 409) {
          Fluttertoast.showToast(
            msg: "Username Already Taken",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 12.0,
          );
          setState(() {
            isCreateAccountButtonTapped = false;
            isCreateAccountSuccessful = false;
            enableTextFields = true;
          });
        } else{
          Fluttertoast.showToast(
            msg: "Account Creation unsuccessful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 12.0,
          );
          setState(() {
            isCreateAccountButtonTapped = false;
            isCreateAccountSuccessful = false;
            enableTextFields = true;
          });
        }
      });
    }
  }

}
