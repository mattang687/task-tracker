import 'package:flutter/foundation.dart';

import '../database/task.dart';

class SelectedTasks with ChangeNotifier {
  DateTime date;
  List<Task> selectedTasks;

  void setSelectedTasks(List<Task> newTasks) {
    selectedTasks = newTasks;
    notifyListeners();
  }

  void setDate(DateTime dateTime) {
    date = dateTime;
    notifyListeners();
  }
}
