import 'package:cardapiovirtual/Apresentacao/AdicionaItemCardapio/AdicionaItemCardapio.dart' show AdicionaItemCardapio;
import 'package:cardapiovirtual/Apresentacao/Telas/CriaCategoriasScreen.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/ListViewGridViewUnico/GridView.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/ListViewGridViewUnico/ListView.dart';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';

class CategoriasDoCardapio extends StatefulWidget {
  const CategoriasDoCardapio({Key? key}) : super(key: key);

  @override
  State<CategoriasDoCardapio> createState() => _CategoriasDoCardapioState();
}

class _CategoriasDoCardapioState extends State<CategoriasDoCardapio> with SingleTickerProviderStateMixin{

  Animation<double>? _animation;
  AnimationController? _animationController;

  ConectaFirebase conectaFirebase = ConectaFirebase();

  var existeItens;
  int? existeDados;
  int? resultadoConsulta;
  var decisao;
  int? consultaCategorias;
  int? QuantidadeItens;

  Future AtualizaPagina() async{
      FirebaseFirestore
          .instance
          .collection('Itens Cardapio').get();
  }


  Future<int> ValidaExistenciaCategoria() async {

    final QuerySnapshot result = await Future.value(
      FirebaseFirestore
          .instance
          .collection('Itens Cardapio').get(),
    );

    consultaCategorias = result.docs.length;

    print(consultaCategorias);

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

  String? Itens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 78, 90, 85),
        bottomNavigationBar: BottomAppBar(
          shape:  const CircularNotchedRectangle(),
          color: const Color.fromARGB(255, 124, 112, 97),
          child: Row(
            children: [
              PopupMenuButton(
                    itemBuilder: (context) {
                      var list = <PopupMenuEntry<Object>>[];
                      list.add(
                        PopupMenuItem(
                          onTap: (){
                            setState(() {
                              gradeOuLista = false;
                            });
                          },
                          value: 2,
                          child: Row(
                            children: const [
                              Icon(
                                  Icons.list,
                                  color: Colors.black
                              ),
                              SizedBox(width: 5,),
                              Text('Ver como Lista')
                            ],
                          ),
                        ),
                      );
                      list.add(
                        PopupMenuItem(
                          onTap: (){
                            setState(() {
                              gradeOuLista = true;
                            });
                          },
                          value: 1,
                          child: Row(
                            children: const [
                              Icon(
                                Icons.grid_view,
                                color: Colors.black,
                              ),
                              SizedBox(width: 5,),
                              Text('Ver como Grade')
                            ],
                          ),
                        ),
                      );
                      return list;
                    },
                    icon: const Icon(Icons.filter_alt),
                  ),
            ],
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionBubble(
          backGroundColor: const Color.fromARGB(255, 150, 0, 0),
          iconData: Icons.add,
          animation: _animation!,
          herotag: const Text('Adicionar'),
          onPress: () => _animationController!.isCompleted
              ? _animationController!.reverse()
              : _animationController!.forward(),
          iconColor: Colors.white,
          items: [
             Bubble(
                 icon: Icons.category,
                 iconColor: Colors.white,
                 title: ' + Categoria',
                 titleStyle: const TextStyle(color: Colors.white),
                 bubbleColor: const Color.fromARGB(255, 150, 0, 0),
                 onPress: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CriaCategoria(),),);
                },
             ),
            Bubble(
              icon: Icons.restart_alt,
              iconColor: Colors.white,
              title: 'Recarregar',
              titleStyle: const TextStyle(color: Colors.white),
              bubbleColor: const Color.fromARGB(255, 150, 0, 0),
              onPress: (){
                setState(() {
                  FirebaseFirestore
                      .instance
                      .collection('Itens Cardapio').get();
                });
              },
            ),
            Bubble(
              icon: Icons.category,
              iconColor: Colors.white,
              title: ' + Itens',
              titleStyle: const TextStyle(color: Colors.white),
              bubbleColor: const Color.fromARGB(255, 150, 0, 0),
              onPress: (){
                Navigator
                    .of(context)
                    .push(MaterialPageRoute(
                  builder: (context) => const AdicionaItemCardapio(),
                ),);
              },
            ),

          ],
        ),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('Itens Cardapio').get(),
                  builder: (context, snapshot){
                    ValidaExistenciaCategoria();
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
                          consultaCategorias == 0 || consultaCategorias == null ?
                          Center(
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
                           Center(
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
                            padding: EdgeInsets.only(top: 10),
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
            ),
          ],
        ),
    );
  }
}

