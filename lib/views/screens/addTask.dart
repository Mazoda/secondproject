import 'dart:developer';
import 'dart:ffi';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:secproject/data/DbHelper.dart';
import 'package:secproject/models/task_model.dart';
import 'package:secproject/providers/Dbprovider.dart';



class AddTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddTaskState();
  }
}

class AddTaskState extends State<AddTask> {
  GlobalKey<FormState> registerKey = GlobalKey();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDate = TextEditingController();
  TextEditingController taskType = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: registerKey,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              image:const DecorationImage(
                image: AssetImage("assets/images/backg.png"),
                opacity: 0.8,
                fit: BoxFit.cover,
              )),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20.w),
                  padding: EdgeInsets.only(top: 50.h),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w,right: 10),
                child: Center(
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: taskNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is required";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton(
                          onPressed: () {
                            DateTime now = DateTime.now();
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(now.year, now.month, now.day,
                                    now.hour, now.minute),
                                maxTime: DateTime(
                                    now.year + 4,
                                    now.month,
                                    now.day,
                                    now.hour,
                                    now.minute), onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                              print('confirm $date');
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Text(
                            'Choose date and time',
                            style: TextStyle(color: Colors.blue),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 20.w, left: 20.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "Work",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20.sp),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                  width: 100.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 119, 168, 171),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "Personal",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20.sp),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                  width: 100.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "Shopping",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20.sp),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "Health",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20.sp),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Container(
                                  width: 100.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 88, 28, 99),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "Other",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20.sp),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Image.asset(
                                  "assets/images/addW.png",
                                  width: 40.w,
                                  height: 40.h,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: taskDescription,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is required";
                          }else if(value.length<=10){
                            return" description must be larger than 10";
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.description_outlined),
                            hintText: "Description...",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 300.h,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (registerKey.currentState!.validate()) {
                              await Provider.of<DBProvider>(context).insertOneTask(TaskModel(
                                  Name: taskNameController.text,
                                  description: taskDescription.text,
                                  date: DateTime.now())
                                  
                                  );

                              Navigator.pop(context);

                           
                            }
                          },
                          child: Text("Add Task")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
