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

class GridViewItens extends StatefulWidget {
  GridViewItens({
    Key? key,
    this.categoria,
    this.categoriaOuItem,
    this.crossAxisCount
  }) : super(key: key);

  bool? categoriaOuItem;
  UniqueKey? categoria;
  int? crossAxisCount;

  @override
  State<GridViewItens> createState() => _GridViewItensState();
}

class _GridViewItensState extends State<GridViewItens> {
  ConectaFirebase conectaFirebase = ConectaFirebase();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    FirebaseFirestore.instance.collection('Itens Cardapio').get();
  }

  int? resultadoConsulta;

  int? consultaCategorias;


  Future<int?> validaExistenciaDeDados(UniqueKey? Categoria, String? UserRoot) async {
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

  Future<int> validaExistenciaCategoria(String UserRoot) async {
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance
            .collection('Usuario raiz')
            .doc(UserRoot)
            .collection('Itens Cardapio')
            .get()
    );

    consultaCategorias = result.docs.length;

    print(consultaCategorias);

    return consultaCategorias!;
  }

  atualizaDados() async{
    setState(() {
      FirebaseFirestore.instance.collection('Itens Cardapio').get();
    });
  }

  UniqueKey? Itens;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CardapioModel>(
      model: CardapioModel(),
      child: ScopedModelDescendant<CardapioModel>(
        builder: (context, child, model) {
          return FutureBuilder<QuerySnapshot>(
            future:widget.categoriaOuItem == true ?
            FirebaseFirestore
                .instance
                .collection('Usuario raiz')
                .doc(model.firebaseUser!.email)
                .collection('Itens Cardapio').get()
                :
              FirebaseFirestore
                  .instance
                  .collection('Usuario raiz')
                  .doc(model.firebaseUser!.email)
                  .collection('Itens Cardapio')
                  .doc(Itens.toString())
                  .collection('Itens').get(),
            builder: (context, snapshot) {
              validaExistenciaCategoria(model.firebaseUser!.email!);
              if (!snapshot.hasData) {
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              } else {
                atualizaDados();
                return Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 0, left: 9, right: 9),
                  child: GridView.builder(
                    itemBuilder: (context, index) {
                      atualizaDados();
                      return ElevatedButton(
                        style: ButtonStyle(

                          padding: MaterialStateProperty.all(
                           const EdgeInsets.only(top: 5),
                          ),
                          fixedSize: MaterialStateProperty.all(
                            const Size(180, 180),
                          ),
                          shadowColor: MaterialStateProperty.all(
                            widget.categoriaOuItem == true ?
                            Colors.transparent
                                :
                            const Color.fromARGB(255, 124, 112, 97),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            widget.categoriaOuItem == true ?
                            Colors.transparent
                                :
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
                          if(widget.categoriaOuItem == true){
                            Itens = snapshot.data!.docs[index]['id'];
                            await validaExistenciaDeDados(
                                Itens,
                                model.firebaseUser!.email
                            );
                            print(resultadoConsulta);
                            if (resultadoConsulta! > 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ItensDoCardapio(itens: Itens!)
                              ));
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    icon: const Icon(
                                      Icons.crisis_alert_outlined,
                                      color: Color.fromARGB(255, 150, 0, 0),
                                      size: 150,
                                    ),
                                    backgroundColor:
                                    const Color.fromARGB(255, 124, 112, 97),
                                    title: Text(
                                      'A categoria $Itens está vazia \n',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                },
                              );
                            }
                          }else{
                            String Nome = snapshot.data?.docs[index]['Nome'];
                            print('Nome do Produto $Nome');
                            double Preco = snapshot.data?.docs[index]['Preco'];
                            print('Preco do Produto $Preco');
                            String Image = snapshot.data?.docs[index]['Imagem'];
                            print('Foto do Produto $Image');
                            String Descricao = snapshot.data?.docs[index]['Descricao'];
                            print('Descrição do produto $Descricao');

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ApresentaProdutos(
                                      nome: Nome,
                                      descricao: Descricao,
                                      imagem: Image,
                                      preco: Preco),
                            ));
                            initState();
                          }
                        },
                        child: widget.categoriaOuItem == true ?
                        layoutElevatedCategotyGrid(
                          LocalStorage: snapshot.data!.docs[index]['LocalStorage'],
                          Imagem: snapshot.data!.docs[index]['Imagem'],
                          Nome: snapshot.data!.docs[index]['Nome'],
                          id: snapshot.data!.docs[index]['id'],
                          UserRoot: model.firebaseUser!.email,
                        )
                          :
                        layoutElevatedGridItens(
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
                        return QuiltedGridTile(e['y'], e['x']);
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