import 'package:codephile/resources/colors.dart';
import 'package:flutter/material.dart';

class Bar extends StatelessWidget{
  final bool shade;
  const Bar(this.shade);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return  Container(
        margin: EdgeInsets.only(top: 45),
        height: 10.0,
        width: width/3.5,
        child: Material(
          borderRadius: BorderRadius.circular(2.0),
          color: shade ? codephileMain : codephileMainShade ,
          elevation: 0.0,
        )
    );
  }
}
