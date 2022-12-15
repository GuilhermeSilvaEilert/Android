import 'dart:io';
import 'package:cardapiovirtual/Apresentacao/AdicionaItemCardapio/AdicionaItemCardapio.dart';
import 'package:cardapiovirtual/Apresentacao/Widgets/Drawer.dart';
import 'package:cardapiovirtual/Apresentacao/Widgets/HomeWidget.dart';
import 'package:cardapiovirtual/Apresentacao/Widgets/ItensDoCardapio.dart';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AdmHomePage extends StatefulWidget {
   AdmHomePage({Key? key,}) : super(key: key);


  @override
  State<AdmHomePage> createState() => _AdmHomePageState();
}

class _AdmHomePageState extends State<AdmHomePage> {

  final _pageController = PageController();
  final ConectaFirebase conectaFirebase = ConectaFirebase();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 78, 90, 85),
            centerTitle: true,
            title: Text('Seu Cardapio'),
          ),
          backgroundColor: Color.fromARGB(255, 78, 90, 85),
          body: HomeWidget(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 78, 90, 85),
            centerTitle: true,
            title: Text('Seu Cardapio'),
          ),
          backgroundColor: Color.fromARGB(255, 78, 90, 85),
          body: ItensDoCardapio(),
          drawer: CustomDrawer(pageController: _pageController),
        ),

      ],
    );
  }
}
