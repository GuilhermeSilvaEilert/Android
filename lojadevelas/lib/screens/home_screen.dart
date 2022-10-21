import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../tabs/home_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
        physics: NeverScrollableScrollPhysics(),
        children:[
          HomeTab(),
        ]
    );
  }
}
