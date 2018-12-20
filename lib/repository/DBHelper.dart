import 'dart:async';
import 'package:check_yourself/repository/models/Task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT, max_count INTEGER, current_count INTEGER, last_update TEXT )");
  }

  Future<List<Task>> getTasks() async {
    var dbClient = await db;
    List<Map> map = await dbClient.rawQuery('SELECT * FROM Tasks');
    List<Task> item = new List();
    for (int i = 0; i < map.length; i++) {
      item.add(new Task(
          id: map[i]["id"],
          currentCount: map[i]["current_count"],
          maxCount: map[i]["max_count"],
          title: map[i]["title"],
          description: map[i]["description"],
          lastUpdate: map[i]["last_update"]));
    }
    return item;
  }

  void saveTask(Task task) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO Tasks(max_count, current_count, title, description, last_update ) VALUES(' +
              '\'' +
              '${task.maxCount}' +
              '\'' +
              ',' +
              '\'' +
              '${task.currentCount}' +
              '\'' +
              ',' +
              '\'' +
              task.title +
              '\'' +
              ',' +
              '\'' +
              task.description +
              '\'' +
              ',' +
              '\'' +
              task.lastUpdate +
              '\'' +
              ')');
    });
  }

  void updateTask(Task task) async {
    var dbClient = await db;
      await dbClient.rawUpdate(
          'UPDATE Tasks SET current_count = \'${task.currentCount}\', last_update = \'${task.lastUpdate}\' WHERE id = \'${task.id}\';');
  }

  void deleteTask(Task task) async {
    var dbClient = await db;
      await dbClient.rawDelete(
          'DELETE FROM Tasks WHERE id = "${task.id}";');
  }
}
