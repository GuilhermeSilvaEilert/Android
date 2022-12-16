import 'package:cardapiovirtual/Apresentacao/Widgets/Drawer.dart';
import 'package:cardapiovirtual/Apresentacao/Widgets/HomeWidget.dart';
import 'package:cardapiovirtual/Apresentacao/Widgets/ItensDoCardapio.dart';
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
      physics: const NeverScrollableScrollPhysics(),
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
          body: ItensDoCardapio(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
      ],
    );
  }
}

