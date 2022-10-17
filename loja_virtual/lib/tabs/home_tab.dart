import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
           colors: [
             Color.fromARGB(150, 255, 0, 0),
             Color.fromARGB(255, 0 ,0 ,0 ),
           ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
      ),
    );

    return Stack(
      children: [
        _buildBodyBack(),
        CustomScrollView(
          slivers:[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Novidadesss'),
                centerTitle: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
