import 'package:codephile/resources/colors.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/services/update_password.dart';
import 'package:flutter/material.dart';

class UpdatePasswordScreen extends StatefulWidget {
  final String _token;
  const UpdatePasswordScreen(this._token, {Key key}) : super(key: key);

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = new GlobalKey<FormState>();
  bool isUpdatePasswordTapped = false;
  bool _obscureTextOld = true,
      _obscureTextNew = true,
      _obscureTextNewConfirm = true,
      enableTextFields = true,
      _lockIconColorOld = false,
      _seePasswordIconColorOld = false,
      _lockIconColorNew = false,
      _seePasswordIconColorNew = false,
      _lockIconColorNewConfirm = false,
      _seePasswordIconColorNewConfirm = false,
      isOldPasswordIncorrect = false;
  TextEditingController _oldPasswordController = TextEditingController(),
      _newPasswordController = TextEditingController(),
      _newPasswordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            "Change Password",
            style: TextStyle(
                fontSize: 20.0,
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
                if (!isUpdatePasswordTapped) {
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 27.0, 16.0, 16.0),
                        child: Text(
                          "Setup a new password for Codephile",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: primaryBlackText,
                          ),
                        ),
                      ),
                      _showPasswordInput("old"),
                      _showPasswordInput("new"),
                      _showPasswordInput("newConfirm"),
                    ],
                  ),
                )),
            _showUpdatePasswordButton(),
          ],
        ),
      ),
      onWillPop: _onBackPressed,
    );
  }

  Widget _showPasswordInput(String inputField) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: Stack(
        children: <Widget>[
          TextFormField(
            onTap: () => onInputFieldTap(inputField),
            onChanged: (value) {
              isOldPasswordIncorrect = false;
            },
            controller: getController(inputField),
            enabled: enableTextFields,
            maxLines: 1,
            obscureText: getObscureTextBool(inputField),
            autofocus: false,
            decoration: new InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: new Icon(
                (inputField == "old") ? Icons.lock_outline : Icons.lock,
                color:
                    getLockIconBool(inputField) ? codephileMain : Colors.grey,
                size: 39,
              ),
              hintText: getHintText(inputField),
              labelStyle: new TextStyle(
                color: Colors.grey,
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Password can\'t be empty';
              } else {
                if (inputField == "newConfirm") {
                  if (_newPasswordController.text !=
                      _newPasswordConfirmController.text) {
                    return "Passwords don't match";
                  } else {
                    return null;
                  }
                } else if ((inputField == "old") && isOldPasswordIncorrect) {
                  return "Password Incorrect";
                } else {
                  return null;
                }
              }
            },
          ),
          Positioned(
            top: 6.0,
            right: 0.0,
            child: IconButton(
              icon: new Icon(
                getObscureTextBool(inputField)
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: getPasswordIconBool(inputField)
                    ? codephileMain
                    : Colors.grey,
              ),
              onPressed: () => _toggle(inputField),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showUpdatePasswordButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              isUpdatePasswordTapped ? Colors.grey[500] : codephileMain,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Text(
              'Update Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: isUpdatePasswordTapped ? Colors.grey[700] : Colors.white,
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
        isUpdatePasswordTapped = true;
        enableTextFields = false;
      });

      int responseCode = await updatePassword(widget._token,
          _oldPasswordController.text, _newPasswordController.text, context);

      print(responseCode);
      if (responseCode == 200) {
        setState(() {
          isUpdatePasswordTapped = false;
          enableTextFields = true;
          isOldPasswordIncorrect = false;
          showToast("Password Changed");
        });
      } else if (responseCode == 403) {
        setState(() {
          isUpdatePasswordTapped = false;
          enableTextFields = true;
          isOldPasswordIncorrect = true;
          _validateAndSave();
        });
      } else {
        setState(() {
          isUpdatePasswordTapped = false;
          enableTextFields = true;
          showToast("Something went wrong");
        });
      }
    }
  }

  Future<bool> _onBackPressed() async {
    if (isUpdatePasswordTapped) {
      return false;
    } else {
      return true;
    }
  }

  getController(String inputField) {
    switch (inputField) {
      case "old":
        return _oldPasswordController;
        break;
      case "new":
        return _newPasswordController;
        break;
      case "newConfirm":
        return _newPasswordConfirmController;
        break;
    }
  }

  getObscureTextBool(String inputField) {
    switch (inputField) {
      case "old":
        return _obscureTextOld;
        break;
      case "new":
        return _obscureTextNew;
        break;
      case "newConfirm":
        return _obscureTextNewConfirm;
        break;
    }
  }

  _toggle(String inputField) {
    switch (inputField) {
      case "old":
        setState(() {
          _obscureTextOld = !_obscureTextOld;
        });
        break;
      case "new":
        setState(() {
          _obscureTextNew = !_obscureTextNew;
        });
        break;
      case "newConfirm":
        setState(() {
          _obscureTextNewConfirm = !_obscureTextNewConfirm;
        });
        break;
    }
  }

  onInputFieldTap(String inputField) {
    switch (inputField) {
      case "old":
        setState(() {
          _lockIconColorOld = true;
          _seePasswordIconColorOld = true;
          if ((_newPasswordController.text == '') ||
              (_oldPasswordController.text == null)) {
            _lockIconColorNew = false;
            _seePasswordIconColorNew = false;
          }
          if ((_newPasswordConfirmController.text == '') ||
              (_oldPasswordController.text == null)) {
            _lockIconColorNewConfirm = false;
            _seePasswordIconColorNewConfirm = false;
          }
        });
        break;
      case "new":
        setState(() {
          _lockIconColorNew = true;
          _seePasswordIconColorNew = true;
          if ((_oldPasswordController.text == '') ||
              (_newPasswordController.text == null)) {
            _lockIconColorOld = false;
            _seePasswordIconColorOld = false;
          }
          if ((_newPasswordConfirmController.text == '') ||
              (_newPasswordController.text == null)) {
            _lockIconColorNewConfirm = false;
            _seePasswordIconColorNewConfirm = false;
          }
        });
        break;
      case "newConfirm":
        setState(() {
          _lockIconColorNewConfirm = true;
          _seePasswordIconColorNewConfirm = true;
          if ((_oldPasswordController.text == '') ||
              (_newPasswordConfirmController.text == null)) {
            _lockIconColorOld = false;
            _seePasswordIconColorOld = false;
          }
          if ((_newPasswordController.text == '') ||
              (_newPasswordConfirmController.text == null)) {
            _lockIconColorNew = false;
            _seePasswordIconColorNew = false;
          }
        });
        break;
    }
  }

  getPasswordIconBool(String inputField) {
    switch (inputField) {
      case "old":
        return _seePasswordIconColorOld;
        break;
      case "new":
        return _seePasswordIconColorNew;
        break;
      case "newConfirm":
        return _seePasswordIconColorNewConfirm;
        break;
    }
  }

  getLockIconBool(String inputField) {
    switch (inputField) {
      case "old":
        return _lockIconColorOld;
        break;
      case "new":
        return _lockIconColorNew;
        break;
      case "newConfirm":
        return _lockIconColorNewConfirm;
        break;
    }
  }

  getHintText(String inputField) {
    switch (inputField) {
      case "old":
        return "Current Password";
        break;
      case "new":
        return "New Password";
        break;
      case "newConfirm":
        return "Re-enter Password";
        break;
    }
  }
}
