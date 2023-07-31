// ignore_for_file: file_names, sized_box_for_whitespace

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:superadm/Apresentacao/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:superadm/Apresentacao/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:superadm/Neg%C3%B3cio/CriaItem/CriaItemCategoria.dart';

List list = [];

class CadastraItem extends StatefulWidget {
  CadastraItem({
    Key? key,
    this.Empresa,
    this.id,
    this.categoria,
  }) : super(key: key);

  String? Empresa;
  String? id;
  String? categoria;

  @override
  State<CadastraItem> createState() => CadastraItemState();
}

class CadastraItemState extends State<CadastraItem> {

  final ImagePicker _picker = ImagePicker();
  File? fileSend;
  XFile? imgFile;
  final TextEditingController nomeProduto = TextEditingController();
  final TextEditingController precoProduto = TextEditingController();
  final TextEditingController categoriaProduto = TextEditingController();
  final TextEditingController descricaoProduto = TextEditingController();
  String? Categoria;
  String? file;
  String? valorDropDonw;
  CriaItemCategoria criaItemCategoria =  CriaItemCategoria();

  retornaLista(String? Empresa) async {
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore
            .instance
            .collection('Empresa')
            .doc(Empresa)
            .collection('Itens').get(),
    );
    if(list.isEmpty) {
      int tamanhoArray = (result.docs.length) - 1;
      for (int i = 0; i <= tamanhoArray; i++){
        list.add(result.docs[i]['id'] + result.docs[i]['Nome'],);
      }
    }
    return list;
  }


  dynamic firstItem;// = list.first;

  @override
  Widget build(BuildContext context) {
   int QuantidadeItensLista = list.length;
   list.removeRange(0, QuantidadeItensLista);
    return ScaffoldMultiColor(
      TextAppBar: const Text('Adicione um item',
        style: TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
      Body: FutureBuilder(
          future: FirebaseFirestore
              .instance
              .collection('Empresa')
              .doc(widget.Empresa)
              .collection('Itens').get(),
          builder:(context, snapshot) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                    child: Column(
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
                        FutureBuilder(
                            future: retornaLista(widget.Empresa),
                            builder: (context, snapshot) {
                              if(list.isEmpty){
                                return Text('Sem categorias cadastradas');
                              }else{
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 400,
                                  height: 60,
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

                                      items: list.map((Item) => DropdownMenuItem(
                                        value: Item,
                                        child: Text(
                                          Item.substring(8,),
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
                            }
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
                          largura: 400,
                          altura: 70,
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
                          funcao: (){
                            String result = categoriaProduto.text.substring(0,8);
                            criaItemCategoria.sendDados(
                              Empresa: widget.Empresa,
                              imgFile: fileSend,
                              id: result,
                              preco: double.parse(precoProduto.text),
                              nomeProduto: nomeProduto.text,
                              descricao: descricaoProduto.text,
                              file: file,
                            );

                            precoProduto.clear();
                            descricaoProduto.clear();

                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}
