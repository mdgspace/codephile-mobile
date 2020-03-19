import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import 'dart:core';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'signup2.dart';
import 'package:codephile/resources/colors.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _name, _institute;
  bool _buttonText = false, _buttonColor = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = new GlobalKey<FormState>();
  bool isNextButtonTapped = false;

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
             _bar(width, false),
             _bar(width, false),
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
                          child: Text('What\'s your name?',
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 10.0),
                        _showNameInput(),
                        SizedBox(height: 30.0),
                        Container(
                          child: Text('What is the name of your Institute?',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 10.0),
                        _showInstituteInput(),
                        SizedBox(height: 240.0),
                        _showNextButton(),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }

  Widget _showNameInput() {
    return new TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
          labelText: 'Enter name',
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.grey),
//          focusedBorder: UnderlineInputBorder(
//              borderSide: BorderSide(color: Colors.green))
      ),
      validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
      onSaved: (value) => _name = value,
    );
  }

  Widget _showInstituteInput() {
  return InputDecorator(
    decoration: InputDecoration(
        labelText: 'Enter name',
        labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.grey),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
        hintText: 'Institute',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
    ),
    isEmpty: _institute == '',
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _institute,
        isDense: true,
        onChanged: (String newValue) {
          setState(() {
            _institute = newValue;
//            state.didChange(newValue);
          });
        },
        items: _inputs.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ),
  );
  }

  var _inputs = [
    'Indian Institute of Technology Roorkee', 'Indian Institute of Technology Delhi','Indian Institute of Technology Mandi','Indian Institute of Technology Indore','Indian Institute of Technology Bombay'
  ];

  Widget _showNextButton() {
    return new FlatButton(
      padding: EdgeInsets.all(10),
      color: _buttonColor ?  codephileMain : Colors.grey[500],
      child: new Text(
        'NEXT',
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
        isNextButtonTapped = true;
        _buttonText = true;
        _buttonColor = true;
      });
      FocusScope.of(context).requestFocus(new FocusNode());
      if (isNextButtonTapped) {

        Future.delayed(const Duration(milliseconds: 1500), () {
          setState(() {
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (context) {
                  return SignUpPage2(
                    name: _name,
                    institute: _institute,
                  );
                }));
          });
        });

      }
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
