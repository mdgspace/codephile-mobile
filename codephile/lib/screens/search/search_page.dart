import 'package:codephile/homescreen.dart';
import 'package:codephile/screens/search/search_result_card.dart';
import 'package:codephile/services/search.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{

  final String token;

  SearchPage(this.token);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final String inputHint = "Enter handle or platform";

  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;
  List<SearchUser> searchResult = List();
  int statusCode = 0;

  @override
  void initState(){
    super.initState();
    _controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            elevation: 0.0,
            color: const Color.fromRGBO(229, 229, 229, 0.5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 2.0, 4.0),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration.collapsed(
                            hintText: inputHint,
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              color : const Color.fromRGBO(151, 151, 151, 1),
                            )
                        ),
//                      onChanged: searchOperation,
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.fromLTRB(8.0, 1.0, 2.0, 4.0),
                    icon: Icon(
                      Icons.search,
                      size: 30.0,
                      color : const Color.fromRGBO(145, 145, 145, 1),
                    ),
                    onPressed: () {
                      if(_controller.text != ""){
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
        body: _isSearching==true?
        Center(
          child: CircularProgressIndicator(),
        )
            :
        (statusCode == 403)?
        Center(
          child: Text(
            "Please enter a longer query",
            style: TextStyle(
                fontSize: 20.0
            ),
          ),
        )
            :
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchResult.length,
                itemBuilder: (BuildContext context, int index){
                  SearchUser user = searchResult[index];
                  return SearchResultCard(testToken, user._name, user._handle, user._image, user._uid);
                },
              ),
            )
          ],
        )
    );
    //FOR DYNAMIC SEARCH!!


//      Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: <Widget>[
//          Flexible(
//              child: (searchResult.length != 0 || _controller.text.isNotEmpty)?
//              ListView.builder(
//                shrinkWrap: true,
//                itemCount: searchResult.length,
//                itemBuilder: (BuildContext context, int index){
//                  SearchUser user = searchResult[index];
//                  return SearchResultCard(user._name, user._handle, user._image);
//                },
//              )
//                  :
//              ListView.builder(
//                  shrinkWrap: true,
//                  itemCount: _list.length,
//                  itemBuilder: (BuildContext context, int index){
//                    SearchUser user = _list[index];
//                    return SearchResultCard(user._name, user._handle, user._image);
//                  }
//              )
//          )
//        ],
//      ),
//      backgroundColor: Colors.white,
//    );
  }

//  void searchOperation(String searchText){
//    List<SearchUser> newSearchResult = List();
//    if(_isSearching == false){
//      _handleSearchStart();
//    }
//    searchResult.clear();
//    if(_isSearching != null){
//      for(int i = 0; i < _list.length; i++){
//        String username = _list[i]._name;
//        String handle = _list[i]._handle;
//
//        if((username.toLowerCase().contains((searchText.toLowerCase())))||
//            (handle.toLowerCase().contains((searchText.toLowerCase()))) ){
//          newSearchResult.add(_list[i]);
//        }
//      }
//      setState(() {
//        searchResult = newSearchResult;
//      });
//    }
//  }
//
//  void _handleSearchStart() {
//    setState(() {
//      _isSearching = true;
//    });
//  }
//
//  void _handleSearchEnd() {
//    setState(() {
//      _isSearching = false;
////      _controller.text = "";
//    });
//  }

  void _handleSearch(String query) {
    setState(() {
      _isSearching = true;
    });
    List<SearchUser> searchResultsTemp = List();
    search(widget.token, query).then((results){
      if(results != null){
        statusCode = results.statusCode;
        if(results.users != null){
          for(int i = 0; i < results.users.length; i++){
            searchResultsTemp.add(
                SearchUser(
                    results.users[i].fullname,
                    results.users[i].username,
                    results.users[i].id,
                    results.users[i].picture,
                )
            );
          }
        }
      }
      setState(() {
        _isSearching = false;
        searchResult = searchResultsTemp;
      });
    });
  }

}

//TODO: remove dummy data class
class SearchUser{
  String _name;
  String _handle;
  String _uid;
  String _image;

  SearchUser(this._name, this._handle, this._uid, this._image);

  String get name => _name;
  String get handle => _handle;
  String get uid => _uid;
  String get image => _image;
}
