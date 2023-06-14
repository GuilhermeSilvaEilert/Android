

import 'package:cardapiovirtualmodulogarcom/Apresentacao/Comandas/CarrinhoItensComanda/CarrinhoItensComanda.dart';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/Comandas/CriaComandas/CriaComanda.dart';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:cardapiovirtualmodulogarcom/Repository/SQLiteDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../Negocio/Models/CriaComandaModel.dart';

class ApresentaComandas extends StatefulWidget {
  ApresentaComandas({Key? key, this.UserRoot}) : super(key: key);

  String? UserRoot;

  @override
  State<ApresentaComandas> createState() => _ApresentaComandasState();
}

class _ApresentaComandasState extends State<ApresentaComandas> {

  dynamic? UsuarioRaiz;
  SQLiteDB liteDB = SQLiteDB();
  Endereco endereco = Endereco();

  int? consultaItensComanda;

  CriaComandaModel criaComandaModel = CriaComandaModel();

  Future<int> validaExistenciaCategoria(
      String? UserRoot,
      String? NumeroComanda,
      ) async {

    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance
            .collection('Usuario raiz')
            .doc(UserRoot)
            .collection('comandas')
            .doc(NumeroComanda).collection('Itens')
            .get()
    );

    consultaItensComanda = result.docs.length;

    return consultaItensComanda!;
  }

  @override
  void initState()  {
      liteDB.getEndereco(1).then((value) {
      UsuarioRaiz = value!.EmailEndereco;
      print('Email Raiz: $UsuarioRaiz');
      print(value);
    });
    // TODO: implement setState
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3));
    return ScopedModel<CriaComandaModel>(
      model: CriaComandaModel(),
      child: ScopedModelDescendant<CriaComandaModel>(
        builder: (context, child, model) {
          if (model.isLoading! == true) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          } else {
            return FutureBuilder(
              future: FirebaseFirestore
                  .instance
                  .collection('Usuario raiz')
                  .doc(widget.UserRoot)
                  .collection('comandas').orderBy('Ordenador').get(),
              builder: (context, snapshot) {
                return ScaffoldMultiColor(
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Color.fromARGB(255, 150, 0, 0),
                    onPressed: (){
                      setState(() {
                        criaComandaModel.AdicionaComanda(
                          UserRoot: widget.UserRoot,
                          ComandasExistentes: snapshot.data!.docs.length,
                          onSucess: onSucess,
                          onFail: onFail,
                        );
                      });
                    },
                    child: Icon(Icons.add),
                  ),
                  TextAppBar: Text('Comandas'),
                  Body: FutureBuilder(
                      future: FirebaseFirestore
                          .instance
                          .collection('Usuario raiz')
                          .doc(widget.UserRoot)
                          .collection('comandas')
                          .orderBy('Ordenador').get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        } else {
                          if(model!.isLoading!){
                            return Container(
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            );
                          }else{
                            return CustomScrollView(
                              slivers: [
                                SliverToBoxAdapter(
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextButtonMultiColor(
                                              text: Text(
                                                snapshot.data!.docs[index]['NumeroComanda'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              funcao: () async {
                                                await validaExistenciaCategoria(
                                                    widget.UserRoot,
                                                    snapshot.data!.docs[index]['NumeroComanda'],
                                                  );
                                               setState(() {
                                                 consultaItensComanda;
                                               });
                                                if(consultaItensComanda == 0){
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) => CriaComandaCategoria(
                                                          UserRoot: widget.UserRoot,
                                                          NumeroComanda: snapshot.data!.docs[index]['NumeroComanda'],
                                                        ),
                                                      ),
                                                    );
                                                }else{
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (context){
                                                        return BottomSheet(
                                                          builder: (context){
                                                            LogicalKeyboardKey.close;
                                                            return Container(
                                                              color: Color.fromARGB(255, 124, 112, 97),
                                                              padding: const EdgeInsets.all(10),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: ElevatedButton(
                                                                        style: ButtonStyle(
                                                                          backgroundColor: MaterialStateProperty.all(
                                                                            Color.fromARGB(255, 150, 0, 0),
                                                                          ),
                                                                        ),
                                                                        child: Text('Atualizar Comanda'),
                                                                        onPressed: (){
                                                                          Navigator.of(context).push(
                                                                            MaterialPageRoute(
                                                                              builder: (context) => CarrinhoItensComanda(
                                                                                UserRoot: widget.UserRoot,
                                                                                NumeroComanda: snapshot.data!.docs[index]['NumeroComanda'],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      )
                                                                  ),
                                                                  Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: ElevatedButton(
                                                                        style: ButtonStyle(
                                                                          backgroundColor: MaterialStateProperty.all(
                                                                            Color.fromARGB(255, 150, 0, 0),
                                                                          ),
                                                                        ),
                                                                        child: Text('Adicionar a Comanda'),
                                                                        onPressed: (){
                                                                          Navigator
                                                                              .of(context)
                                                                              .push(MaterialPageRoute(
                                                                            builder: (context) => CriaComandaCategoria(
                                                                              UserRoot: widget.UserRoot,
                                                                              NumeroComanda: snapshot.data!.docs[index]['NumeroComanda'],
                                                                            ),
                                                                          ),
                                                                          );
                                                                        },
                                                                      )
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }, onClosing: () {
                                                        },
                                                        );
                                                      });
                                                }

                                              },
                                              altura: 50,
                                              largura: 400,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                      }
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  onSucess() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Comanda Emitida'
        ),
        backgroundColor: Colors.green,
      ),
    );
    await Future.delayed(Duration(seconds: 1));
  }

  onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Problema ao Emitir Comanda'
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}

