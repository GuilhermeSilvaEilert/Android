import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'DrawerTile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.pageController}) : super(key: key);

  final PageController  pageController;

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack()=> Container(
      decoration:  BoxDecoration(

      ),
    );

    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0.0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: [
                    Positioned(
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
                        children:[
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
              Divider(),
              DrawerTile(icon: Icons.home,text: 'Home', pageController: pageController, page: 0),
              DrawerTile( icon: Icons.list, text: 'Ver Cardapio', pageController: pageController, page: 1),
              DrawerTile(icon: Icons.create_rounded,text: 'Criar usuario', pageController: pageController, page: 2),
              DrawerTile(icon: Icons.settings,text: 'Configurações',pageController: pageController, page: 3),
            ],
          ),
        ],
      ),
    );
  }
}
