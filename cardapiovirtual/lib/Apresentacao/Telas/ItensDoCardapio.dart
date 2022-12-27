import 'package:cardapiovirtual/Apresentacao/Telas/ApresentaProduto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class ItensDoCardapio extends StatelessWidget {
  ItensDoCardapio({required this.Itens});

  String Itens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Itens'),
        backgroundColor: Color.fromARGB(255, 78, 90, 85),
      ),
      backgroundColor: Color.fromARGB(255, 78, 90, 85),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Itens Cardapio')
                    .doc(Itens)
                    .collection('Itens')
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SliverToBoxAdapter(
                      child: Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: GridView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(
                                            Size(190, 190),
                                          ),
                                          shadowColor: MaterialStateProperty.all(
                                            Colors.transparent,
                                          ),
                                          backgroundColor: MaterialStateProperty.all(
                                            Colors.transparent,
                                          ),
                                          enableFeedback: true,
                                        ),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              FadeInImage.memoryNetwork(
                                                placeholder: kTransparentImage,
                                                image: snapshot.data!.docs[index]['Imagem'],
                                                fit: BoxFit.cover,
                                                width: 150,
                                                height: 150,
                                              ),
                                              SizedBox(height: 1,),
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        snapshot.data!.docs[index]['Nome'],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
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
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onPressed: () {
                                          print(
                                              'Categoria do Itens do Cardapio $Itens');
                                          String Nome = snapshot.data?.docs[index]['Nome'];
                                          double Preco = snapshot.data?.docs[index]['Preco'];
                                          String Image = snapshot.data?.docs[index]['Imagem'];
                                          String Descricao = snapshot.data?.docs[index]['Descricao'];
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
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
      ),
    );
  }
}
