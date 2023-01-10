import 'package:cardapiovirtual/Apresentacao/Telas/ItensDoCardapio.dart';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/TelaAtualizaCategoria.dart';

class GridItens extends StatefulWidget {
  const GridItens({Key? key}) : super(key: key);

  @override
  State<GridItens> createState() => _GridItensState();
}

class _GridItensState extends State<GridItens> {
  ConectaFirebase conectaFirebase = ConectaFirebase();

  var existeItens;
  int? existeDados;
  int? resultadoConsulta;
  var decisao;
  int? consultaCategorias;

  Future<int?> ValidaExistenciaDeDados(String? Categoria) async {
    final QuerySnapshot result = await Future.value(
      FirebaseFirestore.instance
          .collection('Itens Cardapio')
          .doc(Categoria)
          .collection('Itens')
          .get(),
    );
    print('ValidaExistenciaDeDados ${result.docs.length}');

    resultadoConsulta = result.docs.length;

    print(resultadoConsulta);

    return resultadoConsulta;
  }

  Future<int> ValidaExistenciaCategoria() async {
    final QuerySnapshot result = await Future.value(
      FirebaseFirestore.instance.collection('Itens Cardapio').get(),
    );

    consultaCategorias = result.docs.length;

    print(consultaCategorias);

    return consultaCategorias!;
  }

  String? Itens;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('Itens Cardapio').get(),
      builder: (context, snapshot) {
        ValidaExistenciaCategoria();
        if (!snapshot.hasData) {
          return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
        } else {
          return GridView.builder(
              itemBuilder: (context, index) {
                return ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      const Size(180, 180),
                    ),
                    shadowColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                    enableFeedback: true,
                  ),
                  onPressed: () async {
                    Itens = snapshot.data!.docs[index]['Nome'];

                    print('1$resultadoConsulta');

                    await ValidaExistenciaDeDados(Itens);

                    print('2$resultadoConsulta');

                    if (resultadoConsulta! > 0) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ItensDoCardapio(Itens: Itens!),
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
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              snapshot.data?.docs[index]['Imagem'],
                            ),
                          ),
                        ),
                        height: 170,
                        width: 170,
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PopupMenuButton(
                              itemBuilder: (context) {
                                var list = <PopupMenuEntry<Object>>[];
                                list.add(
                                  PopupMenuItem(
                                    value: 2,
                                    child: Row(
                                      children: const [
                                        Icon(Icons.delete, color: Colors.red),
                                        Text('Deletar')
                                      ],
                                    ),
                                  ),
                                );
                                list.add(
                                  PopupMenuItem(
                                    value: 1,
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                        Text('Editar')
                                      ],
                                    ),
                                  ),
                                );
                                return list;
                              },
                              onSelected: (value) async {
                                if (value == 1) {
                                  Navigator
                                      .of(context)
                                      .push(MaterialPageRoute(
                                        builder: (context) => AtualizaCategoria(
                                          NomeCategoria: snapshot.data!.docs[index]['Nome'],
                                          LocalArquivo: snapshot.data!.docs[index]['LocalStorage'],
                                          NomeArquivo: snapshot.data!.docs[index]['Imagem'],
                                        ),),);
                                } else {
                                  print('Excluir');
                                  await FirebaseStorage.instance
                                      .ref(snapshot.data!.docs[index]['LocalStorage'])
                                      .delete();
                                  print(snapshot.data!.docs[index]['Imagem']);
                                  await FirebaseFirestore.instance
                                      .collection('Itens Cardapio')
                                      .doc(snapshot.data!.docs[index]['Nome'])
                                      .delete();
                                }
                              },
                              icon: Image.asset(
                                'Assets/Icons/quicksetting.png',
                                fit: BoxFit.cover,
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data?.docs[index]['Nome'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                  return QuiltedGridTile(e['y'], e['x']);
                }).toList(),
              ),
            );
        }
      },
    );
  }
}
