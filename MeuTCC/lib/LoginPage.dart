import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image_button/transparent_image_button.dart';
import 'package:meutcc/Perfil.dart';
import 'package:auth_buttons/auth_buttons.dart';

class PaginaLogin extends StatelessWidget {
   PaginaLogin({Key? key}) : super(key: key);

  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            children: [
              Image.asset(
                'Assets/BannerApp/indice.png',
                width:80, height: 80,
                alignment: Alignment.center,
                scale: 0.1,
              ),
              Text('Unique'),
            ],
          )
        ),
        backgroundColor: Colors.amber,
        body: Center(
          child: Container(
            alignment: Alignment.center,
            width:400,
            height:400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Seja Bem Vindo!!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      alignment: Alignment.center,
                      width: 450,
                      height: 300,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                          style: BorderStyle.solid,
                          strokeAlign: StrokeAlign.center
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex:0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                TextField(
                                  decoration: InputDecoration(
                                    label:Text('Email',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),),
                                    hintText: 'example@gmail.com',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: email,
                                  cursorColor: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Expanded(
                            flex: 0,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  TextField(
                                    decoration: InputDecoration(
                                     label: Text('Senha', style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 20,
                                       color: Colors.black,
                                     ),

                                     ),
                                      hintText: '******',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:Colors.black
                                        )
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                    cursorColor: Colors.black,
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
                          Baseline(
                            baseline: 10,
                            baselineType: TextBaseline.ideographic,
                            child: Text('________________________________',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                            ),
                          SizedBox(height: 10,),
                         Container(
                           height:70,
                           width:200,
                           child: Column(
                             children: [
                               ElevatedButton(
                                   onPressed: (){},
                                   style: ButtonStyle(
                                     backgroundColor:MaterialStateProperty.all(
                                       Colors.white,
                                     ),
                                     side: MaterialStateProperty.all(
                                       BorderSide(
                                         color: Colors.black
                                       )
                                     )
                                   ),
                                   child: Row(
                                     children: [
                                       Image.asset(
                                         'Assets/BannerApp/google.png',
                                         width:30, height: 30,
                                         scale: 1,
                                       ),
                                        SizedBox(width: 10,),
                                       Text('Login com Google',
                                         style: TextStyle(
                                             color: Colors.black
                                         ),
                                       ),
                                     ],
                                   ),
                               ),
                             ],
                           ),
                         ),
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
