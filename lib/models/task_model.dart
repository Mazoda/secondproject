import 'package:secproject/data/DbHelper.dart';
class TaskModel {

  int? id;
  String? taskType;
  String? Name;
  bool? isComplete;
  String? description;
  DateTime? date;
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
  }

  copy(int id) {
    this.id = id;
  }

  Map<String, dynamic> toMap() {
    return  {
      DbHelper.taskName: Name,
      DbHelper.taskIsComplete: isComplete! ? 1 : 0,
      DbHelper.taskDes:description,
      DbHelper.taskdate:"${date!.hour} : ${date!.minute}"
    };
  }

  void ChangeIsComplete() {}
}