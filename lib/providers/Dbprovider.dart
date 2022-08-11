import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secproject/data/DbHelper.dart';
import 'package:secproject/models/task_model.dart';

class DBProvider extends ChangeNotifier {
  TimeOfDay selectedTime = TimeOfDay.now();
  // TaskModel? taskModel;
  String type = "";
  List<TaskModel> specificWork = [];
  List<TaskModel> specificPersonal = [];
  List<TaskModel> specificShopping = [];
  List<TaskModel> specificOther = [];

  List<TaskModel> allTasks = [];
  List<TaskModel> CompleteTasks = [];
  List<TaskModel> InCompleteTasks = [];
  int count = 0;
  int leftCounter = 0;
  int workC = 0;
  int shopping = 0;
  int sports = 0;
  int others = 0;
  int personal = 0;

  DBProvider() {
    selectAllTasks();
  }
  fillTasks(
    List<TaskModel> allTasks,
    List<TaskModel> completeTasks,
    List<TaskModel> inCompleteTask,
     List<TaskModel> specificWork,
     List<TaskModel> specificPersonal,
     List<TaskModel> specificShopping,
     List<TaskModel> specificOther,
    // List<TaskModel> specific,
    int count,
    int leftCounter,
    int workC,
    int shopping,
    int sports,
    int others,
    int personal,
  ) {
    this.allTasks = allTasks;
    CompleteTasks = completeTasks;
    InCompleteTasks = inCompleteTask;
    this.count = count;
    this.leftCounter = leftCounter;
    this.workC = workC;
    this.shopping = shopping;
    this.sports = sports;
    this.others = others;
    this.personal = personal;
    this.specificWork=specificWork;
    this.specificPersonal=specificPersonal;
    this.specificShopping=specificShopping;
    this.specificOther=specificOther;

    // this.specific = specific;
    notifyListeners();
  }

  insertOneTask(TaskModel taskModel) async {
    await DbHelper.dbHelper.insertOneTask(taskModel);
    selectAllTasks();
  }

  selectSpecific(String type) async {
    await DbHelper.dbHelper.speceficType(type);
    selectAllTasks();
  }

  selectTime(var time) async {
    selectedTime = time;
    notifyListeners();
  }

  selectAllTasks() async {
    List<TaskModel> allTasks = await DbHelper.dbHelper.selectAllTask();
    List<TaskModel> allCompleteTasks =
        await DbHelper.dbHelper.selectCompletedTasks();
    List<TaskModel> allInCompleteTasks =
        await DbHelper.dbHelper.selectIncompletedTasks();
    int counter = await DbHelper.dbHelper.getAllCount();
    int leftCounter = await DbHelper.dbHelper.getleftCount();
    int work = await DbHelper.dbHelper.getWorkCount();
    int shopping = await DbHelper.dbHelper.getShopCount();
    int others = await DbHelper.dbHelper.getOtherCount();
    int personal = await DbHelper.dbHelper.getPersonalCount();
    int sports = await DbHelper.dbHelper.getSportsCount();
    List<TaskModel> workList = await DbHelper.dbHelper.getWorkTasks();
    List<TaskModel> personalList = await DbHelper.dbHelper.getPersonalTasks();
    List<TaskModel> shoppingList = await DbHelper.dbHelper.getShoppingTasks();
    List<TaskModel> othersList = await DbHelper.dbHelper.getOthersTasks();

    // List<TaskModel> specific = await DbHelper.dbHelper.speceficType(type);
    fillTasks(allTasks, allCompleteTasks, allInCompleteTasks, workList,personalList,shoppingList,othersList,counter,
        leftCounter, work, shopping, sports, others, personal);
  }

  updateTask(TaskModel taskModel) async {
    await DbHelper.dbHelper.updateTask(taskModel);
    selectAllTasks();
  }

  deleteTasks(TaskModel taskModel) async {
    await DbHelper.dbHelper.deleteTask(taskModel.id!);
    selectAllTasks();
  }
}
