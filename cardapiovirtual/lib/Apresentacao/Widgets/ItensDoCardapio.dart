import 'package:cardapiovirtual/Apresentacao/Widgets/CardItens.dart';
import 'package:cardapiovirtual/Apresentacao/Widgets/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../Repository/ItemData.dart';

class ItensDoCardapio extends StatelessWidget {
  ItensDoCardapio(this.snapshot);
  final DocumentSnapshot snapshot;
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore
            .instance
            .collection('Itens Cardapio')
            .orderBy('Preço').get(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
              ),
            );
          }else{
            return TabBarView(
              physics: NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 0.65
                      ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return CardProduto(
                        product: ItemData.fromDocument(
                          snapshot!.data!.docs[index],
                        ),
                      );
                    },
                  ),
                ],
            );
          }
        },
      ),
    );
  }
}
