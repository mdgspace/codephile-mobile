import 'package:codephile/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:codephile/screens/on_boarding/page_indicator.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => new _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> with TickerProviderStateMixin {
  PageController _controller;
  int currentPage = 0;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
    );
    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PageView.builder(
            itemCount: pageList.length,
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
                if (currentPage == pageList.length - 1) {
                  animationController.forward();
                } else {
                  animationController.reset();
                }
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  var page = pageList[index];
                  var delta;
                  var y = 1.0;

                  if (_controller.position.haveDimensions) {
                    delta = _controller.page - index;
                    y = 1 - delta.abs().clamp(0.0, 1.0);
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 226.0,
                        width: 226.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromRGBO(196, 196, 196, 0.5),
                        ),
                      ), //TODO: Add Image.asset(page.imageUrl),
                      Container(
                        height: 40.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(69.0, 0.0, 71.0, 0.0),
                        child: Container(
                          width: 272,
                          child: Text(page.title,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center),
                        ),
                      ),
                      Container(
                        width: 272,
                        child: Text(
                          page.body,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Positioned(
            left: 180.0,
            bottom: 315.0,
            child: Container(
                width: 160.0,
                child: PageIndicator(currentPage, pageList.length)),
          ),
          Positioned(
              left: 50.0,
              bottom: 73.0,
              child: Container(
                width: 312,
                child: RaisedButton(
                    color: const Color.fromRGBO(197, 197, 197, 0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onPressed: () {
//                      Navigator.pop(context);
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) => MyHomePage()));
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginScreen()));
                    }, //TODO: implement onPressed

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              )),
        ],
      ),
    );
  }
}
