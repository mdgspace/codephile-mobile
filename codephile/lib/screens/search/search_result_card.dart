import 'package:codephile/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class SearchResultCard extends StatelessWidget{

  final String _name;
  final String _handle;
  final String _imageLink;
  final String _uid;
  final String token;

  const SearchResultCard(this.token, this._name, this._handle, this._imageLink, this._uid, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 4.0, 8.0),
              child: Image.network(
                _imageLink!=""?
                _imageLink
                    :
                "https://cdn2.iconfinder.com/data/icons/ios-7-icons/50/user_male2-512.png",
                height: 40.0,
                width: 40.0,
              ),
            ),
//          ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 5.0, 8.0, 2.0),
                  child: Text(
                    "$_name",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: const Color.fromRGBO(36, 36, 36, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 2.0, 8.0, 8.0),
                  child: Text(
                    "@$_handle",
                    style: TextStyle(
                      color: const Color.fromRGBO(151, 151, 151, 1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new Profile(token, _uid))
        );
      },
    );
  }

}
