import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';
import 'package:kulina/resources/decoration.dart';

class CalendarTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final TextStyle dayOfWeekStyles;
  final TextStyle dateStyles;
  final Widget child;
  final bool isDisable;
  final bool isToday;

  CalendarTile(
      {this.onDateSelected,
      this.date,
      this.child,
      this.dateStyles,
      this.dayOfWeek,
      this.dayOfWeekStyles,
      this.isDisable: false,
      this.isDayOfWeek: false,
      this.isSelected: false,
      this.isToday: false});

  Widget renderTile(BuildContext context) {
    return isToday
        ? new Stack(
            children: <Widget>[
              new Container(
                alignment: Alignment.center,
                child: new Text(Utils.formatDay(date).toString(),
                    style: new TextStyle(color: const Color(0xffdadedf))),
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle, color: const Color(0xfff2f3f4)),
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                          child: new Container(
                        decoration: new BoxDecoration(color: yellow),
                        child: new Text('Hari ini',
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                color: Colors.white, fontSize: 11.0)),
                      ))
                    ],
                  )
                ],
              ),
            ],
          )
        : new Container(
            decoration: isSelected
                ? new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: yellow,
                  )
                : new BoxDecoration(
                    shape: BoxShape.rectangle, color: const Color(0xfff2f3f4)),
            alignment: Alignment.center,
            child: new Text(
              Utils.formatDay(date).toString(),
              style: isDisable
                  ? new TextStyle(color: const Color(0xffdadedf))
                  : isSelected
                      ? new TextStyle(color: Colors.white)
                      : dateStyles,
              textAlign: TextAlign.center,
            ),
          );
  }

  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (isDayOfWeek) {
      return new InkWell(
        child: new Container(
          alignment: Alignment.center,
          child: new Text(
            dayOfWeek,
            style: dayOfWeekStyles,
          ),
        ),
      );
    } else {
      return new InkWell(
          onTap: onDateSelected,
          child: new Padding(
            padding: new EdgeInsets.all(1.0),
            child: renderTile(context),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return child;
    }
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: renderDateOrDayOfWeek(context),
    );
  }
}
