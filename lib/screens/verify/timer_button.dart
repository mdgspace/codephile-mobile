import 'package:codephile/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ButtonState { Idle, Waiting }

class TimerButton extends StatefulWidget {
  final Function callback;

  TimerButton({this.callback});

  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton>
    with SingleTickerProviderStateMixin {
  ButtonState buttonState;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    buttonState = ButtonState.Idle;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 45),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print(buttonState);
        if (buttonState == ButtonState.Idle) {
          await widget.callback();
          setState(() {
            buttonState = ButtonState.Waiting;
            animationController.forward().then((value) {
              animationController.reset();
              setState(() {
                buttonState = ButtonState.Idle;
              });
            });
          });
        } else {
          Fluttertoast.showToast(msg: "Please Wait!");
        }
      },
      child: Container(
        width: double.infinity,
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: codephileMain,
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Builder(builder: (context) {
          if (buttonState == ButtonState.Idle) {
            return Text(
              "Resend Email",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: codephileMain,
                fontSize: 16.0,
              ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Wait",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: codephileMain,
                    fontSize: 16.0,
                  ),
                ),
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        value: animationController.value,
                        strokeWidth: 3.5,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(codephileMain),
                        backgroundColor: codephileMainShade,
                      ),
                    );
                  },
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
