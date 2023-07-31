import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:superadm/Apresentacao/CadastroNovasEmpresas/CadastroNovasEmpresas.dart';
import 'package:superadm/Apresentacao/FloatingActionBubble/FloatingActionBubble.dart';
import 'package:superadm/Apresentacao/OpcoesAddCatItemverItens/OpcoesAddCatItemVerIten.dart';
import 'package:superadm/Apresentacao/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:superadm/Apresentacao/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:superadm/Apresentacao/telaLogin/CriaUsuarioGerente.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:superadm/Neg%C3%B3cio/ValidaExistenciaCategoria.dart';




class AgenciasLicenciadas extends StatefulWidget {
  const AgenciasLicenciadas({Key? key}) : super(key: key);

  @override
  State<AgenciasLicenciadas> createState() => _AgenciasLicenciadasState();
}

class _AgenciasLicenciadasState extends State<AgenciasLicenciadas> {

  ValidaExistenciaCategoria validaExistenciaCategoria = ValidaExistenciaCategoria();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('Empresa').get(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else {
          return ScaffoldMultiColor(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 150, 0, 0),
              onPressed: () async {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => CadastroNovasEmpresas(),));
              },
              child: Icon(Icons.add),
            ),
            Body: CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        child: TextButtonMultiColor(
                          funcao: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Opcoes(
                              Empresa: snapshot.data!.docs[index]['Nome'],
                              endereco: snapshot.data!.docs[index]['Endereco'],
                              estado: snapshot.data!.docs[index]['Estado'],
                              Imagem: snapshot.data!.docs[index]['Imagem'],
                              numero: snapshot.data!.docs[index]['Numero'],
                              cidade: snapshot.data!.docs[index]['Cidade'],
                            ),));
                          },
                          largura: 350,
                          altura: 65,
                          text: Text(
                              snapshot.data!.docs[index]['Nome'],
                              style: TextStyle(
                                color: Colors.white,
                              ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
