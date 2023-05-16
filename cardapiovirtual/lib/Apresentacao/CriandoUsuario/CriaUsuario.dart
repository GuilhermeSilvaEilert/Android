
import 'dart:convert';
import 'dart:io';
import 'package:cardapiovirtual/Model/itemModel.dart';
import 'package:crypto/crypto.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../Repository/ConectaFirebase.dart';

class CriaUsuarioGarcom extends StatefulWidget {
  const CriaUsuarioGarcom({Key? key}) : super(key: key);

  @override
  State<CriaUsuarioGarcom> createState() => _CriaUsuarioGarcomState();
}

class _CriaUsuarioGarcomState extends State<CriaUsuarioGarcom> {

  final ImagePicker _picker = ImagePicker();
  ConectaFirebase conectaFirebase = ConectaFirebase();
  File? fileSend;
  XFile? imgFile;
  String? file;

  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController EmailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
      Body: ScopedModelDescendant<CardapioModel>(
        builder: (context, child, model) {
          if(model!.isLoading!){
            return Center(child: CircularProgressIndicator());
          }else{
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.transparent
                            ),
                            shadowColor: MaterialStatePropertyAll(
                                Colors.transparent
                            ),
                          ),
                          onPressed:() async {
                            showModalBottomSheet(
                                context: context,
                                builder: (context){
                                  return BottomSheet(
                                    builder: (context){
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: FloatingActionButton(
                                                    onPressed: () async {
                                                      imgFile = await _picker.pickImage(source: ImageSource.camera);
                                                      setState(() {
                                                        if(imgFile == null){
                                                          return;
                                                        }else{
                                                          fileSend = File(imgFile!.path);
                                                          file = fileSend.toString();
                                                        }
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    backgroundColor: Colors.red,
                                                    child:  const Icon(Icons.photo_camera, color: Colors.white),
                                                  ),
                                                ),
                                                const Text('Camera'),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: FloatingActionButton(
                                                    backgroundColor: Colors.red,
                                                    onPressed: () async{
                                                      imgFile = await _picker.pickImage(source: ImageSource.gallery);
                                                      setState(() {
                                                        if(imgFile == null){
                                                          return;
                                                        }else{
                                                          fileSend = File(imgFile!.path);
                                                          file = fileSend.toString();
                                                        }
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Icon(Icons.photo_album, color: Colors.white),
                                                  ),
                                                ),
                                                const Text('Galeria'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }, onClosing: () {

                                  },
                                  );
                                });
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imgFile != null ?
                                  FileImage(File(imgFile!.path),) :
                                  const AssetImage('Assets/cardapio/AddComida.png',
                                  ) as ImageProvider
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: usuarioController,
                        cursorColor: Colors.black,
                        decoration:InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hoverColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:const BorderSide(color: Colors.black),
                          ),
                          hintText: 'Nome de Usuario',
                          counterStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        controller: EmailController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration:InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hoverColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:const BorderSide(color: Colors.black),
                          ),
                          hintText: 'Email',
                          counterStyle: const TextStyle(color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        controller: senhaController,
                        cursorColor: Colors.black,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
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
                      SizedBox(height: 50,),
                      Container(
                        child: TextButtonMultiColor(
                          funcao: (){
                            model.signUpGarcom(
                              Raiz: model.firebaseUser!.email,
                              Senha: senhaController.text,
                              Email: EmailController.text,
                              imgFile: fileSend,
                              LocalStorage: file,
                              onSuccess: _onSuccess,
                              onFail: _onFail,
                              NomeUsuario: usuarioController.text,
                            );
                            print(senhaController.text);
                            print(EmailController.text);
                            print(fileSend);
                            print(file);
                          },
                          text: Text(
                            'Criar Usuario',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                          largura: 400,
                          altura: 70,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      )
    );
  }

  _onSuccess(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
          content: Text(
          'Usuario Garçom Criado',
        )
      ),
    );
  }

  _onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content:
      Text(
        'Falha ao criar usuario',
      )
      ),
    );
  }
}

