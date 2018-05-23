import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'decoration.dart';

class HoverButton extends StatefulWidget {
  const HoverButton({
    Key key,
    this.leftRound = false,
    this.rightRound = false,
    @required this.height,
    @required this.child,
    this.margin = const EdgeInsets.all(0.0),
    this.higlight,
    this.icon,
    this.fill,
    this.border = const Color(0xfffd9714),
    this.onPressed
  }) : super(key: key);

  final bool leftRound;
  final bool rightRound;
  final Widget child;
  final Icon icon;
  final double height;
  final Color higlight;
  final EdgeInsets margin;
  final Color border;
  final VoidCallback onPressed;
  final Color fill;

  @override
  _LordButton createState() => new _LordButton();
}

class _LordButton extends State<HoverButton> {
  Color border = yellow;
  Color higlight;


  @override
  void initState() {
    setState(() {
      higlight = widget.fill;
    });
  }

  void _down(TapDownDetails details){
    setState(() {
      border =  widget.border;
      higlight = widget.higlight;
    });
  }

  void _up(TapUpDetails details){
    setState(() {
      border = yellow;
      higlight = widget.fill;
    });
  }


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
      onTapUp: _up,
      onTapDown: _down,
      onTap: widget.onPressed,
      child: new Container(
        margin: widget.margin,
        height: widget.height,
        decoration: new BoxDecoration(
            color:  higlight,
            borderRadius: radius,
            shape: BoxShape.rectangle,
            border: new Border.all(color:border, width: 2.0)),
        alignment: FractionalOffset.center,
        child: widget.child,
      ),
    );

  }
}
