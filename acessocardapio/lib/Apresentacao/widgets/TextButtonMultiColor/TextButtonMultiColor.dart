// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:acessocardapio/Negocio/Model/itemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TextButtonMultiColor extends StatefulWidget {
  TextButtonMultiColor({super.key,
    this.largura,
    this.text,
    this.funcao,
    this.altura
  });

  double? altura;
  double? largura;
  var funcao;
  var text;

  @override
  State<TextButtonMultiColor> createState() => _TextButtonMultiColorState();
}

class _TextButtonMultiColorState extends State<TextButtonMultiColor> {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CardapioModel>(
      model: CardapioModel(),
      child: ScopedModelDescendant<CardapioModel>(
        builder: (context, child, model) {
          return FutureBuilder(
            /*future: !model.firebaseUser!.email!.isEmpty ?
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
              .collection('Configuracoes').get(),*/
            builder: (context, snapshot) {
               /* if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else{*/
                  return Container(
                    child: TextButton(
                      onPressed: widget.funcao,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(
                              255, 150, 0, 0
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all(
                            Size(widget.largura!,widget.altura!, )
                        ),
                      ),
                      child: widget.text!,
                    ),
                  );
               // }
            }
          );
        }
      ),
    );
  }



}
