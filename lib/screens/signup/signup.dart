import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/services/email_availability.dart';
import 'package:codephile/services/institute_list.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'progress_tab_bar.dart';
import 'signup2.dart';
import 'package:codephile/resources/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String _name, _email;
  String? _institute;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  bool isNextButtonTapped = false;
  List<String> _instituteList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isNextButtonTapped = false;
    showConnectivityStatus();
    getInstituteList().then((instituteList) {
      setState(() {
        if (instituteList.isNotEmpty) {
          _instituteList = instituteList;
        } else {
          _instituteList = [
            'Indian Institute of Technology Roorkee',
            'Indian Institute of Technology Delhi',
            'Indian Institute of Technology Mandi',
            'Indian Institute of Technology Indore',
            'Indian Institute of Technology Bombay'
          ];
        }
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const ProgressTabBar(1),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.fromLTRB(
                                0.0,
                                20.0,
                                0.0,
                                20.0,
                              ),
                              child: Text(
                                'What\'s your name?',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _showNameInput(),
                            const Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                              child: Text(
                                'What\'s your email?',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _showEmailInput(),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Text(
                                'What is the name of your Institute?',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _showInstituteInput(),
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

  Widget _showNameInput() {
    return TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Enter full name',
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
      ),
      validator: (value) => value!.isEmpty ? 'Name can\'t be empty' : null,
      onSaved: (value) => _name = value!,
    );
  }

  Widget _showEmailInput() {
    return TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Enter email ID',
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
      ),
      validator: (value) => value!.isEmpty
          ? 'Email can\'t be empty'
          : RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)
              ? null
              : "Enter a valid email address!",
      onSaved: (value) => _email = value!,
    );
  }

  Widget _showInstituteInput() {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
      child: DropdownSearch<String>(
        items: _instituteList,
        onChanged: (String? institute) {
          setState(() {
            _institute = institute;
          });
        },
        dropdownSearchDecoration: const InputDecoration(
          hintText: 'Select Institute',
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }

  Widget _showNextButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              isNextButtonTapped ? Colors.grey[500] : codephileMain,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Text(
              'NEXT',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: isNextButtonTapped ? Colors.grey[700] : Colors.white,
              ),
            ),
          ),
        ),
        onPressed: _validateAndSubmit,
      ),
    );
  }

  Future<bool> _validateAndSave() async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      final response = await isEmailAvailable(_email);
      if (!response) {
        Fluttertoast.showToast(
          msg: 'An account with this email already exists!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
      return response;
    }
    return false;
  }

  void _validateAndSubmit() async {
    if (await _validateAndSave()) {
      setState(() {
        isNextButtonTapped = true;
      });
      if (isNextButtonTapped) {
        setState(() {
          isNextButtonTapped = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpPage2(
                name: _name,
                email: _email,
                institute: _institute ?? '',
              ),
            ),
          );
        });
      }
    }
  }
}
