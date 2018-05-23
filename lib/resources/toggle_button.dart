import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'decoration.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({
    Key key,
    this.leftRound = false,
    this.rightRound = false,
    @required this.height,
    @required this.child,
    this.margin = const EdgeInsets.all(0.0),
    this.icon,
    this.fill,
    this.border = const Color(0xfffd9714),
    this.toggel,
    this.isActive = false
  }) : super(key: key);

  final bool leftRound;
  final bool rightRound;
  final Widget child;
  final Icon icon;
  final double height;
  final EdgeInsets margin;
  final Color border;
  final VoidCallback toggel;
  final Color fill;
  final bool isActive;

  @override
  _LordButton createState() => new _LordButton();
}

class _LordButton extends State<ToggleButton> {
  Color border = yellow;

  @override
  Widget build(BuildContext context) {
    var radius = new BorderRadius.circular(6.0);
    if (widget.leftRound)
      radius = new BorderRadius.only(
          bottomLeft: new Radius.circular(6.0),
          topLeft: new Radius.circular(6.0));
    if (widget.rightRound)
      radius = new BorderRadius.only(
          topRight: new Radius.circular(6.0),
          bottomRight: new Radius.circular(6.0));

   return new GestureDetector(
      onTap: widget.toggel,
      child: new Container(
        margin: widget.margin,
        height: widget.height,
        decoration: new BoxDecoration(
            color:  widget.fill,
            borderRadius: radius,
            shape: BoxShape.rectangle,
            border: new Border.all(color:border, width: 2.0)),
        alignment: FractionalOffset.center,
        child: widget.child,
      ),
    );

  }
}
