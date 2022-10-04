import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image_button/transparent_image_button.dart';
import 'package:meutcc/Perfil.dart';
import 'package:auth_buttons/auth_buttons.dart';

class PaginaLogin extends StatelessWidget {
  const PaginaLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
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
                 onPressed: (){
                   Navigator.push(
                       context,
                    MaterialPageRoute(builder: (context)=>Perfis()),
                   );
                 },
                 child: const Text(
                   'Login',
                   style: TextStyle(
                     fontSize: 18,
                     color: Colors.black,
                   ),
                 ),
               ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.blue
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children:[
                      GoogleAuthButton(
                        onPressed:(){

                        }
                      ),
                      TransparentImageButton.assets(
                        'Assets/BannerApp/google.png',
                        width: 45,
                        opacityThreshold: 0.1,
                        onTapInside: () => print("You tapped the image."),
                      ),
                      Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
