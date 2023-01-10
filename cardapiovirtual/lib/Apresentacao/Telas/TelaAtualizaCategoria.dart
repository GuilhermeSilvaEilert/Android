import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:image_picker/image_picker.dart';

class AtualizaCategoria extends StatefulWidget {
  AtualizaCategoria({Key? key,
    this.NomeCategoria,
    this.LocalArquivo,
    this.NomeArquivo}) : super(key: key);

  String? NomeCategoria;
  String? NomeArquivo;
  String? LocalArquivo;

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 78, 90, 85),
        title: Text('Atualize a Categoria ${widget.NomeCategoria}',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 78, 90, 85),
        ),
        child: Column(
          children: [
            ElevatedButton(
              style: ButtonStyle(
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
                            padding: EdgeInsets.all(10),
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
                                        child:  Icon(Icons.photo_camera, color: Colors.white),
                                      ),
                                    ),
                                    Text('Camera'),
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
                                        child: Icon(Icons.photo_album, color: Colors.white),
                                      ),
                                    ),
                                    Text('Galeria'),
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
                      AssetImage('Assets/cardapio/AddComida.png',
                      ) as ImageProvider
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            TextField(
              controller: nomeCategoria,
              cursorColor: Colors.black,
              decoration:InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hoverColor: Colors.black,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:BorderSide(color: Colors.black),
                ),
                hintText: 'Nome da Categoria',
                counterStyle: TextStyle(color: Colors.black),
                labelStyle: TextStyle(color: Colors.black,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            SizedBox(height: 50,),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 150, 0, 0),
                ),
              ),
              onPressed: (){

                if(nomeCategoria.text.isEmpty){
                  nomeCategoria.text = 'Vazia';
                }
                conectaFirebase.AtualizaCategoria(
                  localFile: widget.LocalArquivo,
                  imgFile: fileSend,
                  NomeCategoria: nomeCategoria.text,
                  oldimgFile: widget.NomeArquivo,
                  oldlocalFile: widget.LocalArquivo,
                  oldNomecategoria: widget.NomeCategoria,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only( top: 9, right: 50, left: 50, bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
            ),
          ],
        ),
      ),
    );
  }
}