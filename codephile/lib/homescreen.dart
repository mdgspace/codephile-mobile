import 'package:codephile/services/Id.dart';
import 'package:flutter/material.dart';
import 'package:codephile/screens/contests/contests_screen.dart';
import 'package:codephile/screens/profile/profile_screen.dart';
import 'package:codephile/screens/submission/submission_screen.dart';
import 'package:codephile/screens/search/search_page.dart';
import 'package:codephile/colors.dart';

class HomePage extends StatefulWidget{
  final String token;
  const HomePage({Key key, this.token}) : super(key: key);

  @override
  HomePageState createState() => new HomePageState(token: token);
}

class HomePageState extends State<HomePage>{
  final String token;
  HomePageState({Key key, this.token});
  String uid;
  @override
  void initState(){
    super.initState();
    uid = getUserId(token);
//    var result = search(token, "user");
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

 List<Widget> _showHomeScreen(String token, String uid){
    return <Widget>[
      new PageView(
        children: <Widget>[
          new MaterialApp(
            debugShowCheckedModeBanner: false,
            home: new Timeline(token),
          ),
          new MaterialApp(
            debugShowCheckedModeBanner: false,
            home: new Submission(token: token, id: uid),
          )
        ],
      )
      ,new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new SearchPage(token),
      ),
      new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Submission(token: token, id: uid),
      ),
      new MaterialApp(
        debugShowCheckedModeBanner: false,
        //TODO: implement UserId
        //TODO: implement token
        home: new Profile(token, uid),
      ),
    ];
  }

  //Working Fine
  String getUserId(String token){
    id(token).then((T) async {
      print("UID :" + T);
     return T;
    });
  }

  void _onItemTapped(int index) {
       setState(() {
         _selectedIndex = index;
       });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//            'Codephile',
//              style: new TextStyle(
//                color: Colors.black,
//                fontWeight: FontWeight.bold,
//              ),
//        ),
//        backgroundColor: Colors.white,
//        automaticallyImplyLeading: false,
//        centerTitle: true,
//        actions: <Widget>[
//          new Icon(
//            Icons.settings,
//            color: Colors.green,
//            size: 35,
//          ),
//          new SizedBox(width: 15,),
//        ],
//        leading: Builder(
//          builder: (BuildContext context) {
//            return new Row(
//              children: <Widget>[
//              new SizedBox(width:15,),
//              new CircleAvatar(
//              backgroundColor: Colors.grey,
//              backgroundImage: NetworkImage('https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
//              radius: 18.0,
//            ),
//            ],);
//          },
//        ),
//      ),
      body: Center(
        child: _showHomeScreen(token, uid).elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
                Icons.timeline,
                size: 30,
            ),
            title: Text(
                "Activity",
                style: new TextStyle(
                ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.search,
                size: 30,
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
              'Bookmark',
              style: new TextStyle(
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.perm_identity,
                size: 30,
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
