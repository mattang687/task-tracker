import 'package:flutter/material.dart';
import 'package:time_manager/database/database_wrapper.dart';
import 'package:time_manager/database/task.dart';

class DatabaseModel with ChangeNotifier {
  DatabaseWrapper db = DatabaseWrapper.instance;
  // tasks to be displayed
  List<Task> selectedInfo = new List<Task>();

  Future<void> updateSelectedInfo(DateTime date) async {
    selectedInfo = await db.queryDate(date);
    notifyListeners();
  }

  Future<List<Task>> getTasks(DateTime date) async {
    print("GETTING TASKS");
    List<Task> tasks = await db.queryDate(date);
    print(tasks.length);
    return await db.queryDate(date);
  }

  Future<void> createTask(Task task) async {
    await db.insertTask(task);
    notifyListeners();
  }

  Future<void> updateTask(Task newTask) async {
    await db.updateTask(newTask);
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    await db.deleteTask(task);
    notifyListeners();
  }

  // moving a task leaves an entry in its original place
  Future<void> moveTask(Task task, DateTime newDate, DateTime newStartTime,
      DateTime newEndTime) async {
    // mark as moved
    task.status = Status.moved;
    await db.updateTask(task);

    // make new task at provided time
    Task newTask = new Task(
      name: task.name,
      notes: task.notes,
      date: newDate.millisecondsSinceEpoch,
      startTime: newStartTime.millisecondsSinceEpoch,
      endTime: newEndTime.millisecondsSinceEpoch,
    );
    await db.insertTask(newTask);
    notifyListeners();
  }

  // marks task as complete
  Future<void> completeTask(Task task) async {
    task.status = Status.complete;
    updateTask(task);
    notifyListeners();
  }

  // marks task as incomplete
  Future<void> uncompleteTask(Task task) async {
    task.status = Status.incomplete;
    updateTask(task);
    notifyListeners();
  }

  // marks task as canceled
  Future<void> cancelTask(Task task) async {
    task.status = Status.canceled;
    updateTask(task);
    notifyListeners();
  }
}
