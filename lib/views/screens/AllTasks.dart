import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:secproject/models/task_model.dart';
import 'package:secproject/providers/Dbprovider.dart';
import 'package:secproject/views/widgets/Task.dart';
import 'package:lottie/lottie.dart';
import 'package:secproject/views/widgets/fulltask.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/road.png"),
        //     opacity: 0.5,
        //     fit: BoxFit.cover,
        //   ),
        // ),
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
              child: ListView.builder(
                  itemCount: Provider.of<DBProvider>(context).allTasks.length,
                  itemBuilder: (context, index) {
                    return  Slidable(
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                    

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: ((context) {
                               print(tasks[index].Name)
                                      ;
                              Provider.of<DBProvider>(context,listen: false).deleteTasks(
                               tasks[index]
                                    );
                                     
                            }),
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete'.tr(),
                          ),
                         
                        ],
                      ),
                      child:GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullTask(
                                          Provider.of<DBProvider>(context)
                                              .allTasks[index],
                                        )));
                          },
                          child: Task(Provider.of<DBProvider>(context)
                              .allTasks[index])));
                    
                  }
      ))]),
      ),
    );
  }
}
