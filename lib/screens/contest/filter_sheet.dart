import 'package:codephile/models/filters.dart';
import 'package:codephile/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class FilterSheet extends StatefulWidget {
  final ContestFilter filter;
  FilterSheet({this.filter});
  @override
  _FilterSheetState createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  ContestFilter _filter;
  int _duration;
  @override
  void initState() {
    super.initState();
    _filter = widget.filter;
    _duration = widget.filter.duration;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: Colors.white,
          height: 510,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Color(0xFFF3F4F7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Filters",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w400),
                        ),
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context, _filter);
                          },
                          child: Text(
                            "Apply",
                            style: TextStyle(color: codephileMain),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 25, 0, 25),
                  child: Text(
                    "Platforms",
                    style: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 25),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
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
                              child: Image.asset(
                                'assets/platformIcons/codeChefIcon.png',
                                height: 70,
                                width: 70,
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 25),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
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
                              child: Image.asset(
                                'assets/platformIcons/codeForcesIcon.png',
                                height: 70,
                                width: 70,
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 25),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
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
                              child: Image.asset(
                                'assets/platformIcons/hackerEarthIcon.png',
                                height: 70,
                                width: 70,
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 25),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
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
                              child: Image.asset(
                                'assets/platformIcons/hackerRankIcon.png',
                                height: 70,
                                width: 70,
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 25),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
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
                              child: Image.asset(
                                'assets/platformIcons/otherIcon.jpg',
                                height: 70,
                                width: 70,
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'Max. Duration',
                            style: TextStyle(
                              color: Color(0xFF979797),
                              fontSize: 18.0,
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
                ),
                Slider(
                  activeColor: codephileMain,
                  inactiveColor: codephileMainShade,
                  min: 0.0,
                  max: 6.0,
                  divisions: 6,
                  value: _duration.toDouble(),
                  label: getLabelForValue(_duration.toInt()),
                  onChanged: (_value) {
                    setState(() {
                      _duration = _value.toInt();
                    });
                  },
                  onChangeEnd: (_value) {
                    setState(() {
                      _filter.duration = _value.toInt();
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 15, 0, 15),
                  child: Text(
                    "Start Date",
                    style: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 18.0,
                    ),
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
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 15, 10),
                          child: SvgPicture.asset(
                            _filter.ongoing
                                ? "assets/true_audio_button.svg"
                                : "assets/false_audio_button.svg",
                            height: 28,
                            width: 28,
                          ),
                        )),
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
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 15, 10),
                          child: SvgPicture.asset(
                            _filter.upcoming
                                ? "assets/true_audio_button.svg"
                                : "assets/false_audio_button.svg",
                            height: 28,
                            width: 28,
                          ),
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
                                  builder: (BuildContext context, Widget child){
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light().copyWith(primary: codephileMain)
                                      ),
                                      child: child,
                                    );
                                  },
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2025),
                          )
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
              ])),
    );
  }
}
