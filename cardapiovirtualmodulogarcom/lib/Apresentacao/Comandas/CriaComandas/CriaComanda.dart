import 'package:cardapiovirtualmodulogarcom/Apresentacao/Comandas/CriaComandas/CriaComandaItens/CriaComandaItens.dart';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/Models/AddItensComandaModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CriaComandaCategoria extends StatefulWidget {
  CriaComandaCategoria({
    Key? key,
    this.UserRoot,
    this.NumeroComanda,
  }) : super(key: key);
  
  String? UserRoot;
  String? NumeroComanda;
  @override
  State<CriaComandaCategoria> createState() => _CriaComandaCategoriaState();
}

class _CriaComandaCategoriaState extends State<CriaComandaCategoria> {


  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
      TextAppBar: Text('Categoria da comanda'),
      Body: FutureBuilder(
        future: FirebaseFirestore
                .instance
                .collection('Usuario raiz')
                .doc(widget.UserRoot)
                .collection('Itens Cardapio').get(),
        builder: (context, snapshot) {
          print(widget.UserRoot);
          return Container(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: GridView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
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
                          ),

                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CriaComandasItens(
                                  UserRoot: widget.UserRoot,
                                  idCategoria: snapshot.data!.docs[index]['id'],
                                  Categoria: snapshot.data!.docs[index]['Nome'],
                                  NumeroComanda: widget.NumeroComanda,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Image.network(
                                snapshot.data!.docs[index]['Imagem'],
                                height: 150,
                                width: 150,
                              ),
                              Text(snapshot.data!.docs[index]['Nome']),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      repeatPattern: QuiltedGridRepeatPattern.inverted,
                      pattern: snapshot.data!.docs.map((e) {
                        return QuiltedGridTile(e['x'], e['y']);
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
