
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../Repository/ItemData.dart';

class ItensDoCardapio extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.
                collection('Itens Cardapio').get(),
                builder: (context, snapshot){
                  if(!snapshot.hasData) {
                    return SliverToBoxAdapter(
                      child: Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return
                        SliverToBoxAdapter(
                          child: GridView.builder(
                            itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                             FadeInImage.memoryNetwork(
                                                  placeholder: kTransparentImage,
                                                  image: snapshot.data!.docs[index]['Imagem'],
                                               height: 300,
                                               width: 300,
                                              ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        children:[
                                                          Text(snapshot.data!.docs[index]['Nome']),
                                                          Text(snapshot.data!.docs[index]['Preco'].toString()),
                                                        ],
                                                      ),
                                                    ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                );
                            },
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverQuiltedGridDelegate(
                              crossAxisCount: 1,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
                              repeatPattern: QuiltedGridRepeatPattern.inverted,
                              pattern: snapshot.data!.docs.map((e) {
                                return QuiltedGridTile(e['y'], e['x']);
                              }).toList(),

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
