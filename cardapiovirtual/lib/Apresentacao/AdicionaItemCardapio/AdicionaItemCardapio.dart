// ignore_for_file: file_names, sized_box_for_whitespace

import 'dart:io';
import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:cardapiovirtual/Model/ModelCardapioItem.dart';
import 'package:cardapiovirtual/Model/itemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

List list = [];

class AdicionaItemCardapio extends StatefulWidget {
  const AdicionaItemCardapio({Key? key}) : super(key: key);

  @override
  State<AdicionaItemCardapio> createState() => AdicionaItemCardapioState();
}

class AdicionaItemCardapioState extends State<AdicionaItemCardapio> {

  final ImagePicker _picker = ImagePicker();
  ModelCardapioItem conectaFirebase = ModelCardapioItem();
  ModelCardapioItem cardapioItem = ModelCardapioItem();
  File? fileSend;
  XFile? imgFile;
  final TextEditingController nomeProduto = TextEditingController();
  final TextEditingController precoProduto = TextEditingController();
  final TextEditingController categoriaProduto = TextEditingController();
  final TextEditingController descricaoProduto = TextEditingController();
  String? Categoria;
  String? file;
  String? valorDropDonw;

  retornaLista(String UserRoot) async {
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore
            .instance
            .collection('Usuario raiz')
            .doc(UserRoot)
            .collection('Itens Cardapio').get()
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
    return ScopedModel<CardapioModel>(
      model: CardapioModel(),
      child: ScopedModelDescendant<CardapioModel>(
        builder: (context, child, model)  {
          return ScaffoldMultiColor(
            TextAppBar: const Text('Adicione um item',
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
            Body: FutureBuilder(
               future: FirebaseFirestore
                    .instance
                    .collection('Usuario raiz')
                    .doc(model.firebaseUser!.email)
                    .collection('Itens Cardapio').get(),
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
                                future: retornaLista(model!.firebaseUser!.email!),
                                builder: (context, snapshot) {
                                  if(list.isEmpty){
                                    return const CircularProgressIndicator();
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
                                cardapioItem.sendDados(
                                  imgFile: fileSend,
                                  UserRoot: model.firebaseUser!.email,
                                  file: file,
                                  descricao: descricaoProduto.text,
                                  id: result,
                                  nomeProduto: nomeProduto.text,
                                  preco: double.parse(precoProduto.text),
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
      ),
    );
  }
}
