// ignore_for_file: unused_field, file_names, prefer_typing_uninitialized_variables

import 'package:cardapiovirtual/Apresentacao/AdicionaItemCardapio/AdicionaItemCardapio.dart';
import 'package:cardapiovirtual/Apresentacao/AdicionaCategoriaCardapio/CriaCategoriasScreen.dart';
import 'package:cardapiovirtual/Apresentacao/ListViewGridViewUnico/GridView.dart';
import 'package:cardapiovirtual/Apresentacao/ListViewGridViewUnico/ListView.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/FloatingActionBubble/FloatingActionBubble.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/PopMenuButton/PopMenuButton.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Model/itemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CategoriasDoCardapio extends StatefulWidget {
  const CategoriasDoCardapio({Key? key}) : super(key: key);

  @override
  State<CategoriasDoCardapio> createState() => _CategoriasDoCardapioState();
}

class _CategoriasDoCardapioState extends State<CategoriasDoCardapio> with SingleTickerProviderStateMixin{

  Animation<double>? _animation;
  AnimationController? _animationController;

  var existeItens;
  int? existeDados;
  int? resultadoConsulta;
  var decisao;
  int? consultaCategorias;

  Future<int> validaExistenciaCategoria(String? UserRoot) async {

    final QuerySnapshot result = await Future.value(
      FirebaseFirestore.instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('Itens Cardapio')
          .get()
    );

    consultaCategorias = result.docs.length;

    return consultaCategorias!;
  }

  @override
  void initState(){
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  bool? gradeOuLista;


  @override
  Widget build(BuildContext context) {
    return

    ScaffoldMultiColor(
      Body: Stack(
        children: [
          ScopedModel<CardapioModel>(
            model: CardapioModel(),
            child: ScopedModelDescendant<CardapioModel>(
              builder: (context, child, model) {
                return CustomScrollView(
                  slivers: [
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('Usuario raiz')
                          .doc(model.firebaseUser!.email)
                          .collection('Itens Cardapio')
                          .get(),
                      builder: (context, snapshot){
                        validaExistenciaCategoria(model.firebaseUser!.email);
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
                              child: gradeOuLista == false ?
                              snapshot.data!.docs.length == null ?
                              const Center(
                                heightFactor: 20,
                                child: Text(
                                  'Adicione Categorias',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                                  :
                              ListaViewUnico(
                                categoriaOuItem: true,
                              )
                              //ListaItens()
                                  : consultaCategorias == 0 || consultaCategorias == null ?
                              const Center(
                                heightFactor: 20,
                                child: Text(
                                  'Adicione Categorias',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                                  :
                              Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: GridViewItens(
                                    categoriaOuItem: true,
                                    crossAxisCount: 2,
                                  )
                                // GridItens()
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
      BottomNavigationBar: BottomAppBar(
        shape:  const CircularNotchedRectangle(),
        color: const Color.fromARGB(255, 124, 112, 97),
        child: Row(
          children: [
            PopMenuButtonWidget(
              Icon1: Row(
                children: const [
                  Icon(Icons.list),
                  SizedBox(width: 10,),
                  Text('Lista')
                ],
              ),
              Icon2: Row(
                children: const [
                  Icon(Icons.grid_view),
                  SizedBox(width: 10,),
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
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionBubbleMultiColor(
        Funcao1: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CriaCategoria(),),);
        },
        Funcao2: (){
          setState(() {
            FirebaseFirestore.instance.collection('Itens Cardapio').get();
          });
        },
        Funcao3: (){
          Navigator
              .of(context)
              .push(MaterialPageRoute(
            builder: (context) => const AdicionaItemCardapio(),
          ),);
        },
      ),
    );
  }
}

