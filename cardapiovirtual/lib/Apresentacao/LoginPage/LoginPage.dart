// ignore_for_file: file_names

import 'package:cardapiovirtual/Apresentacao/HomePage/HomePage.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool? salvaSenha = false;
  int checkBox = 0;

  @override
  Widget build(BuildContext context) {

    return ScaffoldMultiColor(
      Body: Container(
        padding: const EdgeInsets.all(50),
        alignment: Alignment.topCenter,
          child: Column(
            children:[
              FutureBuilder(
                future: FirebaseFirestore.instance.collection('Configurações').get(),
                  builder: (context, snapshot) {
                  String? imagem = snapshot.data!.docs[1]['Image'];
                  if(imagem == null || imagem == ''){
                    return Image.asset('Assets/LogoMarca/LogoMarcaTG.png', height: 100, width: 100,);
                  }else{
                    return Image.network(imagem, height: 100, width: 100,);
                  }
                  },
              ),
              Container(
                padding: const EdgeInsets.all(30),
                  child: const Text('Bem Vindo', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  cursorColor: Colors.black,
                  decoration:InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(15),
                      borderSide:const BorderSide(color: Colors.black),
                    ),
                    hintText: 'Login',
                    counterStyle: const TextStyle(color: Colors.black),
                    labelStyle: const TextStyle(color: Colors.black,),
                    border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  obscureText: true,
                  cursorColor: Colors.black,
                  decoration:InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hoverColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:const BorderSide(color: Colors.black),
                    ),
                    hintText: 'Senha',
                    counterStyle: const TextStyle(color: Colors.black),
                    labelStyle: const TextStyle(color: Colors.black,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Checkbox(
                      focusColor: Colors.black,
                      autofocus: true,
                      overlayColor: MaterialStateProperty.all(
                        Colors.grey
                      ),
                      fillColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 150, 0, 0)
                      ),
                      checkColor:  Colors.black,
                      splashRadius: 20,
                        value: salvaSenha,
                        onChanged: (value) {
                          checkBox ++;
                          if(checkBox == 1){
                            return setState(() {
                              value = true;
                              salvaSenha = true;
                            });
                          }else{
                            checkBox = 0;
                            return setState(() {
                              value = false;
                              salvaSenha = false;
                            });
                          }

                        }),
                    const Text('Lembrar da senha ?'),
                  ],
                ),
              ),

              TextButtonMultiColor(
                funcao: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdmHomePage()));
                },
                altura: 50,
                largura: 200,
                text: Text('LOGIN',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ]
          ),
      ),
    );
  }
}
