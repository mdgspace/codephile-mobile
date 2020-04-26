import 'dart:convert';

import 'package:codephile/models/filters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:codephile/resources/colors.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterButton extends StatefulWidget {
  final ContestFilter filter;
  final Function applyFilter;
  FilterButton({this.filter, this.applyFilter});
  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  var sheetController;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(
          Icons.filter_list,
          size: 30.0,
        ),
        backgroundColor: codephileMain,
        onPressed: () {
          showCupertinoModalPopup(
              context: context,
              builder: (context) =>
                  FilterSheetWidget(filter: widget.filter)).then((_) {
            SharedPreferences.getInstance().then((pref) {
              pref.setString('filter', jsonEncode(widget.filter.toJson()));
            });
            widget.applyFilter();
          });
        });
  }
}

class FilterSheetWidget extends StatefulWidget {
  final ContestFilter filter;
  FilterSheetWidget({this.filter});
  @override
  _FilterSheetWidgetState createState() => _FilterSheetWidgetState();
}

class _FilterSheetWidgetState extends State<FilterSheetWidget> {
  ContestFilter _filter;
  int value;
  @override
  void initState() {
    _filter = widget.filter;
    value = _filter.duration;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          height: 400,
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 5.0),
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            "Platform ",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: codephileMainShade),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              (_filter.platform[0] &&
                                      _filter.platform[1] &&
                                      _filter.platform[2] &&
                                      _filter.platform[3] &&
                                      _filter.platform[4])
                                  ? "All"
                                  : "Selected",
                              style: TextStyle(
                                  color: codephileMain, fontSize: 14.0),
                            ),
                          ),
                        )
                      ]),
                  SizedBox(
                    height: 4.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _filter.platform[0] = !_filter.platform[0];
                            });
                          },
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 500),
                            opacity: _filter.platform[0] ? 1.0 : 0.2,
                            child: Card(
                              borderOnForeground: true,
                              elevation: _filter.platform[0] ? 10.0 : 1.0,
                              margin: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 24.0),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image.asset(
                                  'assets/platformIcons/codeChefIcon.png',
                                  height: 75,
                                  width: 65,
                                ),
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _filter.platform[1] = !_filter.platform[1];
                            });
                          },
                          child: AnimatedOpacity(
                              duration: Duration(milliseconds: 500),
                              opacity: _filter.platform[1] ? 1.0 : 0.2,
                              child: Card(
                                borderOnForeground: true,
                                elevation: _filter.platform[1] ? 10.0 : 1.0,
                                margin:
                                    EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 24.0),
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    'assets/platformIcons/codeForcesIcon.png',
                                    height: 75,
                                    width: 65,
                                  ),
                                ),
                                color: Colors.white,
                              )),
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                _filter.platform[2] = !_filter.platform[2];
                              });
                            },
                            child: AnimatedOpacity(
                                duration: Duration(milliseconds: 500),
                                opacity: _filter.platform[2] ? 1.0 : 0.2,
                                child: Card(
                                  borderOnForeground: true,
                                  elevation: _filter.platform[2] ? 10.0 : 1.0,
                                  margin:
                                      EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 24.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      'assets/platformIcons/hackerEarthIcon.png',
                                      height: 75,
                                      width: 65,
                                    ),
                                  ),
                                  color: Colors.white,
                                ))),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                _filter.platform[3] = !_filter.platform[3];
                              });
                            },
                            child: AnimatedOpacity(
                                duration: Duration(milliseconds: 500),
                                opacity: _filter.platform[3] ? 1.0 : 0.2,
                                child: Card(
                                  borderOnForeground: true,
                                  elevation: _filter.platform[3] ? 10.0 : 1.0,
                                  margin:
                                      EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 24.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      'assets/platformIcons/hackerRankIcon.png',
                                      height: 75,
                                      width: 65,
                                    ),
                                  ),
                                  color: Colors.white,
                                ))),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                _filter.platform[4] = !_filter.platform[4];
                              });
                            },
                            child: AnimatedOpacity(
                                duration: Duration(milliseconds: 500),
                                opacity: _filter.platform[4] ? 1.0 : 0.2,
                                child: Card(
                                  borderOnForeground: true,
                                  elevation: _filter.platform[4] ? 10.0 : 1.0,
                                  margin:
                                      EdgeInsets.fromLTRB(5.0, 5.0, 15.0, 24.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      'assets/platformIcons/otherIcon.jpg',
                                      height: 75,
                                      width: 65,
                                    ),
                                  ),
                                  color: Colors.white,
                                ))),
                      ],
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'Max. Duration',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: codephileMainShade,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Text(
                            getLabelForValue(_filter.duration),
                            style:
                                TextStyle(fontSize: 14.0, color: codephileMain),
                          ),
                        )
                      ]),
                  SizedBox(height: 15.0),
                  Slider(
                    activeColor: codephileMain,
                    inactiveColor: codephileMainShade,
                    min: 0.0,
                    max: 6.0,
                    divisions: 6,
                    value: value.toDouble(),
                    label: getLabelForValue(value.toInt()),
                    onChanged: (_value) {
                      setState(() {
                        value = _value.toInt();
                      });
                    },
                    onChangeEnd: (_value) {
                      setState(() {
                        _filter.duration = _value.toInt();
                      });
                    },
                  )
                ],
              ),
            ),
            Container(
              height: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      "Start Date",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _filter.ongoing = !_filter.ongoing;
                          });
                        },
                        child: Container(
                          height: 24.0,
                          width: 24.0,
                          margin: EdgeInsets.all(15.0),
                          child: _filter.ongoing
                              ? Icon(
                                  Icons.check,
                                  size: 20.0,
                                  color: Colors.white,
                                )
                              : null,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: codephileMain, width: 2.0),
                              color: _filter.ongoing
                                  ? codephileMain
                                  : codephileMainShade,
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _filter.ongoing = !_filter.ongoing;
                            });
                          },
                          child: Text(
                            "Ongoing",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _filter.upcoming = !_filter.upcoming;
                              _filter.startDate =
                                  _filter.upcoming ? DateTime.now() : null;
                            });
                          },
                          child: Container(
                            height: 24.0,
                            width: 24.0,
                            margin: EdgeInsets.all(15.0),
                            child: _filter.upcoming
                                ? Icon(
                                    Icons.check,
                                    size: 20.0,
                                    color: Colors.white,
                                  )
                                : null,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: codephileMain, width: 2.0),
                                color: _filter.upcoming
                                    ? codephileMain
                                    : codephileMainShade,
                                borderRadius: BorderRadius.circular(20.0)),
                          )),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _filter.upcoming = !_filter.upcoming;
                              _filter.startDate =
                                  _filter.upcoming ? DateTime.now() : null;
                            });
                          },
                          child: Text(
                            "Upcoming",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          )),
                      FlatButton(
                          onPressed: () async {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2025))
                                .then((val) {
                              if (val == null) {
                                _filter.upcoming = true;
                                _filter.startDate = DateTime.now();
                              } else {
                                setState(() {
                                  _filter.upcoming = true;
                                  _filter.startDate = val;
                                });
                              }
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 15.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color: codephileMainShade,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Text(
                                (_filter.startDate != null)
                                    ? DateFormat("d MMMM, yyyy")
                                        .format(_filter.startDate)
                                    : "Select Date",
                                style: TextStyle(color: codephileMain),
                              )))
                    ],
                  )
                ],
              ),
            )
          ])),
    );
  }
}
