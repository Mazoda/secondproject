import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';

class widget2 extends StatelessWidget {
  String? taskType;
  String? caption;
  widget2(this.taskType, this.caption);
  @override
  Widget build(BuildContext context) {
    Color random = Color((math.Random().nextDouble() * 0xFFFFFF).toInt());
    return Stack(children: [
      Column(
        children: [
          Row(
            children: [
              Text("8:00 AM", style: TextStyle(fontSize: 20)),
              SizedBox(
                width: 10,
              ),
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
                width: 270.w,
                height: 90.h,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.w, top: 15.h),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("$taskType".tr(),
                              style: TextStyle(fontSize: 20.sp))),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.w, top: 10.h),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("$caption".tr(),
                              style: TextStyle(fontSize: 18.sp))),
                    ),
                  ],
                ),
              ),
              Positioned(
                  right: 20,
                  top: 10.h,
                  child: Container(
                      width: 10.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        color: Colors.black.withOpacity(0.4),
                      ))),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    ]);
  }
}
