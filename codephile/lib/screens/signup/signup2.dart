import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'signup3.dart';
import 'package:codephile/services/handle.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/models/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage2 extends StatefulWidget {
 final String name;
 final String institute;

  const SignUpPage2({Key key, this.name, this.institute})
      : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState(name: name,institute: institute);
}

class _SignUpPageState extends State<SignUpPage2> {

  String name;
  String institute;
  bool _buttonText = false, _buttonColor = false;
  _SignUpPageState({Key key, this.name, this.institute});
  String _codechef, _hackerrank,_codeforces, _spoj;
  Handle handle;

   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }
  final _formKey = new GlobalKey<FormState>();
  bool isNextButtonTapped = false;
  bool handleVefifying = false;

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
                          padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 20.0),
                          child: Text('Which competetive platforms do you use?',
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                        _showCodechefInput(width),
                        SizedBox(height: 10.0),
                        _showHackerrankInput(width),
                        SizedBox(height: 10.0),
                        _showCodeforcesInput(width),
                        SizedBox(height: 10.0),
                        _showSpojInput(width),
                        SizedBox(height: 110.0),
                        _showNextButton(),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }

  Widget _showCodechefInput(double width) {
    return Center(
      child: Card(
        child: Container(
          height: 50,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: width/10,
                child: Image.asset("assets/platformIcons/codeChefIcon.png"),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: width/4,
                child: Text('Codechef'),
              ),
              Container(
                width: width/2,
                padding: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(

                          fontFamily: 'Montserrat',
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                  onSaved: (value) {
                    _codechef = value;
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _showHackerrankInput(double width) {
    return Center(
      child: Card(
        child: Container(
          height: 50,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: width/10,
                child: Image.asset("assets/platformIcons/hackerRankIcon.png"),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: width/4,
                child: Text('HackerRank'),
              ),
              Container(
                width: width/2,
                padding: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                  onSaved: (value) => _hackerrank = value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showCodeforcesInput(double width) {
    return Center(
      child: Card(
        child: Container(
          height: 50,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: width/10,
                child: Image.asset("assets/platformIcons/codeForcesIcon.png"),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: width/4,
                child: Text('CodeForces'),
              ),
              Container(
                width: width/2,
                padding: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                  onSaved: (value) => _codeforces = value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showSpojInput(double width) {
    return Center(
      child: Card(
        child: Container(
          height: 50,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: width/10,
                child: Image.asset("assets/platformIcons/spoj.png"),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: width/4,
                child: Text('Spoj'),
              ),
              Container(
                width: width/2,
                padding: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                  onSaved: (value) => _spoj = value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showNextButton() {
    return (handleVefifying) ? new FlatButton(
      padding: EdgeInsets.all(10),
      color: _buttonColor ?  codephileMain : Colors.grey[500],
      child: new Text(
        'VERIFYING HANDLE',
        style: new TextStyle(
          color: _buttonText ? Colors.white : Colors.grey[700],
        ),
      ),
      onPressed: _validateAndSubmit,
    ) : new FlatButton(
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
        handleVefifying = true;
      });

      if (handleVefifying) {
        handleVerify("codechef", _codechef).then((T) async {
          if (T == true) {
            Fluttertoast.showToast(
              msg: "Codechef handle verified",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 7,
              fontSize: 12.0,
            );
          } else {
            _codechef = "";
            Fluttertoast.showToast(
              msg: "Wrong handle for Codechef",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 7,
              fontSize: 12.0,
            );
          }
        });

        handleVerify("hackerrank", _hackerrank).then((T) async {
          if (T == true) {
            Fluttertoast.showToast(
              msg: "Hackerrank handle verified",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 7,
              fontSize: 12.0,
            );
          } else {
            _hackerrank = "";
            Fluttertoast.showToast(
              msg: "Wrong handle for Hackerrank",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 7,
              fontSize: 12.0,
            );
          }
        });
        handleVerify("codeforces", _codeforces).then((T) async {
          if (T == true) {
            Fluttertoast.showToast(
              msg: "Codeforces handle verified",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 7,
              fontSize: 12.0,
            );
          } else {
            _codeforces = "";
            Fluttertoast.showToast(
              msg: "Wrong handle for codeforces",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 7,
              fontSize: 12.0,
            );
          }
        });
        handleVerify("spoj", _spoj).then((T) async {
          if (T == true) {
            Fluttertoast.showToast(
              msg: "Spoj handle verified",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 7,
              fontSize: 12.0,
            );
          } else {
            _spoj = "";
            Fluttertoast.showToast(
              msg: "Wrong handle for Spoj",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 7,
              fontSize: 12.0,
            );
          }
        });

        Handle handle = new Handle(codechef: _codechef,
            codeforces: _codeforces,
            hackerrank: _hackerrank,
            spoj: _spoj);

        setState(() async{
          handleVefifying = false;
          await new Future.delayed(const Duration(seconds: 10));
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) {
                return SignUpPage3(
                  name: name,
                  institute: institute,
                  handle: handle,
                );
              }));
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
