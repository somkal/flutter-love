import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteWidget extends StatefulWidget {
  FavoriteWidget({Key key}) : super(key: key);
  @override
  _FavoriteWidgetState createState() => new _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;
  int _favoriteCount = 0;

  @override
  void initState() {
    super.initState();
    _loadFavCount();
  }

  _loadFavCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteCount = (prefs.getInt('counter') ?? 0);
    });
  }

  _incFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favoriteCount = (prefs.getInt('counter') ?? 0) + 1;
    setState(() {
      if (!_isFavorited) {
        _isFavorited = true;
      }
      _favoriteCount;
    });
    prefs.setInt('counter', _favoriteCount);
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        new SizedBox(
          width: 36.0,
          child: new Container(
            child: new Text(
              '$_favoriteCount',
              style: new TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,                
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        new Container(
          padding: new EdgeInsets.all(0.0),
          child: new IconButton(
            icon: (_isFavorited
                ? new Icon(Icons.favorite)
                : new Icon(Icons.favorite_border)),
            color: Colors.purple[500],
            onPressed: _incFavorite,
          ),
        ),
      ],
    );
  }
}