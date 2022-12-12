import 'dart:io';

import 'package:cardapiovirtual/Apresentacao/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ConectaFirebase{


  Future<void> sendDados({String? NomeProduto, double? preco, File? imgFile}) async {
    await Firebase.initializeApp();

    Map<String, dynamic> data = {
      'NomeProdutoCardapio': NomeProduto,
      'PrecoProduto': preco,
      'Imagem Produto': imgFile,
      'time': Timestamp.now(),
    };

    if (imgFile != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$NomeProduto DateTime.now().microsecondsSinceEpoch.toString()')
          .putFile(imgFile);

      TaskSnapshot taskSnapshot = await task;
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgurl'] = url;

    }

  }

}
