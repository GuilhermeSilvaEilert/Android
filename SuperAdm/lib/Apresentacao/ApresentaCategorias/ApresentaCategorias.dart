import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:superadm/Apresentacao/ApresentaItens/ApresentaItens.dart';
import 'package:superadm/Apresentacao/CriaCategorias/CriaCategorias.dart';
import 'package:superadm/Apresentacao/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:superadm/Neg%C3%B3cio/ValidaExistenciaCategoria.dart';


class ApresentaCategorias extends StatefulWidget {
  ApresentaCategorias({
    Key? key,
    this.Empresa,
    this.NomeFranquia
  }) : super(key: key);
  
  String? Empresa;
  String? NomeFranquia;
  
  @override
  State< ApresentaCategorias> createState() => _ApresentaCategoriasState();
}

class _ApresentaCategoriasState extends State< ApresentaCategorias> {

  ValidaExistenciaCategoria validaExistenciaCategoria = ValidaExistenciaCategoria();
  int? ExistenciaCategoria;

  String _message = "Choose a MenuItem.";

  void _showMessage(String newMessage) {
    setState(() {
      _message = newMessage;
    });
  }

  @override
  Widget build(BuildContext context){
    print('Empresa: ${widget.Empresa}');
    return ScaffoldMultiColor(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CriaCategoria(
            Empresa: widget.Empresa,
            Filial: widget.NomeFranquia,
          ),));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 150, 0, 0),
      ),
      TextAppBar: Text('Categorias'),
      Body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('Empresa')
                .doc(widget.Empresa)
                .collection('Franquias')
                .doc(widget.NomeFranquia)
                .collection('categorias')
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
                                  onLongPress: (){

                                  setState(() {
                                    PopupMenuButton(
                                      itemBuilder: (context){
                                        var list = <PopupMenuEntry<Object>>[];
                                        list.add(
                                          PopupMenuItem(
                                            value: 2,
                                            child: Row(
                                              children: const [
                                                Icon(Icons.delete, color: Colors.red),
                                                Text('Deletar')
                                              ],
                                            ),
                                          ),
                                        );
                                        list.add(
                                          PopupMenuItem(
                                            value: 1,
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.black,
                                                ),
                                                Text('Editar')
                                              ],
                                            ),
                                          ),
                                        );
                                        return list;
                                      },
                                      onSelected: (value) {

                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 20,
                                      ),

                                    );
                                  });

                                  },
                                  onPressed: (){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ApresentaItens(
                                          Empresa: widget.Empresa,
                                          Categoria: snapshot.data!.docs[index]['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                            snapshot.data!.docs[index]['Imagem'],
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: 150,
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

