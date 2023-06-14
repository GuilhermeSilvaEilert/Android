// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:cardapiovirtual/Model/ModelCardapioCategoria.dart';
import 'package:cardapiovirtual/Model/itemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class CriaCategoria extends StatefulWidget {
  const CriaCategoria({Key? key}) : super(key: key);

  @override
  State<CriaCategoria> createState() => _CriaCategoria();
}

class _CriaCategoria extends State<CriaCategoria> {

  final ImagePicker _picker = ImagePicker();
  File? fileSend;
  XFile? imgFile;
  final TextEditingController nomeCategoria = TextEditingController();
  String? file;
  CardapioModelCategoria addCategoria = CardapioModelCategoria();

  @override
  Widget build(BuildContext context) {
        return ScaffoldMultiColor(
          TextAppBar:  const Text('Adicione uma Categoria',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
          Body: ScopedModel<CardapioModel>(
            model: CardapioModel(),
            child: ScopedModelDescendant<CardapioModel>(
              builder: (context, child, model) {
                return FutureBuilder(
                  future:  FirebaseFirestore.instance
                      .collection('Usuario raiz')
                      .doc(model.firebaseUser!.email)
                      .collection('Itens Cardapio')
                      .get(),
                  builder: (context, snapshot){
                    return Container(
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
                          const SizedBox(height: 40,),
                          TextField(
                            controller: nomeCategoria,
                            cursorColor: Colors.black,
                            decoration:InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hoverColor: Colors.black,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:const BorderSide(color: Colors.black),
                              ),
                              hintText: 'Nome da Categoria',
                              counterStyle: const TextStyle(color: Colors.black),
                              labelStyle: const TextStyle(color: Colors.black,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50,),

                          TextButtonMultiColor(
                            altura: 70,
                            largura: 400,
                            funcao: (){
                              setState(() {
                                addCategoria.criaCategoria(
                                  UserRoot: model.firebaseUser!.email,
                                  imgFile: fileSend,
                                  localFile: file,
                                  nomeCategoria: nomeCategoria.text,
                                  id: UniqueKey(),
                                );
                              });
                              nomeCategoria.clear();
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
                      ),
                    );
                  }
                );
              }
            ),
          ),
        );
  }
}
