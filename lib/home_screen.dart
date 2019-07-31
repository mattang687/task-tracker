import 'package:flutter/material.dart';

import 'calendar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
      ),
      body: CalendarWidget()
    );
  }
}