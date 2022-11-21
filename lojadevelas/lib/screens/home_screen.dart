import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/CustomDrawer.dart';
import '../tabs/home_tab.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children:const [
          Scaffold(
            body: HomeTab(),
            drawer: CustomDrawer(),
          )
        ]
    );
  }
}
