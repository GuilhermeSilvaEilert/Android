import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:superadm/Apresentacao/CadastroDeAg%C3%AAnciasFisicas/CadastroDeAg%C3%AAnciaFisica.dart';
import 'package:superadm/Apresentacao/CadastroNovasEmpresas/CadastroNovasEmpresas.dart';
import 'package:superadm/Apresentacao/OpcoesAddCatItemverItens/OpcoesAddCatItemVerIten.dart';
import 'package:superadm/Apresentacao/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:superadm/Apresentacao/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:superadm/Neg%C3%B3cio/Model/CadastroDeAgencias/CadastroDeAgenciaFilha/CadastroDeAgenciaFilha.dart';
import 'package:superadm/Neg%C3%B3cio/ValidaExistenciaCategoria.dart';




class ApresentaFiliais extends StatefulWidget {
  ApresentaFiliais({
    Key? key,
    this.Empresa
  }) : super(key: key);

  String? Empresa;
  @override
  State<ApresentaFiliais> createState() => _ApresentaFiliaisState();
}

class _ApresentaFiliaisState extends State<ApresentaFiliais> {

  ValidaExistenciaCategoria validaExistenciaCategoria = ValidaExistenciaCategoria();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore
          .instance
          .collection('Empresa')
          .doc(widget.Empresa)
          .collection('Franquias').get(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else {
          return ScaffoldMultiColor(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 150, 0, 0),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CadastroDeAgenciaFisica(
                  NomeEmpresa: widget.Empresa,
                ),));
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

                          },
                          largura: 350,
                          altura: 160,
                          text: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.network(
                                  snapshot.data!.docs[index]['Imagem'],
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        '${snapshot.data!.docs[index]['Nome']}, ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        '${snapshot.data!.docs[index]['Endereco']}, ${snapshot.data!.docs[index]['Numero']}, ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text('${snapshot.data!.docs[index]['Cidade']}, ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text('${snapshot.data!.docs[index]['Estado']}.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
