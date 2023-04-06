import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lojadevelas/Models/User_model.dart';
import 'package:lojadevelas/screens/home_screen.dart';
import 'package:lojadevelas/screens/login_screen.dart';
import 'package:lojadevelas/screens/sigingupScreen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ScopedModel<UserModel>(
              model: UserModel(),
              child: MaterialApp(
                  title: 'Venda de velas',
                  debugShowCheckedModeBanner: false,
                  home: HomeScreen()
              ),
          );
        }
        return const CircularProgressIndicator();
      }
    );
  }
}