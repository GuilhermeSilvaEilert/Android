import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:superadm/Apresentacao/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:superadm/Apresentacao/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:superadm/Neg%C3%B3cio/CriaCategoria/CriaCategoria.dart';
import 'package:superadm/Neg%C3%B3cio/UpdateCategoria/UpdateCategoria.dart';

class CriaCategoria extends StatefulWidget {
  CriaCategoria({
    Key? key,
    this.Empresa,
    this.Filial,

  }) : super(key: key);

  String? Empresa;
  String? Filial;
  String? Nome;
  String? url;

  @override
  State<CriaCategoria> createState() => _CriaCategoria();
}

class _CriaCategoria extends State<CriaCategoria> {

  final ImagePicker _picker = ImagePicker();
  File? fileSend;
  XFile? imgFile;
  final TextEditingController nomeCategoria = TextEditingController();
  String? file;
  UpdateCategoria updateCategoria = UpdateCategoria();

  @override
  void initState() {
    // TODO: implement initState
    nomeCategoria.text = widget.Nome!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
      TextAppBar:  const Text('Adicione uma Categoria',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
      Body: FutureBuilder(
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
                          widget.url != null ?
                          Image.network(widget.url!) as ImageProvider:
                          const AssetImage('Assets/cardapio/AddComida.png',
                          ) as ImageProvider,
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
                    updateCategoria.criaCategoria(
                      id: UniqueKey(),
                      Empresa: widget.Empresa,
                      imgFile: fileSend,
                      localFile: file,
                      nomeCategoria: nomeCategoria.text,
                      nomeFilial: widget.Filial,
                      url: widget.url,
                    );
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
        }, future: null,
      ),
    );
  }
}
