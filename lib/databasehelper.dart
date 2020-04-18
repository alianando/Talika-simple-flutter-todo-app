import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbTaskManager {
  Database _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), "tk3.db"),
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            "CREATE TABLE task(id INTEGER PRIMARY KEY autoincrement, name TEXT, color TEXT)",
          );
        },
      );
    }
  }

  Future<int> insertTask(Task task) async {
    await openDb();
    return await _database.insert(
      'task',
      task.toMap(),
    );
  }

  //Get a list of the tasks
  Future<List<Task>> getTaskList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('task');
    return List.generate(
      maps.length,
      (i) {
        return Task(
          id: maps[i]['id'],
          name: maps[i]['name'],
          color: maps[i]['color'],
        );
      },
    );
  }

  //update method

  Future<int> updateTask(Task task) async {
    await openDb();
    return await _database.update(
      'task',
      task.toMap(),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

  // delete method

  Future<void> deleteTask(int id) async {
    await openDb();
    await _database.delete('task', where: "id = ?", whereArgs: [id]);
  }
}

class Task {
  int id;
  String name;
  String color;

  Task({@required this.name, @required this.color, this.id});
  Map<String, dynamic> toMap() {
    return {'name': name, 'color': color};
  }


}
