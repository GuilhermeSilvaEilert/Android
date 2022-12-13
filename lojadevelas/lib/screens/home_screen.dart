import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/CustomDrawer.dart';
import '../tabs/home_tab.dart';
import '../tabs/products_tab.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            body: HomeTab(),
            drawer: CustomDrawer(pageController: pageController,),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text('Produtos'),
              centerTitle: true,
            ),
            drawer: CustomDrawer(pageController: pageController,),
            body: ProductsTab(),
          ),
          Container(color: Colors.black,),
          Container(color: Colors.blue,),
        ]
    );
  }
}
