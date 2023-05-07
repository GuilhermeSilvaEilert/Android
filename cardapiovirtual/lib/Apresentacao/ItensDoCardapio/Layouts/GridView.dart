// ignore_for_file: file_names, must_be_immutable

import 'package:cardapiovirtual/Apresentacao/ItensDoCardapio/ItensDoCardapio.dart';
import 'package:cardapiovirtual/Apresentacao/ListViewGridViewUnico/layoutButton/layouElevatedButtonCategoryGrid.dart';
import 'package:cardapiovirtual/Apresentacao/ListViewGridViewUnico/layoutButton/layoutElevatedButtonItenGrid.dart';
import 'package:cardapiovirtual/Model/itemModel.dart';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cardapiovirtual/Apresentacao/ApresentaProduto/ApresentaProduto.dart';
import 'package:scoped_model/scoped_model.dart';

class GridViewItensCorrigido extends StatefulWidget {
  GridViewItensCorrigido({
    Key? key,
    this.categoria,
    this.crossAxisCount
  }) : super(key: key);

  String? categoria;
  int? crossAxisCount;

  @override
  State<GridViewItensCorrigido> createState() => _GridViewItensCorrigidoState();
}

class _GridViewItensCorrigidoState extends State<GridViewItensCorrigido> {
  ConectaFirebase conectaFirebase = ConectaFirebase();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    FirebaseFirestore.instance.collection('Itens Cardapio').get();
  }

  int? resultadoConsulta;

  int? consultaCategorias;

  Future<int?> validaExistenciaDeDados(
      String? Categoria,
      String? UserRoot) async {
    final QuerySnapshot result = await Future.value(
      FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('Itens Cardapio')
          .doc(Categoria.toString())
          .collection('Itens').get(),
    );

    resultadoConsulta = result.docs.length;

    return resultadoConsulta;
  }

  String? Itens;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CardapioModel>(
      model: CardapioModel(),
      child: ScopedModelDescendant<CardapioModel>(
        builder: (context, child, model) {
          print(model.firebaseUser!.email);
          print('Itens:${widget.categoria}');
          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore
                  .instance
                  .collection('Usuario raiz')
                  .doc(model.firebaseUser!.email)
                  .collection('Itens Cardapio')
                  .doc(widget.categoria)
                  .collection('Itens').get(),
            builder: (context, snapshot) {
             if (!snapshot.hasData) {
                print('Abrindo itens');
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              } else {
              /* print('Abrindo grid');
               String Nome = snapshot.data?.docs[1]['Nome'];
               print('Nome do Produto $Nome');
               double Preco = snapshot.data?.docs[1]['Preco'];
               print('Preco do Produto $Preco');
               String Image = snapshot.data?.docs[1]['Imagem'];
               print('Foto do Produto $Image');
               String Descricao = snapshot.data?.docs[1]['Descricao'];
               print('Descrição do produto $Descricao');
               String id = snapshot.data?.docs[1]['id'];
               print('id: $id');
               String x = snapshot.data?.docs[1]['x'];
               print('x: $x');
               String y = snapshot.data?.docs[1]['y'];
               print('y: $y');*/
               return Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 0, left: 9, right: 9),
                  child: GridView.builder(
                    itemBuilder: (context, index) {
                      String Nome = snapshot.data?.docs[index]['Nome'];
                      print('Nome do Produto $Nome');
                      double Preco = snapshot.data?.docs[index]['Preco'];
                      print('Preco do Produto $Preco');
                      String Image = snapshot.data?.docs[index]['Imagem'];
                      print('Foto do Produto $Image');
                      String Descricao = snapshot.data?.docs[index]['Descricao'];
                      print('Descrição do produto $Descricao');
                      String id = snapshot.data?.docs[index]['id'];
                      print('id: $id');
                      return ElevatedButton(
                        style: ButtonStyle(

                          padding: MaterialStateProperty.all(
                           const EdgeInsets.only(top: 5),
                          ),
                          fixedSize: MaterialStateProperty.all(
                            const Size(180, 180),
                          ),
                          shadowColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 124, 112, 97),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 124, 112, 97),
                          ),
                          enableFeedback: true,
                          shape: MaterialStateProperty.all(
                            ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                            )
                          ),
                        ),

                        onPressed: () async {
                            String Nome = snapshot.data?.docs[index]['Nome'];
                            print('Nome do Produto $Nome');
                            double Preco = snapshot.data?.docs[index]['Preco'];
                            print('Preco do Produto $Preco');
                            String Image = snapshot.data?.docs[index]['Imagem'];
                            print('Foto do Produto $Image');
                            String Descricao = snapshot.data?.docs[index]['Descricao'];
                            print('Descrição do produto $Descricao');
                            String id = snapshot.data?.docs[index]['id'];
                            print('id: $id');

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ApresentaProdutos(
                                      nome: Nome,
                                      descricao: Descricao,
                                      imagem: Image,
                                      preco: Preco),
                            ));
                            initState();
                        },
                        child: layoutElevatedGridItens(
                          Descricao: snapshot.data!.docs[index]['Descricao'],
                          Nome: snapshot.data!.docs[index]['Nome'],
                          Imagem: snapshot.data?.docs[index]['Imagem'],
                          LocalStorage: snapshot.data!.docs[index]['LocalStorage'],
                          categoria: widget.categoria.toString(),
                          Preco:  snapshot.data!.docs[index]['Preco'],
                          id: snapshot.data!.docs[index]['id'],
                        ),
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount: widget.crossAxisCount!,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      repeatPattern: QuiltedGridRepeatPattern.inverted,
                      pattern: snapshot.data!.docs.map((e) {
                        return QuiltedGridTile(e['x'], e['y']);
                      }).toList(),
                    ),
                  ),
                );
              }
            },
          );
        }
      ),
    );
  }

  Future _onBackPressed() {
    return FirebaseFirestore.instance.collection('Itens Cardapio').get();
  }

}