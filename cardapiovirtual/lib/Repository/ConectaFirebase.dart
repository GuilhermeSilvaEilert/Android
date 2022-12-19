import 'dart:io';

import 'package:cardapiovirtual/Apresentacao/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ConectaFirebase{


  Future<void> sendDados({String? NomeProduto, double? preco, File? imgFile}) async {
    await Firebase.initializeApp();

    int TamanhoEixoX = 1;
    int TamanhoEixoY = 1;


    if (imgFile != null && NomeProduto != null && preco != null) {

      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile ${DateTime.now().microsecondsSinceEpoch.toString()}')
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;
      String url = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> data = {
        'Nome': NomeProduto,
        'Preco': preco,
        'Imagem': url,
        'time': Timestamp.now(),
        'x': TamanhoEixoX,
        'y': TamanhoEixoY
      };

      FirebaseFirestore.instance.collection('Itens Cardapio').doc('Xis').collection('Xis').add(data);
    }else{
      print('valores nulos');
    }

  }

}
