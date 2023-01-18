
import 'package:cardapiovirtual/Apresentacao/LoginPage/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cardapiovirtual/Apresentacao/HomePage/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot){
          return Scaffold(
            backgroundColor: Colors.white,
            body: LoginPage(),
          );
        },
      ),
    );
  }
}

