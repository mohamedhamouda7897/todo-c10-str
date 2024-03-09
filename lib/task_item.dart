import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_c10_str/firebase_function.dart';
import 'package:todo_c10_str/task_model.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;

  TaskItem(this.taskModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 12),
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Slidable(
        startActionPane:
            ActionPane(motion: BehindMotion(), extentRatio: .7, children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.delete(taskModel.id);
            },
            label: "Delete",
            backgroundColor: Colors.red,
            icon: Icons.delete,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          SlidableAction(
            onPressed: (context) {},
            label: "Edit",
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          )
        ]),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 4,
              margin: EdgeInsets.only(top: 12, left: 12, bottom: 12),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(12)),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  taskModel.title,
                  style: TextStyle(fontSize: 22),
                ),
                subtitle: Text(
                  taskModel.description,
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.done,
                      size: 30,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
