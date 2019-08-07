import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'task.dart';

class DatabaseUtils {
  static final _databaseName = "Database.db";
  static final _databaseVersion = 1;

  // singleton class
  DatabaseUtils._privateConstructor();
  static final DatabaseUtils instance = DatabaseUtils._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open database or create if it doesn't exist
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    if (documentsDirectory == null) print("DOC DIR NULL");
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // create task table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        notes TEXT,
        date INTEGER,
        startTime INTEGER,
        endTime INTEGER
      )
    ''');
  }

  // insert a task
  Future<int> insertTask(Task t) async {
    Database db = await instance.database;
    try {
      return await db.insert('tasks', t.toMap());
    } catch (e) {
      return null;
    }
  }

  // query tasks on provided day
  // dateTime should be day at 00:00
  Future<List<Task>> queryDate(DateTime dateTime) async {
    Database db = await instance.database;

    // select tasks that start on the provided day
    final List<Map<String, dynamic>> taskMaps = await db.query(
      'tasks',
      where: 'date = ?',
      whereArgs: [dateTime.millisecondsSinceEpoch],
      orderBy: 'endTime',
    );

    // turn maps into tasks
    return List.generate(
      taskMaps.length,
      (index) => Task.fromMap(taskMaps[index]),
    );
  }

  // update task
  Future<void> updateTask(Task newTask) async {
    final db = await instance.database;
    await db.update(
      'tasks',
      newTask.toMap(),
      where: 'id = ?',
      whereArgs: [newTask.id],
    );
  }

  // delete task
  Future<void> deleteTask(Task task) async {
    Database db = await instance.database;
    db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // clear the database
  Future<void> clear() async {
    Database db = await instance.database;
    db.delete('tasks');
  }
}
