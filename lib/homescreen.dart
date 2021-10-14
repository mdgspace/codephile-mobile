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
  final String? token;
  final String? userId;
  const HomePage({Key? key, this.token, this.userId}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late String? token, userId;
  int? _selectedIndex;
  PageController? _pageController;
  bool? _showBatteryOptimizationDialog;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 1;
    _pageController = PageController(initialPage: 1);
    token = widget.token;
    userId = widget.userId;
    showBatteryOptimisationAlert();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          FeedScreen(token: token),
          ContestScreen(token: token),
          SearchPage(token, userId),
          Profile(token, userId, true, false),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, -4),
            ),
          ],
        ),
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
                  _pageController!.jumpToPage(0);
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
                  _pageController!.jumpToPage(1);
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
                  _pageController!.jumpToPage(2);
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
                  _pageController!.jumpToPage(3);
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

    _showBatteryOptimizationDialog ??= true;

    BatteryOptimization.isIgnoringBatteryOptimizations().then(
      (isNotOptimized) {
        if (isNotOptimized!) {
          //do nothing
        } else {
          if (_showBatteryOptimizationDialog!) {
            showDialog(
              context: context,
              builder: (context) => const BatteryOptimisationDialog(),
            );
          }
        }
      },
    );
  }
}

class NavbarButton extends StatelessWidget {
  final bool? selected;
  final String? asset;
  final Function()? callback;
  final String? title;
  const NavbarButton({
    this.asset,
    this.selected,
    this.callback,
    this.title,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: SizedBox(
        height: 64,
        child: Column(
          children: <Widget>[
            Container(
              color: selected! ? codephileMain : Colors.transparent,
              height: 2,
              width: 75,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: SvgPicture.asset(
                asset!,
                color: selected! ? codephileMain : const Color(0xFF979797),
              ),
            ),
            Text(
              title!,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: selected! ? codephileMain : const Color(0xFF979797),
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
      onPressed: callback,
    );
  }
}
