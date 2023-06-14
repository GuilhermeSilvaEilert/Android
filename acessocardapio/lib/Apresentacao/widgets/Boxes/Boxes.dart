import 'package:acessocardapio/Negocio/Model/itemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Boxes extends StatefulWidget {
  Boxes({
    this.altura,
    this.largura,
    this.child,
    this.alignment,
    this.padding,
    Key? key
  }) : super(key: key);

  var largura;
  var alignment;
  var altura;
  var padding;
  var child;

  @override
  State<Boxes> createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CardapioModel>(
      model: CardapioModel(),
      child: ScopedModelDescendant<CardapioModel>(
        builder: (context, child, model) {
          return FutureBuilder(
            future:  model.firebaseUser!.email!.isEmpty  ?
              FirebaseFirestore
                  .instance
                  .collection('Configurações')
                  .doc('Cores')
                  .collection('Configura Cores')
                  .get()
                  :
              FirebaseFirestore
                  .instance
                  .collection('Usuario raiz')
                  .doc(model.firebaseUser!.email)
                  .collection('Configuracoes').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return Container(
                    padding: widget.padding,
                    alignment: widget.alignment,
                    width: widget.largura,
                    height: widget.altura,
                    child: widget.child,
                    color: Color.fromARGB(
                      snapshot.data!.docs[0]['Opacidade'],
                      snapshot.data!.docs[0]['Red'],
                      snapshot.data!.docs[0]['Green'],
                      snapshot.data!.docs[0]['Blue'],
                    ),
                  );
                }
              }
          );
        }
      ),
    );
  }
}