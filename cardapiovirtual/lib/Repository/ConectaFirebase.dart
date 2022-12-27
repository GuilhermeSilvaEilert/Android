import 'dart:io';

import 'package:cardapiovirtual/Apresentacao/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ConectaFirebase{

  Future<void> sendDados({String? NomeProduto, double? preco, File? imgFile, String? categoria, String? descricao}) async {
    await Firebase.initializeApp();

    int TamanhoEixoX = 1;
    int TamanhoEixoY = 1;


    if (imgFile != null && NomeProduto != null && preco != null && categoria != null) {

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
        'Descrição': descricao,
        'time': Timestamp.now(),
        'x': TamanhoEixoX,
        'y': TamanhoEixoY
      };

      FirebaseFirestore.instance.collection('Itens Cardapio').doc(categoria).collection('Itens').add(data);
    }else{
      print('valores nulos');
    }

  }
  Future<void> CriaCategoria({String? NomeCategoria, File? imgFile}) async {
    await Firebase.initializeApp();

    int TamanhoEixoX = 1;
    int TamanhoEixoY = 1;

    if (imgFile != null && NomeCategoria != null) {

      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile ${DateTime.now().microsecondsSinceEpoch.toString()}')
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;
      String url = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> data = {
        'Nome': NomeCategoria,
        'Imagem': url,
        'time': Timestamp.now(),
        'x': TamanhoEixoX,
        'y': TamanhoEixoY
      };

      FirebaseFirestore.instance.collection('Itens Cardapio').doc(NomeCategoria).set(data);
    }else{
      print('valores nulos');
    }

  }

  Future ListaItens() async{
    await Firebase.initializeApp();
    FirebaseFirestore.instance.collection('Itens Cardapio').get();
  }

   RetornaLista() async{
    final List list = [];
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore
            .instance
            .collection('Itens Cardapio')!.get()
    );
    int tamanhoArray =  (result!.docs!.length)-1;
    for(int i = 0; i<=tamanhoArray; i++){
      print(result.docs[i]['Nome']);
      list!.add( result.docs[i]['Nome']);
      print(list);
    }
    return list;
  }

}

