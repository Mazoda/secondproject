import 'dart:developer';
import 'package:secproject/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();
  Database? database;

  static const String tabelName2 = "tasktype";
  static const String typeTitle = "type_Title";
  static const String typeId = "type_Id";

  static const String tabelName = "tasks";
  static const String taskId = "task_id";
  static const String taskName = 'task_name';
  static const String taskType = "task_type";
  static const String taskIsComplete = "task_completed";
  static const String taskDes = 'task_desccription';
  static const String taskdate = 'task_date';

  initDataBase() async {
    database = await ceateDataBaseConnection();
  }

  Future<Database?> ceateDataBaseConnection() async {
    String databasepath = await getDatabasesPath();
    String databaseName = "tasks11.db";
    String fullpath = join(databasepath, databaseName);
    database = await openDatabase(
      fullpath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''

CREATE TABLE $tabelName (
  $taskId INTEGER PRIMARY KEY AUTOINCREMENT,
  $taskName TEXT,
  $taskDes TEXT,
  $taskdate STRING,
  $taskIsComplete INTEGER,
  $taskType TEXT
  )

''');
      },
      onOpen: (db) async {
        _onOpen(db);
      },
    );
    return database;
  }

  _onOpen(Database db) {
    log("Database opened  ${db.toString()} ");
  }

  insertOneTask(TaskModel taskModel) async {
    int id = await database!.insert(tabelName, taskModel.toMap());
    taskModel.copy(id);
  }

  Future<List<TaskModel>> selectAllTask() async {
    List allTasks = await database!.query(tabelName);
    return allTasks.map((e) {
      return TaskModel.fromMap(e);
    }).toList();
  }

  Future<List<TaskModel>> selectOneTask() async {
    List allTasks = await database!
        .query(tabelName, where: "$taskId=?", whereArgs: ["$taskId"]);
        print(allTasks);
    return allTasks.map((e) {
      return TaskModel.fromMap(e);
    }).toList();

  }

  Future<List<TaskModel>> speceficType(String name) async {
    List allTasks = await database!
        .query(tabelName, where: "$taskType=?", whereArgs: [name]);
    return allTasks.map((e) {
      return TaskModel.fromMap(e);
    }).toList();
  }

  Future<List<TaskModel>> selectCompletedTasks() async {
    List allTasks =
        await database!.query(tabelName, where: '$taskIsComplete=1');

    return allTasks.map((e) {
      return TaskModel.fromMap(e);
    }).toList();
  }

  Future<List<TaskModel>> selectIncompletedTasks() async {
    List allTasks =
        await database!.query(tabelName, where: '$taskIsComplete=0');

    return allTasks.map((e) {
      return TaskModel.fromMap(e);
    }).toList();
  }


  updateTask(TaskModel taskModel) async {
    print("id======"+taskModel.id.toString());
    int x= await database!.update(tabelName, taskModel.toMap(),
        where: "$taskId=?", whereArgs: [taskModel.id]);
        print("================="+x.toString());
  }

  getAllCount() async {
    var x =
        await database!.rawQuery('SELECT COUNT (*)as count from $tabelName ');
    return x[0]["count"];
  }

  getleftCount() async {
    var x = await database!.rawQuery(
        'SELECT COUNT (*)as count from $tabelName where $taskIsComplete=1 ');
    return x[0]["count"];
  }

  getWorkCount() async {
    var x = await database!.rawQuery(
        'SELECT COUNT (*)as count from $tabelName where $taskType="Work" ');
    return x[0]["count"];
  }

  getPersonalCount() async {
    var x = await database!.rawQuery(
        'SELECT COUNT (*)as count from $tabelName where $taskType="Personal" ');
    print(x[0]["count"]);
    return x[0]["count"];
  }

  getShopCount() async {
    var x = await database!.rawQuery(
        'SELECT COUNT (*)as count from $tabelName where $taskType="Shopping" ');
    return x[0]["count"];
  }

  getSportsCount() async {
    var x = await database!.rawQuery(
        'SELECT COUNT (*)as count from $tabelName where $taskType="Sports" ');
    return x[0]["count"];
  }

  getOtherCount() async {
    var x = await database!.rawQuery(
        'SELECT COUNT (*)as count from $tabelName where $taskType="Others" ');
    return x[0]["count"];
  }

  Future<int?> getincompleteCount() async {
    var x = await database!
        .rawQuery('SELECT COUNT (*) from $tabelName where $taskIsComplete=0');
    int? count = Sqflite.firstIntValue(x);
    return count;
  }

  Future<int?> gettaskCount() async {
    var x = await database!
        .rawQuery('SELECT COUNT (*) from $tabelName where $taskIsComplete=0');
    int? count = Sqflite.firstIntValue(x);
    return count;
  }

  deleteTask(int id) async {
    await database!.delete(tabelName, where: "$taskId=?", whereArgs: [id]);
    selectAllTask();
  }
  getWorkTasks() async{
     List allTasks =
        await database!.query(tabelName, where: '$taskType=?',whereArgs: ['Work']);
  print("========================-=-="+allTasks.toString());
    return allTasks.map((e) {
      return TaskModel.fromMap(e);
    }).toList();
  }
    getPersonalTasks() async{
     List allTasks =
        await database!.query(tabelName, where: '$taskType=?',whereArgs: ['Personal']);

    return allTasks.map((e) {
      return TaskModel.fromMap(e);
    }).toList();
  }

    getShoppingTasks() async{
     List allTasks =
        await database!.query(tabelName, where: '$taskType=?',whereArgs: ['Shopping']);

    return allTasks.map((e) {
      return TaskModel.fromMap(e);
    }).toList();
  }
  getOthersTasks() async{
     List allTasks =
        await database!.query(tabelName, where: '$taskType=?',whereArgs: ['Others']);

    return allTasks.map((e) {
      return TaskModel.fromMap(e);
    }).toList();
  }
}
