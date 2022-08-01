import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:secproject/models/task_model.dart';
import 'package:secproject/providers/Dbprovider.dart';
import 'package:secproject/views/widgets/Task.dart';
import 'package:lottie/lottie.dart';

class AllTasks extends StatefulWidget {
  List<TaskModel> Tasks;
  AllTasks({Key? key, required this.Tasks}) : super(key: key);

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  
  @override
  Widget build(BuildContext context) {
     List<TaskModel> tasks=  Provider.of<DBProvider>(context, listen: false).allTasks;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backg.png"),
            opacity: 0.8,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          SizedBox(
            height: 100,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  Spacer(),
                  Image.asset(
                    "assets/images/search.png",
                    width: 24.w,
                    height: 24.h,
                  ),
                  SizedBox(
                    width: 20.w,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child:ListView.builder(
            itemCount: Provider.of<DBProvider>(context).allTasks.length,
            itemBuilder: (context, index) {
              return Task(
                  Provider.of<DBProvider>(context).allTasks[index]);
            }
          ))
        ]),
      ),
    );
  }
}
