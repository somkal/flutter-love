// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:myLoves/favorite_widget.dart';
import 'package:myLoves/image_widget.dart';

// Uncomment lines 7 and 10 to view the visual layout at runtime.
//import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  //debugPaintSizeEnabled = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  void _showLove(url) async {
    String loveUrl = url + '1-201-208-7184';
    if (await UrlLauncher.canLaunch(loveUrl)) {
      await UrlLauncher.launch(loveUrl);
    } else {
      throw 'Could not launch $loveUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(28.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    'Soumi & Dhruv 💕',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Text(
                  'Always in my heart',
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          new FavoriteWidget(), 
        ],
      ),
    );

    Column buildButtonColumn(IconData icon, String label, String method) {
      Color color = Theme.of(context).primaryColor;

      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new IconButton(
            icon: (new Icon(icon)), 
            color: color,
            onPressed: () => _showLove(method)
          ),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],        
      );
    }

    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.call, 'CALL', 'tel:'),
          buildButtonColumn(Icons.voice_chat, 'FACETIME', 'facetime:'),
          buildButtonColumn(Icons.message, 'TEXT', 'sms:'),
        ],
      ),
    );

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''
          "and she loves a little boy very very much, more than anyone could ever"
        ''',
        softWrap: true,
      ),
    );

    return new MaterialApp(
      title: 'My Loves',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('My Loves'),
        ),
        body: new ListView(
          children: [
            new ImageWidget(),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.purple)
    );
  }
}