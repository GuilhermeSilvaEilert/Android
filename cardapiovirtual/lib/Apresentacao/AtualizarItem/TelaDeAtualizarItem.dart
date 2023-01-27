// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


List list = [];
class AtualizaItemCardapio extends StatefulWidget {
  AtualizaItemCardapio({
    this.descricao,
    this.categoria,
    this.nome,
    this.imagem,
    this.localStorage,
    this.preco,
  });

  String? imagem;
  String? nome;
  String? descricao;
  String? categoria;
  String? preco;
  String? localStorage;

  @override
  State<AtualizaItemCardapio> createState() => AtualizaItemCardapioState(
    nome: nome,
    categoria: categoria,
    descricao: descricao,
    imagem: imagem,
    preco: preco,
    localStorage: localStorage,
  );
}

class AtualizaItemCardapioState extends State<AtualizaItemCardapio> {

  String? imagem;
  String? nome;
  String? descricao;
  String? categoria;
  String? preco;
  String? localStorage;

  AtualizaItemCardapioState({
    this.descricao,
    this.categoria,
    this.nome,
    this.imagem,
    this.localStorage,
    this.preco,
  });

  final ImagePicker _picker = ImagePicker();
  ConectaFirebase conectaFirebase = ConectaFirebase();
  File? fileSend;
  XFile? imgFile;

  TextEditingController nomeProduto = TextEditingController();
  TextEditingController precoProduto = TextEditingController();
  TextEditingController descricaoProduto = TextEditingController();
  TextEditingController categoriaProduto = TextEditingController();
  String? file;
  @override
  void initState() {

    file = localStorage;
    nomeProduto.text = nome!;
    precoProduto.text = preco!;
    descricaoProduto.text = descricao!;
    categoriaProduto.text = categoria!;
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return

    ScaffoldMultiColor(
      AppBar: const Text('Atualize o Item',
        style: TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
      Body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 78, 90, 85),
              ),
              child: Builder(
                  builder: (context) {
                    return Column(
                      children: [
                        ElevatedButton(
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
                                                      print(imgFile);
                                                      setState(() {
                                                        if(imgFile == null){
                                                          return;
                                                        }else{
                                                          fileSend = File(imgFile!.path);
                                                          file = fileSend.toString();
                                                          print(fileSend);
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
                                                          print(fileSend);
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
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imgFile != null ?
                                FileImage(File(imgFile!.path),) :
                                NetworkImage(imagem!,
                                ) as ImageProvider,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        TextField(
                          controller: nomeProduto,
                          cursorColor: Colors.black,
                          decoration:InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hoverColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:const BorderSide(color: Colors.black),
                            ),
                            hintText: 'Nome do Produto',
                            counterStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextField(
                          controller: precoProduto,
                          onChanged: (precoProduto){
                            precoProduto = ' ';
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          decoration:InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hoverColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:const BorderSide(color: Colors.black),
                            ),
                            hintText: 'Preço do Produto',
                            counterStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          height: 200,
                          width: 400,
                          child: TextField(
                            controller: descricaoProduto,
                            cursorColor: Colors.black,
                            decoration:InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hoverColor: Colors.black,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:const BorderSide(color: Colors.black),
                              ),
                              hintText: 'Descrição do produto',
                              counterStyle: const TextStyle(color: Colors.black),
                              labelStyle: const TextStyle(color: Colors.black,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),

                        TextButtonMultiColor(
                          altura: 70,
                          largura: 400,
                          funcao: () async {
                            await conectaFirebase.AtualizaItens(
                              NomeProduto: nomeProduto.text,
                              preco: double.parse(precoProduto.text),
                              imgFile: fileSend,
                              idProduto: nome,
                              url: imagem,
                              categoria: categoria,
                              descricao: descricaoProduto.text,
                              file: file,);
                          },
                          text: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.save,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10,),
                              Text('SALVAR',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}