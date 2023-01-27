// ignore_for_file: file_names

import 'package:cardapiovirtual/Apresentacao/LoginPage/LoginPage.dart';
import 'package:cardapiovirtual/Apresentacao/CategoriasDoCardapio/CategoriasDoCardapio.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/Drawer/Drawer.dart';
import 'package:cardapiovirtual/Apresentacao/HomeWidget.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cardapiovirtual/CamadaDeNegócio/ConfiguracoesSistema/Configuracoes.dart';
import 'package:cardapiovirtual/Apresentacao/CriandoUsuario/CriaUsuario.dart';


class AdmHomePage extends StatelessWidget {
   AdmHomePage({Key? key,}) : super(key: key);

  final _pageController = PageController();
  final ConectaFirebase conectaFirebase = ConectaFirebase();

  @override
  Widget build(BuildContext context) {
    return
      PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  ScaffoldMultiColor(
                    TextAppBar: const Text('Seu Cardapio'),
                    Body: const HomeWidget(),
                    drawer: CustomDrawer(pageController: _pageController),
                  ),

                  ScaffoldMultiColor(
                    TextAppBar: const Text('Seu Cardapio'),
                    Body: const CategoriasDoCardapio(),
                    drawer: CustomDrawer(pageController: _pageController),
                  ),

                  ScaffoldMultiColor(
                    TextAppBar: const Text('Seu Cardapio'),
                    Body: const CriaUsuarioGarsom(),
                    drawer: CustomDrawer(pageController: _pageController),
                  ),

                  ScaffoldMultiColor(
                    TextAppBar: Row(children: [
                      const Text('Configurações'),
                      IconButton(
                          onPressed: (){
                            FirebaseFirestore
                                .instance
                                .collection('Configurações')
                                .doc('Cores')
                                .collection('Configura Cores')
                                .get();
                            Navigator
                                .of(context)
                                .push(MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                          },
                          icon: const Icon(Icons.keyboard_return_outlined)
                      ),
                    ],
                    ),
                    Body: const TelaConfiguracoes(),
                    drawer: CustomDrawer(pageController: _pageController),
                  ),
                ],
              );


  }
}

