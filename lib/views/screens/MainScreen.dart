import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:secproject/data/DbHelper.dart';
import 'package:secproject/models/task_model.dart';
import 'package:secproject/providers/Dbprovider.dart';
import 'package:secproject/views/screens/AllTasks.dart';
import 'dart:math' as math;
import 'package:secproject/views/screens/addTask.dart';
import 'package:secproject/views/widgets/widget1.dart';
import 'package:secproject/views/widgets/widget2.dart';
import 'package:sqflite/sqflite.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  List<TaskModel> tasks = [];
  @override
  void initState() {
    super.initState();
   
  }

  String name = "Oday";
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,actions: [
            IconButton(
                onPressed: () {
                  if (context.locale.toString() == "AR") {
                    context.setLocale(Locale("en"));
                  } else {
                    context.setLocale(Locale("AR"));
                  }
                },
                icon: Icon(Icons.language))
          ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Oday Mutlak"),
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 148, 236, 251)),
              accountEmail: Text("oabumutlak@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/WorkDannyJones.png"),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(
                  context,
                );
              },
              subtitle: Text("Go to home"),
              title: Text("Home"),
            ),
            ListTile(
              leading: const Icon(Icons.add_task),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(
                  context,
                );
              },
              subtitle: Text("Add Tasks"),
              title: Text("New Task"),
            ),
            ListTile(
              leading: const Icon(Icons.task),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(
                  context,
                );
              },
              subtitle: Text("Go to Tasks"),
              title: Text("Completed Tasks"),
            ),Spacer(),
            Text("Version: 1.1.0",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),SizedBox(height: 30.h,)
          ],
        ),
      ),
     
     
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.png"),
            opacity: 0.8,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 50.w, top: 10),
              padding: EdgeInsets.only(top: 70.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Hey ".tr() + name,
                        style: TextStyle(
                            fontSize: 36.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 130.w,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTask(),
                                ));
                          },
                          icon: Image.asset("assets/images/add.png"))
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Today you have " "${Provider.of<DBProvider>(context).count}" " Tasks",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.h),
                    child: Row(
                      children: [
                        GestureDetector(
                         onTap:() {
                           
                         Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllTasks(
                                          Tasks: tasks,
                                          )));
                                          },
                          child: Container(
                            width: 120.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.amber.withOpacity(0.5)),
                            child: Column(
                              children: [
                                Text("16"),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text("Tasks Created".tr())
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80.w,
                        ),
                        Container(
                          width: 120.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromARGB(255, 187, 0, 255)
                                  .withOpacity(0.5)),
                          child: Column(
                            children: [
                              Text("12"),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("Tasks Left".tr())
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 2,
                        width: 318.w,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Wiget1("Work", 7),
                      SizedBox(
                        width: 20.w,
                      ),
                      Wiget1("Personal", 2)
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Wiget1("Shopping", 2),
                      SizedBox(
                        width: 20.w,
                      ),
                      Wiget1("Health", 2)
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 18),
              child: SizedBox(
                height: 400.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                        
                          widget2("Do yoga", "15 minutes")
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                  
                    ],
                  ),
                ),
              ),
            )
            // ListView.builder(itemBuilder:  (context, index) {
          ],
        )),
      ),
    );
  }
}

