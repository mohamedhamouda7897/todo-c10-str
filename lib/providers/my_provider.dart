import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c10_str/firebase_function.dart';
import 'package:todo_c10_str/user_model.dart';

class MyProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  void initUser() async {
    userModel = await FirebaseFunctions.readUser();
    notifyListeners();
  }
}
