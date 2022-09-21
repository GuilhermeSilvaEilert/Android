import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaLogin extends StatelessWidget {
  const PaginaLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(
               'Login',
               textAlign: TextAlign.end,
               style: TextStyle(
                 fontSize: 15,
                 fontWeight: FontWeight.bold,
               ),
             ),
               TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Senha',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),),
              SizedBox(height: 10,),
             TextButton(
                 onPressed: (){},
                 child: Text(
                   'Login',
                 style: TextStyle(
                   fontSize: 18,
                   color: Colors.black,
                 ),
                 ),
             ),
            ],
          ),
        ),
    );
  }
}
