import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaLogin extends StatelessWidget {
  const PaginaLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Unique',
                              style: TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.bold,
                              ),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                'Assets/BannerApp/TccImg.png',
                                width:150, height: 150,
                                alignment: Alignment.center),
                          ],
                        ),
                      ],
                    ),
                ),

                Expanded(
                  flex:0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                      'Email',
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
                    ],
                  ),
                ),
                 Expanded(
                  flex: 0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
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
                      ),
                     ),
                   ]
                 ),
               ),
               TextButton(
                 onPressed: (){},
                 child: const Text(
                   'Login',
                   style: TextStyle(
                     fontSize: 18,
                     color: Colors.black,
                   ),
                 ),
               ),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                    onPressed: (){},
                  child: const Icon(Icons.login),
                )
              ],
            ),
          ),
        ),
    );
  }
}
