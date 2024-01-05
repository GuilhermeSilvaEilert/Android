// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TextButtonMultiColor extends StatefulWidget {
  TextButtonMultiColor({super.key,
    this.largura,
    this.text,
    this.funcao,
    this.altura,
    this.onlogPressed,
  });

  double? altura;
  double? largura;
  var funcao;
  var text;
  var onlogPressed;

  @override
  State<TextButtonMultiColor> createState() => _TextButtonMultiColorState();
}

class _TextButtonMultiColorState extends State<TextButtonMultiColor> {

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
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return Container(
              child: TextButton(
                onLongPress: widget.onlogPressed,
                onPressed: widget.funcao,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(
                        snapshot.data!.docs[3]['Opacidade'],
                        snapshot.data!.docs[3]['Red'],
                        snapshot.data!.docs[3]['Green'],
                        snapshot.data!.docs[3]['Blue']),
                  ),
                  fixedSize: MaterialStateProperty.all(
                      Size(widget.largura!,widget.altura!, )
                  ),
                ),
                child: widget.text!,
              ),
            );
          }
      }
    );
  }



}
