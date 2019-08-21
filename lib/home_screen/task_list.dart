import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_manager/database/task.dart';
import 'package:time_manager/home_screen/selected_info.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Task> selectedTasks = Provider.of<SelectedInfo>(context).selectedTasks;

    Icon _getIcon(Task task) {
      switch (task.status) {
        case Status.incomplete:
          return Icon(Icons.fiber_manual_record);
        case Status.complete:
          return Icon(Icons.done);
        case Status.moved:
          return Icon(Icons.chevron_right);
        case Status.canceled:
          return Icon(Icons.cancel);
      }
      // unreachable
      return null;
    }

    return ListView.builder(
      itemCount: selectedTasks != null ? selectedTasks.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          leading: _getIcon(selectedTasks[index]),
          title: Text(selectedTasks[index].name),
        );
      },
    );
  }
}
