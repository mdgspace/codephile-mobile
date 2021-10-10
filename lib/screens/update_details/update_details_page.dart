import 'dart:io';
import 'package:codephile/models/user.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/screens/update_details/update_password_screen.dart';
import 'package:codephile/services/handle.dart';
import 'package:codephile/services/institute_list.dart';
import 'package:codephile/services/update_user_details.dart';
import 'package:codephile/services/upload_user_image.dart';
import 'package:codephile/services/username.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:searchable_dropdown/searchable_dropdown.dart';

class UpdateDetails extends StatefulWidget {
  final String _token;
  final CodephileUser _user;
  final Function _callbackRefresh;
  const UpdateDetails(this._token, this._user, this._callbackRefresh, {Key key})
      : super(key: key);

  @override
  _UpdateDetailsState createState() => _UpdateDetailsState();
}

class _UpdateDetailsState extends State<UpdateDetails> {
  bool isLoading = true;
  bool enableTextFields = true;
  File userImageNew;
  List<String> _instituteList = [];
  String _name = "",
      _username = "",
      _institute = "",
      _codechefHandle = "",
      _codeforcesHandle = "",
      _spojHandle = "",
      _hackerrankHandle = "";
  bool _isNameChanged = false,
      _isUsernameChanged = false,
      _isInstituteChanged = false,
      _isCodechefHandleChanged = false,
      _isCodeforcesHandleChanged = false,
      _isHackerrankHandleChanged = false,
      _isSpojHandleChanged = false;
  final _formKey = new GlobalKey<FormState>();
  bool isSaveChangesTapped = false;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    getInstituteList().then((instituteList) {
      setState(() {
        if (instituteList.length != 0) {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            "Update Details",
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                color: primaryBlackText),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.clear,
                color: primaryBlackText,
                size: MediaQuery.of(context).size.width / 15,
              ),
              onPressed: () {
                if (!isSaveChangesTapped) {
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
        body: (isLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    _userImageSelect(),
                    _showNameInput(),
                    _showUsernameInput(),
                    _showInstituteInput(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 16.0),
                          child: GestureDetector(
                            child: Text(
                              "Change Password",
                              style: TextStyle(
                                color: codephileMain,
                                fontSize: 17.0,
                              ),
                            ),
                            onTap: () {
                              if (!isSaveChangesTapped) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            new UpdatePasswordScreen(
                                                widget._token)));
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 18.0),
                          child: Text(
                            "Update Handles",
                            style: TextStyle(
                              color: primaryBlackText,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    _showHandleInput("CodeChef"),
                    _showHandleInput("Codeforces"),
                    _showHandleInput("HackerRank"),
                    _showHandleInput("Spoj"),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 10,
                    ),
                    _showSaveChangesButton()
                  ],
                ),
              ),
      ),
      onWillPop: _onBackPressed,
    );
  }

