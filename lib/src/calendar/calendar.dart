import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'calendar_tile.dart';
import 'date_utils.dart';

typedef DayBuilder(BuildContext context, DateTime day);

class Calendar extends StatefulWidget {
  final ValueChanged<List<DateTime>> onDateSelected;
  final ValueChanged<Tuple2<DateTime, DateTime>> onSelectedRangeChange;
  final DayBuilder dayBuilder;
  final bool showChevronsToChangeRange;
  final List<DateTime> selectedData;

  Calendar({
    this.selectedData,
    this.onDateSelected,
    this.onSelectedRangeChange,
    this.dayBuilder,
    this.showChevronsToChangeRange: true,
  });

  @override
  _CalendarState createState() => new _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final calendarUtils = new Utils();
  DateTime today = new DateTime.now();
  DateTime batasBawah = new DateTime.now();
  DateTime batasAtas = new DateTime.now().add(new Duration(days: 65));
  List<DateTime> selectedMonthsDays;
  List<DateTime> _selectedDate;
  Tuple2<DateTime, DateTime> selectedRange;
  String currentMonth;
  String displayMonth;

  List<DateTime> get selectedDate => _selectedDate;

  void initState() {
    super.initState();
    _selectedDate = widget.selectedData;
    selectedMonthsDays = Utils.daysInMonth(today);
    displayMonth = Utils.formatMonth(Utils.firstDayOfWeek(today));
  }

  Widget get nameAndIconRow {
    var leftInnerIcon;
    var rightInnerIcon;
    var leftOuterIcon;
    var rightOuterIcon;
    rightInnerIcon = new Container();

    if (widget.showChevronsToChangeRange) {
      bool isPrevNotAvailable = today.month <= batasBawah.month;
      bool isNextNotAvailable = today.month >= batasAtas.month;
      var prevColor = isPrevNotAvailable ? Colors.white : Colors.black87;
      var nextColor = isNextNotAvailable ? Colors.white : Colors.black87;
      var prevPress = isPrevNotAvailable ? null : previousMonth;
      var nextPress = isNextNotAvailable ? null : nextMonth;

      leftOuterIcon = new IconButton(
        onPressed: prevPress,
        icon: new Icon(Icons.chevron_left, color: prevColor),
      );
      rightOuterIcon = new IconButton(
        onPressed: nextPress,
        icon: new Icon(
          Icons.chevron_right,
          color: nextColor,
        ),
      );
    } else {
      leftOuterIcon = new Container();
      rightOuterIcon = new Container();
    }

    leftInnerIcon = new Container();

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftOuterIcon ?? new Container(),
        leftInnerIcon ?? new Container(),
        new Text(
          displayMonth,
          style: new TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
          ),
        ),
        rightInnerIcon ?? new Container(),
        rightOuterIcon ?? new Container(),
      ],
    );
  }

  Widget get calendarGridView {
    return new Container(
      child: new GestureDetector(
        child: new GridView.count(
          shrinkWrap: true,
          crossAxisCount: 7,
          childAspectRatio: 4.4/5,
          mainAxisSpacing: 0.0,
          padding: new EdgeInsets.only(bottom: 0.0),
          children: calendarBuilder(),
        ),
      ),
    );
  }

  List<Widget> calendarBuilder() {
    List<Widget> dayWidgets = [];
    List<DateTime> calendarDays = selectedMonthsDays;

    const List<String> weekdays = const [
      "SEN",
      "SEL",
      "RAB",
      "KAM",
      "JUM",
      "SAB",
      "MIN"
    ];

    weekdays.forEach(
      (day) {
        dayWidgets.add(
          new CalendarTile(
            isDayOfWeek: true,
            dayOfWeek: day,
          ),
        );
      },
    );

    bool monthStarted = false;
    bool monthEnded = false;
    bool disabled = false;

    calendarDays.forEach(
      (day) {
        if (monthStarted && day.day == 01) {
          monthEnded = true;
        }

        if(day.isBefore(batasBawah))
          disabled = true;
        else if(day.weekday ==6 || day.weekday == 7)
          disabled=true;
        else
          disabled=false;

        if (Utils.isFirstDayOfMonth(day)) {
          monthStarted = true;
        }

        if (this.widget.dayBuilder != null) {
          dayWidgets.add(
            new CalendarTile(
              child: this.widget.dayBuilder(context, day),
            ),
          );
        } else {
          dayWidgets.add(
            new CalendarTile(
              onDateSelected:
                  disabled ? null : () => handleSelectedDateAndUserCallback(day),
              date: day,
              isToday: Utils.isSameDay(day, batasBawah),
              isDisable: disabled,
              dateStyles: configureDateStyle(monthStarted, monthEnded, day),
              isSelected: selectedDate.contains(day),
            ),
          );
        }
      },
    );
    return dayWidgets;
  }

  TextStyle configureDateStyle(monthStarted, monthEnded, day) {
    TextStyle dateStyles;

    dateStyles = monthStarted && !monthEnded
        ? new TextStyle(color: Colors.black)
        : new TextStyle(color: Colors.black38);

    return dateStyles;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          nameAndIconRow,
          calendarGridView,
//          expansionButtonRow
        ],
      ),
    );
  }

  void resetToToday() {
    today = new DateTime.now();

    setState(() {
      _selectedDate.clear();
      displayMonth = Utils.formatMonth(Utils.firstDayOfWeek(today));
    });
  }

  void nextMonth() {
    setState(() {
      var next = Utils.nextMonth(today);
      today = next;
      selectedMonthsDays = Utils.daysInMonth(next);
      displayMonth = Utils.formatMonth(next);
    });
  }

  void previousMonth() {
    setState(() {
      var prev = Utils.previousMonth(today);
      today = prev;
      selectedMonthsDays = Utils.daysInMonth(prev);
      displayMonth = Utils.formatMonth(prev);
    });
  }

  var gestureStart;
  var gestureDirection;

  void beginSwipe(DragStartDetails gestureDetails) {
    gestureStart = gestureDetails.globalPosition.dx;
  }

  void getDirection(DragUpdateDetails gestureDetails) {
    if (gestureDetails.globalPosition.dx < gestureStart) {
      gestureDirection = 'rightToLeft';
    } else {
      gestureDirection = 'leftToRight';
    }
  }

  void endSwipe(DragEndDetails gestureDetails) {
    if (gestureDirection == 'rightToLeft') {
      nextMonth();
    } else {
      previousMonth();
    }
  }

  void handleSelectedDateAndUserCallback(DateTime day) {
      setState(() {
        if (_selectedDate.contains(day))
          _selectedDate.remove(day);
        else
          _selectedDate.add(day);
      });
    print(_selectedDate);
    if (widget.onDateSelected != null) {
      widget.onDateSelected(_selectedDate);
    }
  }
}
