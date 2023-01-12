import 'package:cardapiovirtual/Apresentacao/Telas/ListViewGridViewUnico/GridView.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/ListViewGridViewUnico/ListView.dart';
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
