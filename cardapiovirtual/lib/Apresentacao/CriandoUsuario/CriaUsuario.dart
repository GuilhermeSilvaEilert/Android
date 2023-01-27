
// ignore_for_file: file_names

import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';

import 'package:flutter/material.dart';

class CriaUsuarioGarsom extends StatelessWidget {
  const CriaUsuarioGarsom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      ScaffoldMultiColor(
        Body: Center(
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://cdn-icons-png.flaticon.com/512/6360/6360061.png'),
                  ),
                ),
              ),
              const Text('Pagina em desenvolvimento, \nvolte mais tarde obrigado',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
  }
}
