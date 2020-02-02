import 'package:codephile/homescreen.dart';
import 'package:codephile/screens/on_boarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codephile/screens/login/login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
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
      String token = prefs.getString('token');
      String uid = prefs.getString('uid');
      if (token != null && uid != null) {
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) =>  HomePage(token: token, userId: uid)));
      } else {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => LoginPage()));
      }
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
