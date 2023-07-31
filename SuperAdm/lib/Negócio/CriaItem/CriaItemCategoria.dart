import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CriaItemCategoria{

  Future<void> sendDados({
    String? nomeProduto,
    double? preco,
    File? imgFile,
    String? descricao,
    String? file,
    String? Empresa,
    String? id,
  }) async {

    int tamanhoEixoX = 1;
    int tamanhoEixoY = 1;

    if (imgFile != null && nomeProduto != null && preco != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;
      String url = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> data = {
        'Nome': nomeProduto,
        'Preco': preco,
        'Imagem': url,
        'id': id,
        'Descricao': descricao,
        'x': tamanhoEixoX,
        'y': tamanhoEixoY,
        'LocalStorage': file
      };

      FirebaseFirestore
          .instance
          .collection('Empresa')
          .doc(Empresa)
          .collection('Itens')
          .doc(id).collection('Itens')
          .add(data);
    } else {
      print('valores nulos');
    }
  }
}