  Widget _userImageSelect() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 28),
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              alignment:
                  ((userImageNew == null) && (widget._user.picture == ""))
                      ? Alignment(0.0, 0.0)
                      : Alignment.center,
              child: ((userImageNew == null) && (widget._user.picture == ""))
                  ? SizedBox(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      child: SvgPicture.asset(
                        'assets/default_user_icon.svg',
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  : (userImageNew == null)
                      ? Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(
                                  widget._user.picture,
                                ),
                              )),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: FileImage(
                                  userImageNew,
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
                    ((userImageNew == null) && (widget._user.picture == ""))
                        ? Icons.add
                        : Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _selectImage();
                  },
                ),
                decoration: BoxDecoration(
                  color: codephileMain,
                  shape: BoxShape.circle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _showNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 14.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        enabled: enableTextFields,
        initialValue:
            (widget._user.fullname == "") ? null : widget._user.fullname,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter Name",
          labelStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
        ),
        onChanged: (value) {
          _isNameChanged = true;
        },
        validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
        onSaved: (value) => _name = value,
      ),
    );
  }

  Widget _showUsernameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 14.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        enabled: enableTextFields,
        initialValue:
            (widget._user.fullname == "") ? null : widget._user.username,
        decoration: InputDecoration(
          hintText: "Enter Username",
          border: OutlineInputBorder(),
          labelStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
        ),
        onChanged: (value) {
          _isUsernameChanged = true;
        },
        validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
        onSaved: (value) => _username = value,
      ),
    );
  }

  Widget _showInstituteInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 14.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: DropdownSearch<String>(
          selectedItem: widget._user.institute,
          enabled: enableTextFields,
          items: _instituteList,
          onChanged: (String institute) {
            setState(() {
              _institute = institute;
            });
          },
          dropdownSearchDecoration: InputDecoration(
            hintText: 'Select Institute',
            contentPadding: const EdgeInsets.all(8.0),
          ),
        ),
      ),
    );
  }

  Widget _showHandleInput(String platform) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(
              color: userIconBorderGrey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(2.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: codephileBackground,
                  border: Border(
                      right:
                          BorderSide(color: userIconBorderGrey, width: 1.0))),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.width / 13,
                      width: MediaQuery.of(context).size.width / 13,
                      child: Image.asset(getPlatformIconAssetPath(platform)),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(platform),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: TextFormField(
                  initialValue: getInitialHandle(platform),
                  enabled: enableTextFields,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: "$platform handle",
                    labelStyle:
                        TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                  ),
                  onChanged: (value) => setIsChangedTrue(platform),
                  onSaved: (value) => setHandleValue(platform, value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showSaveChangesButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              isSaveChangesTapped ? Colors.grey[500] : codephileMain,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Text(
              'Save Changes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: isSaveChangesTapped ? Colors.grey[700] : Colors.white,
              ),
            ),
          ),
        ),
        onPressed: _validateAndSubmit,
      ),
    );
  }

  Future<void> _selectImage() async {
    var picture = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (picture != null) {
      var croppedPic = await ImageCropper.cropImage(
        sourcePath: picture.path,
        aspectRatio: CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.png,
      );
      setState(() {
        userImageNew = croppedPic;
      });
    } else {
      setState(() {
        userImageNew = null;
      });
    }
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
        enableTextFields = false;
        isSaveChangesTapped = true;
      });

      bool isUsernameValid = await validateUsername();
      if (isUsernameValid == false) showToast("Username already taken!");
      bool allHandlesValid = await validateHandles();

      if (isUsernameValid != null) {
        if ((allHandlesValid == true) && (isUsernameValid == true)) {
          var requestBody = {
            "username": _isUsernameChanged ? _username : widget._user.username,
            "fullname": _isNameChanged ? _name : widget._user.fullname,
            "institute":
                _isInstituteChanged ? _institute : widget._user.institute,
            "handle.codechef": _isCodechefHandleChanged
                ? _codechefHandle
                : widget._user.handle.codechef,
            "handle.codeforces": _isCodeforcesHandleChanged
                ? _codeforcesHandle
                : widget._user.handle.codeforces,
            "handle.hackerrank": _isHackerrankHandleChanged
                ? _hackerrankHandle
                : widget._user.handle.hackerrank,
            "handle.spoj":
                _isSpojHandleChanged ? _spojHandle : widget._user.handle.spoj,
          };

          int responseStatus =
              await updateUserDetails(widget._token, requestBody, context);
          if (responseStatus == 202) {
            if (userImageNew != null) {
              int responseStatusImageUpload =
                  await uploadImage(widget._token, userImageNew.path, context);
              if (responseStatusImageUpload == 201) {
                setState(() {
                  enableTextFields = true;
                  isSaveChangesTapped = false;
                  Navigator.of(context).pop();
                  widget._callbackRefresh();
                });
              } else {
                showToast("Couldn't upload photo");
                setState(() {
                  isSaveChangesTapped = false;
                  enableTextFields = true;
                });
              }
            } else {
              setState(() {
                enableTextFields = true;
                isSaveChangesTapped = false;
                Navigator.of(context).pop();
                widget._callbackRefresh();
              });
            }
          } else {
            showToast("Something went wrong");
            setState(() {
              isSaveChangesTapped = false;
              enableTextFields = true;
            });
          }
        } else {
          setState(() {
            isSaveChangesTapped = false;
            enableTextFields = true;
          });
        }
      } else {
        showToast("Something went wrong");
        setState(() {
          isSaveChangesTapped = false;
          enableTextFields = true;
        });
      }
    }
  }

  setHandleValue(String platform, String value) {
    platform = platform.toLowerCase();
    switch (platform) {
      case "codechef":
        _codechefHandle = value;
        break;
      case "codeforces":
        _codeforcesHandle = value;
        break;
      case "hackerrank":
        _hackerrankHandle = value;
        break;
      case "spoj":
        _spojHandle = value;
        break;
    }
    return null;
  }

  getInitialHandle(String platform) {
    platform = platform.toLowerCase();
    if (widget._user.handle == null) return null;
    switch (platform) {
      case "codechef":
        return widget._user.handle.codechef;
        break;
      case "codeforces":
        return widget._user.handle.codeforces;
        break;
      case "hackerrank":
        return widget._user.handle.hackerrank;
        break;
      case "spoj":
        return widget._user.handle.spoj;
        break;
    }
    return null;
  }

  setIsChangedTrue(String platform) {
    platform = platform.toLowerCase();
    switch (platform) {
      case "codechef":
        setState(() {
          _isCodechefHandleChanged = true;
        });
        break;
      case "codeforces":
        setState(() {
          _isCodeforcesHandleChanged = true;
        });
        break;
      case "hackerrank":
        setState(() {
          _isHackerrankHandleChanged = true;
        });
        break;
      case "spoj":
        setState(() {
          _isSpojHandleChanged = true;
        });
        break;
    }
    return null;
  }

  Future<bool> validateHandles() async {
    bool allHandlesValid = true;
    if ((_codechefHandle != '') && (_codechefHandle != null)) {
      bool isValid = await verifyHandle("codechef", _codechefHandle);
      if (isValid != true) {
        allHandlesValid = false;
        showToast("Invalid CodeChef handle");
      }
    } else {
      _codechefHandle = '';
    }

    if ((_codeforcesHandle != '') && (_codeforcesHandle != null)) {
      bool isValid = await verifyHandle("codeforces", _codeforcesHandle);
      if (isValid != true) {
        allHandlesValid = false;
        showToast("Invalid Codeforces handle");
      }
    } else {
      _codeforcesHandle = '';
    }

    if ((_hackerrankHandle != '') && (_hackerrankHandle != null)) {
      bool isValid = await verifyHandle("hackerrank", _hackerrankHandle);
      if (isValid != true) {
        allHandlesValid = false;
        showToast("Invalid HackerRank handle");
      }
    } else {
      _hackerrankHandle = '';
    }

    if ((_spojHandle != '') && (_spojHandle != null)) {
      bool isValid = await verifyHandle("spoj", _spojHandle);
      if (isValid != true) {
        allHandlesValid = false;
        showToast("Invalid Spoj Handle");
      }
    } else {
      _spojHandle = '';
    }

    return allHandlesValid;
  }

  Future<bool> validateUsername() async {
    bool isUsernameValid = true;
    if ((_isUsernameChanged) && (_username != widget._user.username)) {
      isUsernameValid = await isUsernameAvailable(_username);
    }
    return isUsernameValid;
  }

  Future<bool> _onBackPressed() async {
    if (isSaveChangesTapped) {
      return false;
    } else {
      return true;
    }
  }
}
