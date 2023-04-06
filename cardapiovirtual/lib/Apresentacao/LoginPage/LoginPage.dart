// ignore_for_file: file_names

import 'package:cardapiovirtual/Apresentacao/HomePage/HomePage.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../Model/itemModel.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool? salvaSenha = false;
  int checkBox = 0;

  final _formValidateKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController  =  TextEditingController();

  @override
  initState(){
    checkBox = 0;
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {

    return ScaffoldMultiColor(
      Body: ScopedModelDescendant<CardapioModel>(
        builder: (context, child, model) {
          if(model!.isLoading!){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Form(
                    key: _formValidateKey,
                    child: Container(
                      padding: const EdgeInsets.all(50),
                      alignment: Alignment.topCenter,
                      child: Column(
                          children:[
                            FutureBuilder(
                              future: FirebaseFirestore.instance.collection('Configurações').get(),
                              builder: (context, snapshot) {
                                if(!snapshot.hasData){
                                  String? imagem = snapshot.data!.docs[1]['Image'];
                                  return Image.network(imagem!, height: 100, width: 100,);
                                }else{
                                  return Image.asset('Assets/LogoMarca/LogoMarcaTG.png', height: 100, width: 100,);
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
                              child: TextFormField(
                                controller: emailController,
                                validator: (text) {
                                  if(text!.isEmpty || !text!.contains('@')){
                                    return 'Email invalido';
                                  }
                                },
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
                              child: TextFormField(
                                controller: passController,
                                validator: (text) {
                                  if(text!.isEmpty){
                                    return 'Senha invalida';
                                  }
                                },
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
                                          const Color.fromARGB(255, 150, 0, 0)
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
                              funcao: () async {
                                  if(_formValidateKey.currentState!.validate()){
                                    model.signIn(
                                      email: emailController.text,
                                      pass: passController.text,
                                      onSucess: onSucess,
                                      onFail: onFail,
                                    );
                                  }
                              },
                              altura: 50,
                              largura: 200,
                              text: const Text('LOGIN',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  onSucess() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            'Login bem sucedido'
          ),
        backgroundColor: Colors.green,
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => AdmHomePage(),
      ),
    );
  }

  onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Senha ou Email Incorretos'
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

}
