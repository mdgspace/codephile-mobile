import 'package:codephile/models/search_results.dart';
import 'package:codephile/models/user.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/profile/profile_screen.dart';
import 'package:codephile/screens/search/search_result_card.dart';
import 'package:codephile/services/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  final String token;
  final String uId;

  SearchPage(this.token, this.uId);

  @override
  _SearchPageState createState() => _SearchPageState(token: token);
}

class _SearchPageState extends State<SearchPage> {
  final String inputHint = "Enter handle or platform";
  final String token;
  _SearchPageState({Key key, this.token});

  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;
  List<CodephileUser> searchResult = List();
  int statusCode = 0;
  bool isResultNull = false;
  bool showRecentSearches = true;
  List<CodephileUser> _recentlySearchedUsers;

  @override
  void initState() {
    super.initState();
    _controller.text = "";
    loadRecentSearches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(243, 244, 247, 1),
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 2.0, 4.0),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration.collapsed(
                              hintText: inputHint,
                              hintStyle: TextStyle(
                                fontSize: 17.0,
                                color: secondaryTextGrey,
                              )),
                          onSubmitted: (text) {
                            if (text != "") {
                              _handleSearch(text);
                            }
                          },
                          style: TextStyle(
                            color: const Color.fromRGBO(
                                36, 36, 36, 1), //TODO: use color resources
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      //TODO: use search icon from designs
                      padding: EdgeInsets.fromLTRB(8.0, 1.0, 2.0, 4.0),
                      icon: Icon(
                        Icons.search,
                        size: 30.0,
                        color: const Color.fromRGBO(141, 141, 141, 1),
                      ),
                      onPressed: () {
                        if (_controller.text != "") {
                          _handleSearch(_controller.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _isSearching == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : isResultNull
                      ? Center(
                          child: Text(
                            "No matching users found",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: const Color.fromRGBO(36, 36, 36, 1),
                            ),
                          ),
                        )
                      : ((showRecentSearches) &&
                              (_recentlySearchedUsers != null) &&
                              (_recentlySearchedUsers.length != 0))
                          ? recentSearches()
                          : ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                              itemCount: searchResult.length,
                              itemBuilder: (BuildContext context, int index) {
                                CodephileUser user = searchResult[index];
                                return GestureDetector(
                                  child: SearchResultCard(
                                    token,
                                    user.fullname,
                                    user.username,
                                    user.picture,
                                  ),
                                  onTap: () {
                                    addToRecentSearches(user);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => new Profile(
                                                token,
                                                user.id,
                                                (widget.uId == user.id),
                                                true)));
                                  },
                                );
                              },
                            ),
            )
          ],
        ));
  }

  void _handleSearch(String query) {
    bool isResNull = false;
    setState(() {
      _isSearching = true;
      if (showRecentSearches == true) {
        showRecentSearches = false;
      }
    });
    List<CodephileUser> searchResultsTemp; // = List();
    search(widget.token, query, context).then((results) {
      if ((results != null) && (results.length != 0)) {
        searchResultsTemp = results;
        isResNull = false;
      } else {
        searchResultsTemp = [];
        isResNull = true;
      }
      setState(() {
        _isSearching = false;
        isResultNull = isResNull;
        searchResult = searchResultsTemp;
      });
    });
  }

  void addToRecentSearches(CodephileUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String searchHist = prefs.get("recentSearches");

    List<CodephileUser> oldUserObjects =
        (searchHist != null) ? searchResultUsersFromJson(searchHist) : [];
    List<CodephileUser> newUserObjects = [];
    newUserObjects.add(user);
    for (int i = 0; i < oldUserObjects.length; i++) {
      if (oldUserObjects[i].id != user.id) {
        newUserObjects.add(oldUserObjects[i]);
      }
    }

    if (newUserObjects.length > 10) {
      while (newUserObjects.length > 10) {
        newUserObjects.removeLast();
      }
    }
    searchHist = searchResultUsersToJson(newUserObjects);
    prefs.setString("recentSearches", searchHist);
    setState(() {
      _recentlySearchedUsers = newUserObjects;
    });
  }

  Widget recentSearches() {
    List<Widget> textWidget = [
      Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: Text(
          "RECENT SEARCHES",
          style: TextStyle(
            color: secondaryTextGrey,
            fontSize: 16.0,
          ),
        ),
      )
    ];

    List<Widget> recentSearches = [];
    if ((_recentlySearchedUsers != null) &&
        (_recentlySearchedUsers.length != 0)) {
      for (int i = 0; i < _recentlySearchedUsers.length; i++) {
        recentSearches.add(GestureDetector(
          child: SearchResultCard(
              widget.token,
              _recentlySearchedUsers[i].fullname,
              _recentlySearchedUsers[i].username,
              _recentlySearchedUsers[i].picture),
          onTap: () {
            addToRecentSearches(_recentlySearchedUsers[i]);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new Profile(
                        token,
                        _recentlySearchedUsers[i].id,
                        (widget.uId == _recentlySearchedUsers[i].id),
                        true)));
          },
        ));
      }
    }

    List<Widget> widgetsToRender = textWidget + recentSearches;
    return ListView(children: widgetsToRender);
  }

  void loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userListString = prefs.get("recentSearches");
    List<CodephileUser> recentlySearchedUsers = (userListString == null)
        ? []
        : searchResultUsersFromJson(userListString);
    _recentlySearchedUsers = recentlySearchedUsers;
  }
}
