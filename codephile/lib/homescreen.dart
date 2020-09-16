import 'package:codephile/battery_optimization_dialog.dart';
import 'package:codephile/screens/feed/feed_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:codephile/screens/contest/contest_screen.dart';
import 'package:codephile/screens/profile/profile_screen.dart';
import 'package:codephile/screens/search/search_page.dart';
import 'package:codephile/resources/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:battery_optimization/battery_optimization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String token;
  final String userId;
  const HomePage({Key key, this.token, this.userId}) : super(key: key);

  @override
  HomePageState createState() =>
      new HomePageState(token: token, userId: userId);
}

class HomePageState extends State<HomePage> {
  final String token;
  final String userId;
  int _selectedIndex;
  PageController _pageController;
  bool _showBatteryOptimizationDialog;

  HomePageState({Key key, this.token, this.userId});
  @override
  void initState() {
    super.initState();
    _selectedIndex = 1;
    _pageController = new PageController(initialPage: 1);
    showBatteryOptimisationAlert();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            MaterialApp(home: FeedScreen(token: token)),
            MaterialApp(home: ContestScreen(token: token)),
            MaterialApp(home: SearchPage(token, userId)),
            MaterialApp(home: Profile(token, userId, true, false)),
          ]),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              blurRadius: 16,
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, -4))
        ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            NavbarButton(
              asset: "assets/navbar/feed.svg",
              title: "Feed",
              callback: () {
                setState(() {
                  _selectedIndex = 0;
                  _pageController.jumpToPage(0);
                });
              },
              selected: (_selectedIndex == 0),
            ),
            NavbarButton(
              asset: "assets/navbar/contest.svg",
              title: "Contest",
              callback: () {
                setState(() {
                  _selectedIndex = 1;
                  _pageController.jumpToPage(1);
                });
              },
              selected: (_selectedIndex == 1),
            ),
            NavbarButton(
              asset: "assets/navbar/search.svg",
              title: "Search",
              callback: () {
                setState(() {
                  _selectedIndex = 2;
                  _pageController.jumpToPage(2);
                });
              },
              selected: (_selectedIndex == 2),
            ),
            NavbarButton(
              asset: "assets/navbar/profile.svg",
              title: "Profile",
              callback: () {
                setState(() {
                  _selectedIndex = 3;
                  _pageController.jumpToPage(3);
                });
              },
              selected: (_selectedIndex == 3),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showBatteryOptimisationAlert() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _showBatteryOptimizationDialog =
        prefs.getBool("showBatteryOptimisationDialog");
    if (_showBatteryOptimizationDialog == null)
      _showBatteryOptimizationDialog = true;
    BatteryOptimization.isIgnoringBatteryOptimizations().then((isNotOptimized) {
      if (isNotOptimized) {
        //do nothing
      } else {
        if (_showBatteryOptimizationDialog) {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  new BatteryOptimisationDialog());
        }
      }
    });
  }
}

class NavbarButton extends StatelessWidget {
  final bool selected;
  final String asset;
  final Function callback;
  final String title;
  NavbarButton({this.asset, this.selected, this.callback, this.title});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: SizedBox(
          height: 64,
          child: Column(
            children: <Widget>[
              Container(
                color: selected ? codephileMain : Colors.transparent,
                height: 2,
                width: 75,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: SvgPicture.asset(
                  asset,
                  color: selected ? codephileMain : Color(0xFF979797),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: selected ? codephileMain : Color(0xFF979797),
                    fontSize: 16),
              )
            ],
          ),
        ),
        padding: EdgeInsets.all(0),
        onPressed: callback);
  }
}
