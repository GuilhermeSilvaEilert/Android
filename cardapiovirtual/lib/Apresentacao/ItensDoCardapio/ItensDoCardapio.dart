import 'package:cardapiovirtual/Apresentacao/ListViewGridViewUnico/GridView.dart';
import 'package:cardapiovirtual/Apresentacao/ListViewGridViewUnico/ListView.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/PopMenuButton/PopMenuButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Repository/ConectaFirebase.dart';

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
            PopMenuButtonWidget(
              Funcao1: (){
                setState(() {
                  gradeOuLista = false;
                });
              },
              Funcao2: (){
                setState(() {
                  gradeOuLista = true;
                });
              },
            )
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
                      //ListviewCardapio( Itens: Itens)
                      ListaViewUnico(
                        categoriaOuItem: false,
                        categoria: Itens,
                      )
                      :
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: GridViewItens(
                          categoriaOuItem: false,
                          crossAxisCount: 1,
                          categoria: Itens,
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
