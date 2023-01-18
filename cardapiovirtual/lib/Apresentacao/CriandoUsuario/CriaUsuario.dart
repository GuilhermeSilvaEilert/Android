import 'package:flutter/material.dart';

class CriaUsuarioGarsom extends StatelessWidget {
  const CriaUsuarioGarsom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                 image: NetworkImage('https://cdn-icons-png.flaticon.com/512/6360/6360061.png'),
              ),
              ),
            ),
            Text('Pagina em desenvolvimento, \nvolte mais tarde obrigado',
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
