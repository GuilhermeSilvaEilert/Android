import 'package:cardapiovirtualmodulogarcom/Repository/SQLiteDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';


class CriaComandaModel extends Model{

  bool? isLoading = false;

  User? usuarioGarcom;
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    Firebase.initializeApp();
  }

  Map<String?, dynamic>? userData = Map();


  void AdicionaComanda({
    String? UserRoot,
    String? ComandasExistentes,
    String? Time,
    VoidCallback? onSucess,
    VoidCallback? onFail,
  }) async {

    print(ComandasExistentes);
    print(UserRoot);

    Map<String, dynamic> DataComanda = {
      'NumeroComanda' : ComandasExistentes.toString(),
      'Ordenador': Time,
      'Status':'Ativa'
    };

    FirebaseFirestore
        .instance
        .collection('Usuario raiz')
        .doc(UserRoot)
        .collection('comandas')
        .doc(ComandasExistentes.toString()).get();

    if(UserRoot != null && ComandasExistentes != null){

       FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('comandas')
          .doc(ComandasExistentes.toString()).set(DataComanda);

       FirebaseFirestore
           .instance
           .collection('Usuario raiz')
           .doc(UserRoot)
           .collection('HistóricoComandas')
           .doc(ComandasExistentes.toString()).set(DataComanda);

      onSucess!();
    }else{
      onFail!();
    }

  }
}