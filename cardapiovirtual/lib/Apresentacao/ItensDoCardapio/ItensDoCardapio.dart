
// ignore_for_file: file_names, must_be_immutable, no_logic_in_create_state

import 'package:cardapiovirtual/Apresentacao/ListViewGridViewUnico/GridView.dart';
import 'package:cardapiovirtual/Apresentacao/ListViewGridViewUnico/ListView.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/BottonAppBar/BottonAppBarMultiColor.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/PopMenuButton/PopMenuButton.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Repository/ConectaFirebase.dart';

class ItensDoCardapio extends StatefulWidget {
  ItensDoCardapio({super.key, required this.itens});
  String itens;
  @override
  State<ItensDoCardapio> createState() => _ItensDoCardapioState(itens: itens);
}

class _ItensDoCardapioState extends State<ItensDoCardapio> {

  _ItensDoCardapioState({required this.itens});

  String itens;

  ConectaFirebase conectaFirebase = ConectaFirebase();

  bool? gradeOuLista;

  @override
  Widget build(BuildContext context) {
    return
      ScaffoldMultiColor(
        TextAppBar: const Text('Seu Cardapio'),
        Body:  Stack(
          children: [
            CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics().parent,
              slivers: [
                FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('Itens Cardapio')
                      .doc(itens)
                      .collection('Itens').orderBy('Nome')
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SliverToBoxAdapter(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return  SliverToBoxAdapter(
                        child: gradeOuLista == false ?
                        //ListviewCardapio( Itens: Itens)
                        ListaViewUnico(
                          categoriaOuItem: false,
                          categoria: itens,
                        )
                            :
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: GridViewItens(
                            categoriaOuItem: false,
                            crossAxisCount: 1,
                            categoria: itens,
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
          BottomNavigationBar: BottonAppBarMultiColor(
            child: Row(
              children: [
                PopMenuButtonWidget(
                  Icon1: Row(
                    children: [
                      Icon(Icons.list),
                      SizedBox(width: 5,),
                      Text('Lista')
                    ],
                  ),
                  
                  Icon2: Row(
                    children: [
                      Icon(Icons.grid_view),
                      SizedBox(width: 5,),
                      Text('Grade')
                    ],
                  ),
                  
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
      );
  }
}
