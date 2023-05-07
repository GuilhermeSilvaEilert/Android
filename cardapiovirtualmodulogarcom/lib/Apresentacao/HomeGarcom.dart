import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:flutter/material.dart';

class HomeGarcom extends StatefulWidget {
  const HomeGarcom({Key? key}) : super(key: key);

  @override
  State<HomeGarcom> createState() => _HomeGarcomState();
}

class _HomeGarcomState extends State<HomeGarcom> {
  @override
  Widget build(BuildContext context) {
    return  ScaffoldMultiColor(
      Body: Container(
      ),
      AppBar: AppBar(),
    );
  }
}
