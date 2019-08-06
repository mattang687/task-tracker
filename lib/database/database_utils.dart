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

  // create the tables
  Future _onCreate(Database db, int version) async {
    // create tasks table
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        notes TEXT,
        time INTEGER,
        repeatInterval INTEGER,
        weekday INTEGER, 
        day INTEGER,
        month INTEGER,
        year INTEGER
      )
    ''');
    // create repeat exceptions table
    await db.execute('''
    CREATE TABLE repeatExceptions (
      id INTEGER PRIMARY KEY,
      date INTEGER,
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

  // insert exception
  Future<int> _insertException(int id, int time) async {
    Database db = await instance.database;

    return await db.insert(
      'repeatExceptions',
      {
        "id": id,
        "date": time,
      },
    );
  }

  // query tasks on provided day
  Future<List<Task>> queryDate(DateTime dateTime) async {
    Database db = await instance.database;

    // select tasks that occur on the provided day that do not have an exception
    final List<Map<String, dynamic>> taskMaps = await db.rawQuery('''
      SELECT * 
      FROM tasks 
      RIGHT JOIN repeatExceptions 
      on repeatExceptions.id = tasks.id 
      WHERE (tasks.weekday IS NULL OR weekday = ${dateTime.weekday}) AND 
            (tasks.day IS NULL OR day = ${dateTime.day}) AND 
            (tasks.month IS NULL OR month = ${dateTime.month}) AND 
            (tasks.year IS NULL OR year = ${dateTime.year}) AND
            (repeatExceptions.date != ${dateTime.millisecondsSinceEpoch})
      ''');

    // transform into a list of tasks
    return List.generate(taskMaps.length, (i) {
      return Task.fromMap(taskMaps[i]);
    });
  }

  // update task
  // if the task has wildcards, create a new task and add a repeat exception
  Future<void> updateTask(Task task) async {
    final db = await instance.database;
    if (task.isRepeated()) {
      // is repeated, create task and add exception
      await insertTask(task);
      await _insertException(task.id, task.time);
    } else {
      // is not repeated, update normally
      await db.update(
        'tasks',
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    }
  }

  // delete task with sepecified id or adds exception if the task is repeated
  Future<void> deleteTask(Task task) async {
    Database db = await instance.database;
    if (task.isRepeated()) {
      _insertException(task.id, task.time);
    } else {
      db.delete('tasks', where: 'id = ?', whereArgs: [task.id]);
    }
  }

  // delete repeated task
  Future<void> deleteRepeatedTask(Task task) async {
    Database db = await instance.database;
    if (task.isRepeated()) {
      db.delete('tasks', where: 'id = ?', whereArgs: [task.id]);
    }
  }
}
