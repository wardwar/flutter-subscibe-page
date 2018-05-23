import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


class MainButton extends StatelessWidget {
  const MainButton({
    Key key,
    this.leftRound = false,
    this.rightRound = false,
    @required this.height,
    @required this.child,
    this.margin = const EdgeInsets.all(0.0),
    this.color = Colors.white,
    this.icon,
    @required this.border,
  }) : super(key: key);

  final bool leftRound;
  final bool rightRound;
  final Widget child;
  final Icon icon;
  final double height;
  final Color color;
  final EdgeInsets margin;
  final Color border;


  @override
  Widget build(BuildContext context) {

    var radius = new BorderRadius.circular(6.0);
    if (leftRound)
      radius = new BorderRadius.only(
          bottomLeft: new Radius.circular(6.0),
          topLeft: new Radius.circular(6.0));
    if (rightRound)
      radius = new BorderRadius.only(
          topRight: new Radius.circular(6.0),
          bottomRight: new Radius.circular(6.0));

    return new Container(
      margin: margin,
      height: height,
      decoration: new BoxDecoration(
          color: color,
          borderRadius: radius,
          shape: BoxShape.rectangle,
          border: new Border.all(color: border, width: 2.0)),
      alignment: FractionalOffset.center,
      child: child,
    );
  }
}
