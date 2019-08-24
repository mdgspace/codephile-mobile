import 'package:codephile/screens/contests/contest_card.dart';
import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  Timeline({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body:
        ListView.builder(
          itemBuilder: (context, position){
            return ContestCard();
          },
          itemCount: 3,
        )
    );
  }
}
