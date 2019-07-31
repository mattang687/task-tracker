import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalendarWidgetState();
  }
}

class CalendarWidgetState extends State<CalendarWidget> {
  CalendarController _calendarController;
  
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
    );
  }
}
