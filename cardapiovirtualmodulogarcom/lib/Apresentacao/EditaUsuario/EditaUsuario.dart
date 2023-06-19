import 'dart:io';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/Models/CardapioModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class EditaUsuario extends StatefulWidget {
  EditaUsuario({
    Key? key,
  }) : super(key: key);

  @override
  State<EditaUsuario> createState() => _EditaUsuarioState();
}

class _EditaUsuarioState extends State<EditaUsuario> {

  final ImagePicker _picker = ImagePicker();
  File? fileSend;
  XFile? imgFile;
  String? file;

  TextEditingController usuarioController = TextEditingController();
  TextEditingController EmailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
      Body: ScopedModel<CardapioModel>(
          model: CardapioModel(),
          child: ScopedModelDescendant<CardapioModel>(
            builder: (context, child, model) {
                return FutureBuilder(
                  future: FirebaseFirestore
                          .instance
                          .collection('Usuario Garcom')
                          .doc('Usuarios')
                          .collection(model!.firebaseUser!.email!).get(),
                  builder: (context, snapshot) {
                    usuarioController.text = snapshot.data!.docs[0]['Nome'];
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
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
                                        NetworkImage(snapshot.data!.docs[0]['Imagem'],
                                        ) as ImageProvider,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: usuarioController,
                                cursorColor: Colors.black,
                                decoration:InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hoverColor: Colors.black,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:const BorderSide(color: Colors.black),
                                  ),
                                  hintText: 'Nome de Usuario',
                                  counterStyle: const TextStyle(color: Colors.black),
                                  labelStyle: const TextStyle(color: Colors.black,),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.only(top: 8, right: 10),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: (){
                                      model.recoverPass(model!.firebaseUser!.email!);
                                    },
                                    child: Text('Esqueci minha senha',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 70,),
                              Container(
                                child: TextButtonMultiColor(
                                  funcao: (){
                                    model.EditaUsuarioGarcom(
                                      EmailRaiz:snapshot.data!.docs[0]['EmailRaiz'],
                                      Email: snapshot.data!.docs[0]['Email'],
                                      imgFile: fileSend,
                                      url: snapshot.data!.docs[0]['Imagem'],
                                      Sucesso: Sucesso,
                                      Falha: Falha,
                                      NewLocalStorage: file,
                                      NomeUsuario: usuarioController.text,
                                      OldLocalStorage: snapshot.data!.docs[0]['LocalStorage'],
                                    );
                                  },
                                  text: Text(
                                    'Salvar',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  largura: 400,
                                  altura: 70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                );
            },
          )
      ),
    );
  }

  Sucesso(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editado com Sucesso'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Falha(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Falha ao Criar Usuario'),
        backgroundColor: Color.fromARGB(255, 150, 0 ,0),
      ),
    );
  }
}


