// ignore_for_file: file_names

import 'package:cardapiovirtual/Model/itemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SetCores extends CardapioModel{

  colocarcores({
      int? red,
      int? blue,
      int? green,
      int? opacidade,
      String? localDoApp,
      String? UserRoot}) async{
    //print('set cores ${firebaseUser!.email}');

    Map<String, dynamic> data = {
      'Blue': blue,
      'Red': red,
      'Green': green,
      'Opacidade': opacidade,
      'Nome': localDoApp
    };
  //  print('set cores ${firebaseUser!.email}');
    FirebaseFirestore
        .instance
        .collection('Usuario raiz')
        .doc(UserRoot)
        .collection('Configuracoes')
        .doc(localDoApp).delete();

    FirebaseFirestore
        .instance
        .collection('Usuario raiz')
        .doc(UserRoot)
        .collection('Configuracoes')
        .doc(localDoApp).set(data);

  }

}