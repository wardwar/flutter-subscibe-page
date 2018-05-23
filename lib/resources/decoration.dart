import 'package:flutter/material.dart';

Color yellow = const Color(0xfffd9714);
Color red = const Color(0xFFfa5034);
Color red12 = const Color(0x97fa5034);
Color cream = const Color(0xfffef4e7);
Color greyDiv = const Color(0xfff2f3f4);

TextStyle big = new TextStyle(
    fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black54);

TextStyle bigWhite = new TextStyle(
    fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white);

TextStyle medium = new TextStyle(fontSize: 16.0, color: Colors.black54);

TextStyle mediumWhite = new TextStyle(fontSize: 16.0, color: Colors.white);

final step = new BoxDecoration(
  border: new Border.all(
    color: const Color(0xffdadedf),
    width: 3.0,
  ),
  shape: BoxShape.circle,
);

final stepActive = new BoxDecoration(
  border: new Border.all(
    color: yellow,
    width: 3.0,
  ),
  shape: BoxShape.circle,
);

final rowDivider = new Expanded(
    child: new Container(
      decoration: new BoxDecoration(
          border: new Border(
              top: new BorderSide(color: greyDiv, width: 3.0))),
      height: 1.0,
    ));

final mainCard = new BoxDecoration(
  color: Colors.white,
  shape: BoxShape.rectangle,
  borderRadius: new BorderRadius.circular(6.0),
  boxShadow: <BoxShadow>[
    new BoxShadow(
      color: Colors.black12,
      blurRadius: 30.0,
      offset: new Offset(0.0, 10.0),
    ),
  ],
);

final SecondaryCard = new BoxDecoration(
  color: cream,
  shape: BoxShape.rectangle,
  borderRadius: new BorderRadius.circular(6.0),
);

final mainButton = new BoxDecoration(
  borderRadius: new BorderRadius.circular(6.0),
  shape: BoxShape.rectangle,
  boxShadow: <BoxShadow>[
    new BoxShadow(
        color: red12,
        blurRadius: 30.0,
        offset: new Offset(0.0, 0.0),
        spreadRadius: 0.0
    ),
  ],
  gradient: new LinearGradient(
    begin: Alignment.topLeft,
    end: new Alignment(0.8, 0.0),
    // 10% of the width, so there are ten blinds.
    colors: [
      red,
      yellow
    ], // repeats the gradient over the canvas
  ),
);