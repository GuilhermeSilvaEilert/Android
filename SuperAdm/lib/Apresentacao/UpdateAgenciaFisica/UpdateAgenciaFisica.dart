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
import 'package:superadm/Neg%C3%B3cio/Model/CadastroDeAgencias/CadastroDeAgenciaFilha/CadastroDeAgenciaFilha.dart';
import 'package:superadm/Neg%C3%B3cio/Model/CadastroDeAgencias/CadastroDeAgencias.dart';
import 'package:superadm/Neg%C3%B3cio/Model/itemModel.dart';


class CadastroDeAgenciaFisica extends StatefulWidget {
  CadastroDeAgenciaFisica({
    Key? key,
    this.NomeEmpresa,
    this.cep,
    this.cidade,
    this.endereco,
    this.estado,
    this.nome,
    this.pais,
    this.numero,
    this.Imagem
  }) : super(key: key);


  String? NomeEmpresa;
  String? nome;
  String? endereco;
  String? cidade;
  String? pais;
  String? cep;
  String? estado;
  String? numero;
  String? Imagem;

  @override
  State<CadastroDeAgenciaFisica> createState() => _CadastroDeAgenciaFisicaState();
}

class _CadastroDeAgenciaFisicaState extends State<CadastroDeAgenciaFisica> {

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
  final TextEditingController estadoController = TextEditingController();

  CadastroDeAgenciaFilha  cadastroDeAgencias = CadastroDeAgenciaFilha();

  @override
  initState(){
    checkBox = 0;
    super.initState();
    Firebase.initializeApp();
    if(widget.nome != null || widget == ''){
      paisController.text = widget.pais!;
      numeroController.text = widget.numero!;
      cidadeController.text = widget.cidade!;
      cepController.text = widget.cep!;
      estadoController.text = widget.estado!;
      nomeController.text = widget.nome!;
      enderecoController.text = widget.endereco!;
    }
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
                    widget.Imagem! != null ? NetworkImage(widget!.Imagem!) :
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: paisController,
                          validator: (text) {
                            if(text!.isEmpty){
                              return 'País invalido';
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
                            hintText: 'Nome do País',
                            counterStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: cidadeController,
                          validator: (text) {
                            if(text!.isEmpty){
                              return 'Cidade invalida';
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
                            hintText: 'Nome da Cidade',
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
                          controller: enderecoController,
                          validator: (text) {
                            if(text!.isEmpty){
                              return 'Endereco invalido';
                            }
                          },
                          cursorColor: Colors.black,
                          decoration:InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hoverColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:const BorderSide(color: Colors.black),
                            ),
                            hintText: 'Nome da Rua',
                            counterStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: numeroController,
                          validator: (text) {
                            if(text!.isEmpty){
                              return 'Numero invalido';
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
                            hintText: 'Numero do seu endereco',
                            counterStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: estadoController,
                          validator: (text) {
                            if(text!.isEmpty){
                              return 'Estado invalido';
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
                            hintText: 'Estado da Cidade',
                            counterStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: cepController,
                          validator: (text) {
                            if(text!.isEmpty){
                              return 'Cep invalido';
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
                            hintText: 'Cep do endereco',
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
                            Cep: cepController.text,
                            Cidade: cidadeController.text,
                            Estado: estadoController.text,
                            File: file,
                            imgFile: fileSend,
                            NomeAgencia: widget.NomeEmpresa,
                            NomedaFranquia: nomeController.text,
                            NumeroEndereco: numeroController.text,
                            Pais: paisController.text,
                            Rua: enderecoController.text,
                            id: UniqueKey(),
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
            'Login bem sucedido'
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
            'Senha ou Email Incorretos'
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

}
