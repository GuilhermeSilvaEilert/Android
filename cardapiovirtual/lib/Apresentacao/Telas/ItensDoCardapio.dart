import 'package:cardapiovirtual/Apresentacao/Telas/ApresentaProduto.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/TelaDeAtualizarItem.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/WidgetsItensDoCardapio/GridItensCardapio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../Repository/ConectaFirebase.dart';
import 'Widgets/GridItens.dart';

class ItensDoCardapio extends StatefulWidget {
  ItensDoCardapio({required this.Itens});
  String Itens;
  @override
  State<ItensDoCardapio> createState() => _ItensDoCardapioState(Itens: Itens);
}

class _ItensDoCardapioState extends State<ItensDoCardapio> {

  _ItensDoCardapioState({required this.Itens});

  String Itens;

  ConectaFirebase conectaFirebase = ConectaFirebase();

  bool? gradeOuLista;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seu Cardapio'),
        centerTitle: true,
        backgroundColor:  Color.fromARGB(255, 78, 90, 85),
      ),
      bottomNavigationBar: BottomAppBar(
        shape:  CircularNotchedRectangle(),
        color: Color.fromARGB(255, 124, 112, 97),
        child: Row(
          children: [
            PopupMenuButton(
              itemBuilder: (context) {
                var list = <PopupMenuEntry<Object>>[];
                list.add(
                  PopupMenuItem(
                    onTap: (){
                      setState(() {
                        gradeOuLista = false;
                      });
                    },
                    value: 2,
                    child: Row(
                      children: [
                        Icon(
                            Icons.list,
                            color: Colors.black
                        ),
                        SizedBox(width: 5,),
                        Text('Ver como Lista')
                      ],
                    ),
                  ),
                );
                list.add(
                  PopupMenuItem(
                    onTap: (){
                      setState(() {
                        gradeOuLista = true;
                      });
                    },
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.grid_view,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5,),
                        Text('Ver como Grade')
                      ],
                    ),
                  ),
                );
                return list;
              },
              icon: Icon(Icons.filter_alt),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 78, 90, 85),
      body: Stack(
        children: [
          CustomScrollView(
            physics: AlwaysScrollableScrollPhysics().parent,
            slivers: [
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Itens Cardapio')
                    .doc(Itens)
                    .collection('Itens').orderBy('Nome')
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SliverToBoxAdapter(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return  SliverToBoxAdapter(
                      child: gradeOuLista == false ?
                      ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(top: 8),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                    Size(200, 200),
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
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            snapshot.data?.docs[index]['Imagem'],
                                          ),
                                        ),
                                      ),
                                      height: 180,
                                      width: 180,
                                      child: Row(
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
                                                  builder: (context) => AtualizaItemCardapio(
                                                    Nome: snapshot.data?.docs[index]['Nome']
                                                  ),),);
                                              } else {
                                                print(snapshot.data!.docs[index]['Nome']);
                                                print(snapshot.data!.docs[index]['LocalStorage']);
                                                print(snapshot.data!.docs[index]['Imagem']);
                                               await FirebaseStorage.instance
                                                    .ref(snapshot.data!.docs[index]['LocalStorage'])
                                                    .delete();
                                                await FirebaseFirestore.instance
                                                    .collection('Itens Cardapio')
                                                    .doc(Itens).collection(Itens).doc(snapshot.data!.docs[index]['Nome'])
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
                                          SizedBox(width: 10,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    snapshot.data!.docs[index]['Nome'],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold,
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  // print('Categoria do Itens do Cardapio $Itens');
                                  String Nome = snapshot.data?.docs[index]['Nome'];
                                  print('Nome do Produto $Nome');
                                  double Preco = snapshot.data?.docs[index]['Preco'];
                                  print('Preco do Produto $Preco');
                                  String Image = snapshot.data?.docs[index]['Imagem'];
                                  print('Foto do Produto $Image');
                                  String Descricao = snapshot.data?.docs[index]['Descricao'];
                                  print('Descrição do produto $Descricao');
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ApresentaProdutos(
                                      Descricao: Descricao,
                                      Imagem: Image,
                                      Nome: Nome,
                                      Preco: Preco,
                                    ),
                                  ),
                                  );
                                },
                              ),

                            );
                          },
                      )
                      :
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: GridItensCardapio(
                          Itens: Itens,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
