import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modulocaixa/Apresentacao/ApresentaItensComanda/ApresentaItensComanda.dart';
import 'package:modulocaixa/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:modulocaixa/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:scaffold_responsive/scaffold_responsive.dart';

class HomeCaixa extends StatefulWidget {
  HomeCaixa({
    Key? key,
    this.UserRoot
  }) : super(key: key);

  String? UserRoot;
  @override
  State<HomeCaixa> createState() => _HomeCaixaState();
}

class _HomeCaixaState extends State<HomeCaixa> {

  bool? mostraItensComanda = false;
  String? NumeroComanda;
  @override
  Widget build(BuildContext context) {
    print('Email UserRoot: ${widget.UserRoot}');
    return ScaffoldMultiColor(
      BottomNavigationBar: BottomAppBar(
        height: 50,
        color: Color.fromARGB(255, 124, 112, 97),
        child: mostraItensComanda == false
               ? Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   Container(child: Text(
                      'R\$ 0.00',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                 ],
               )
               : FutureBuilder(
                  future: FirebaseFirestore
                      .instance
                      .collection('Usuario raiz')
                      .doc(widget.UserRoot)
                      .collection('comandas')
                      .doc(NumeroComanda)
                      .collection('Itens').get(),
                  builder: (context, snapshot) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButtonMultiColor(
                          altura: 25,
                          largura: 200,
                          text: Text(
                              'Editar comanda',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          funcao: (){},
                        ),
                        SizedBox(width: 550,),
                        TextButtonMultiColor(
                          altura: 25,
                          largura: 200,
                          text: Text(
                              'Fechar comanda',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          funcao: (){},
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                'R\$ ${snapshot.data!.docs[0]['Preco']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
        ),
      ),
      TextAppBar: Text('Comandas Ativas'),
      Body: Container(
        child: FutureBuilder(
          future: FirebaseFirestore
                  .instance
                  .collection('Usuario raiz')
                  .doc(widget.UserRoot)
                  .collection('comandas')
                  .orderBy('Ordenador').get(),
          builder: (context, snapshot) {
            return CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(8),
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(8),
                            child: TextButtonMultiColor(
                              largura: 100,
                              altura: 50,
                              funcao: (){
                                setState(() {
                                  NumeroComanda = snapshot.data!.docs[index]['NumeroComanda'];
                                  mostraItensComanda = true;
                                });
                              },
                              text: Text('${
                                  snapshot.data!.docs[index]['NumeroComanda']}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      mostraItensComanda == true
                          ?
                      Container(
                        child: ApresentaItensComanda(
                          UserRoot: widget.UserRoot,
                          NumeroComanda: NumeroComanda,
                        ),
                      ) :Container(
                        child: Center(child: Text('Selecione a comanda')),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
