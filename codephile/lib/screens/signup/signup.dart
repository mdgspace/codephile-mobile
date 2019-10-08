import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'signup2.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 45),
                  height: 10.0,
                  width: 100,
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey,
                    elevation: 7.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 45),
                  height: 10.0,
                  width: 100,
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
//                    shadowColor: Colors.grey[200],
                    color: Colors.grey[200],
                    elevation: 7.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 45),
                  height: 10.0,
                  width: 100,
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
//                    shadowColor: Colors.grey[200],
                    color: Colors.grey[200],
                    elevation: 7.0,
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
              child: Text(
                  'What\'s your name?',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Enter name here',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      child: Text(
                          'What is the name of your Institute?',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Enter institute here',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 240.0),
                    Container(
                      height: 50.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.grey,
                        color: Colors.grey,
                        elevation: 4.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                            context,
                              CupertinoPageRoute(builder: (context) => SignupPage2()),
                            );
                          },
                          child: Center(
                            child: Text(
                              'Next',
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
                  ],
                )),
          ],
        ),
    );
  }
}