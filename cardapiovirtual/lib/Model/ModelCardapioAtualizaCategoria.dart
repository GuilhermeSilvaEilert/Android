import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class ModelCardapioAtualizaCategoria{

  Future<void> AtualizaCategoria({
    String? nomeCategoria,
    File? imgFile,
    String? localFile,
    String? url,
    String? oldNomecategoria,
    String? oldlocalFile,
    String? UserRoot,
    String? id,
  }) async {
    await Firebase.initializeApp();
    print('iniciando Atualização');

    int tamanhoEixoX = 1;
    int tamanhoEixoY = 1;

    if (imgFile == null && url != null) {

      Map<String, dynamic> data = {
        'Nome': nomeCategoria,
        'Imagem': url,
        'LocalStorage': oldlocalFile,
        'x': tamanhoEixoX,
        'y': tamanhoEixoY,
        'id':id,
      };


      FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('Itens Cardapio')
          .doc(id.toString()).update(data);




    } else if (imgFile != null) {

      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;

      String url = await taskSnapshot.ref.getDownloadURL();
      print('URL: $url');

      Map<String, dynamic> data = {
        'Nome': nomeCategoria,
        'Imagem': url,
        'LocalStorage': localFile,
        'x': tamanhoEixoX,
        'y': tamanhoEixoY,
        'id':id,
      };

      FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('Itens Cardapio')
          .doc(id.toString()).update(data);

      FirebaseStorage.instance.ref(oldlocalFile).delete();


    } else {

      print('valores nulos');

    }
  }

}