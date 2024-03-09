import 'package:flutter/material.dart';
import 'package:todo_c10_str/auth/login_tab.dart';
import 'package:todo_c10_str/auth/register_tab.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = "AuthScreen";

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Text("Login")),
              Tab(icon: Text("Register")),
            ],
          ),
          title: Text('Auth Screen'),
        ),
        body: TabBarView(
          children: [
            LoginTab(),
            RegisterTab(),
          ],
        ),
      ),
    );
  }
}
