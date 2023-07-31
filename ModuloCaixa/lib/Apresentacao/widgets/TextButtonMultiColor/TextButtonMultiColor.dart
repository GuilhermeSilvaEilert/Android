// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modulocaixa/Negocio/itemModel.dart';
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
    return FutureBuilder(
      builder: (context, snapshot) {
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
      }
    );
  }



}
