import 'package:cloud_firestore/cloud_firestore.dart';

class SetCores{

  ColocarCores({
      int? Red,
      int? Blue,
      int? Green,
      int? Opacidade,
      String? LocalDoApp}) async{


    Map<String, dynamic> data = {
      'Blue': Blue,
      'Red': Red,
      'Green': Green,
      'Opacidade': Opacidade,
      'Nome': LocalDoApp
    };

    FirebaseFirestore
        .instance
        .collection('Configurações')
        .doc('Cores')
        .collection('Configura Cores')
        .doc(LocalDoApp).delete();

    FirebaseFirestore
        .instance
        .collection('Configurações')
        .doc('Cores')
        .collection('Configura Cores')
        .doc(LocalDoApp).set(data);

  }

}