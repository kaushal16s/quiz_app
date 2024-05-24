import 'package:flutter/material.dart';
import 'package:quiz_app/Firebase/firebase.dart';
import 'package:quiz_app/Admin/Admin_login.dart';
import 'package:quiz_app/pages/add_quiz.dart';
import 'package:quiz_app/pages/home.dart';
import 'package:quiz_app/pages/questions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        // Add your theme data here if needed
      ),
      home: const Home(), // Ensure this matches your AdminLogin class
    );
  }
}


