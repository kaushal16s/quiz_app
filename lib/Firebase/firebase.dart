import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBZe2D3z8VbC7dVvTNThjcXyXY5yBXdT5o",
      authDomain: "quiz-app-b235b.firebaseapp.com",
      projectId: "quiz-app-b235b",
      storageBucket: "quiz-app-b235b.appspot.com",
      messagingSenderId: "785826281412",
      appId: "1:785826281412:web:f5259ed48f440356e7d691",
      measurementId: "G-7YM5WC56YD",
    ),
  );
}
