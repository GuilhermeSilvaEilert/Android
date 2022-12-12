import 'package:cardapiovirtual/Apresentacao/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);



  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool? teste;

  ConectaFirebase conectaFirebase = ConectaFirebase();

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(50),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 78, 90, 85),
      ),
        child: Column(
          children:[
            Image.asset('Assets/LogoMarca/LogoMarcaTG.png', height: 100, width: 100,),
            Container(
              padding: EdgeInsets.all(30),
                child: Text('Bem Vindo', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
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
                    borderSide:BorderSide(color: Colors.black),
                  ),
                  hintText: 'Login',
                  counterStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black,),
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
                    borderSide:BorderSide(color: Colors.black),
                  ),
                  hintText: 'Senha',
                  counterStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Checkbox(
                      value: false,
                      onChanged: (value) {
                        print('teste');
                      }),
                  Text('Lembrar da senha ?'),
                ],
              ),
            ),

            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdmHomePage()));
              },
              child: Padding(
                padding: const EdgeInsets.only( top: 9, right: 60, left: 60, bottom: 9),
                child: Text('LOGIN',
                            style: TextStyle(
                            color: Colors.white
                          ),
                        ),
              ),
              style:  ButtonStyle(
                shape:MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 150, 0, 0),
                ),
              ),
            ),
          ]
        ),
    );
  }
}
