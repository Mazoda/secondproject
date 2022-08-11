import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:secproject/models/task_model.dart';
import 'package:secproject/providers/Dbprovider.dart';
import 'package:secproject/views/widgets/Task.dart';
import 'package:lottie/lottie.dart';

class SpecificScreen extends StatefulWidget {
  List<TaskModel> tasksSp;
  SpecificScreen({Key? key, required this.tasksSp}) : super(key: key);

  @override
  State<SpecificScreen> createState() => SpecificScreenState();
}

class SpecificScreenState extends State<SpecificScreen> {
  @override
  Widget build(BuildContext context) {
    //  List<TaskModel> tasks=  Provider.of<DBProvider>(context, listen: false).selectSpecific(widget.taskModel);
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
                  itemCount: widget.tasksSp.length,
                  itemBuilder: (context, index) {
                    return Task(
                         widget.tasksSp[index]);
                  }))
        ]),
      ),
    );
  }
}
