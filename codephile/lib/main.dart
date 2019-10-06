import 'package:codephile/screens/on_boarding/on_boarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup.dart';
import 'homescreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
      home: new ChooseHome(),
    );
  }
}

class ChooseHome extends StatefulWidget {
  @override
  ChooseHomeState createState() => new ChooseHomeState();
}

class ChooseHomeState extends State<ChooseHome> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) =>  MyHomePage()));
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => OnBoarding()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text(""),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
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
//                  Container(
//                    padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
//                    child: Text('There',
//                        style: TextStyle(
//                            fontSize: 80.0, fontWeight: FontWeight.bold)),
//                  ),
//                  Container(
//                    padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
//                    child: Text('.',
//                        style: TextStyle(
//                            fontSize: 80.0,
//                            fontWeight: FontWeight.bold,
//                            color: Colors.blue[900])),
//                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                    ),
                    SizedBox(height: 5.0),
//                    Container(
//                      alignment: Alignment(1.0, 0.0),
//                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
//                      child: InkWell(
//                        child: Text(
//                          'Forgot Password',
//                          style: TextStyle(
//                              color: Colors.blue[900],
//                              fontWeight: FontWeight.bold,
//                              fontFamily: 'Montserrat',
//                              decoration: TextDecoration.none),
//                        ),
//                      ),
//                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 50.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.grey,
                        color: Colors.grey,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => HomePage()),
                            );
                          },
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
//                    Container(
//                      height: 40.0,
//                      color: Colors.transparent,
//                      child: Container(
//                        decoration: BoxDecoration(
//                            border: Border.all(
//                                color: Colors.black,
//                                style: BorderStyle.solid,
//                                width: 1.0),
//                            color: Colors.transparent,
//                            borderRadius: BorderRadius.circular(20.0)),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Center(
//                              child:
//                              ImageIcon(AssetImage('assets/facebook.png')),
//                            ),
//                            SizedBox(width: 10.0),
//                            Center(
//                              child: Text('Log in with facebook',
//                                  style: TextStyle(
//                                      fontWeight: FontWeight.bold,
//                                      fontFamily: 'Montserrat')),
//                            )
//                          ],
//                        ),
//                      ),
//                    )
                  ],
                )),
            SizedBox(height: 5.0),
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
                      CupertinoPageRoute(builder: (context) => SignupPage()),
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
            )
          ],
        ));
  }
}
