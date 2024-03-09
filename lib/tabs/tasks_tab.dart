import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_c10_str/firebase_function.dart';
import 'package:todo_c10_str/task_model.dart';

import '../task_item.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          DateTime.now(),
          height: 100,
          initialSelectedDate: selectedDate,
          selectionColor: Colors.blue,
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            selectedDate = date;
            setState(() {});
          },
        ),
        SizedBox(
          height: 12,
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFunctions.getTasks(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text(snapshot.error.toString()),
                    ElevatedButton(onPressed: () {}, child: Text("Try Again"))
                  ],
                );
              }

              List<TaskModel> tasks =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

              if (tasks.isEmpty) {
                return Text("No TAsks");
              }
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 12,
                ),
                itemBuilder: (context, index) {
                  return TaskItem(tasks[index]);
                },
                itemCount: tasks.length,
              );
            },
          ),
          // child: ListView.separated(
          //   separatorBuilder: (context, index) => SizedBox(
          //     height: 12,
          //   ),
          //   itemBuilder: (context, index) {
          //     return TaskItem();
          //   },
          //   itemCount: 9,
          // ),
        )
      ],
    );
  }
}
