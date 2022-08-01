import 'package:flutter/cupertino.dart';
import 'package:secproject/data/DbHelper.dart';
import 'package:secproject/models/task_model.dart';

class DBProvider extends ChangeNotifier {
  List<TaskModel> allTasks = [];
  List<TaskModel> CompleteTasks = [];
  List<TaskModel> InCompleteTasks = [];
  int count = 0;
  DBProvider() {
    selectAllTasks();
  }
  fillTasks(List<TaskModel> allTasks, List<TaskModel> completeTasks,
      List<TaskModel> inCompleteTask,int count) {
    this.allTasks = allTasks;
    this.CompleteTasks = completeTasks;
    this.InCompleteTasks = inCompleteTask;
    this.count=count;
    notifyListeners();
  }

  insertOneTask(TaskModel taskModel) async {
    await DbHelper.dbHelper.insertOneTask(taskModel);
    selectAllTasks();
  }

  selectAllTasks() async {
    List<TaskModel> allTasks = await DbHelper.dbHelper.selectAllTask();
    List<TaskModel> allCompleteTasks =
        await DbHelper.dbHelper.selectCompletedTasks();
    List<TaskModel> allInCompleteTasks =
        await DbHelper.dbHelper.selectIncompletedTasks();
    int counter= DbHelper.dbHelper.getAllCount();
    fillTasks(allTasks, allCompleteTasks, allInCompleteTasks,counter);
  }

  updateComplete(TaskModel taskModel) async {
    taskModel.ChangeIsComplete();
    await DbHelper.dbHelper.UpdateComplete(taskModel);
    selectAllTasks();
  }

  deleteTasks(TaskModel taskModel) async {
    await DbHelper.dbHelper.deleteTask(taskModel.id!);
    selectAllTasks();
  }

}
