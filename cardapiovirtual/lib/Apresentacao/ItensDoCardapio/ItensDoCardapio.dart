
// ignore_for_file: file_names, must_be_immutable, no_logic_in_create_state

import 'package:cardapiovirtual/Apresentacao/ListViewGridViewUnico/GridView.dart';
import 'package:cardapiovirtual/Apresentacao/ListViewGridViewUnico/ListView.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/BottonAppBar/BottonAppBarMultiColor.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/PopMenuButton/PopMenuButton.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Model/itemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../Repository/ConectaFirebase.dart';

class ItensDoCardapio extends StatefulWidget {
  ItensDoCardapio({super.key, required this.itens});
  UniqueKey? itens;
  @override
  State<ItensDoCardapio> createState() => _ItensDoCardapioState();
}

class _ItensDoCardapioState extends State<ItensDoCardapio> {

  ConectaFirebase conectaFirebase = ConectaFirebase();

  bool? gradeOuLista;

  @override
  Widget build(BuildContext context) {
    return
      ScaffoldMultiColor(
        TextAppBar: const Text('Seu Cardapio'),
        Body:  Stack(
          children: [
            ScopedModel<CardapioModel>(
              model: CardapioModel(),
              child: ScopedModelDescendant<CardapioModel>(
                builder: (context, child, model) {
                  return CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics().parent,
                    slivers: [
                      FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('Usuario raiz')
                            .doc(widget.itens.toString())
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
                                categoria: widget.itens.toString(),
                              )
                                  :
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: GridViewItens(
                                  categoriaOuItem: false,
                                  crossAxisCount: 1,
                                  categoria: widget.itens,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  );
                }
              ),
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
