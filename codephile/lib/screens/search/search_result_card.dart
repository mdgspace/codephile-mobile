import 'package:flutter/material.dart';

class SearchResultCard extends StatelessWidget{

  final String _name;
  final String _handle;
  final String _imageLink;

  const SearchResultCard(this._name, this._handle, this._imageLink, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 8.0),
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                ),
                color: const Color.fromRGBO(145, 145, 145, 1),
              ),
//              child: Image.network(
//                  "https://cdn2.iconfinder.com/data/icons/ios-7-icons/50/user_male2-512.png",
              //TODO: use _imageLink
//                height: 40.0,
//                width: 40.0,
//              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 5.0, 8.0, 2.0),
                child: Text(
                  "$_name",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 2.0, 8.0, 8.0),
                child: Text(
                  "@$_handle",
                  style: TextStyle(
                    color: const Color.fromRGBO(145, 145, 145, 1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
