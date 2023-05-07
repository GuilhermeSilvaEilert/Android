import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:superadm/Neg%C3%B3cio/Model/UserModel.dart';
import 'package:superadm/Apresentacao/telaLogin/telaLogin.dart';


void main() async {
  runApp(MyApp());
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
                  home: CriaUsuarioGerente()
              ),
            );
          }
          return const CircularProgressIndicator();
        }
    );
  }
}
