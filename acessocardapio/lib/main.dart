import 'package:acessocardapio/Apresentacao/LoginPage/LoginPage.dart';
import 'package:acessocardapio/Negocio/Model/FirebaseOptions/DefaultFirebaseOptions.dart';
import 'package:acessocardapio/Negocio/Model/itemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_web/firebase_core_web_interop.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_core_web/firebase_core_web.dart';

// TODO: Replace the following with your app's Firebase project configuration


void main() async{
  runApp( MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(options: DefaultFirebaseOptions.web);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:FutureBuilder(
        future: _initialization,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Container(
              child: Center(
                child: Text('Erro'),
              ),
            );
          }else if(snapshot.connectionState == ConnectionState.done){
            return Container(
              child: LoginPage(),
            );
          }else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

