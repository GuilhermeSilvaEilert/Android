import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ModelCardapioItem{

Future<void> sendDados({
  String? nomeProduto,
  double? preco,
  File? imgFile,
  String? categoria,
  String? descricao,
  String? file,
  String? UserRoot,
  String? id,
}) async {
  await Firebase.initializeApp();

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
      'Descricao': descricao,
      'x': tamanhoEixoX,
      'y': tamanhoEixoY,
      'LocalStorage': file
    };

    FirebaseFirestore
        .instance
        .collection('Usuario raiz')
        .doc(UserRoot)
        .collection('Itens Cardapio')
        .doc(id).collection('Itens')
        .add(data);
  } else {
    print('valores nulos');
  }
}
}