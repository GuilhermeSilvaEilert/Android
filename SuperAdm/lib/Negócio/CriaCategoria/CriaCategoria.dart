import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class CriarCategoria {
  Future<void> criaCategoria(
      {String? nomeCategoria,
        File? imgFile,
        String? localFile,
        String? Empresa,
        required UniqueKey id,}) async {
    await Firebase.initializeApp();

    int tamanhoEixoX = 1;
    int tamanhoEixoY = 1;

    if (imgFile != null && nomeCategoria != null && id != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;

      String url = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> data = {
        'id': id.toString(),
        'Nome': nomeCategoria,
        'Imagem': url,
        'x': tamanhoEixoX,
        'y': tamanhoEixoY,
        'LocalStorage': localFile,
      };

      FirebaseFirestore.instance.collection('Empresa')
          .doc(Empresa).collection('Itens')
          .doc(id.toString()).set(data);
    } else {
      print('valores nulos');
    }
  }

}