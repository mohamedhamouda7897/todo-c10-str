import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c10_str/task_model.dart';
import 'package:todo_c10_str/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }

  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static Future<void> addUser(UserModel user) {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  static Future<void> addTask(TaskModel taskModel) {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Stream<QuerySnapshot<TaskModel>>? getTasks(DateTime date) {
    return getTaskCollection()
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("title")
        .snapshots();
  }

  static void delete(String id) {
    getTaskCollection().doc(id).delete();
  }

  static Future<UserModel?> readUser() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<UserModel> snap = await getUsersCollection().doc(id).get();
    return snap.data();
  }

  static login(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // if (credential.user!.emailVerified) {
      onSuccess();
      // } else {
      //   onError("Please verify Your Email");
      // }
    } on FirebaseAuthException catch (e) {
      onError(e.code);
    }
  }

  static createAccount(String userName, String phone, String email,
      String password, Function onSuccess, Function onError) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
      UserModel userModel = UserModel(
          email: email,
          id: credential.user!.uid,
          userName: userName,
          phone: phone);
      addUser(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    } catch (e) {
      print(e);
    }
  }
}
