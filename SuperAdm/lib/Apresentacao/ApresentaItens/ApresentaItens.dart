import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:superadm/Apresentacao/ApresentaItemFinal/ApresentaItemFinal.dart';
import 'package:superadm/Apresentacao/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:superadm/Neg%C3%B3cio/ValidaExistenciaCategoria.dart';

class ApresentaItens extends StatefulWidget {
  ApresentaItens({
    Key? key,
    this.Empresa,
    this.Categoria,
  }) : super(key: key);

  String? Empresa;
  String? Categoria;

  @override
  State< ApresentaItens> createState() => _ApresentaItensState();
}

class _ApresentaItensState extends State<ApresentaItens> {

  ValidaExistenciaCategoria validaExistenciaCategoria = ValidaExistenciaCategoria();
  int? ExistenciaCategoria;

  @override
  Widget build(BuildContext context){
    print('Empresa: ${widget.Empresa}');
    return ScaffoldMultiColor(
      TextAppBar: Text('Categorias'),
      Body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Empresa')
                  .doc(widget.Empresa)
                  .collection('Itens')
                  .doc(widget.Categoria)
                  .collection('Itens')
                  .get(),
              builder:(context, snapshot){
                if(snapshot.data!.docs.length == 0) {
                  return Container(
                    child: Center(
                      child: Text('Sem Itens Cadastrados :/'),
                    ),
                  );
                }else{
                  return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      repeatPattern: QuiltedGridRepeatPattern.inverted,
                      pattern: snapshot.data!.docs.map((e) {
                        return QuiltedGridTile(e['x'], e['y']);
                      }).toList(),
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 63, 58, 58)
                              ),
                            ),
                            onPressed: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ApresentaProdutos(
                                        nome: snapshot.data!.docs[index]['Nome'],
                                        descricao: snapshot.data!.docs[index]['Descricao'],
                                        imagem: snapshot.data!.docs[index]['Imagem'],
                                        preco: snapshot.data!.docs[index]['Preco']),
                                  )
                              );
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                      snapshot.data!.docs[index]['Imagem'],
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                                Text(snapshot.data!.docs[index]['Nome'])
                              ],
                            )
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}