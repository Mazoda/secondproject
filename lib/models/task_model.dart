import 'package:secproject/data/DbHelper.dart';
class TaskModel {
  
  int? id;
  String? taskType;
  String? Name;
  bool? isComplete;
  String? description;
  String? date;
  TaskModel({
    this.taskType,
    required this.Name,
    this.isComplete = false,
    required this.description,
    required this.date
  });
  TaskModel.fromMap(Map<String, dynamic> json){
    id = json[DbHelper.taskId];
    Name = json[DbHelper.taskName];
    isComplete = json[DbHelper.taskIsComplete] == 1 ? true : false;
    description=json[DbHelper.taskDes];
    taskType=json[DbHelper.taskType];
    date= json[DbHelper.taskdate];

   
  }

  copy(int id) {
    this.id = id;
  }

  Map<String, dynamic> toMap() {
    return  {
      DbHelper.taskType:taskType,
      DbHelper.taskName: Name,
      DbHelper.taskIsComplete: isComplete! ? 1 : 0,
      DbHelper.taskDes:description,
      DbHelper.taskdate:date,
    };
  }

  void ChangeIsComplete() {
       this.isComplete = !this.isComplete!;
  }
}