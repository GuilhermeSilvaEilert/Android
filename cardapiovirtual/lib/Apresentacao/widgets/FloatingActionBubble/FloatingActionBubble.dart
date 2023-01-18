import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';

class FloatingActionBubbleMultiColor extends StatefulWidget {
  FloatingActionBubbleMultiColor({
  this.Funcao1,
  this.Funcao3,
  this.Funcao2
  });

  var Funcao1;
  var Funcao2;
  var Funcao3;

  @override
  State<FloatingActionBubbleMultiColor> createState() => _FloatingActionBubbleMultiColorState();
}

class _FloatingActionBubbleMultiColorState extends State<FloatingActionBubbleMultiColor> with SingleTickerProviderStateMixin{

  Animation<double>? _animation;
  AnimationController? _animationController;

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore
          .instance
          .collection('Configurações')
          .doc('Cores')
          .collection('Configura Cores')
          .get(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else{
          return FloatingActionBubble(
            backGroundColor: Color.fromARGB(
                snapshot.data!.docs[3]['Opacidade'],
                snapshot.data!.docs[3]['Red'],
                snapshot.data!.docs[3]['Green'],
                snapshot.data!.docs[3]['Blue']),
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
                  bubbleColor: Color.fromARGB(
                      snapshot.data!.docs[3]['Opacidade'],
                      snapshot.data!.docs[3]['Red'],
                      snapshot.data!.docs[3]['Green'],
                      snapshot.data!.docs[3]['Blue']),
                  onPress: widget.Funcao1
              ),
              Bubble(
                  icon: Icons.restart_alt,
                  iconColor: Colors.white,
                  title: 'Recarregar',
                  titleStyle: const TextStyle(color: Colors.white),
                  bubbleColor: Color.fromARGB(
                      snapshot.data!.docs[3]['Opacidade'],
                      snapshot.data!.docs[3]['Red'],
                      snapshot.data!.docs[3]['Green'],
                      snapshot.data!.docs[3]['Blue']),
                  onPress: widget.Funcao2
              ),
              Bubble(
                icon: Icons.category,
                iconColor: Colors.white,
                title: ' + Itens',
                titleStyle: const TextStyle(color: Colors.white),
                bubbleColor: Color.fromARGB(
                    snapshot.data!.docs[3]['Opacidade'],
                    snapshot.data!.docs[3]['Red'],
                    snapshot.data!.docs[3]['Green'],
                    snapshot.data!.docs[3]['Blue']),
                onPress: widget.Funcao3,
              ),

            ],
          );
        }
        },
    );
  }
}
