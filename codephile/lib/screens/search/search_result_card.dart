import 'package:codephile/resources/colors.dart';
import 'package:codephile/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchResultCard extends StatelessWidget {
  final String _name;
  final String _handle;
  final String _userImage;
  final String token;

  const SearchResultCard(this.token, this._name, this._handle, this._userImage, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 4.0, 8.0),
              child:Container(
                height: MediaQuery.of(context).size.width/10,
                width: MediaQuery.of(context).size.width/10,
                alignment: (_userImage == "")? Alignment(0.0, 0.0): Alignment.center,
                child: (_userImage == "")?
                SizedBox(
                  height: MediaQuery.of(context).size.width/3,
                  width: MediaQuery.of(context).size.width/3,
                  child: SvgPicture.asset(
                    'assets/default_user_icon.svg',
                    fit: BoxFit.fitWidth,
                  ),
                )
                    :
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                          _userImage,
                        ),
                      )
                  ),
                ),
                decoration: BoxDecoration(
                    color: codephileBackground,
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 0,
                        color: userIconBorderGrey
                    )
                ),
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
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
