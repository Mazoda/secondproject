import 'dart:ffi';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'package:secproject/models/task_model.dart';

class Task extends StatelessWidget {
  TaskModel taskmodel;
  Task(this.taskmodel);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
      ),
      height: 82.h,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0),
          border: const Border(
            bottom: BorderSide(color: Colors.grey, width: 0.2),
          )),
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Container(
                width: 30.w,
                height: 30.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/edit.png"),
                    opacity: 0.5,
                    fit: BoxFit.cover,
                  ),
                )),
            SizedBox(
              width: 30.w,
            ),
            Column(
              children: [
                Container(
                  width: 300.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(taskmodel.Name!,
                        style: GoogleFonts.cairo(
                          fontSize: 20.sp,
                        )),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  width: 300.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      taskmodel.description!.substring(0, 10) + "...",
                      style: GoogleFonts.cairo(fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                right: 20,
                child: Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      color: Colors.pink,
                    ))),
          ],
        ),
      ),
    );
  }
}
