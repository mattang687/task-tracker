import 'package:flutter/material.dart';
import 'package:time_manager/create_task_page/create_task_page.dart';
import 'package:time_manager/home_screen/task_list.dart';

import 'calendar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
      ),
      body: Column(
        children: <Widget>[
          CalendarWidget(),
          SizedBox(
            child: TaskList(),
            height: 500,
          ),
        ],
      ),
    );
  }
}
