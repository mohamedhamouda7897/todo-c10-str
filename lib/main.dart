import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_str/auth/auth.dart';
import 'package:todo_c10_str/firebase_options.dart';
import 'package:todo_c10_str/home.dart';
import 'package:todo_c10_str/providers/my_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.enableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: provider.firebaseUser != null
            ? HomeScreen.routeName
            : AuthScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          AuthScreen.routeName: (context) => AuthScreen(),
        });
  }
}
