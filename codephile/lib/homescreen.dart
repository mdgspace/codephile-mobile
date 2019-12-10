import 'package:codephile/services/Id.dart';
import 'package:flutter/material.dart';
import 'package:codephile/screens/contests/contests_screen.dart';
import 'package:codephile/screens/profile/profile_screen.dart';
import 'package:codephile/screens/submission/submission_screen.dart';
import 'package:codephile/screens/search/search_page.dart';
import 'package:codephile/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{
  final String token;
  final String userId;
  const HomePage({Key key, this.token, this.userId}) : super(key: key);

  @override
  HomePageState createState() => new HomePageState(token: token, userId: userId);
}

class HomePageState extends State<HomePage>{
  final String token;
  final String userId;
  HomePageState({Key key, this.token, this.userId});
  bool activity_color = true;
  bool search_color = false;
  bool profile_color = false;
  @override
  void initState(){
    super.initState();
    //    var result = search(token, "user");
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
 List<Widget> _showHomeScreen(String token, String userId){
    return <Widget>[
      new PageView(
        children: <Widget>[
          new MaterialApp(
            debugShowCheckedModeBanner: false,
            home: new Timeline(token),
          ),
          new MaterialApp(
            debugShowCheckedModeBanner: false,
            home: new Submission(token: token, id: userId),
          )
        ],
      )
      ,new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new SearchPage(token),
      ),
      new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Submission(token: token, id: userId),
      ),
      new MaterialApp(
        debugShowCheckedModeBanner: false,
        //TODO: implement UserId
        //TODO: implement token
        home: new Profile(token, userId),
      ),
    ];
  }

  void _onItemTapped(int index) {
       setState(() {
         _selectedIndex = index;
         if(index == 0) activity_color = true;
         else activity_color = false;
         if(index == 1) search_color = true;
         else search_color = false;
         if(index == 3) profile_color = true;
         else profile_color = false;
       });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _showHomeScreen(token, userId).elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/activity.png"),
            color: activity_color ? codephileMain : Colors.black,
          ),
            title: Text(
                "Activity",
                style: new TextStyle(
                ),
            ),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/search.png"),
              color: search_color ? codephileMain : Colors.black,
            ),
            title: Text(
                'Search',
                style: new TextStyle(
                ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_border,
               size: 30,
            ),
            title: Text(
              'Bookmarks',
              style: new TextStyle(
              ),
            ),
          ),
          BottomNavigationBarItem(
//            icon: Icon(
//                Icons.perm_identity,
//                size: 30,
//            ),
            icon: ImageIcon(
              AssetImage("assets/person.png"),
              color: profile_color ? codephileMain : Colors.black,
            ),
            title: Text(
                'Profile',
              style: new TextStyle(
              ),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: codephileMain,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        elevation: 100,
      ),
    );
  }
}
