import 'package:cardapiovirtual/Apresentacao/Telas/ApresentaProduto.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/TelaDeAtualizarItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../Repository/ConectaFirebase.dart';


class GridItensCardapio extends StatefulWidget {
  GridItensCardapio({required this.Itens});
  String Itens;
  @override
  State<GridItensCardapio> createState() => _GridItensCardapioState(Itens: Itens);
}

class _GridItensCardapioState extends State<GridItensCardapio> {

  _GridItensCardapioState({required this.Itens});

  String Itens;

  ConectaFirebase conectaFirebase = ConectaFirebase();

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Itens Cardapio')
                    .doc(Itens)
                    .collection('Itens').orderBy('Nome')
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  } else {
                    return GridView.custom(
                        scrollDirection: axisDirectionToAxis(AxisDirection.up),
                        physics: const NeverScrollableScrollPhysics(),
                        childrenDelegate: SliverChildBuilderDelegate(
                          childCount: snapshot.data?.docs.length,
                              (context, index) {
                            return Container(
                              padding: EdgeInsets.only(top: 8),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                    Size(300, 300),
                                  ),
                                  shadowColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  enableFeedback: false,
                                ),
                                child: Column(
                                  children: [
                                    Image.network(
                                      snapshot.data!.docs[index]['Imagem'],
                                      fit: BoxFit.cover,
                                      width: 300,
                                      height: 300,
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data!.docs[index]['Nome'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

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
                                                      builder: (context) => AtualizaItemCardapio(
                                                        Preco: snapshot.data!.docs[index]['Preco'].toString(),
                                                        Nome: snapshot.data?.docs[index]['Nome'],
                                                        Imagem: snapshot.data?.docs[index]['Imagem'],
                                                        Descricao: snapshot.data?.docs[index]['Descricao'],
                                                        Categoria: Itens,
                                                        LocalStorage:snapshot.data?.docs[index]['LocalStorage'],
                                                      ),),
                                                    );
                                                  } else {
                                                    print(snapshot.data!.docs[index]['LocalStorage']);
                                                    await FirebaseStorage.instance
                                                        .ref(snapshot.data!.docs[index]['LocalStorage'])
                                                        .delete();
                                                    await FirebaseFirestore.instance
                                                        .collection('Itens Cardapio')
                                                        .doc(Itens).collection('Itens').doc(snapshot.data!.docs[index]['Nome'])
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
                                          SizedBox(height: 10,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text('R\$' + snapshot.data!.docs[index]['Preco'].toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  // print('Categoria do Itens do Cardapio $Itens');
                                  String Nome = snapshot.data?.docs[index]['Nome'];
                                  print('Nome do Produto $Nome');
                                  print('id: $index');
                                  double Preco = snapshot.data?.docs[index]['Preco'];
                                  print('Preco do Produto $Preco');
                                  String Image = snapshot.data?.docs[index]['Imagem'];
                                  print('Foto do Produto $Image');
                                  String Descricao = snapshot.data?.docs[index]['Descricao'];
                                  print('Descrição do produto $Descricao');
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ApresentaProdutos(
                                      descricao: Descricao,
                                      imagem: Image,
                                      nome: Nome,
                                      preco: Preco,
                                    ),
                                  ),
                                  );
                                },
                              ),

                            );
                          },
                        ),

                        shrinkWrap: true,
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 1,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
                          pattern: snapshot.data!.docs.map((e) {
                            return QuiltedGridTile(
                              e['y'],
                              e['x'],
                            );
                          }).toList(),
                        ),
                      );
                  }
                },
              );
  }
}
