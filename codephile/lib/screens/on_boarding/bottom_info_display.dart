import 'package:codephile/resources/colors.dart';
import 'package:flutter/material.dart';

class BottomInfoDisplay extends StatelessWidget {
  final String heading;
  final String description;

  const BottomInfoDisplay(this.heading, this.description, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: codephileMain,
      height: MediaQuery.of(context).size.height * 0.32,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
            child: Text(
              heading,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 40.0, 16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                description,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
