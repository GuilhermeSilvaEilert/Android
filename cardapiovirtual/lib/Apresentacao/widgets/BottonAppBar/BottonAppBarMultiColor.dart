import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';

class BottonAppBarMultiColor extends StatefulWidget {

  BottonAppBarMultiColor({this.child, Key? key}) : super(key: key);

  var child;

  @override
  State<BottonAppBarMultiColor> createState() => _BottonAppBarMultiColorState();
}

class _BottonAppBarMultiColorState extends State<BottonAppBarMultiColor> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore
          .instance
          .collection('Configurações')
          .doc('Cores')
          .collection('Configura Cores')
          .get(),
      builder: (context, snapshot) {
        return BottomAppBar(
          shape:  const CircularNotchedRectangle(),
          color:  Color.fromARGB(
              snapshot.data!.docs[0]['Opacidade'],
              snapshot.data!.docs[0]['Red'],
              snapshot.data!.docs[0]['Green'],
              snapshot.data!.docs[0]['Blue'],
          ),
          child: widget.child,
        );
      }
    );
  }
}
