import 'package:flutter/material.dart';
import 'package:meutcc/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cursos e Turmas Online",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaginaLogin(),
    );
  }
}



