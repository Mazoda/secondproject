import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secproject/models/task_model.dart';
import 'package:secproject/views/widgets/fulltask.dart';

class widget2 extends StatelessWidget {
   colorss(TaskModel taskModel) {
    switch (taskModel.taskType) {
      case "Work":
        return Colors.blue;
      case "Personal":
        return Colors.teal;
      case "Shopping":
        return Colors.purple;
      case "Health":
        return Colors.red;
      case "Others":
        return Colors.purple.shade900;
    }
  }
  TaskModel taskModel;

  widget2(this.taskModel);
  @override
  Widget build(BuildContext context) {
    Color random = Color((math.Random().nextDouble() * 0xFFFFFF).toInt());
    return  Stack(children: [
        Column(
          children: [
            Row(
              children: [
                Text("${taskModel.date}", style: TextStyle(fontSize: 20)),
                SizedBox(
                  width: 10.w,
                ),Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color:
                              Color.fromARGB(255, 0, 60, 255).withOpacity(0.06),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0.0, 0.75) // changes position of shadow
                          ),
                    ],
                  ),
                  width: 290.w,
                  height: 90.h,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20.w, top: 15.h),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("${taskModel.Name}",
                                style: TextStyle(fontSize: 20.sp))),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.w, top: 10.h),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("${taskModel.description}",
                                style: TextStyle(fontSize: 18.sp))),
                      ),
                    ],
                  ),
                ),SizedBox(width: 30.w,),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
        Positioned(
            right: 80.w,
            top: 40.h,
            child: Container(
                width: 10.w,
                height: 10.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(360),
                  color:colorss(taskModel)
                ))),
      ],
    );
  }
}
