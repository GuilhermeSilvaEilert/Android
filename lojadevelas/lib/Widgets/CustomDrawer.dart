import 'package:flutter/material.dart';
import 'package:lojadevelas/Models/User_model.dart';
import 'package:lojadevelas/screens/login_screen.dart';
import 'package:lojadevelas/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatefulWidget {
   CustomDrawer({Key? key,  required this.pageController}) : super(key: key);

  final PageController  pageController;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text('Ola,${!model.isLoggedIn() ? ' ' : model!.userData!['name']} ',
                                style:TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn() ?
                                  'Entre ou Cadastre-se >'
                                  :'Sair',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                                onTap: (){
                                  if(!model.isLoggedIn())
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => LoginScreen(),));
                                  else
                                    model.signOut();
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(icon: Icons.home,text: 'Inicio', pageController: widget.pageController, page: 0),
              DrawerTile(icon: Icons.list,text: 'Produtos',pageController: widget.pageController, page: 1),
              DrawerTile(icon: Icons.location_on,text: 'Lojas', pageController: widget.pageController,page: 2,),
              DrawerTile(icon: Icons.playlist_add_check,text: 'Meus Pedidos',pageController:  widget.pageController, page: 3,),
            ],
          ),
        ],
      ),
    );
  }
}
