import 'package:cardapiovirtual/Apresentacao/Telas/ListTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoriasDoCardapio extends StatelessWidget {
  const CategoriasDoCardapio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 78, 90, 85),
      bottomNavigationBar: BottomAppBar(
        shape:  CircularNotchedRectangle(),
        color: Color.fromARGB(255, 124, 112, 97),
        child: Row(
          children: [
            IconButton(
              style: ButtonStyle(
              ),
              onPressed: (){},
              icon: Icon(Icons.filter_alt),
            ),
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 150, 0, 0),
        onPressed: (){},
        child: Icon(Icons.add),
      ),
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
                            return
                             ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                    Size(180, 180),
                                  ),
                                  shadowColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  enableFeedback: true,
                                ),
                                onPressed: (){

                                },
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  padding: EdgeInsets.all(0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: snapshot.data!.docs[index]['Imagem'],
                                        width: 125,
                                        height: 125,
                                        fit: BoxFit.cover,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[
                                              Text(
                                                  snapshot.data!.docs[index]['Nome'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color:Colors.white,
                                                  ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverQuiltedGridDelegate(
                            crossAxisCount: 2,
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
      )

    );
  }
}
