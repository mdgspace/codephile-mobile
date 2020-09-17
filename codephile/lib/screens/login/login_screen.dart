import 'package:codephile/homescreen.dart';
import 'package:codephile/models/token.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/signup/signup.dart';
import 'package:codephile/services/Id.dart';
import 'package:codephile/services/login.dart';
import 'package:codephile/services/password_reset.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode _usernameFocusNode;
  FocusNode _passwordFocusNode;
  bool _usernameFocus;
  bool _passwordFocus;
  bool _obscureText;
  bool _keepMeLoggedIn;
  bool _loggingIn;
  String _username;
  String _password;
  GlobalKey<FormState> _key;
  TextEditingController _controller;
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();

    _usernameFocus = false;
    _passwordFocus = false;
    _obscureText = true;
    _keepMeLoggedIn = true;
    _loggingIn = false;
    _username = '';
    _password = '';
    _key = GlobalKey<FormState>();
    _controller = TextEditingController();
    _scrollController = ScrollController();
    _usernameFocusNode = FocusNode();
    _usernameFocusNode.addListener(() async {
      setState(() {
        _usernameFocus = _usernameFocusNode.hasFocus;
      });
      await Future.delayed(Duration(milliseconds: 300));

      _scrollController.animateTo(MediaQuery.of(context).viewInsets.bottom,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });

    _passwordFocusNode = FocusNode();
    _passwordFocusNode.addListener(() {
      setState(() {
        _passwordFocus = _passwordFocusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Scaffold(
        body: CustomPaint(
          painter: ShapePainter(),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 30,
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(flex: 10),
                    Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 48.0, fontWeight: FontWeight.bold),
                        )),
                    Spacer(flex: 1),
                    Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                        child: TextFormField(
                          onSaved: (value) {
                            setState(() {
                              _username = value;
                            });
                          },
                          validator: (value) =>
                              value.isEmpty ? 'Username can\'t be empty' : null,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          focusNode: _usernameFocusNode,
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                              hintText: 'Username',
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'assets/person.svg',
                                  color: (_usernameFocus)
                                      ? codephileMain
                                      : Colors.grey,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: codephileMain, width: 1.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: codephileMain, width: 1.5))),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                        child: Stack(
                            alignment: Alignment.centerRight,
                            children: <Widget>[
                              TextFormField(
                                onSaved: (value) {
                                  setState(() {
                                    _password = value;
                                  });
                                },
                                validator: (value) => value.isEmpty
                                    ? 'Password can\'t be empty'
                                    : null,
                                textInputAction: TextInputAction.go,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _obscureText,
                                focusNode: _passwordFocusNode,
                                style: TextStyle(fontSize: 18.0),
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: SvgPicture.asset('assets/lock.svg',
                                          color: (_passwordFocus)
                                              ? codephileMain
                                              : Colors.grey),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: codephileMain, width: 1.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: codephileMain, width: 1.5))),
                              ),
                              IconButton(
                                  icon: SvgPicture.asset(
                                    (_obscureText)
                                        ? 'assets/eye-on.svg'
                                        : 'assets/eye-off.svg',
                                    color: (_passwordFocus)
                                        ? codephileMain
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  })
                            ])),
                    Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                                value: _keepMeLoggedIn,
                                activeColor: codephileMain,
                                onChanged: (val) {
                                  setState(() {
                                    _keepMeLoggedIn = val;
                                  });
                                }),
                            Text('Keep me logged in'),
                            Spacer(),
                            FlatButton(
                                onPressed: () async {
                                  bool result = await buildShowDialog(context);
                                  if (result == true) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Success! Please check your email");
                                  } else if (result == false) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Failure! No user associated with the email address");
                                  }
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: codephileMain),
                                ))
                          ],
                        )),
                    Spacer(flex: 2),
                    Center(
                      child: RaisedButton(
                        padding: EdgeInsets.all(0),
                        child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                color:
                                    (_loggingIn) ? Colors.grey : codephileMain,
                                borderRadius: BorderRadius.circular(0.0)),
                            child: Text(
                              (_loggingIn) ? 'LOGGING IN' : 'LOGIN',
                              style: TextStyle(
                                  color: (_loggingIn)
                                      ? Colors.black87
                                      : Colors.white,
                                  fontSize: 18),
                            )),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            _loggingIn = true;
                          });
                          if (_validateAndSave()) {
                            Token token = await login(_username, _password);
                            if (token != null) {
                              String uid = await id(token.token, context);
                              if (_keepMeLoggedIn) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString("token", token.token);
                                prefs.setString("uid", uid);
                              }
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomePage(
                                  token: token.token,
                                  userId: uid,
                                );
                              }));
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Incorrect username or password.');
                            }
                          }
                          setState(() {
                            _loggingIn = false;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 25.0),
                      child: Center(
                        child: RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: 'Don\'t have an account? ',
                              style: TextStyle(color: Colors.grey)),
                          TextSpan(
                              text: 'Create one!',
                              style: TextStyle(color: codephileMain),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignUpPage();
                                  }));
                                })
                        ])),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future buildShowDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
              titlePadding: EdgeInsets.all(0),
              title: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                decoration: BoxDecoration(
                    color: Color(0xFFF3F4F7),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Text(
                  "Forgot Password",
                  textAlign: TextAlign.center,
                ),
              ),
              contentPadding: EdgeInsets.all(0),
              content: Padding(
                  padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter email',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: codephileMain, width: 1.5)),
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    controller: _controller,
                  )),
              actions: <Widget>[
                FlatButton(
                    padding: EdgeInsets.all(15),
                    onPressed: () async {
                      String email = _controller.text;
                      bool result = await resetPassword(email);
                      Navigator.pop(context, result);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                      color: codephileMain,
                      child:
                          Text("Okay", style: TextStyle(color: Colors.white)),
                    ))
              ],
              actionsPadding: EdgeInsets.all(0),
            ));
  }

  bool _validateAndSave() {
    final FormState form = _key.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = codephileMainShade
      ..style = PaintingStyle.fill;
    double startX = 225, startY = 75;
    Path trianglePath = Path()
      ..moveTo(startX, startY)
      ..lineTo(startX + 300, startY + 50)
      ..lineTo(startX + 100, startY + 300)
      ..lineTo(startX, startY);
    canvas.drawCircle(Offset(30, 100), 175.0, paint);
    canvas.drawPath(trianglePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
