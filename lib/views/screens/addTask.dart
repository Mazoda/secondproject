import 'dart:developer';
import 'dart:ffi';
import 'package:easy_localization/easy_localization.dart';
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
  TimeOfDay selectedTime = TimeOfDay.now();

  GlobalKey<FormState> registerKey = GlobalKey();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDate = TextEditingController();
  TextEditingController taskType = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  List<String> itemsDropDown = [
    'Personal',
    'Work',
    'Shopping',
    'Sports',
    'Others',
  ];
  String? selectedItem;
  @override
  void initState() {
    super.initState();
    selectedItem = itemsDropDown[0];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: registerKey,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              image: const DecorationImage(
                image: AssetImage("assets/images/back3.png"),
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
                margin: EdgeInsets.only(left: 10.w, right: 10),
                child: Center(
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: taskNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is required".tr();
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Name".tr(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton(
                          onPressed: () async {
                            selectedTime = (await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                              
                            ))!;
                            Provider.of<DBProvider>(context, listen: false).selectTime(selectedTime);
                            // date =
                            //   await  Provider.of<DBProvider>(context, listen: false)
                            //         .selectTime(context);
                            // DateTime now = DateTime.now();
                            // DatePicker.showDatePicker(context,
                            //     showTitleActions: true,
                            //     minTime: DateTime(now.hour, now.minute),
                            //     maxTime: DateTime(now.hour, now.minute),
                            //     onChanged: (date) {
                            //   print('change $date');
                            // }, onConfirm: (date) {
                            //   print('confirm $date');
                            // },
                            //     currentTime: DateTime.now(),
                            //     locale: LocaleType.en);
                          },
                          child: Text(
                            'Choose time'.tr(),
                            style: TextStyle(color: Colors.blue),
                          )),
                      Container(
                        child: Text(
                            "${Provider.of<DBProvider>(context).selectedTime.hour}:${Provider.of<DBProvider>(context).selectedTime.minute}"),
                      ),
                      DropdownButtonHideUnderline(
                          child: DropdownButton<dynamic>(
                        value: selectedItem,
                        items: [
                          ...itemsDropDown
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList()
                        ],
                        onChanged: (value) {
                          selectedItem = value;
                          setState(() {});
                        },
                      )),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: taskDescription,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is required".tr();
                          } else if (value.length <= 10) {
                            return "Description must be larger than 10".tr();
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.description_outlined),
                            hintText: "Description".tr(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),maxLines: 10,
                      ),
                      SizedBox(
                        height: 150.h,
                      ),
                      ElevatedButton(style:ElevatedButton.styleFrom(primary: Colors.deepPurple) ,
                          onPressed: () async {
                            if (registerKey.currentState!.validate()) {
                              await Provider.of<DBProvider>(context,
                                      listen: false)
                                  .insertOneTask(TaskModel(
                                      Name: taskNameController.text,
                                      description: taskDescription.text,
                                      taskType: selectedItem,
                                      date:
                                          "${selectedTime.hour}:${selectedTime.minute}"));

                              Navigator.pop(context);
                            }
                          },
                          child: Text("Add Task".tr())),
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
