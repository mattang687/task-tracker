import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalendarWidgetState();
  }
}

class CalendarWidgetState extends State<CalendarWidget> with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  Map<DateTime, List> _events;
  List _selectedEvents;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();

    DateTime _selectedDay = DateTime.now();

    _events = {};
    _selectedEvents = _events[_selectedDay] ?? [];

    AnimationController _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      headerVisible: false,
      initialCalendarFormat: CalendarFormat.week,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }
  _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    // TODO: send date to appbar
  }
}
