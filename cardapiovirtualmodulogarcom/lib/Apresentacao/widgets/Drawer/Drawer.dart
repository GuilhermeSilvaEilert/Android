import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import'DrawerTile/DrawerTile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.pageController}) : super(key: key);

  final PageController  pageController;



  @override
  Widget build(BuildContext context) {

    Widget buildDrawerBack() {
      return FutureBuilder(
          future: FirebaseFirestore
              .instance
              .collection('Configurações')
              .doc('Cores')
              .collection('Configura Cores')
              .get(),
        builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.grey
                ),
              );
            }else {
              return Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(
                    snapshot.data!.docs[2]['Opacidade'],
                    snapshot.data!.docs[2]['Red'],
                    snapshot.data!.docs[2]['Green'],
                    snapshot.data!.docs[2]['Blue'],),
                ),
              );
            }
        }
      );
    }
        return Drawer(
          child: Stack(
            children: [
              buildDrawerBack(),
              ListView(
                padding: const EdgeInsets.only(left: 32, top: 16),
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.fromLTRB(0.0, 16, 16, 8),
                    height: 170,
                    child: Stack(
                      children: [
                        const Positioned(
                          top:8,
                          left: 8,
                          child: Text('Gerenciamento',
                            style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0.0,
                          bottom: 0.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:const [
                              Text('Ola, seja bem vindo',
                                style:TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  DrawerTile(icon: Icons.home,text: 'Home', pageController: pageController, page: 0),
                  DrawerTile( icon: Icons.perm_identity, text: 'Editar Usuario', pageController: pageController, page: 1),
                ],
              ),
            ],
          ),
        );
  }
}
