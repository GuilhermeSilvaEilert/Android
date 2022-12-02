
import 'package:chat_online_firebsase/ChatScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen()));

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  await firestore.collection('mensagens1').get().then((QuerySnapshot querySnapshot){
    querySnapshot.docs.forEach((d) {
      print(d.data());
    });
  });
   firestore.collection('mensagens1').snapshots().listen((dado){
     dado.docs.forEach((d){
       print(d.data());
     });
  });
}

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

