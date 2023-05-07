import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/Models/CardapioModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
    this.enderecoEmail
  }) : super(key: key);
  String? enderecoEmail;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  ScopedModel<CardapioModel>(
        model: CardapioModel(),
        child: ScaffoldMultiColor(
          AppBar: AppBar(
            title: Text('Garçom'),
          ),
          Body: FutureBuilder(
            future: FirebaseFirestore
                .instance
                .collection('Usuario raiz')
                .doc(widget.enderecoEmail)
                .collection('Usuario Garçom').get(),
            builder: (context, snapshot) {
              return Container(

              );
            },
          ),
        )
    );
  }
}
