import 'package:cloud_firestore/cloud_firestore.dart';

class ValidaExistenciaCategoria {

  Future<int>? validadorCategoria(
      String? Empresa,
      ) async {

    int consultaCategorias;

    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance
            .collection('Usuario raiz')
            .doc(Empresa)
            .collection('Itens Cardapio')
            .get()
    );

    consultaCategorias = result.docs.length;

    return consultaCategorias!;
  }

}