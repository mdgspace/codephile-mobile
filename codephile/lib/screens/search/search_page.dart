import 'package:codephile/models/user.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/profile/profile_screen.dart';
import 'package:codephile/screens/search/search_result_card.dart';
import 'package:codephile/services/search.dart';
import 'package:flutter/material.dart';

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
  List<User> searchResult = List();
  int statusCode = 0;
  bool isResultNull = false;

  @override
  void initState() {
    super.initState();
    _controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: codephileBackground,
      appBar: AppBar(
        backgroundColor: codephileBackground,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 2.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            elevation: 0.0,
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
                            color: const Color.fromRGBO(151, 151, 151, 1),
                          )),
                      onSubmitted: (text) {
                        if (text != "") {
                          _handleSearch(text);
                        }
                      },
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.fromLTRB(8.0, 1.0, 2.0, 4.0),
                  icon: Icon(
                    Icons.search,
                    size: 30.0,
                    color: const Color.fromRGBO(51, 102, 255, 1),
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
        elevation: 0.0,
      ),
      body: _isSearching == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (statusCode == 403)
              ? Center(
                  child: Text(
                    "Please enter a longer query",
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              : isResultNull
                  ? Center(
                      child: Text(
                        "No matching users found",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchResult.length,
                      itemBuilder: (BuildContext context, int index) {
                        User user = searchResult[index];
                        return GestureDetector(
                          child: SearchResultCard(
                            token,
                            user.fullname,
                            user.username,
                            user.picture,
                          ),
                          onTap: () {
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
    );
  }

  void _handleSearch(String query) {
    print(query);
    setState(() {
      _isSearching = true;
    });
    List<User> searchResultsTemp; // = List();
    search(widget.token, query).then((results) {
      if (results != null) {
        searchResultsTemp = results;
        isResultNull = false;
      } else {
        isResultNull = true;
      }
      setState(() {
        _isSearching = false;
        searchResult = searchResultsTemp;
      });
    });
  }
}
