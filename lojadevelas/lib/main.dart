import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lojadevelas/screens/home_screen.dart';

void main() async {
  runApp(MaterialApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Venda de velas',
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}