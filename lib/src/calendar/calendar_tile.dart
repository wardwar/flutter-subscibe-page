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

  CalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyles,
    this.isDisable: false,
    this.isDayOfWeek: false,
    this.isSelected: false,
  });

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
            child: new Container(
              decoration: isSelected
                  ? new BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: yellow,
                    )
                  : new BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: const Color(0xfff2f3f4)),
              alignment: Alignment.center,
              child: new Text(
                Utils.formatDay(date).toString(),
                style: isDisable ? new TextStyle(color: const Color(0xffdadedf)) : isSelected
                    ? new TextStyle(color: Colors.white)
                    : dateStyles,
                textAlign: TextAlign.center,
              ),
            ),
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
