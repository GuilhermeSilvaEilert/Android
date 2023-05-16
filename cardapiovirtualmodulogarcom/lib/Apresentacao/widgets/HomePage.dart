import 'package:cardapiovirtualmodulogarcom/Apresentacao/EditaUsuario/EditaUsuario.dart';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/HomeGarcom.dart';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/Drawer/Drawer.dart';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/Models/CardapioModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class GarcomHomePage extends StatelessWidget {
  GarcomHomePage({Key? key,}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return
      ScopedModel<CardapioModel>(
        model: CardapioModel(),
        child: PageView(
          padEnds: true,
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            ScaffoldMultiColor(
              TextAppBar: const Text('Garçom'),
              Body: HomeGarcom(),
              drawer: CustomDrawer(pageController: _pageController),
            ),
            ScaffoldMultiColor(
              TextAppBar: const Text('Usuario'),
              Body: EditaUsuario(),
              drawer: CustomDrawer(pageController: _pageController),
            ),
          ],
        ),
      );
  }
}