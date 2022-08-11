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
import 'package:secproject/views/screens/specificScreen.dart';
// import 'package:secproject/views/screens/specificScreen.dart';
import 'package:secproject/views/widgets/fulltask.dart';
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
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                if (context.locale.toString() == "ar") {
                  context.setLocale(Locale("en"));
                } else {
                  context.setLocale(Locale("ar"));
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
              subtitle: Text("Go to home".tr()),
              title: Text("Home".tr()),
            ),
            ListTile(
              leading: const Icon(Icons.add_task),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTask()),
                );
              },
              subtitle: Text("Add Tasks".tr()),
              title: Text("New Task".tr()),
            ),
            ListTile(
              leading: const Icon(Icons.task),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllTasks(
                            Tasks: tasks,
                          )),
                );
              },
              subtitle: Text("Go to Tasks".tr()),
              title: Text("All tasks".tr()),
            ),
            Spacer(),
            Text(
              "Version".tr() + ": 1.1.0",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.h,
            )
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
              margin:(context.locale.toString() == "en")?  EdgeInsets.only(left: 50.w, top: 80.h):EdgeInsets.only(right: 20.w, top: 80.h),

              // padding: EdgeInsets.only(top: 70.h),
              child: Column(
                children: [
                  Container(
                    margin:  EdgeInsets.only(right:(context.locale.toString() == "en")?10.w:10.w),
                    child: Row(
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
                  ),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     "Today you have " "${Provider.of<DBProvider>(context).count}" " Tasks",
                  //     textAlign: TextAlign.start,
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(top: 30.h,right: (context.locale.toString() == "en")?0.w:20.w),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
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
                                Text(
                                    "${Provider.of<DBProvider>(context).count}"),
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
                              Text("${Provider.of<DBProvider>(context).count}"),
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
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 30,right:(context.locale.toString() == "en")? 50.w:0.w),
                        height: 2,
                        width: 318.w,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    width: 400.w,
                    // margin: EdgeInsets.symmetric(horizontal: 20.w),
                    margin: EdgeInsets.only(right: 20.w),
                    child: Column(children: [
                      Row(
                        children: [
                          GestureDetector(
                            onDoubleTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SpecificScreen( tasksSp: Provider.of<DBProvider>(context).specificWork
                                          )));
                            },
                            child: Wiget1(
                                "Work", Provider.of<DBProvider>(context).workC),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          GestureDetector(
                             onDoubleTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SpecificScreen( tasksSp: Provider.of<DBProvider>(context).specificPersonal
                                          )));
                            },
                            child: Wiget1(
                              "Personal",
                              Provider.of<DBProvider>(context).personal,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                             onDoubleTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SpecificScreen( tasksSp: Provider.of<DBProvider>(context).specificShopping
                                          )));
                            },
                            child: Wiget1(
                              "Shopping",
                              Provider.of<DBProvider>(context).shopping,
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          GestureDetector(
                             onDoubleTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SpecificScreen( tasksSp: Provider.of<DBProvider>(context).specificOther
                                          )));
                            },
                            child: Wiget1(
                                "Others", Provider.of<DBProvider>(context).others),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 18),
                child: SizedBox(
                    height: 390.h,
                    child: ListView.builder(
                        itemCount:
                            Provider.of<DBProvider>(context).allTasks.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullTask(
                                              Provider.of<DBProvider>(context)
                                                  .allTasks[index],
                                            )));
                              },
                              child: widget2(Provider.of<DBProvider>(context)
                                  .allTasks[index]));
                        }))),
          ],
        )),
      ),
    );
  }
}
