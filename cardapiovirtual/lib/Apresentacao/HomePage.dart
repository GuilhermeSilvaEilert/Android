// ignore_for_file: file_names

import 'package:cardapiovirtual/Apresentacao/LoginPage/LoginPage.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/CategoriasDoCardapio.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/Drawer.dart';
import 'package:cardapiovirtual/Apresentacao/Telas/HomeWidget.dart';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cardapiovirtual/CamadaDeNegócio/ConfiguracoesSistema/Configuracoes.dart';
import 'Telas/CriandoUsuario/CriaUsuario.dart';


class AdmHomePage extends StatelessWidget {
   AdmHomePage({Key? key,}) : super(key: key);

  final _pageController = PageController();
  final ConectaFirebase conectaFirebase = ConectaFirebase();

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
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
            }else {
              return PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  Scaffold(
                    appBar: AppBar(

                      backgroundColor: Color.fromARGB(
                          snapshot.data!.docs[1]['Opacidade'],
                          snapshot.data!.docs[1]['Red'],
                          snapshot.data!.docs[1]['Green'],
                          snapshot.data!.docs[1]['Blue']
                      ),
                      centerTitle: true,
                      title: const Text('Seu Cardapio'),
                    ),
                    backgroundColor: Color.fromARGB(
                        snapshot.data!.docs[1]['Opacidade'],
                        snapshot.data!.docs[1]['Red'],
                        snapshot.data!.docs[1]['Green'],
                        snapshot.data!.docs[1]['Blue']
                    ),
                    body: HomeWidget(),
                    drawer: CustomDrawer(pageController: _pageController),
                  ),
                  Scaffold(
                    appBar: AppBar(
                      backgroundColor: Color.fromARGB(
                          snapshot.data!.docs[1]['Opacidade'],
                          snapshot.data!.docs[1]['Red'],
                          snapshot.data!.docs[1]['Green'],
                          snapshot.data!.docs[1]['Blue']
                      ),
                      centerTitle: true,
                      title: const Text('Seu Cardapio'),
                    ),
                    backgroundColor: Color.fromARGB(
                        snapshot.data!.docs[1]['Opacidade'],
                        snapshot.data!.docs[1]['Red'],
                        snapshot.data!.docs[1]['Green'],
                        snapshot.data!.docs[1]['Blue']
                    ),
                    body: const CategoriasDoCardapio(),
                    drawer: CustomDrawer(pageController: _pageController),
                  ),
                  Scaffold(
                    appBar: AppBar(
                      backgroundColor: Color.fromARGB(
                          snapshot.data!.docs[1]['Opacidade'],
                          snapshot.data!.docs[1]['Red'],
                          snapshot.data!.docs[1]['Green'],
                          snapshot.data!.docs[1]['Blue']
                      ),
                      centerTitle: true,
                      title: const Text('Seu Cardapio'),
                    ),
                    backgroundColor: Color.fromARGB(
                        snapshot.data!.docs[1]['Opacidade'],
                        snapshot.data!.docs[1]['Red'],
                        snapshot.data!.docs[1]['Green'],
                        snapshot.data!.docs[1]['Blue']
                    ),
                    body: const CriaUsuarioGarsom(),
                    drawer: CustomDrawer(pageController: _pageController),
                  ),
                  Scaffold(
                    appBar: AppBar(

                      backgroundColor: Color.fromARGB(
                          snapshot.data!.docs[1]['Opacidade'],
                          snapshot.data!.docs[1]['Red'],
                          snapshot.data!.docs[1]['Green'],
                          snapshot.data!.docs[1]['Blue']
                      ),
                      centerTitle: true,
                      title: Row(children: [
                        Text('Configurações'),
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
                            icon: Icon(Icons.keyboard_return_outlined)
                        ),
                      ],)
                    ),
                    backgroundColor: Color.fromARGB(
                        snapshot.data!.docs[1]['Opacidade'],
                        snapshot.data!.docs[1]['Red'],
                        snapshot.data!.docs[1]['Green'],
                        snapshot.data!.docs[1]['Blue']
                    ),
                    body: TelaConfiguracoes(),
                    drawer: CustomDrawer(pageController: _pageController),
                  ),
                ],
              );
            }
          },
      );

  }
}

