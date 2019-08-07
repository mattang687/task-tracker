import 'package:flutter_test/flutter_test.dart';
import 'package:time_manager/database/database_wrapper.dart';
import 'package:time_manager/database/task.dart';

// to be run through an emulator/device with "flutter run test/database_test.dart"
void main() {
  test('Insert single, query date', () async {
    final DatabaseWrapper db = DatabaseWrapper.instance;
    db.clear();

    DateTime dateTime = DateTime.parse("2019-08-06");
    Task t = new Task(
      id: 1,
      name: "test task",
      notes: "a note",
      date: dateTime.millisecondsSinceEpoch,
      startTime: dateTime.millisecondsSinceEpoch,
      endTime: dateTime.millisecondsSinceEpoch + 1000,
    );
    db.insertTask(t);
    List<Task> result = await db.queryDate(DateTime.parse("2019-08-06"));
    expect(result.length, 1);
    expect(result[0].status, Status.incomplete);
  });

  test('Insert single, update', () async {
    final DatabaseWrapper db = DatabaseWrapper.instance;
    db.clear();

    DateTime dateTime = DateTime.parse("2019-08-06");
    Task t = new Task(
      id: 1,
      name: "test task",
      notes: "a note",
      date: dateTime.millisecondsSinceEpoch,
      startTime: dateTime.millisecondsSinceEpoch,
      endTime: dateTime.millisecondsSinceEpoch + 1000,
    );

    DateTime newDateTime = DateTime.parse("2019-09-06");
    Task newTask = new Task(
      id: 1,
      name: "new test task",
      notes: "a new note",
      date: newDateTime.millisecondsSinceEpoch,
      startTime: newDateTime.millisecondsSinceEpoch,
      endTime: newDateTime.millisecondsSinceEpoch + 1000,
    );

    db.insertTask(t);
    db.updateTask(newTask);

    List<Task> originalDateResult =
        await db.queryDate(DateTime.parse("2019-08-06"));
    expect(originalDateResult.length, 0);

    List<Task> newDateResult = await db.queryDate(DateTime.parse("2019-09-06"));
    expect(newDateResult.length, 1);
    expect(newDateResult[0].name, "new test task");
  });

  test('Insert single, delete', () async {
    final DatabaseWrapper db = DatabaseWrapper.instance;
    db.clear();

    DateTime dateTime = DateTime.parse("2019-08-06");
    Task t = new Task(
      id: 1,
      name: "test task",
      notes: "a note",
      date: dateTime.millisecondsSinceEpoch,
      startTime: dateTime.millisecondsSinceEpoch,
      endTime: dateTime.millisecondsSinceEpoch + 1000,
    );
    db.insertTask(t);
    db.deleteTask(t);
    List<Task> result = await db.queryDate(DateTime.parse("2019-08-06"));
    expect(result.length, 0);
  });

  test('Insert no id, query and get id', () async {
    final DatabaseWrapper db = DatabaseWrapper.instance;
    db.clear();

    DateTime dateTime = DateTime.parse("2019-08-06");
    Task t = new Task(
      name: "test task",
      notes: "a note",
      date: dateTime.millisecondsSinceEpoch,
      startTime: dateTime.millisecondsSinceEpoch,
      endTime: dateTime.millisecondsSinceEpoch + 1000,
    );
    db.insertTask(t);
    List<Task> result = await db.queryDate(DateTime.parse("2019-08-06"));
    expect(result[0].id, 1);
  });

  test('Insert multiple, query order by end time', () async {
    final DatabaseWrapper db = DatabaseWrapper.instance;
    db.clear();

    DateTime dateTime = DateTime.parse("2019-08-06");
    Task taskA = new Task(
      name: "task A",
      notes: "a note",
      date: dateTime.millisecondsSinceEpoch,
      startTime: dateTime.millisecondsSinceEpoch,
      endTime: dateTime.millisecondsSinceEpoch + 1000,
    );
    Task taskB = new Task(
      name: "task B",
      notes: "a note",
      date: dateTime.millisecondsSinceEpoch,
      startTime: dateTime.millisecondsSinceEpoch,
      endTime: dateTime.millisecondsSinceEpoch + 2000,
    );
    db.insertTask(taskA);
    db.insertTask(taskB);
    List<Task> result = await db.queryDate(DateTime.parse("2019-08-06"));
    expect(result.length, 2);
    expect(result[0].name, "task A");
    expect(result[1].name, "task B");
  });
}
