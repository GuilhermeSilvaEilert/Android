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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
        child: Column(
          children: [
            TextField(

            ),
            TextField(

            ),
            IconButton(
            onPressed: () async {
              final XFile? imgFile = await _picker.pickImage(source: ImageSource.camera);
              if(imgFile == null){
                return;
              }else{
                File fileSend = File(imgFile.path);
                conectaFirebase.sendDados(imgFile: fileSend);
              }
            },
              icon: Icon(Icons.add_a_photo),
            ),
      IconButton(
        onPressed: (){

        },
        icon: Row(
          children: [

          ],
        ),
      ),
      ],
    ),
     ),
    );

  }
}
