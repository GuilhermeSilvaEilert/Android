import 'package:cardapiovirtual/Apresentacao/Telas/CategoriasDoCardapio.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/Drawer.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/HomeWidget.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/ItensDoCardapio.dart';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AdmHomePage extends StatelessWidget {
   AdmHomePage({Key? key, this.snapshot}) : super(key: key);

  final _pageController = PageController();
  final ConectaFirebase conectaFirebase = ConectaFirebase();
  final DocumentSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 78, 90, 85),
            centerTitle: true,
            title: Text('Seu Cardapio'),
          ),
          backgroundColor: Color.fromARGB(255, 78, 90, 85),
          body: HomeWidget(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 78, 90, 85),
            centerTitle: true,
            title: Text('Seu Cardapio'),
          ),
          backgroundColor: Color.fromARGB(255, 78, 90, 85),
          body: CategoriasDoCardapio(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
      ],
    );
  }
}

