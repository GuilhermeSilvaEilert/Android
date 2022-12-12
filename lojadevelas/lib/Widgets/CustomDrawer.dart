import 'package:flutter/material.dart';
import 'package:lojadevelas/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack()=> Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 200, 0, 0),
              Color.fromARGB(255, 50,10, 10),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
        ),
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
                        child: Text('Velanceado',
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
                          Text('Ola, ',
                          style:TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                          GestureDetector(
                            child: Text('Entre ou Cadastre-se >',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              ),
                            onTap: (){

                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(icon: Icons.home,text: 'Inicio',),
              DrawerTile(icon: Icons.list,text: 'Produtos',),
              DrawerTile(icon: Icons.location_on,text: 'Lojas',),
              DrawerTile(icon: Icons.playlist_add_check,text: 'Meus Pedidos',),
            ],
          ),
        ],
      ),
    );
  }
}
