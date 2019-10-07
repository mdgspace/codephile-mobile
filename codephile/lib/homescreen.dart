import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage>{
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Codephile',
              style: new TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[
          new Icon(
            Icons.search,
            color: Colors.green,
            size: 35,
          ),
          new SizedBox(width: 15,),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return new Row(
              children: <Widget>[
              new SizedBox(width:15,),
              new CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage('https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
              radius: 18.0,
            ),
            ],);
          },
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
                Icons.timeline,
                color: Colors.green,
                size: 30,
            ),
            title: Text(
                "Activity",
                style: new TextStyle(
                  color: Colors.black,
                ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.search,
                color: Colors.green,
                size: 30,
            ),
            title: Text(
                'Search',
                style: new TextStyle(
                  color: Colors.black,
                ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_border,
              color: Colors.green,
              size: 30,
            ),
            title: Text(
              'Bookmark',
              style: new TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.perm_identity,
                color: Colors.green,
                size: 30,
            ),
            title: Text(
                'Profile',
              style: new TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedLabelStyle: new TextStyle(
          color: Colors.deepPurple,
        ),
        onTap: _onItemTapped,
        elevation:30,
      ),
    );
  }
}