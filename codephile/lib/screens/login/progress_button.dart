import 'dart:math';

import 'package:codephile/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressButton extends StatefulWidget {
  final Function onPressed;
  final Function positiveCallback;
  final Function negativeCallback;
  ProgressButton(
      {@required this.onPressed,@required this.negativeCallback,@required this.positiveCallback});
  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  double _fraction = 0.0;
  int state = 0;
  @override
  Widget build(BuildContext context) {
    
    return CustomPaint(
      painter: SplashPainter(
          fraction: _fraction, screenSize: MediaQuery.of(context).size),
      child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: 50.0,
          width: state == 0 ? 200.0 : 50.0,
          decoration: BoxDecoration(
              color: (state == 0 || state == 1)
                  ? codephileMain
                  : (state == 2) ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(25.0)),
          child: SizedBox.expand(
            child: FlatButton(
              padding: EdgeInsets.all(0.0),
              onPressed: () async {
                setState(() {
                  state = 1;
                });
                bool res = await widget.onPressed();
                if (res) {
                  setState(() {
                    state = 2;
                  });
                  _controller = AnimationController(
                      duration: const Duration(milliseconds: 500), vsync: this);
                  _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
                    ..addListener(() {
                      setState(() {
                        _fraction = _animation.value;
                      });
                    })
                    ..addStatusListener((AnimationStatus state) {
                      if (state == AnimationStatus.completed) {
                        widget.positiveCallback();
                      }
                    });
                    await Future.delayed(Duration(milliseconds: 500));
                  _controller.forward();
                } else {
                  setState(() {
                    state = 3;
                  });
                  await widget.negativeCallback();
                  await Future.delayed(Duration(seconds: 1));
                  setState(() {
                    state = 0;
                  });
                }
                print("Pressed");
              },
              child: showChild(state: state),
              highlightColor: Colors.white12,
              splashColor: Colors.white54,
            ),
          )),
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  deactivate() {
    _fraction = 0.0;
    super.deactivate();
  }

  Widget showChild({int state}) {
    switch (state) {
      case 0:
        return Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        );
        break;
      case 1:
        return Padding(
            padding: EdgeInsets.all(5.0),
            child: SpinKitRing(
              color: Colors.white,
              lineWidth: 4.0,
            ));
        break;
      case 2:
        return Icon(
          Icons.check,
          color: Colors.white,
          size: 36.0,
        );
        break;
      case 3:
        return Icon(Icons.close, color: Colors.white, size: 36.0);
        break;
      default:
        return Icon(
          Icons.blur_on,
          color: Colors.white,
          size: 36.0,
        );
    }
  }
}

class SplashPainter extends CustomPainter {
  double fraction = 0.0;
  Size screenSize;
  SplashPainter({this.fraction, this.screenSize});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color.fromRGBO(0, 255, 0, 1)
      ..style = PaintingStyle.fill;
    var finalRadius = sqrt(
        pow(screenSize.width / 2, 2) + pow(screenSize.height - 32.0 - 48.0, 2));
    var radius = 25.0 + finalRadius * fraction;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

  @override
  bool shouldRepaint(SplashPainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}
