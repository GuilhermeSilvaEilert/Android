// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ConectaFirebase {

  Future<void> sendDados({
    String? nomeProduto,
    double? preco,
    File? imgFile,
    String? categoria,
    String? descricao,
    String? file}) async {
    await Firebase.initializeApp();

    int tamanhoEixoX = 1;
    int tamanhoEixoY = 1;


    if (imgFile != null && nomeProduto != null && preco != null &&
        categoria != null) {
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
        'time': Timestamp.now(),
        'x': tamanhoEixoX,
        'y': tamanhoEixoY,
        'LocalStorage': file
      };

      FirebaseFirestore.instance.collection('Itens Cardapio')
          .doc(categoria)
          .collection('Itens').doc(nomeProduto)
          .set(data);
    } else {
      print('valores nulos');
    }
  }


  Future<void> AtualizaCategoria({
    String? nomeCategoria,
    File? imgFile,
    String? localFile,
    String? oldNomecategoria,
    String? oldimgFile,
    String? oldlocalFile
  }) async {
    await Firebase.initializeApp();
    print('iniciando Atualização');

    int tamanhoEixoX = 1;
    int tamanhoEixoY = 1;

    print(
        'Velho Nome: $oldNomecategoria'
            '\n Velha Imagem: $oldimgFile'
            '\n Velho local: $oldlocalFile'
            '\n Novo Nome: $nomeCategoria'
            '\n File: $imgFile'
            '\n localFile: $localFile'
    );

    if (imgFile != null && nomeCategoria != 'Vazia') {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;

      String url = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> data = {
        'Nome': nomeCategoria,
        'Imagem': url,
        'LocalStorage': localFile,
        'time': Timestamp.now(),
        'x': tamanhoEixoX,
        'y': tamanhoEixoY,
      };

      FirebaseFirestore.instance.collection('Itens Cardapio')
          .doc(nomeCategoria)
          .set(data);
      FirebaseFirestore.instance.collection('Itens Cardapio').doc(
          oldNomecategoria).delete();

    } else if (imgFile == null && nomeCategoria != 'Vazia') {

      Map<String, dynamic> data = {
        'Nome': nomeCategoria,
        'Imagem': oldimgFile,
        'LocalStorage': oldlocalFile,
        'time': Timestamp.now(),
        'x': tamanhoEixoX,
        'y': tamanhoEixoY,
      };

      FirebaseFirestore.instance.collection('Itens Cardapio')
          .doc(nomeCategoria)
          .set(data);
      FirebaseFirestore.instance.collection('Itens Cardapio').doc(
          oldNomecategoria).delete();
    } else if (imgFile != null && nomeCategoria == 'Vazia') {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;

      String url = await taskSnapshot.ref.getDownloadURL();
      print('URL: $url');

      Map<String, dynamic> data = {
        'Nome': oldNomecategoria,
        'Imagem': url,
        'LocalStorage': localFile,
        'time': Timestamp.now(),
        'x': tamanhoEixoX,
        'y': tamanhoEixoY,
      };
      FirebaseFirestore.instance.collection('Itens Cardapio').doc(
          oldNomecategoria).delete();
      FirebaseFirestore.instance.collection('Itens Cardapio').doc(
          oldNomecategoria).set(data);
    } else {
      print('valores nulos');
    }
  }

  Future? logoInicial  (
      File? imgFile,
      String? localStorage
      ) async {

    final QuerySnapshot result = await Future.value(
        FirebaseFirestore
            .instance
            .collection('Configurações').get()
    );
    if(result.docs[1]['Image'] == null){

      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile!);

      TaskSnapshot taskSnapshot = await task;
      String url = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> data = {
        'Image': url,
        'LocalStorage': localStorage,
      };

      FirebaseFirestore.instance.collection('Configurações')
          .doc('Logo Inicial').set(data);
    }else{
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile!);

      TaskSnapshot taskSnapshot = await task;
      String url = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> data = {
        'Image': url,
        'LocalStorage': localStorage,
      };



      FirebaseFirestore
          .instance
          .collection('Configurações')
          .doc('Logo Inicial').delete();

      FirebaseStorage.instance.ref(result.docs[1]['LocalStorage']).delete();

      FirebaseFirestore.instance.collection('Configurações')
          .doc('Logo Inicial').set(data);
    }


  }

  Future? RemovaLogoInicial(){
    FirebaseFirestore
        .instance
        .collection('Configurações')
        .doc('Logo Inicial').delete();
  }

  Future? AtualizaItens(
      { String? NomeProduto,
        String? idProduto,
        double? preco,
        File? imgFile,
        String? url,
        String? categoria,
        String? descricao,
        String? file,}) async {
    await Firebase.initializeApp();

    int TamanhoEixoX = 1;
    int TamanhoEixoY = 1;


    if(url != null && imgFile == null) {
      Map<String, dynamic> data = {
        'Nome': NomeProduto,
        'Preco': preco,
        'Imagem': url,
        'Descricao': descricao,
        'time': Timestamp.now(),
        'x': TamanhoEixoX,
        'y': TamanhoEixoY,
        'LocalStorage': file
      };

      FirebaseFirestore
          .instance
          .collection('Itens Cardapio')
          .doc(categoria).collection('Itens').doc(idProduto).delete();

      FirebaseFirestore.instance.collection('Itens Cardapio')
          .doc(categoria)
          .collection('Itens').doc(NomeProduto)
          .set(data);

    } else if(imgFile != null){
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;

      String urlNew = await taskSnapshot.ref.getDownloadURL();
      Map<String, dynamic> data = {
        'Nome': NomeProduto,
        'Preco': preco,
        'Imagem': urlNew,
        'Descricao': descricao,
        'time': Timestamp.now(),
        'x': TamanhoEixoX,
        'y': TamanhoEixoY,
        'LocalStorage': file
      };

      FirebaseFirestore
          .instance
          .collection('Itens Cardapio')
          .doc(categoria).collection('Itens').doc(NomeProduto).delete();

      FirebaseStorage.instance.ref(file).delete();

      FirebaseFirestore.instance.collection('Itens Cardapio')
          .doc(categoria)
          .collection('Itens').doc(NomeProduto)
          .set(data);

    } else {
      // ignore: avoid_print
      print('valores nulos');
    }
  }

  AtualizaDados() async{
      FirebaseFirestore.instance.collection('Itens Cardapio').get();
  }

}
