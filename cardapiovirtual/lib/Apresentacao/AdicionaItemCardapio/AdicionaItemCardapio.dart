import 'dart:io';
import 'package:cardapiovirtual/Repository/ConectaFirebase.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdicionaItemCardapio extends StatefulWidget {
  const AdicionaItemCardapio({Key? key}) : super(key: key);

  @override
  State<AdicionaItemCardapio> createState() => _AdicionaItemCardapioState();
}

class _AdicionaItemCardapioState extends State<AdicionaItemCardapio> {


  final ImagePicker _picker = ImagePicker();
  ConectaFirebase conectaFirebase = ConectaFirebase();
  File? fileSend;
  XFile? imgFile;
  final TextEditingController nomeProduto = TextEditingController();
  final TextEditingController precoProduto = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 78, 90, 85),
        title: Text('Adicione um item',
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
                  imgFile = await _picker.pickImage(source: ImageSource.camera);
                 setState(() {
                   if(imgFile == null){
                     return;
                   }else{
                     fileSend = File(imgFile!.path);
                   }
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
            SizedBox(height: 50,),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 150, 0, 0),
                  ),
                ),
                  onPressed: (){
                      conectaFirebase.sendDados(
                          NomeProduto: nomeProduto.text,
                          preco: double.parse(precoProduto.text),
                          imgFile: fileSend,
                      );
                      nomeProduto.clear();
                      precoProduto.clear();
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
