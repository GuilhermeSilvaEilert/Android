// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class SetCores{

  colocarcores({
      int? red,
      int? blue,
      int? green,
      int? opacidade,
      String? localDoApp}) async{


    Map<String, dynamic> data = {
      'Blue': blue,
      'Red': red,
      'Green': green,
      'Opacidade': opacidade,
      'Nome': localDoApp
    };

    FirebaseFirestore
        .instance
        .collection('Configurações')
        .doc('Cores')
        .collection('Configura Cores')
        .doc(localDoApp).delete();

    FirebaseFirestore
        .instance
        .collection('Configurações')
        .doc('Cores')
        .collection('Configura Cores')
        .doc(localDoApp).set(data);

  }

}