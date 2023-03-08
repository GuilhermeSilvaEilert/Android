// ignore_for_file: file_names, use_build_context_synchronously
import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtual/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:image_picker/image_picker.dart';

class AdicionaLogoInicial extends StatefulWidget {
  const AdicionaLogoInicial({Key? key}) : super(key: key);

  @override
  State<AdicionaLogoInicial> createState() => _AdicionaLogoInicial();
}

class _AdicionaLogoInicial extends State<AdicionaLogoInicial> {

  final ImagePicker _picker = ImagePicker();
  ConectaFirebase conectaFirebase = ConectaFirebase();
  File? fileSend;
  XFile? imgFile;
  final TextEditingController nomeCategoria = TextEditingController();
  String? file;

  @override
  Widget build(BuildContext context) {
    return
    ScaffoldMultiColor(
      TextAppBar: const Text('Adicione uma Logo',
        style: TextStyle(
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

            TextButtonMultiColor(
              altura: 70,
              largura: 400,
              funcao: (){
                nomeCategoria.clear();
                conectaFirebase.logoInicial(fileSend, file);
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
            const SizedBox(height: 40,),
            TextButtonMultiColor(
              altura: 70,
              largura: 400,
              funcao: (){
                nomeCategoria.clear();
                conectaFirebase.RemovaLogoInicial();
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
                  Text('REMOVER ICONE',
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