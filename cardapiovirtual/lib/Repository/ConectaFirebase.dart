import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ConectaFirebase {

  Future<void> sendDados({
    String? NomeProduto,
    double? preco,
    File? imgFile,
    String? categoria,
    String? descricao,
    String? file}) async {
    await Firebase.initializeApp();

    int TamanhoEixoX = 1;
    int TamanhoEixoY = 1;


    if (imgFile != null && NomeProduto != null && preco != null &&
        categoria != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;
      String url = await taskSnapshot.ref.getDownloadURL();

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

      FirebaseFirestore.instance.collection('Itens Cardapio')
          .doc(categoria)
          .collection('Itens').doc(NomeProduto)
          .set(data);
    } else {
      print('valores nulos');
    }
  }

  Future<void> CriaCategoria(
      {String? NomeCategoria, File? imgFile, String? localFile}) async {
    await Firebase.initializeApp();

    int TamanhoEixoX = 1;
    int TamanhoEixoY = 1;

    if (imgFile != null && NomeCategoria != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;

      String url = await taskSnapshot.ref.getDownloadURL();


      Map<String, dynamic> data = {
        'Nome': NomeCategoria,
        'Imagem': url,
        'time': Timestamp.now(),
        'x': TamanhoEixoX,
        'y': TamanhoEixoY,
        'LocalStorage': localFile,
      };

      FirebaseFirestore.instance.collection('Itens Cardapio')
          .doc(NomeCategoria)
          .set(data);
    } else {
      print('valores nulos');
    }
  }

  RetornaLista() async {
    final List list = [];
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore
            .instance
            .collection('Itens Cardapio').get()
    );
    int tamanhoArray = (result.docs.length) - 1;
    for (int i = 0; i <= tamanhoArray; i++) {
      print(result.docs[i]['Nome']);
      list.add(result.docs[i]['Nome']);
      print(list);
    }
    return list;
  }

  Future<void> AtualizaCategoria({
    String? NomeCategoria,
    File? imgFile,
    String? localFile,
    String? oldNomecategoria,
    String? oldimgFile,
    String? oldlocalFile
  }) async {
    await Firebase.initializeApp();
    print('iniciando Atualização');

    int TamanhoEixoX = 1;
    int TamanhoEixoY = 1;

    print(
        'Velho Nome: $oldNomecategoria'
            '\n Velha Imagem: $oldimgFile'
            '\n Velho local: $oldlocalFile'
            '\n Novo Nome: $NomeCategoria'
            '\n File: $imgFile'
            '\n localFile: $localFile'
    );

    if (imgFile != null && NomeCategoria != 'Vazia') {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile!);

      TaskSnapshot taskSnapshot = await task;

      String url = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> data = {
        'Nome': NomeCategoria,
        'Imagem': url,
        'LocalStorage': localFile,
        'time': Timestamp.now(),
        'x': TamanhoEixoX,
        'y': TamanhoEixoY,
      };

      FirebaseFirestore.instance.collection('Itens Cardapio')
          .doc(NomeCategoria)
          .set(data);
      FirebaseFirestore.instance.collection('Itens Cardapio').doc(
          oldNomecategoria).delete();

    } else if (imgFile == null && NomeCategoria != 'Vazia') {

      Map<String, dynamic> data = {
        'Nome': NomeCategoria,
        'Imagem': oldimgFile,
        'LocalStorage': oldlocalFile,
        'time': Timestamp.now(),
        'x': TamanhoEixoX,
        'y': TamanhoEixoY,
      };

      FirebaseFirestore.instance.collection('Itens Cardapio')
          .doc(NomeCategoria)
          .set(data);
      FirebaseFirestore.instance.collection('Itens Cardapio').doc(
          oldNomecategoria).delete();
    } else if (imgFile != null && NomeCategoria == 'Vazia') {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile!);

      TaskSnapshot taskSnapshot = await task;

      String url = await taskSnapshot.ref.getDownloadURL();
      print('URL: $url');

      Map<String, dynamic> data = {
        'Nome': oldNomecategoria,
        'Imagem': url,
        'LocalStorage': localFile,
        'time': Timestamp.now(),
        'x': TamanhoEixoX,
        'y': TamanhoEixoY,
      };
      FirebaseFirestore.instance.collection('Itens Cardapio').doc(
          oldNomecategoria).delete();
      FirebaseFirestore.instance.collection('Itens Cardapio').doc(
          oldNomecategoria).set(data);
    } else {
      print('valores nulos');
    }
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
      print('Subindo Imagem velha');

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
          .putFile(imgFile!);

      TaskSnapshot taskSnapshot = await task;

      String urlNew = await taskSnapshot.ref.getDownloadURL();
      print('Subindo Imagem nova');
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
      print('valores nulos');
    }
  }
}
