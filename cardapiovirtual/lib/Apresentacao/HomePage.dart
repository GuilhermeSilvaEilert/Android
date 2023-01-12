// ignore_for_file: file_names

import 'package:cardapiovirtual/Apresentacao/Telas/CategoriasDoCardapio.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/Drawer.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/HomeWidget.dart';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cardapiovirtual/CamadaDeNegócio/ConfiguracoesSistema/Configuracoes.dart';
import 'Telas/CriandoUsuario/CriaUsuario.dart';


class AdmHomePage extends StatelessWidget {
   AdmHomePage({Key? key, this.snapshot}) : super(key: key);

  final _pageController = PageController();
  final ConectaFirebase conectaFirebase = ConectaFirebase();
  final DocumentSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 78, 90, 85),
            centerTitle: true,
            title: const Text('Seu Cardapio'),
          ),
          backgroundColor: const Color.fromARGB(255, 78, 90, 85),
          body: HomeWidget(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 78, 90, 85),
            centerTitle: true,
            title: const Text('Seu Cardapio'),
          ),
          backgroundColor: const Color.fromARGB(255, 78, 90, 85),
          body: const CategoriasDoCardapio(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 78, 90, 85),
            centerTitle: true,
            title: const Text('Seu Cardapio'),
          ),
          backgroundColor: const Color.fromARGB(255, 78, 90, 85),
          body: const CriaUsuarioGarsom(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 78, 90, 85),
            centerTitle: true,
            title: const Text('Seu Cardapio'),
          ),
          backgroundColor: const Color.fromARGB(255, 78, 90, 85),
          body: const Configuracoes(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
      ],
    );
  }
}

