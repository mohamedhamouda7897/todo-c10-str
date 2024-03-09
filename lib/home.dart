import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_str/add_task_bottom_sheet.dart';
import 'package:todo_c10_str/auth/auth.dart';
import 'package:todo_c10_str/tabs/settings_tab.dart';
import 'package:todo_c10_str/tabs/tasks_tab.dart';

import 'providers/my_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xFFDFECDB),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, AuthScreen.routeName, (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
        title: Text(
          "ToDo ${provider.userModel?.userName}",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        height: 60,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.task), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskBottomSheet(),
              );
            },
          );
        },
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(30)),
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      body: tabs[index],
    );
  }

  List<Widget> tabs = [TasksTab(), SettingsTab()];
}
