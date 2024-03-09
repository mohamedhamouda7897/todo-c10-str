import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_c10_str/firebase_function.dart';
import 'package:todo_c10_str/task_model.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add New task",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 18,
            ),
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Task title";
                }
                return null;
              },
              decoration: InputDecoration(
                  label: const Text("title"),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(
              height: 18,
            ),
            TextFormField(
              controller: descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Task Description";
                }
                return null;
              },
              decoration: InputDecoration(
                  label: const Text("Description"),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(
              height: 18,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text("Select Time",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w300))),
            const SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                selectTaskDate();
              },
              child: Text("${selectedDate.toString().substring(0, 10)}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TaskModel taskModel = TaskModel(
                        title: titleController.text,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        description: descriptionController.text,
                        date: DateUtils.dateOnly(selectedDate)
                            .millisecondsSinceEpoch);

                    print(DateUtils.dateOnly(selectedDate));
                    FirebaseFunctions.addTask(taskModel);

                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  "Add Task",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  selectTaskDate() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }
}

/**
 *
 * Select * From TableName value(
 * Insert into
 * *
 * **/
