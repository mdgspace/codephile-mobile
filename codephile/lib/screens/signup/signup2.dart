import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bar.dart';
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
  _SignUpPageState({Key key, this.name, this.institute});
  String _codechef, _hackerrank,_codeforces, _spoj;
  bool enableTextFields = true;
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
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Bar(true),
                    Bar(true),
                    Bar(false),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height/15,),
                      Text(
                          'Which competetive platforms do you use?',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      _showCodechefInput(width),
                      SizedBox(height: 10.0),
                      _showHackerrankInput(width),
                      SizedBox(height: 10.0),
                      _showCodeforcesInput(width),
                      SizedBox(height: 10.0),
                      _showSpojInput(width),
                    ],
                  ),
                ),
              ],
            ),
            _showNextButton(),
          ],
        ),
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
                  enabled: enableTextFields,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, -5),
                      hintText: "Codechef handle",
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      )
                  ),
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
                  enabled: enableTextFields,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, -5),
                      hintText: "Hackerrank handle",
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      )
                  ),
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
                  enabled: enableTextFields,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, -5),
                      hintText: "Codeforces handle",
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      )
                  ),
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
                  enabled: enableTextFields,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, -5),
                      hintText: "Spoj handle",
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
    return (handleVefifying) ?
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: FlatButton(
        color: isNextButtonTapped ? Colors.grey[500] : codephileMain,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width*0.85,
            child: new Text(
              'VERIFYING HANDLES',
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: isNextButtonTapped ? Colors.grey[700] : Colors.white,
                  fontSize: 16.0
              ),
            ),
          ),
        ),
        onPressed: (){},
      ),
    )
        :
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: FlatButton(
        color: isNextButtonTapped ? Colors.grey[500] : codephileMain,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width*0.85,
            child: new Text(
              'NEXT',
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: isNextButtonTapped ? Colors.grey[700] : Colors.white,
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

  void _validateAndSubmit() async {
    if (_validateAndSave()) {
      setState(() {
        isNextButtonTapped = true;
        handleVefifying = true;
        enableTextFields = false;
      });

      bool allHandlesValid = true;
      if (handleVefifying) {
        if((_codechef != '')&&(_codechef != null)){
          bool isValid = await verifyHandle("codechef", _codechef);
          if (isValid != true) {
            allHandlesValid = false;
            Fluttertoast.showToast(
              msg: "Invalid Codechef handle",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 12.0,
            );
          }
        }else{
          _codechef = '';
        }

        if((_hackerrank != '')&&(_hackerrank != null)){
          bool isValid = await verifyHandle("hackerrank", _hackerrank);
          if (isValid != true) {
            allHandlesValid = false;
            Fluttertoast.showToast(
              msg: "Invalid Hackerrank handle",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 7,
              fontSize: 12.0,
            );
          }
        }else{
          _hackerrank = '';
        }

        if((_codeforces != '')&&(_codeforces != null)){
          bool isValid = await verifyHandle("codeforces", _codeforces);
          if (isValid != true) {
            allHandlesValid = false;
            Fluttertoast.showToast(
              msg: "Invalid Codeforces handle",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 12.0,
            );
          }
        }else{
          _codeforces = '';
        }

        if((_spoj != '')&&(_spoj != null)){
          bool isValid = await verifyHandle("spoj", _spoj);
          if (isValid != true) {
            allHandlesValid = false;
            Fluttertoast.showToast(
              msg: "Invalid Spoj handle",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 7,
              fontSize: 12.0,
            );
          }
        }else{
          _spoj = '';
        }


        var handle = Handle(
            codechef: _codechef,
            codeforces: _codeforces,
            hackerrank: _hackerrank,
            spoj: _spoj
        );

        if(allHandlesValid){
          setState((){
            handleVefifying = false;
            isNextButtonTapped = false;
            enableTextFields = true;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignUpPage3(
                      name: name,
                      institute: institute,
                      handle: handle,
                    )
                )
            );
          });
        }else{
          setState(() {
            enableTextFields = true;
            handleVefifying = false;
            isNextButtonTapped = false;
          });
        }
      }

    }
  }

}
