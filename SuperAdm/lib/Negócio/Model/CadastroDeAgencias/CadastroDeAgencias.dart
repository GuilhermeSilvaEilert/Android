import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CadastroDeAgencias{

  CadastraAgencias({
    String? NomeAgencia,
    File? imgFile,
    String? File,
  }) async {
    if(NomeAgencia != null && NomeAgencia != 'null'){

      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('$imgFile')
          .putFile(imgFile!);

      TaskSnapshot taskSnapshot = await task;

      String url = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> data = {
        'Nome': NomeAgencia,
        'Imagem': url,
        'LocalStorage': File,
      };

      FirebaseFirestore.instance.collection('Empresa')
          .doc(NomeAgencia).set(data);
    }


  }

}