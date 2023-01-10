import 'dart:io';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


List list = [];
class AtualizaItemCardapio extends StatefulWidget {
  AtualizaItemCardapio({
    this.Descricao,
    this.Categoria,
    this.Nome,
    this.Imagem,
    this.LocalStorage,
    this.Preco,
  });

  String? Imagem;
  String? Nome;
  String? Descricao;
  String? Categoria;
  String? Preco;
  String? LocalStorage;

  @override
  State<AtualizaItemCardapio> createState() => AtualizaItemCardapioState(
    Nome: Nome,
    Categoria: Categoria,
    Descricao: Descricao,
    Imagem: Imagem,
    Preco: Preco,
    LocalStorage: LocalStorage,
  );
}

class AtualizaItemCardapioState extends State<AtualizaItemCardapio> {

  String? Imagem;
  String? Nome;
  String? Descricao;
  String? Categoria;
  String? Preco;
  String? LocalStorage;

  AtualizaItemCardapioState({
    this.Descricao,
    this.Categoria,
    this.Nome,
    this.Imagem,
    this.LocalStorage,
    this.Preco,
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
    print('Nome: $Nome');
    print('Preco: $Preco');
    print('Descricao: $Descricao');
    print('Categoria: $Categoria');
    print('Imagem: $Imagem');
    print('LocalStorage: $LocalStorage');
    file = LocalStorage;
    nomeProduto.text = Nome!;
    precoProduto.text = Preco!;
    descricaoProduto.text = Descricao!;
    categoriaProduto.text = Categoria!;
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 78, 90, 85),
        title: Text('Atualize o Item',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 78, 90, 85),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 78, 90, 85),
              ),
              child: Builder(
                builder: (context) {
                  return Column(
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
                                    LogicalKeyboardKey.close;
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
                                                        print(fileSend);
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
                              NetworkImage(Imagem!,
                              ) as ImageProvider,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),
                      TextField(
                        controller: nomeProduto,
                        cursorColor: Colors.black,
                        decoration:InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hoverColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:BorderSide(color: Colors.black),
                          ),
                          hintText: 'Nome do Produto',
                          counterStyle: TextStyle(color: Colors.black),
                          labelStyle: TextStyle(color: Colors.black,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
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
                            borderSide:BorderSide(color: Colors.black),
                          ),
                          hintText: 'Preço do Produto',
                          counterStyle: TextStyle(color: Colors.black),
                          labelStyle: TextStyle(color: Colors.black,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
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
                              borderSide:BorderSide(color: Colors.black),
                            ),
                            hintText: 'Descrição do produto',
                            counterStyle: TextStyle(color: Colors.black),
                            labelStyle: TextStyle(color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 150, 0, 0),
                          ),
                        ),
                        onPressed: () async {
                          await conectaFirebase.AtualizaItens(
                              NomeProduto: nomeProduto.text,
                              preco: double.parse(precoProduto.text),
                              imgFile: fileSend,
                              idProduto: Nome,
                              url: Imagem,
                              categoria: Categoria,
                              descricao: descricaoProduto.text,
                              file: file,);
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