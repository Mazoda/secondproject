
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math'as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
class Wiget1 extends StatelessWidget {
  colorss(Value) {
    Color random = Color((math.Random().nextDouble() * 0xFFFFFF).toInt());
    switch (Value) {
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
      default:
        return random;
    }
  }

  String? taskType;
  int? num;
  Wiget1(this.taskType, this.num);
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 0, 60, 255).withOpacity(0.06),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0.0, 0.75) // changes position of shadow
                ),
          ],
        ),
        width: 150.w,
        height: 90.h,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.w, top: 15.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("$taskType".tr(),
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold))),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.w, top: 10.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("$num Tasks".tr(),
                      style: TextStyle(fontSize: 18.sp))),
            ),
          ],
        ),
      ),
      Positioned(
          left: 120.w,
          top: 10.h,
          child: Container(
              width: 10.w,
              height: 10.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                color: colorss(taskType),
              ))),
    ]);
  }
}