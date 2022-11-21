import 'package:flutter/material.dart';

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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
