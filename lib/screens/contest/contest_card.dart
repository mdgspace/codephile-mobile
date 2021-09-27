import 'package:codephile/resources/colors.dart';
import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/services/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:intl/intl.dart';

class ContestCard extends StatefulWidget {
  final String platform;
  final DateTime endTime;
  final String title;
  final DateTime startTime;
  final String url;
  ContestCard(
      {this.endTime, this.platform, this.startTime, this.title, this.url});
  @override
  _ContestCardState createState() => _ContestCardState();
}

class _ContestCardState extends State<ContestCard>
    with AutomaticKeepAliveClientMixin {
  int remindTime;
  bool notifyMe;
  @override
  void initState() {
    super.initState();
    remindTime = 2;
    notifyMe = false;
    checkNotification();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TextButton(
      onPressed: () {
        FlutterWebBrowser.openWebPage(
          url: widget.url,
          customTabsOptions: CustomTabsOptions(toolbarColor: codephileMain),
        );
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
      ),
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Container(
                height: 28,
                width: 28,
                child: Image.asset(getPlatformIconAssetPath(widget.platform)))),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(context),
              _buildTitle(),
              _buildFooter()
            ],
          ),
        ),
      ]),
    );
  }

  Row _buildFooter() {
    return Row(children: <Widget>[
      SvgPicture.asset("assets/clock.svg", height: 18, width: 18),
      Text(getTime(),
          style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF979797),
              fontWeight: FontWeight.normal)),
    ]);
  }

  Padding _buildTitle() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Text(
        '${widget.title.trim()}',
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '${getPlatformName(widget.platform)} hosted a contest',
          style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF979797),
              fontWeight: FontWeight.normal),
        ),
        SizedBox(
            height: 20,
            width: 20,
            child: IconButton(
                icon: SvgPicture.asset(
                  (notifyMe) ? "assets/selected_bell.svg" : "assets/bell.svg",
                  height: 20,
                ),
                padding: EdgeInsets.all(0),
                onPressed: () {
                  showAlertDialog(context);
                }))
      ],
    );
  }

  void showAlertDialog(BuildContext context) {
    if (widget.startTime == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                titlePadding: EdgeInsets.all(0),
                title: Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  decoration: BoxDecoration(
                      color: Color(0xFFF3F4F7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Text(
                    "Cannot Set Reminder",
                    textAlign: TextAlign.center,
                  ),
                ),
                contentPadding: EdgeInsets.all(0),
                content: Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                  child: Text(
                    "The selected contest has already started. 😔 ",
                    textAlign: TextAlign.center,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(15),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                        color: codephileMain,
                        child:
                            Text("Okay", style: TextStyle(color: Colors.white)),
                      ))
                ],
                actionsPadding: EdgeInsets.all(0),
              ));
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  titlePadding: EdgeInsets.all(0),
                  title: Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    decoration: BoxDecoration(
                        color: Color(0xFFF3F4F7),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Text(
                      "Set Reminder",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(0),
                  content: SizedBox(
                    height: 220,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                          child: Text(
                            "You will be reminded before the contest starts. Set the timer",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                            height: 80,
                            width: 200,
                            child: _buildListWheelScrollView(setState)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () async {
                                  await removeNotification(name: widget.title);
                                  Navigator.pop(context, false);
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  color: Color(0xFFE5E5E5),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Color(0xFF979797)),
                                  ),
                                )),
                            TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                ),
                                onPressed: () async {
                                  Duration duration;
                                  switch (remindTime) {
                                    case 0:
                                      duration = Duration(minutes: 5);
                                      break;
                                    case 1:
                                      duration = Duration(minutes: 10);
                                      break;
                                    case 2:
                                      duration = Duration(minutes: 15);
                                      break;
                                    case 3:
                                      duration = Duration(minutes: 20);
                                      break;
                                    case 4:
                                      duration = Duration(minutes: 25);
                                      break;
                                    case 5:
                                      duration = Duration(minutes: 30);
                                      break;
                                    default:
                                      duration = Duration(minutes: 30);
                                  }

                                  await setNotification(
                                      name: widget.title,
                                      platform:
                                          getPlatformName(widget.platform),
                                      startTime: widget.startTime,
                                      offset: duration);
                                  Navigator.pop(context, true);
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  color: codephileMain,
                                  child: Text("Okay",
                                      style: TextStyle(color: Colors.white)),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                );
              })).then((value) {
        setState(() {
          notifyMe = value;
        });
      });
    }
  }

  ListWheelScrollView _buildListWheelScrollView(StateSetter setState) {
    return ListWheelScrollView(
      controller: FixedExtentScrollController(initialItem: 2),
      itemExtent: 25,
      useMagnifier: true,
      magnification: 1.3,
      onSelectedItemChanged: (val) {
        setState(() {
          remindTime = val;
        });
      },
      physics: FixedExtentScrollPhysics(),
      children: [
        Text(
          "5",
          style: TextStyle(
              color: (remindTime == 0) ? codephileMain : Colors.black),
        ),
        Text(
          "10",
          style: TextStyle(
              color: (remindTime == 1) ? codephileMain : Colors.black),
        ),
        Text(
          "15",
          style: TextStyle(
              color: (remindTime == 2) ? codephileMain : Colors.black),
        ),
        Text(
          "20",
          style: TextStyle(
              color: (remindTime == 3) ? codephileMain : Colors.black),
        ),
        Text(
          "25",
          style: TextStyle(
              color: (remindTime == 4) ? codephileMain : Colors.black),
        ),
        Text(
          "30",
          style: TextStyle(
              color: (remindTime == 5) ? codephileMain : Colors.black),
        )
      ],
    );
  }

  String getTime() {
    if (widget.startTime == null) {
      return " Ends on ${DateFormat("dd, MMMM yyyy hh:mm a").format(widget.endTime)}";
    } else {
      return " Starts on ${DateFormat("dd, MMMM yyyy hh:mm a").format(widget.startTime)}";
    }
  }

  bool checkNotification() {
    getNotificationList().then((value) {
      setState(() {
        notifyMe = value.indexOf(widget.title) != -1;
      });
    });
    return true;
  }

  @override
  bool get wantKeepAlive => true;
}
