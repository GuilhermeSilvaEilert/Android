import 'package:cloud_firestore/cloud_firestore.dart';

class ExcluiCategoria {

  Excluircategoria(
      String? EmpresaFisica,
      String? Filial,
      ){
    if(EmpresaFisica != null ||
        EmpresaFisica != '' &&
        Filial != null ||
        Filial != '' ){

      FirebaseFirestore
          .instance
          .collection('Empresa')
          .doc(EmpresaFisica)
          .collection(Filial!)
          .doc('categorias').delete();
      
    }

  }

}