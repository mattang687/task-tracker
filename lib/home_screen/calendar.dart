import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_manager/database/database_model.dart';

import '../database/task.dart';
import 'selected_info.dart';

class CalendarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalendarWidgetState();
  }
}

class CalendarWidgetState extends State<CalendarWidget>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  Map<DateTime, List> _events;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();

    _events = {};

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
      onDaySelected: _onDaySelected,
    );
  }

  _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) async {
    // get events on every day from first to last, update events
    DatabaseModel databaseModel = Provider.of<DatabaseModel>(context);
    while (first.millisecondsSinceEpoch <= last.millisecondsSinceEpoch) {
      List<Task> tasks = await databaseModel.getTasks(first);
      setState(() {
        _events[first] = tasks;
      });
      first.add(Duration(days: 1));
    }
  }

  _onDaySelected(DateTime day, List events) async {
    // update selected tasks
    DatabaseModel databaseModel = Provider.of<DatabaseModel>(context);
    SelectedInfo selectedInfo = Provider.of<SelectedInfo>(context);
    selectedInfo.setSelectedInfo(await databaseModel.getTasks(day));
  }
}
