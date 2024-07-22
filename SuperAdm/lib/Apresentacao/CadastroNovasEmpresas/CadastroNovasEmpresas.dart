// ignore_for_file: file_names
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:superadm/Apresentacao/HomePage/HomePage.dart';
import 'package:superadm/Apresentacao/ListaDeAgencias/ListaDeAgencias.dart';
import 'package:superadm/Apresentacao/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:superadm/Apresentacao/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:superadm/Neg%C3%B3cio/Model/CadastroDeAgencias/CadastroDeAgencias.dart';
import 'package:superadm/Neg%C3%B3cio/Model/itemModel.dart';


class CadastroNovasEmpresas extends StatefulWidget {
  CadastroNovasEmpresas({Key? key}) : super(key: key);

  @override
  State<CadastroNovasEmpresas> createState() => _CadastroNovasEmpresasState();
}

class _CadastroNovasEmpresasState extends State<CadastroNovasEmpresas> {

  bool? salvaSenha = false;
  int checkBox = 0;
  File? fileSend;
  XFile? imgFile;
  final ImagePicker _picker = ImagePicker();
  String? file;
  final _formValidateKey = GlobalKey<FormState>();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController enderecoController  =  TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController paisController = TextEditingController();
  final TextEditingController cepController = TextEditingController();

  CadastroDeAgencias  cadastroDeAgencias = CadastroDeAgencias();

  @override
  initState(){
    checkBox = 0;
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {

    return ScaffoldMultiColor(
      TextAppBar: Text('Cadastros de Agências'),
      Body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
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
                                LogicalKeyboardKey.close;
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
                      setState(() {
                        if(imgFile == null){
                          return;
                        }else{
                          fileSend = File(imgFile!.path);
                          file = fileSend.toString();
                        }
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imgFile != null ?
                          FileImage(File(imgFile!.path),) :
                          const AssetImage('Assets/cardapio/AddComida.png',
                          ) as ImageProvider,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Form(
                    key: _formValidateKey,
                    child: Container(
                      padding: const EdgeInsets.all(50),
                      alignment: Alignment.topCenter,
                      child: Column(
                          children:[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: nomeController,
                                validator: (text) {
                                  if(text!.isEmpty){
                                    return 'Campo Vazio';
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
                                  hintText: 'Nome da Empresa',
                                  counterStyle: const TextStyle(color: Colors.black),
                                  labelStyle: const TextStyle(color: Colors.black,),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextButtonMultiColor(
                              funcao: () async {
                                cadastroDeAgencias.CadastraAgencias(

                                    NomeAgencia: nomeController.text,
                                    imgFile: fileSend,
                                    File: file,
                                );
                              },
                              altura: 50,
                              largura: 200,
                              text: const Text(
                              'Cadastrar Empresa',
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
      ),
    );
  }

  onSucess() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Cadastrada com sucesso'
        ),
        backgroundColor: Colors.green,
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomePage(),
      ),
    );
  }

  onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Revise os dados por gentileza'
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

}
