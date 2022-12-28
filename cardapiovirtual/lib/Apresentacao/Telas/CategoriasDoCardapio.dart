import 'package:cardapiovirtual/Apresentacao/AdicionaItemCardapio/AdicionaItemCardapio.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/CriaCategoriasScreen.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/ItensDoCardapio.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/ListTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';



class CategoriasDoCardapio extends StatefulWidget {
  const CategoriasDoCardapio({Key? key}) : super(key: key);

  @override
  State<CategoriasDoCardapio> createState() => _CategoriasDoCardapioState();
}

class _CategoriasDoCardapioState extends State<CategoriasDoCardapio> with SingleTickerProviderStateMixin{

  Animation<double>? _animation;
  AnimationController? _animationController;

  @override
  void initState(){
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  String? Itens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 78, 90, 85),
        bottomNavigationBar: BottomAppBar(
          shape:  CircularNotchedRectangle(),
          color: Color.fromARGB(255, 124, 112, 97),
          child: Row(
            children: [
                  PopupMenuButton(
                    itemBuilder: (context) {
                      var list = <PopupMenuEntry<Object>>[];
                      list.add(
                        PopupMenuItem(
                          value: 2,
                          child: Row(
                            children: [
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
                          value: 1,
                          child: Row(
                            children: [
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
                    icon: Icon(Icons.filter_alt),
                  ),
            ],
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionBubble(
          backGroundColor: Color.fromARGB(255, 150, 0, 0),
          iconData: Icons.add,
          animation: _animation!,
          herotag: Text('Adicionar'),
          onPress: () => _animationController!.isCompleted
              ? _animationController!.reverse()
              : _animationController!.forward(),
          iconColor: Colors.white,

          items: [
             Bubble(
                 icon: Icons.category,
                 iconColor: Colors.white,
                 title: ' + Categoria',
                 titleStyle: TextStyle(color: Colors.white),
                 bubbleColor: Color.fromARGB(255, 150, 0, 0),
                 onPress: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CriaCategoria(),),);
                },
             ),
            Bubble(
              icon: Icons.category,
              iconColor: Colors.white,
              title: ' + Itens',
              titleStyle: TextStyle(color: Colors.white),
              bubbleColor: Color.fromARGB(255, 150, 0, 0),
              onPress: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdicionaItemCardapio(),),);
              },
            ),
          ],
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
                                    Itens = snapshot.data!.docs[index]['Nome'];
                                    print('Categoria Do Cardapio $Itens');
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => ItensDoCardapio(Itens: Itens!),),
                                      );

                                  },
                                  child: Column(
                                    children: [
                                     Container(
                                       decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                              image: NetworkImage(
                                                snapshot.data?.docs[index]['Imagem'],
                                              ),
                                          ),
                                        ),
                                        height: 170,
                                        width: 170,
                                        padding: EdgeInsets.all(0),
                                       child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                          PopupMenuButton(
                                              itemBuilder: (context) {
                                              var list = <PopupMenuEntry<Object>>[];
                                              list.add(
                                                PopupMenuItem(
                                                  value: 2,
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          Icons.delete,
                                                        color: Colors.red
                                                      ),
                                                      Text('Deletar')
                                                    ],
                                                  ),
                                                ),
                                              );
                                              list.add(
                                                PopupMenuItem(
                                                  value: 1,
                                                  child: Row(
                                                    children: [
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
                                              icon: Image.asset('Assets/Icons/quicksetting.png',
                                              fit: BoxFit.cover,
                                              height: 20,
                                              width: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[
                                              Text(
                                                snapshot.data?.docs[index]['Nome'],
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

