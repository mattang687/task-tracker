import 'package:flutter/foundation.dart';
import 'package:time_manager/database/task.dart';

class SelectedInfo with ChangeNotifier {
  DateTime date;
  List<Task> selectedTasks;

  void setSelectedInfo(List<Task> newTasks) {
    selectedTasks = newTasks;
    notifyListeners();
  }

  void setDate(DateTime dateTime) {
    date = dateTime;
    notifyListeners();
  }
}
