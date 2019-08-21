import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_manager/database/database_model.dart';
import 'package:time_manager/database/task.dart';

class CreateTaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateTaskPageState();
  }
}

class CreateTaskPageState extends State<CreateTaskPage> {
  String name;
  String notes;
  // date is in milliseconds since epoch
  int date;
  // time is in milliseconds since epoch
  int startTime;
  int endTime;
  Status status = Status.incomplete;

  int getDate() {
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
  }

  @override
  Widget build(BuildContext context) {
    DatabaseModel databaseModel = Provider.of<DatabaseModel>(context);
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => databaseModel.createTask(Task(
                  name: name,
                  notes: notes,
                  date: getDate(),
                  startTime: getDate(),
                  endTime: getDate(),
                  status: status)),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            // text fields to input task properties
            Text('Name'),
            TextField(onChanged: (text) {
              name = text;
            }),
            Text('Notes'),
            TextField(onChanged: (text) {
              notes = text;
            }),
          ],
        ));
  }
}
