//ignore_for_file: must_be_immutable, file_names, use_build_context_synchronously

import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:image_picker/image_picker.dart';

class AtualizaCategoria extends StatefulWidget {
  AtualizaCategoria({Key? key,
    this.nomeCategoria,
    this.localArquivo,
    this.nomeArquivo}) : super(key: key);

  String? nomeCategoria;
  String? nomeArquivo;
  String? localArquivo;

  @override
  State<AtualizaCategoria> createState() => _AtualizaCategoria();
}

class _AtualizaCategoria extends State<AtualizaCategoria> {

  final ImagePicker _picker = ImagePicker();
  ConectaFirebase conectaFirebase = ConectaFirebase();
  File? fileSend;
  XFile? imgFile;
  TextEditingController nomeCategoria = TextEditingController();
  String? file;

  @override
  Widget build(BuildContext context) {
    return

    ScaffoldMultiColor(
      TextAppBar: Text('Atualize a Categoria ${widget.nomeCategoria}',
        style: const TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
      Body: Container(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 78, 90, 85),
        ),
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
                if(nomeCategoria.text.isEmpty){
                  nomeCategoria.text = 'Vazia';
                }
                conectaFirebase.AtualizaCategoria(
                  localFile: widget.localArquivo,
                  imgFile: fileSend,
                  nomeCategoria: nomeCategoria.text,
                  oldimgFile: widget.nomeArquivo,
                  oldlocalFile: widget.localArquivo,
                  oldNomecategoria: widget.nomeCategoria,
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
      ),
    );
  }
}