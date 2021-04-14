import 'package:codephile/models/token.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/verify/timer_button.dart';
import 'package:codephile/services/login.dart';
import 'package:codephile/services/send_verify_email.dart';
import 'package:codephile/services/upload_user_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codephile/homescreen.dart';

class VerifyScreen extends StatefulWidget {
  final String username;
  final String password;
  final String id;

  VerifyScreen({this.password, this.username, this.id});

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Hi,",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "You are almost done with the sign up process. Please check your email to verify this account.",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TimerButton(
                      borderRadius: 2,
                      height: 51,
                      width: MediaQuery.of(context).size.width * 0.45,
                      minWidth: MediaQuery.of(context).size.width * 0.30,
                      color: codephileMain,
                      child: Text(
                        "Resend Email",
                        style: TextStyle(
                          color: codephileMain,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      loader: (timeLeft) {
                        return Text(
                          "Wait | $timeLeft",
                          style: TextStyle(
                            color: codephileMain,
                            fontSize: 16,
                          ),
                        );
                      },
                      onTap: (startTimer, btnState) async {
                        if (btnState == ButtonState.Idle) {
                          startTimer(3);
                        }
                        final response = await sendVerifyEmail(widget.id);
                        if (response != 1) {
                          Fluttertoast.showToast(
                            msg:
                                "Something went wrong, can not send new verification email.",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                          );
                        }
                      },
                    ),
                    // child: FlatButton(
                    //   color: Colors.white,
                    //   onPressed: () async {
                    //     final response = await sendVerifyEmail(widget.id);
                    //     if (response != 1) {
                    //       Fluttertoast.showToast(
                    //         msg:
                    //             "Something went wrong, can not send new verification email.",
                    //         toastLength: Toast.LENGTH_LONG,
                    //         gravity: ToastGravity.CENTER,
                    //       );
                    //     }
                    //   },
                    //   child: Container(
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: codephileMain, width: 1.5),
                    //     ),
                    //     padding: EdgeInsets.all(16.0),
                    //     child: Text(
                    //       "Resend Email",
                    //       textAlign: TextAlign.center,
                    //       style:
                    //           TextStyle(color: codephileMain, fontSize: 16.0),
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      color: codephileMain,
                      onPressed: () async {
                        Token userToken =
                            await login(widget.username, widget.password);
                        if (userToken.token == "unverified") {
                          Fluttertoast.showToast(
                            msg: "Email still unverified!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            fontSize: 12.0,
                          );
                        } else {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          if (pref.containsKey("userImagePath")) {
                            await uploadImage(
                              userToken.token,
                              pref.getString("userImagePath"),
                              context,
                            );
                            pref.remove("userImagePath");
                          }
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage(
                                  token: userToken.token,
                                  userId: widget.id,
                                );
                              },
                            ),
                          );
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 1,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
