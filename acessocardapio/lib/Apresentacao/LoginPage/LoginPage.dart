// ignore_for_file: file_names

//import 'package:cardapiovirtual/Apresentacao/HomePage/HomePage.dart';
import 'package:acessocardapio/Apresentacao/CardapioPage/CardapioPage.dart';
import 'package:acessocardapio/Apresentacao/DadosComanda/DadosComanda.dart';
import 'package:acessocardapio/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:acessocardapio/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:acessocardapio/Negocio/Model/DataBase/DataBase.dart';
import 'package:acessocardapio/Negocio/Model/itemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool? salvaSenha = false;
  int checkBox = 0;
  String? UserRoot;
  Endereco endereco = Endereco();
  SQLiteDB liteDb = SQLiteDB();

  List<Endereco> list = [];
  List lists = [];
  int? i;

  final GoogleSignIn? googleSignIn = GoogleSignIn();

  User? _currentUser;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _currentUser = user;
    });

    checkBox = 0;
    super.initState();
  }

   _getUser() async {

     if(_currentUser != null) {
       return _currentUser;
     }

    try{
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn!.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      final UserCredential authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = authResult.user;

      return user;
    }catch (error){
      return null;
    }
  }

  final _formValidateKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController  =  TextEditingController();
  final TextEditingController categoriaProduto = TextEditingController();
  dynamic firstItem;

  CaminhoDB() async {
    print('iniciando db');
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance
            .collection('Empresa')
            .get()
    );
    if(lists.isEmpty){
      int counter = result.docs.length - 1;
      for(int i = 0; i <= counter; i++){
        lists.add(result.docs[i]['Nome']);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    CaminhoDB();
    emailController.text = 'deadpool@gmail.com';
    passController.text = '123456';
    return ScopedModel<CardapioModel>(
        model: CardapioModel(),
        child: ScopedModelDescendant<CardapioModel>(
          builder: (context, child, model) {
            return ScaffoldMultiColor(
                Body: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Form(
                        key: _formValidateKey,
                        child: Container(
                          padding: const EdgeInsets.all(50),
                          alignment: Alignment.topCenter,
                          child: Column(
                              children:[
                                Image.asset('Assets/LogoMarca/LogoMarcaTG.png', height: 100, width: 100,),
                                Container(
                                  padding: const EdgeInsets.all(30),
                                  child: const Text('Bem Vindo', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: 425,
                                  height: 70,
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

                                Container(
                                  width: 425,
                                  height: 70,
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
                                     // hoverColor: Colors.black,
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
                                FutureBuilder(
                                  builder: (context, snapshot) {
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      width: 410,
                                      height: 55,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          borderRadius: BorderRadius.circular(15),
                                          hint: Row(
                                            children: const [
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Categoria',
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          value: firstItem,
                                          isExpanded: true,
                                          onChanged: (value){
                                            setState(() {
                                              firstItem = value;
                                            });
                                            categoriaProduto.text = firstItem;
                                          },
                                          items: lists.map((Item) => DropdownMenuItem(
                                            value: Item,
                                            child: Text(
                                              Item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),).toList(),
                                        ),
                                      ),
                                    );
                                  }
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        print('Abrindo CaminhoRoot');
                                        print('Empresa: ${categoriaProduto.text}');
                                        final QuerySnapshot result = await Future.value(
                                            FirebaseFirestore.instance
                                                .collection('Empresa')
                                                .doc(categoriaProduto.text)
                                                .collection('Raiz')
                                                .get()
                                        );
                                        print('Email: ${result.docs[0]['Email']}');
                                        UserRoot = await result.docs[0]['Email'];
                                        print('userRoot $UserRoot');
                                      model.signOut();
                                      model.signIn(
                                        email: emailController.text,
                                        pass: passController.text,
                                        onFail: onFail,
                                        onSucess: onSucess
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
                                SizedBox(height: 10,),
                                /*ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.white
                                    ),
                                    fixedSize: MaterialStateProperty.all(
                                      Size(200, 50)
                                    ),
                                  ),
                                    onPressed: () async {
                                      final User? user = await _getUser();
                                      if( categoriaProduto.text.isEmpty){
                                        RestauranteNulo;
                                      }else if(user == null){
                                        UsuarioNulo;
                                      }else{
                                        onSucess;
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.g_mobiledata, color: Colors.black,),
                                        Text('Login com Google',
                                            style: TextStyle(
                                              color: Colors.black
                                            )
                                        ),
                                      ],
                                    )
                                )*/
                              ]
                          ),
                        ),
                      ),
                    )
                  ],
                )
            );
          }
        )
    );
  }

  RestauranteNulo() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Selecione um restaurante'
        ),
        backgroundColor: Colors.red,
      ),
    );
    print(categoriaProduto.text);
    await Future.delayed(Duration(seconds: 2));
  }

  UsuarioNulo() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Selecione um restaurante'
        ),
        backgroundColor: Colors.red,
      ),
    );
    print(categoriaProduto.text);
    await Future.delayed(Duration(seconds: 2));
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
    print(categoriaProduto.text);
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => DadosComanda(
          UserRoot: UserRoot,
        ),
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
