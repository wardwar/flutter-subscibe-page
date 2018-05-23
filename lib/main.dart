import 'package:flutter/material.dart';
import 'package:kulina/src/page/langganan.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Kulina',
      theme: new ThemeData(
        textTheme:
            new TextTheme(body2: new TextStyle(color: const Color(0xff8c979a)),body1: new TextStyle(color: const Color(0xff8c979a))),
      ),
      home: new LanggananPage(title: 'Mulai Langganan'),

    );
  }
}


