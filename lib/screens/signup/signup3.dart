import 'dart:io';
import 'package:codephile/models/signup.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/screens/signup/progress_tab_bar.dart';
import 'package:codephile/screens/signup/signup4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage3 extends StatefulWidget {
  final String? name;
  final String? email;
  final String? institute;
  final Handle? handle;

  const SignUpPage3(
      {Key? key, this.name, this.email, this.institute, this.handle})
      : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage3> {
  String? name;
  String? email;
  String? institute;
  Handle? handle;
  File? userImage;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  bool isNextButtonTapped = false;

  @override
  void initState() {
    name = widget.name;
    email = widget.email;
    institute = widget.institute;
    handle = widget.handle;
    super.initState();
    showConnectivityStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //TODO: change background color at root
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                const ProgressTabBar(3),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height / 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: const Text(
                          'Upload a profile photo',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                        child: Text(
                          'This photo will be visible to your followers.',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: secondaryTextGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                _userImageSelect(),
              ],
            ),
            _showNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _userImageSelect() {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width / 2,
          width: MediaQuery.of(context).size.width / 2,
          alignment: (userImage == null)
              ? const Alignment(0.0, 0.0)
              : Alignment.center,
          child: (userImage == null)
              ? SizedBox(
                  height: MediaQuery.of(context).size.width / 3,
                  width: MediaQuery.of(context).size.width / 3,
                  child: SvgPicture.asset(
                    'assets/default_user_icon.svg',
                    fit: BoxFit.fitWidth,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: FileImage(
                          userImage!,
                        ),
                      )),
                ),
          decoration: BoxDecoration(
              color: codephileBackground,
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: userIconBorderGrey)),
        ),
        Positioned(
          right: 0.0,
          bottom: 0.0,
          child: Container(
            child: IconButton(
              icon: Icon(
                (userImage == null) ? Icons.add : Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                _selectImage();
              },
            ),
            decoration: const BoxDecoration(
              color: codephileMain,
              shape: BoxShape.circle,
            ),
          ),
        )
      ],
    );
  }

  Widget _showNextButton() {
    showConnectivityStatus();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor:
                  (userImage == null) ? Colors.white : codephileMain,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Text(
                  (userImage == null) ? 'SKIP' : 'NEXT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: (userImage == null) ? codephileMain : Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            onPressed: () {
              if (!isNextButtonTapped) {
                _validateAndSubmit();
              }
            }),
        decoration: BoxDecoration(
            border: Border.all(
          width: (userImage == null) ? 1.0 : 0,
          color: codephileMain,
        )),
      ),
    );
  }

  bool _validateAndSave() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() {
    setState(() {
      isNextButtonTapped = true;
    });
    if (_validateAndSave()) {
      if (isNextButtonTapped) {
        setState(() {
          isNextButtonTapped = false;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpPage4(
                      name: name,
                      email: email,
                      institute: (institute == null) ? '' : institute,
                      handle: handle,
                      userImagePath:
                          (userImage == null) ? null : userImage!.path)));
        });
      }
    }
  }

  Future<void> _selectImage() async {
    var picture = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (picture != null) {
      var croppedPic = await ImageCropper.cropImage(
        sourcePath: picture.path,
        aspectRatio: const CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.png,
      );
      setState(() {
        userImage = croppedPic;
      });
    } else {
      setState(() {
        userImage = null;
      });
    }
  }
}
