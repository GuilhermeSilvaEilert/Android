import 'package:cardapiovirtualmodulogarcom/Apresentacao/teladeLogin.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/FirebaseNotification/FirebaseMessagins.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/FirebaseNotification/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
      MultiProvider(
        providers: [
          Provider<NotificationService>(create: (context) => NotificationService()),
          Provider<FirebaseMessagins>(
            create: (context) => FirebaseMessagins(context.read<NotificationService>()),
          )
        ],
          child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot){
          return LoginPage();
        }
      ),
    );
  }
}


