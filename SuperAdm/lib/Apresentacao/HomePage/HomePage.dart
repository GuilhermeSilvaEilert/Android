import 'package:flutter/material.dart';
import 'package:superadm/Apresentacao/Drawer/Drawer.dart';
import 'package:superadm/Apresentacao/ListaDeAgencias/ListaDeAgencias.dart';
import 'package:superadm/Apresentacao/ScaffoldMulticolor/ScaffoldMulticolor.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics:  const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        ScaffoldMultiColor(
          Body: AgenciasLicenciadas(),
          TextAppBar: Text('Restaurantes Cadastrados'),
          drawer: CustomDrawer(pageController: _pageController,),
        ),
        ScaffoldMultiColor(
          Body: Container(),
          drawer: CustomDrawer(pageController: _pageController,),
        ),
      ],
    );
  }
}
