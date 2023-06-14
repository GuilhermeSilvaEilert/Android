import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'package:modulocaixa/Negocio/itemModel.dart';
import 'package:scoped_model/scoped_model.dart';

class BottonAppBarMultiColor extends StatefulWidget {

  BottonAppBarMultiColor({this.child, Key? key}) : super(key: key);

  var child;

  @override
  State<BottonAppBarMultiColor> createState() => _BottonAppBarMultiColorState();
}

class _BottonAppBarMultiColorState extends State<BottonAppBarMultiColor> {

 final firebaseCoresDefault = FirebaseFirestore
      .instance
      .collection('Configurações')
      .doc('Cores')
      .collection('Configura Cores')
      .get();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CardapioModel>(
      model: CardapioModel(),
      child: ScopedModelDescendant<CardapioModel>(
        builder: (context, child, model) {
          return FutureBuilder(
              future:
              FirebaseFirestore
                  .instance
                  .collection('Usuario raiz')
                  .doc(model.firebaseUser!.email)
                  .collection('Configuracoes').get()
                  != null ?
              FirebaseFirestore
                  .instance
                  .collection('Usuario raiz')
                  .doc(model.firebaseUser!.email)
                  .collection('Configuracoes').get()
                  :
              firebaseCoresDefault,
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
        },
      ),
    );
  }
}
