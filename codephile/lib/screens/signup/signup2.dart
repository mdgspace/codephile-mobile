import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'signup3.dart';
import 'package:codephile/services/handle.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:codephile/models/signup.dart';

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
  _SignUpPageState({Key key, this.name, this.institute});
  String _codechef, _hackerrank,_codeforces, _hackerearth, _spoj;
  Handle handle;

   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }
  final _formKey = new GlobalKey<FormState>();
  bool isNextButtonTapped = false;

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
              _bar(width, 200),
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
                          padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 20.0),
                          child: Text('Which competetive platforms do you use?',
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                        _showCodechefInput(width),
                        SizedBox(height: 10.0),
                        _showHackerrankInput(width),
                        SizedBox(height: 10.0),
                        _showCodeforcesInput(width),
                        SizedBox(height: 10.0),
                        _showHackerEarthInput(width),
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
                  onSaved: (value) => _codechef = value,
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

  Widget _showHackerEarthInput(double width) {
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
                child: Image.asset("assets/platformIcons/hackerEarthIcon.png"),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: width/4,
                child: Text('HackerEarth'),
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
                  onSaved: (value) => _hackerearth = value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showNextButton() {
    return new FlatButton(
      disabledColor: Colors.black,
      padding: EdgeInsets.all(8),
      color: Colors.white,
      shape: new Border.all(
        width: 2,
        color: Colors.grey,
        style: BorderStyle.solid,

      ),
      child: new Text(
        'Next',
        style: new TextStyle(
          color: Colors.grey,
        ),
      ),
      onPressed: _validateAndSubmit,
    );
  }

  void _validateAndSubmit() {
    isNextButtonTapped = true;
    if (isNextButtonTapped) {
      _codechef = _verifyHandle("codechef", _codechef);
      _hackerearth = _verifyHandle("spoj", _hackerearth);
      _codeforces = _verifyHandle("codeforces", _codeforces);
      _hackerrank = _verifyHandle("hackerrank", _hackerrank);
      Handle handle = new Handle(codechef: _codechef, codeforces: _codeforces, hackerrank: _hackerrank,spoj: _hackerearth);
      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) {
            return SignUpPage3(
              name: name,
              institute: institute,
              handle: handle,
            );
          }));
    }
  }

  String _verifyHandle(String site, String handle) {
    handleVerify(site, handle).then((T) async {
      if(T == true){
        return handle;
      }else{
        return null;
      }
    });
    return null;
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
