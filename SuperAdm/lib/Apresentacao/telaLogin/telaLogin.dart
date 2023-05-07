import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:superadm/Apresentacao/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:superadm/Apresentacao/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:superadm/Neg%C3%B3cio/Model/UserModel.dart';

class CriaUsuarioGerente extends StatefulWidget {
  const CriaUsuarioGerente({Key? key}) : super(key: key);

  @override
  State<CriaUsuarioGerente> createState() => _CriaUsuarioGerenteState();
}

class _CriaUsuarioGerenteState extends State<CriaUsuarioGerente> {

  final ImagePicker _picker = ImagePicker();
  File? fileSend;
  XFile? imgFile;
  String? file;

  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController nomeEmpresa = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
      Body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if(model.isLoading!)
            return Center(child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            );
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
                    TextField(
                      controller: EmailController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hoverColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:const BorderSide(color: Colors.black),
                        ),
                        hintText: 'Email',
                        counterStyle: const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: nomeEmpresa,
                      cursorColor: Colors.black,
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hoverColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
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
                    SizedBox(height: 20,),
                    TextField(
                      controller: senhaController,
                      cursorColor: Colors.black,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hoverColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:const BorderSide(color: Colors.black),
                        ),
                        hintText: 'Senha',
                        counterStyle: const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      child: TextButtonMultiColor(
                        funcao: (){
                          model.signUp(
                            LocalStorage: file,
                            imgFile: fileSend,
                            Senha: senhaController.text,
                            NomeUsuario: usuarioController.text,
                            Email: EmailController.text,
                            onSuccess: onSucess,
                            onFail: onFail,
                          );
                          EmailController.clear();
                          usuarioController.clear();
                          senhaController.clear();
                          imgFile =  null;
                        },
                        text: Text(
                          'Criar Usuario',
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
              )
            ],
          );
        },
      ),
    );
  }

  onSucess(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Conta Criada',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Conta Criada',
        ),
        backgroundColor: Color.fromRGBO(150, 0, 0, 255),
      ),
    );
  }

}