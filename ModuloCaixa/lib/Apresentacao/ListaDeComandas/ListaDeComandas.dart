import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modulocaixa/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:modulocaixa/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';

class ListaDeComandas extends StatefulWidget {
  ListaDeComandas({Key? key, this.UserRoot}) : super(key: key);

  String? UserRoot;

  @override
  State<ListaDeComandas> createState() => _ListaDeComandasState();
}

class _ListaDeComandasState extends State<ListaDeComandas> {
  @override
  bool? mostraItensComanda;

  @override
  Widget build(BuildContext context) {
    print('Email UserRoot: ${widget.UserRoot}');
    return ScaffoldMultiColor(
      TextAppBar: Text('Comandas Ativas', style: TextStyle(color: Colors.white),),
      Body: Container(
        child: FutureBuilder(
          future: FirebaseFirestore
              .instance
              .collection('Usuario raiz')
              .doc(widget.UserRoot).collection('comandas').get(),
          builder: (context, snapshot) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: TextButtonMultiColor(
                                largura: 300,
                                altura: 75,
                                funcao: (){},
                                text: Text('${
                                    snapshot.data!.docs[index]['NumeroComanda']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
