import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/signup/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool value = true;
  FocusNode _usernameFocusNode;
  FocusNode _passwordFocusNode;
  bool _usernameFocus;
  bool _passwordFocus;
  @override
  void initState() {
    super.initState();
    _usernameFocus = false;
    _passwordFocus = false;
    _usernameFocusNode = FocusNode();
    _usernameFocusNode.addListener(() {
      setState(() {
        _usernameFocus = _usernameFocusNode.hasFocus;
      });
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 48.0, fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
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
                              borderSide:
                                  BorderSide(color: codephileMain, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: codephileMain, width: 1.5))),
                    )),
                Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
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
                              borderSide:
                                  BorderSide(color: codephileMain, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: codephileMain, width: 1.5))),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                            value: value,
                            onChanged: (val) {
                              value = val;
                            }),
                        Text('Keep me signed in'),
                        Spacer(),
                        FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: codephileMain),
                            ))
                      ],
                    )),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.all(0),
                    child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: codephileMain,
                            borderRadius: BorderRadius.circular(0.0)),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                    onPressed: () {},
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
                              Navigator.pushReplacement(context,
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
    );
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
    canvas.drawCircle(Offset(30, 100), 150.0, paint);
    canvas.drawPath(trianglePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
