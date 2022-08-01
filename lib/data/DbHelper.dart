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

  static const String databaseName = "tasks";
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
    String databaseName = "tasks.db";
    String fullpath = join(databasepath, databaseName);
    database = await openDatabase(
      fullpath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
CREATE TABLE $tabelName2 (
  $typeId INTEGER PRIMARY KEY AUTOINCREMENT,
  $typeTitle Text,

  )
''');
        db.execute('''

CREATE TABLE $tabelName (
  $taskId INTEGER PRIMARY KEY AUTOINCREMENT,
  $taskName TEXT,
  $typeId INTEGER,
  $taskDes TEXT,
  $taskdate DATE,
  $taskIsComplete INTEGER,
   FOREIGN KEY ($typeId) REFERENCES $tabelName2($typeId)
  )

''');
        db.execute('''
 $taskId INTEGER PRIMARY KEY AUTOINCREMENT,
 $typeId INTEGER PRIMARY KEY AUTOINCREMENT,
  FOREIGN KEY ($taskId) REFERENCES $tabelName($taskId)
   FOREIGN KEY ($typeId) REFERENCES $tabelName2($typeId)
''');
      },
      onOpen: (db) async {
        final tables =
            await db.rawQuery("Select name from sqlite_master order by name;");
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
    print("asdfasdfasdfsadfasdf $allTasks");
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

  // ignore: non_constant_identifier_names
  UpdateComplete(TaskModel taskModel) async {
    int count = await database!.update(tabelName, taskModel.toMap(),
        where: "$taskId=?", whereArgs: [taskModel.id]);
    print(count);
  }

   getAllCount() async {
    
    var x = await database!.rawQuery('SELECT COUNT (*)as count from $tabelName ');  print(x[0]["count"]);
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
}
